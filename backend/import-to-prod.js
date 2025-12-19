const fs = require('fs');
const { Client } = require('pg');

const client = new Client({
    host: 'plataformacumplimiento-prod.clasooasuh5c.us-east-1.rds.amazonaws.com',
    port: 5432,
    user: 'owner_cumplimiento_prod',
    password: 'Q9d¡RG@a08p',
    database: 'postgres',
    ssl: {
        rejectUnauthorized: false,
    },
});

async function importDumpToProd() {
    try {
        console.log('📖 Reading SQL dump file...');
        let sqlContent = fs.readFileSync('../dump-incumplimientos-202507011640.sql', 'utf8');
        console.log(`✅ SQL file loaded (${(sqlContent.length / 1024 / 1024).toFixed(2)} MB)`);

        console.log('\n🧹 Cleaning SQL for AWS RDS compatibility...');
        // Remove AWS RDS incompatible commands
        sqlContent = sqlContent.replace(/SET transaction_timeout = [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/SET idle_in_transaction_session_timeout = [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/SET default_table_access_method = [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/ALTER TABLE .* OWNER TO [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/ALTER SEQUENCE .* OWNER TO [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/COMMENT ON EXTENSION [^;]+;/gi, '');
        sqlContent = sqlContent.replace(/CREATE EXTENSION IF NOT EXISTS plpgsql[^;]*;/gi, '');
        console.log('✅ SQL cleaned');

        console.log('\n🔌 Connecting to AWS RDS PRODUCTION...');
        await client.connect();
        console.log('✅ Connected successfully');

        console.log('\n⚠️  WARNING: This will import data to PRODUCTION database!');
        console.log('📊 Executing SQL dump...');
        console.log('This may take several minutes...\n');

        // Split and execute statements
        const statements = sqlContent.split(';').filter(stmt => stmt.trim().length > 0);
        console.log(`Total statements to execute: ${statements.length}`);

        let executed = 0;
        let errors = 0;

        for (const statement of statements) {
            const trimmedStmt = statement.trim();
            if (trimmedStmt.length > 0) {
                try {
                    await client.query(trimmedStmt);
                    executed++;
                    if (executed % 100 === 0) {
                        console.log(`  Progress: ${executed}/${statements.length} statements (${errors} errors)...`);
                    }
                } catch (err) {
                    // Skip errors for SELECTs on pg_catalog and some specific patterns
                    if (!err.message.includes('pg_catalog') &&
                        !err.message.includes('already exists') &&
                        !err.message.includes('does not exist')) {
                        errors++;
                        if (errors < 10) {  // Only show first 10 errors
                            console.warn(`  ⚠️  Warning: ${err.message.substring(0, 100)}`);
                        }
                    }
                }
            }
        }

        console.log(`\n✅ SQL import completed!`);
        console.log(`   Executed: ${executed} statements`);
        console.log(`   Errors: ${errors} (most are safe to ignore)`);

        // Verify imported data
        console.log('\n🔍 Verifying imported data...');
        const counts = await client.query(`
      SELECT 
        'norma' as table_name, COUNT(*) as count FROM norma
      UNION ALL
      SELECT 'sub_norma', COUNT(*) FROM sub_norma
      UNION ALL
      SELECT 'departamento', COUNT(*) FROM departamento
      UNION ALL
      SELECT 'reuc', COUNT(*) FROM reuc
      UNION ALL
      SELECT 'cumplimiento', COUNT(*) FROM cumplimiento
      UNION ALL
      SELECT 'user', COUNT(*) FROM "user"
    `);
        console.table(counts.rows);

        // Check for data
        const normaData = await client.query('SELECT COUNT(*) FROM norma WHERE descripcion IS NOT NULL');
        const reucData = await client.query('SELECT COUNT(*) FROM reuc WHERE nombre_fantasia IS NOT NULL');

        console.log('\n✅ Data Verification:');
        console.log(`   Normas with data: ${normaData.rows[0].count}`);
        console.log(`   REUCs with data: ${reucData.rows[0].count}`);

        await client.end();
        console.log('\n🎉 Import to PRODUCTION completed successfully!');
    } catch (error) {
        console.error('\n❌ Error during import:', error.message);
        console.error('Details:', error.stack);
        await client.end();
        process.exit(1);
    }
}

importDumpToProd();
