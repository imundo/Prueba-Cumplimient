# Guía de Instalación y Ejecución - REUC App

## ⚠️ REQUISITO IMPORTANTE: Node.js v18+

**PROBLEMA DETECTADO**: Actualmente tienes Node.js v12.22.12 instalado.
**REQUERIDO**: Node.js v18.x o superior (recomendado v20 LTS)

### Por qué es necesario actualizar

El proyecto usa tecnologías modernas que requieren Node.js v18+:
- TypeScript 5.x con sintaxis moderna
- NestJS 10.x
- Vite 5.x
- Características de JavaScript moderno (nullish coalescing `??`, optional chaining, etc.)

## 📥 Cómo Actualizar Node.js

### Opción 1: Instalación Directa (Recomendada)

1. Visita: https://nodejs.org/
2. Descarga **Node.js 20 LTS** (Long Term Support)
3. Ejecuta el instalador
4. Verifica la instalación:
```bash
node --version
# Debería mostrar: v20.x.x
```

### Opción 2: Usando nvm (Node Version Manager)

Si tienes nvm instalado:
```bash
nvm install 20
nvm use 20
node --version
```

## ✅ Estado Actual del Proyecto

### Ya Completado
- ✅ **Backend**: 806 paquetes instalados
- ✅ **Frontend**: 316 paquetes instalados
- ✅ **Archivo .env**: Creado y configurado
- ✅ **Código fuente**: 100% generado

### Pendiente (después de actualizar Node.js)

1. **Crear Base de Datos PostgreSQL**
```sql
-- Conectarse a PostgreSQL
psql -U postgres

-- Crear base de datos
CREATE DATABASE reuc_compliance;

-- Salir
\q
```

2. **Configurar credenciales en .env** (si es necesario)
```bash
cd backend
# Editar .env con tus credenciales de PostgreSQL
```

3. **Ejecutar Seed (datos de prueba)**
```bash
cd backend
npm run seed
```

4. **Iniciar Backend**
```bash
cd backend
npm run start:dev
```

Deberías ver:
```
🚀 Application is running on: http://localhost:3000
📚 Swagger documentation: http://localhost:3000/api
```

5. **Iniciar Frontend** (en otra terminal)
```bash
cd frontend
npm run dev
```

Deberías ver:
```
VITE v5.x.x  ready in xxx ms

➜  Local:   http://localhost:5173/
```

## 🔐 Credenciales de Prueba

Una vez que la aplicación esté corriendo:

- **Admin**: 
  - Usuario: `admin`
  - Contraseña: `admin123`
  - Permisos: Crear, editar, eliminar

- **Analista**:
  - Usuario: `analista`
  - Contraseña: `analista123`
  - Permisos: Solo lectura

## 🌐 URLs de Acceso

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:3000
- **Swagger Docs**: http://localhost:3000/api

## 🐛 Solución de Problemas

### Error: "Cannot find module"
```bash
# Reinstalar dependencias
cd backend
rm -rf node_modules package-lock.json
npm install

cd ../frontend
rm -rf node_modules package-lock.json
npm install
```

### Error: "Database connection failed"
- Verificar que PostgreSQL esté corriendo
- Verificar credenciales en `backend/.env`
- Verificar que la base de datos `reuc_compliance` exista

### Error: "Port already in use"
- Backend (3000): Cambiar `PORT` en `backend/.env`
- Frontend (5173): Cambiar en `frontend/vite.config.ts`

## 📞 Próximos Pasos

1. **Actualizar Node.js a v18 o v20**
2. **Crear base de datos PostgreSQL**
3. **Ejecutar los comandos de arriba en orden**
4. **Acceder a http://localhost:5173**
5. **Login con credenciales de prueba**

¡La aplicación está lista para funcionar una vez actualices Node.js!
