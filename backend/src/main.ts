import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);

    // Enable CORS
    app.enableCors({
        origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
        credentials: true,
    });

    // Global validation pipe
    app.useGlobalPipes(
        new ValidationPipe({
            whitelist: true,
            transform: true,
            forbidNonWhitelisted: true,
            transformOptions: {
                enableImplicitConversion: true,
            },
        }),
    );

    // Swagger documentation
    const config = new DocumentBuilder()
        .setTitle('REUC Compliance Management API')
        .setDescription('API para gestión de cumplimiento normativo de empresas REUC')
        .setVersion('1.0')
        .addBearerAuth()
        .addTag('auth', 'Autenticación')
        .addTag('departamentos', 'Gestión de departamentos')
        .addTag('normas', 'Gestión de normas')
        .addTag('sub-normas', 'Gestión de sub-normas')
        .addTag('reuc', 'Gestión de empresas REUC')
        .addTag('cumplimientos', 'Gestión de cumplimientos')
        .addTag('cartas', 'Gestión de cartas de incumplimiento')
        .addTag('homologaciones', 'Gestión de homologaciones')
        .build();

    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('api', app, document);

    const port = process.env.PORT || 3000;
    await app.listen(port);
    console.log(`🚀 Application is running on: http://localhost:${port}`);
    console.log(`📚 Swagger documentation: http://localhost:${port}/api`);
}

bootstrap();
