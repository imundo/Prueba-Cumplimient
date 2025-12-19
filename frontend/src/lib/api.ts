import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';

export const api = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Request interceptor to add JWT token
api.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    },
    (error) => {
        return Promise.reject(error);
    }
);

// Response interceptor to handle errors
api.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response?.status === 401) {
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            window.location.href = '/login';
        }
        return Promise.reject(error);
    }
);

// Auth API
export const authAPI = {
    login: (username: string, password: string) =>
        api.post('/auth/login', { username, password }),
};

// Generic CRUD API factory
export const createCRUDAPI = <T>(endpoint: string) => ({
    getAll: (params?: any) => api.get<{ data: T[]; total: number; page: number; limit: number; totalPages: number }>(`/${endpoint}`, { params }),
    getOne: (id: number) => api.get<T>(`/${endpoint}/${id}`),
    create: (data: Partial<T>) => api.post<T>(`/${endpoint}`, data),
    update: (id: number, data: Partial<T>) => api.patch<T>(`/${endpoint}/${id}`, data),
    delete: (id: number) => api.delete(`/${endpoint}/${id}`),
});

import {
    Departamento, Norma, SubNorma, Reuc, TipoSegmento,
    TipoCumplimiento, Cumplimiento, CartaIncpmt, TipoEventoSeg, Homologacion
} from '../types';

// ... (existing code)

// Specific APIs
export const departamentosAPI = createCRUDAPI<Departamento>('departamentos');
export const normasAPI = createCRUDAPI<Norma>('normas');
export const subNormasAPI = createCRUDAPI<SubNorma>('sub-normas');
export const reucAPI = {
    ...createCRUDAPI<Reuc>('reuc'),
    getByRut: (rut: string) => api.get<Reuc>(`/reuc/rut/${rut}`),
};
export const tiposSegmentoAPI = createCRUDAPI<TipoSegmento>('tipos-segmento');
export const tiposCumplimientoAPI = createCRUDAPI<TipoCumplimiento>('tipos-cumplimiento');
export const cumplimientosAPI = {
    ...createCRUDAPI<Cumplimiento>('cumplimientos'),
    getAllWithDetails: (params?: any) => api.get<Cumplimiento[]>('/cumplimientos/con-detalle', { params }),
    getByReuc: (idReuc: number, params?: any) => api.get<Cumplimiento[]>(`/cumplimientos/reuc/${idReuc}`, { params }),
    getBySubNorma: (idSubNorma: number, params?: any) => api.get<Cumplimiento[]>(`/cumplimientos/sub-norma/${idSubNorma}`, { params }),
};
export const cartasIncpmtAPI = {
    ...createCRUDAPI<CartaIncpmt>('cartas-incpmt'),
    getSeguimiento: (idCarta: number) => api.get(`/cartas-incpmt/${idCarta}/seguimiento`),
};
export const tiposEventoSegAPI = createCRUDAPI<TipoEventoSeg>('tipos-evento-seg');
export const homologacionesAPI = {
    ...createCRUDAPI<Homologacion>('homologaciones'),
    getByRut: (rut: string, params?: any) => api.get<Homologacion[]>(`/homologaciones/reuc/${rut}`, { params }),
};
