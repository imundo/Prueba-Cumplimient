# Frontend - Sistema REUC

Frontend web para el sistema de gestión de cumplimiento normativo REUC.

## Tecnologías

- **Framework**: React 18.x
- **Lenguaje**: TypeScript 5.x
- **Build Tool**: Vite 5.x
- **Estilos**: TailwindCSS 3.x
- **Routing**: React Router DOM 6.x
- **HTTP Client**: Axios
- **Forms**: React Hook Form + Zod
- **Icons**: Lucide React

## Instalación

```bash
npm install
```

## Configuración

Crear archivo `.env` (opcional):

```env
VITE_API_URL=http://localhost:3000
```

## Ejecución

```bash
# Desarrollo
npm run dev

# Build
npm run build

# Preview
npm run preview
```

La aplicación estará disponible en: http://localhost:5173

## Estructura

```
src/
├── components/
│   ├── layout/              # Sidebar, Topbar, MainLayout
│   └── ui/                  # Componentes reutilizables
├── contexts/
│   └── AuthContext.tsx      # Contexto de autenticación
├── lib/
│   └── api.ts               # Cliente API con axios
├── pages/
│   ├── Login.tsx            # Página de login
│   ├── Dashboard.tsx        # Dashboard principal
│   ├── normativa/           # Páginas de normativa
│   ├── reuc/                # Páginas de REUC
│   ├── cumplimiento/        # Páginas de cumplimiento
│   ├── cartas/              # Páginas de cartas
│   └── homologacion/        # Páginas de homologación
├── types/
│   └── index.ts             # Interfaces TypeScript
├── App.tsx                  # Configuración de rutas
├── main.tsx                 # Entry point
└── index.css                # Estilos globales
```

## Características

### Autenticación
- Login con JWT
- Persistencia en localStorage
- Redirección automática si no autenticado
- Logout con limpieza de sesión

### Control de Acceso
- Rol **admin**: Puede crear, editar y eliminar
- Rol **analista**: Solo lectura
- Botones de acción ocultos para analistas

### Funcionalidades Comunes
- **Búsqueda**: En todos los listados
- **Paginación**: Navegación de páginas
- **Filtros**: Por estado, año, etc.
- **Loading States**: Spinners durante carga
- **Responsive**: Adaptable a móviles y tablets

### Módulos

#### 1. Dashboard
- KPIs de cumplimientos por estado
- Accesos rápidos a módulos
- Estadísticas generales

#### 2. Normativa
- Gestión de Normas
- Gestión de SubNormas
- Gestión de Departamentos

#### 3. REUC
- Listado de empresas con filtros
- Vista detallada de empresa
- Información de contactos

#### 4. Cumplimiento
- Listado con filtros avanzados (año, estado)
- Vista detallada con información completa
- Estados visuales con badges de color

#### 5. Cartas de Incumplimiento
- Listado de cartas
- Vista detallada con información completa
- Seguimiento de eventos

#### 6. Homologación
- Gestión de reglas de homologación
- Búsqueda y filtrado

## Estilos

### TailwindCSS
Configuración personalizada con:
- Paleta de colores primary y secondary
- Clases utilitarias personalizadas
- Componentes reutilizables (btn, input, card, table)

### Tipografía
- Fuente: Inter (Google Fonts)
- Tamaños responsivos
- Jerarquía clara

## API Client

El cliente API (`src/lib/api.ts`) incluye:
- Interceptor para agregar JWT automáticamente
- Interceptor para manejar errores 401
- Factory para crear APIs CRUD
- APIs específicas para cada módulo

## Rutas

```
/login                        # Login
/                             # Dashboard
/normativa/normas             # Normas
/normativa/sub-normas         # SubNormas
/normativa/departamentos      # Departamentos
/reuc                         # Listado REUC
/reuc/:id                     # Detalle REUC
/cumplimiento                 # Listado Cumplimientos
/cumplimiento/:id             # Detalle Cumplimiento
/cartas                       # Listado Cartas
/cartas/:id                   # Detalle Carta
/homologacion                 # Homologaciones
```

## Credenciales de Prueba

- **Admin**: `admin` / `admin123`
- **Analista**: `analista` / `analista123`

## Build para Producción

```bash
npm run build
```

Los archivos optimizados estarán en `dist/`

## Linting

```bash
npm run lint
```
