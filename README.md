# Plataforma de Cumplimiento Normativo

Sistema de gestión y visualización de cumplimiento normativo para el Coordinador Eléctrico Nacional.

## 🚀 Características

- **Vista Pública**: Dashboard de cumplimiento accesible sin autenticación
- **Gráficos Interactivos**: Evolución de cumplimiento con comparación interanual
- **Heatmap por Segmento**: Visualización del cumplimiento por tipo de segmento
- **Autenticación**: Sistema de login con JWT
- **API REST**: Backend con NestJS y documentación Swagger

## 📋 Requisitos

- Node.js 18+
- PostgreSQL 15+
- npm o yarn

## 🛠️ Instalación Local

### Backend

```bash
cd backend
npm install
cp .env.example .env
# Editar .env con tu configuración de base de datos
npm run start:dev
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

## 🐳 Docker

### Con Docker Compose (recomendado)

```bash
docker-compose up -d
```

Esto levantará:
- Frontend en http://localhost:80
- Backend en http://localhost:3000
- PostgreSQL en localhost:5432

### Build individual

```bash
# Backend
cd backend && docker build -t cumplimiento-backend .

# Frontend
cd frontend && docker build -t cumplimiento-frontend .
```

## ☁️ Despliegue en Render.com

1. Conecta tu repositorio de GitHub a Render
2. Selecciona "Blueprint" y usa el archivo `render.yaml`
3. Render.com creará automáticamente:
   - Base de datos PostgreSQL
   - Servicio backend (NestJS)
   - Sitio estático frontend (React/Vite)

### Variables de entorno en Render

- `JWT_SECRET`: Se genera automáticamente
- `CORS_ORIGIN`: URL del frontend desplegado

## 📁 Estructura del Proyecto

```
├── backend/                 # API NestJS
│   ├── src/
│   │   ├── analytics/      # Endpoints de analytics
│   │   ├── auth/           # Autenticación JWT
│   │   ├── cumplimientos/  # Gestión de cumplimientos
│   │   ├── reuc/           # Gestión de REUCs
│   │   └── tipos-segmento/ # Tipos de segmento
│   └── Dockerfile
├── frontend/               # React + Vite + TypeScript
│   ├── src/
│   │   ├── components/     # Componentes reutilizables
│   │   ├── pages/          # Páginas de la aplicación
│   │   └── contexts/       # Contextos de React
│   ├── Dockerfile
│   └── nginx.conf
├── docker-compose.yml      # Orquestación Docker
├── render.yaml            # Blueprint para Render.com
└── Dockerfile             # Dockerfile unificado
```

## 🔗 URLs

- **Desarrollo**
  - Frontend: http://localhost:5173
  - Backend: http://localhost:3000
  - Swagger: http://localhost:3000/api

## 📄 Licencia

MIT
