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

async function checkAllColumns() {
    try {
        await client.connect();
        console.log('✅ Connected to PRODUCTION\n');

        // Check norma columns
        console.log('=== NORMA TABLE STRUCTURE ===');
        const normaColumns = await client.query(`
      SELECT column_name, data_type, is_nullable 
      FROM information_schema.columns 
      WHERE table_name = 'norma'
      ORDER BY ordinal_position
    `);
        console.table(normaColumns.rows);

        // Check ALL norma data
        console.log('\n=== ALL NORMA DATA ===');
        const allNormas = await client.query('SELECT * FROM norma');
        console.log(JSON.stringify(allNormas.rows, null, 2));

        // Check sub_norma columns
        console.log('\n=== SUB_NORMA TABLE STRUCTURE ===');
        const subNormaColumns = await client.query(`
      SELECT column_name, data_type, is_nullable 
      FROM information_schema.columns 
      WHERE table_name = 'sub_norma'
      ORDER BY ordinal_position
    `);
        console.table(subNormaColumns.rows);

        // Check one sub_norma
        console.log('\n=== ONE SUB_NORMA ===');
        const oneSubNorma = await client.query('SELECT * FROM sub_norma LIMIT 1');
        console.log(JSON.stringify(oneSubNorma.rows[0], null, 2));

        await client.end();
    } catch (error) {
        console.error('❌ Error:', error.message);
        await client.end();
    }
}

checkAllColumns();
