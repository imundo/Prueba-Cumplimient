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

async function checkNormaStructure() {
    try {
        await client.connect();
        console.log('✅ Connected to PRODUCTION database\n');

        // Get norma table structure
        console.log('📋 NORMA table structure:');
        const columns = await client.query(`
      SELECT 
        column_name, 
        data_type, 
        is_nullable,
        column_default
      FROM information_schema.columns 
      WHERE table_name = 'norma' 
      ORDER BY ordinal_position
    `);
        console.table(columns.rows);

        // Get sample data
        console.log('\n📊 Sample data from norma:');
        const data = await client.query('SELECT * FROM norma');
        console.log(JSON.stringify(data.rows, null, 2));

        // Check constraints
        console.log('\n🔗 Constraints on norma:');
        const constraints = await client.query(`
      SELECT 
        tc.constraint_name,
        tc.constraint_type,
        kcu.column_name
      FROM information_schema.table_constraints tc
      LEFT JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name
      WHERE tc.table_name = 'norma'
      ORDER BY tc.constraint_type
    `);
        console.table(constraints.rows);

        await client.end();
    } catch (error) {
        console.error('❌ Error:', error.message);
        await client.end();
    }
}

checkNormaStructure();
