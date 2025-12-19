import * as fs from 'fs';
import * as path from 'path';
import { DataSource } from 'typeorm';
import { dataSourceOptions } from '../../config/typeorm.config';

async function importSqlData() {
    const sqlFilePath = path.join(__dirname, '../../../../cumplimiento-normativo2025-202512021814.sql');
    const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');

    const dataSource = new DataSource(dataSourceOptions);
    await dataSource.initialize();

    console.log('🚀 Starting SQLite data import from PostgreSQL dump...');
    console.log('📁 Reading SQL file...');

    // Extract INSERT statements
    const insertRegex = /INSERT INTO public\.(\w+) VALUES \((.*?)\);/gs;
    const matches = [...sqlContent.matchAll(insertRegex)];

    console.log(`📊 Found ${matches.length} INSERT statements`);

    // Group inserts by table
    const tableInserts: { [key: string]: string[][] } = {};

    for (const match of matches) {
        const tableName = match[1];
        const values = match[2];

        if (!tableInserts[tableName]) {
            tableInserts[tableName] = [];
        }

        // Parse values - handle strings, numbers, nulls
        const valuesList = parseValues(values);
        tableInserts[tableName].push(valuesList);
    }

    console.log('📋 Tables to import:');
    Object.keys(tableInserts).forEach(table => {
        console.log(`   - ${table}: ${tableInserts[table].length} records`);
    });

    // Import order based on dependencies
    const importOrder = [
        'departamento',
        'norma',
        'tipo_cumplimiento',
        'tipo_segmento',
        'tipo_evento_seg',
        'sub_norma',
        'reuc',
        'reuc_tipo_segmento',
        'homologacion',
        'cumplimiento',
        'detalle_cumplimiento',
        'carta_incpmt_detalle',
        'carta_incpmt',
        'carta_incpmt_seg'
    ];

    // Disable foreign keys for faster import
    await dataSource.query('PRAGMA foreign_keys = OFF');
    await dataSource.query('BEGIN TRANSACTION');

    for (const tableName of importOrder) {
        if (!tableInserts[tableName]) {
            console.log(`⏭️  Skipping ${tableName} (no data)`);
            continue;
        }

        console.log(`📥 Importing ${tableName}...`);
        const records = tableInserts[tableName];

        // Batch insert for performance
        const batchSize = 100;
        for (let i = 0; i < records.length; i += batchSize) {
            const batch = records.slice(i, i + batchSize);

            for (const values of batch) {
                const placeholders = values.map(() => '?').join(', ');
                const sql = `INSERT OR IGNORE INTO ${tableName} VALUES (${placeholders})`;

                try {
                    await dataSource.query(sql, values);
                } catch (error) {
                    console.warn(`⚠️  Failed to insert into ${tableName}:`, error.message);
                }
            }

            if (i % 500 === 0 && i > 0) {
                console.log(`   Progress: ${i}/${records.length}`);
            }
        }

        console.log(`✅ Imported ${records.length} records into ${tableName}`);
    }

    await dataSource.query('COMMIT');
    await dataSource.query('PRAGMA foreign_keys = ON');

    console.log('🎉 Data import completed successfully!');
    await dataSource.destroy();
}

function parseValues(valuesString: string): any[] {
    const values: any[] = [];
    let current = '';
    let inString = false;
    let stringChar = '';

    for (let i = 0; i < valuesString.length; i++) {
        const char = valuesString[i];
        const nextChar = valuesString[i + 1];

        if (!inString && (char === "'" || char === '"')) {
            inString = true;
            stringChar = char;
            current = '';
        } else if (inString && char === stringChar) {
            // Check if it's an escaped quote
            if (nextChar === stringChar) {
                current += char;
                i++; // Skip next char
            } else {
                // End of string
                values.push(current);
                current = '';
                inString = false;
                stringChar = '';
            }
        } else if (!inString && char === ',') {
            if (current.trim() === 'NULL') {
                values.push(null);
            } else if (current.trim() !== '') {
                // Try to parse as number
                const num = parseFloat(current.trim());
                values.push(isNaN(num) ? current.trim() : num);
            }
            current = '';
        } else if (inString || (char !== ' ' || current.length > 0)) {
            current += char;
        }
    }

    // Handle last value
    if (current.trim() !== '') {
        if (current.trim() === 'NULL') {
            values.push(null);
        } else {
            const num = parseFloat(current.trim());
            values.push(isNaN(num) ? current.trim() : num);
        }
    }

    return values;
}

importSqlData().catch((error) => {
    console.error('❌ Error importing data:', error);
    process.exit(1);
});
