import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { DataSource, DataSourceOptions } from 'typeorm';

// Production Database Configuration (Read-Only)
const DB_CONFIG = {
    host: process.env.DB_HOST || 'plataformacumplimiento-prod.clasooasuh5c.us-east-1.rds.amazonaws.com',
    port: parseInt(process.env.DB_PORT || '5432', 10),
    username: process.env.DB_USERNAME || 'lectura_cumplimiento_prod',
    password: process.env.DB_PASSWORD || 'Qaf&u@e1zP!',
    database: process.env.DB_DATABASE || 'postgres',
};

// Feature Flags
export const ENABLE_MAINTAINERS = process.env.ENABLE_MAINTAINERS === 'true';

export const typeOrmConfig: TypeOrmModuleOptions = {
    type: 'postgres',
    host: DB_CONFIG.host,
    port: DB_CONFIG.port,
    username: DB_CONFIG.username,
    password: DB_CONFIG.password,
    database: DB_CONFIG.database,
    entities: [__dirname + '/../**/*.entity{.ts,.js}'],
    synchronize: false,
    ssl: {
        rejectUnauthorized: false,
    },
    logging: process.env.NODE_ENV === 'development',
};

export const dataSourceOptions: DataSourceOptions = {
    type: 'postgres',
    host: DB_CONFIG.host,
    port: DB_CONFIG.port,
    username: DB_CONFIG.username,
    password: DB_CONFIG.password,
    database: DB_CONFIG.database,
    entities: [__dirname + '/../**/*.entity{.ts,.js}'],
    migrations: [__dirname + '/../database/migrations/*{.ts,.js}'],
    synchronize: false,
    ssl: {
        rejectUnauthorized: false,
    },
};

const dataSource = new DataSource(dataSourceOptions);
export default dataSource;

