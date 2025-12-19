# Backend - Sistema REUC

Backend API REST para el sistema de gestión de cumplimiento normativo REUC.

## Tecnologías

- **Framework**: NestJS 10.x
- **Lenguaje**: TypeScript 5.x
- **Base de Datos**: PostgreSQL 14+
- **ORM**: TypeORM 0.3.x
- **Autenticación**: JWT (Passport)
- **Validación**: class-validator
- **Documentación**: Swagger/OpenAPI

## Instalación

```bash
npm install
```

## Configuración

Crear archivo `.env` basado en `.env.example`:

```env
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=tu_password
DB_DATABASE=reuc_compliance

JWT_SECRET=tu-secret-key-seguro
JWT_EXPIRES_IN=24h

PORT=3000
NODE_ENV=development

CORS_ORIGIN=http://localhost:5173
```

## Ejecución

```bash
# Desarrollo
npm run start:dev

# Producción
npm run build
npm run start:prod
```

## Base de Datos

### Crear Base de Datos

```sql
CREATE DATABASE reuc_compliance;
```

### Ejecutar Seed

```bash
npm run seed
```

Esto creará:
- 2 usuarios de prueba (admin/analista)
- Datos de ejemplo para todas las entidades

## Estructura

```
src/
├── auth/                    # Autenticación JWT
│   ├── auth.controller.ts
│   ├── auth.service.ts
│   ├── jwt.strategy.ts
│   └── roles.guard.ts
├── departamentos/           # Módulo CRUD
├── normas/                  # Módulo CRUD
├── sub-normas/              # Módulo CRUD
├── reuc/                    # Módulo CRUD
├── cumplimientos/           # Módulo CRUD con endpoints especiales
├── cartas-incpmt/           # Módulo CRUD
├── homologaciones/          # Módulo CRUD
├── tipos-*/                 # Módulos de catálogos
├── config/                  # Configuración TypeORM
├── common/                  # DTOs compartidos
└── database/seeds/          # Seeders
```

## API Endpoints

### Autenticación
- `POST /auth/login` - Login

### Patrón CRUD Estándar
Todos los módulos siguen este patrón:

- `GET /{recurso}` - Listar (paginado, búsqueda, filtros)
- `GET /{recurso}/:id` - Obtener uno
- `POST /{recurso}` - Crear (requiere rol admin)
- `PATCH /{recurso}/:id` - Actualizar (requiere rol admin)
- `DELETE /{recurso}/:id` - Eliminar (requiere rol admin)

### Endpoints Especiales

**Cumplimientos**:
- `GET /cumplimientos/con-detalle` - Con joins completos
- `GET /cumplimientos/reuc/:idReuc` - Por empresa
- `GET /cumplimientos/sub-norma/:idSubNorma` - Por sub-norma

**Cartas**:
- `GET /cartas-incpmt/:id/seguimiento` - Seguimiento de carta

**Homologaciones**:
- `GET /homologaciones/reuc/:rut` - Por RUT

**REUC**:
- `GET /reuc/rut/:rut` - Por RUT

## Documentación API

Swagger disponible en: http://localhost:3000/api

## Seguridad

- Contraseñas hasheadas con bcrypt (10 rounds)
- JWT con expiración configurable
- Guards de autenticación en todos los endpoints (excepto login)
- Guards de roles para operaciones de escritura
- Validación automática de DTOs

## Testing

```bash
npm run test
npm run test:e2e
```

## Usuarios de Prueba

Creados automáticamente con el seed:

- **Admin**: username=`admin`, password=`admin123`
- **Analista**: username=`analista`, password=`analista123`
