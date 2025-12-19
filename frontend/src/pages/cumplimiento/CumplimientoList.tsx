import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { cumplimientosAPI } from '../../lib/api';
import { Cumplimiento } from '../../types';
import { Plus, Search, Eye, Filter } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';

const CumplimientoList: React.FC = () => {
    const [cumplimientos, setCumplimientos] = useState<Cumplimiento[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [estadoFilter, setEstadoFilter] = useState('');
    const [anioFilter, setAnioFilter] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();

    useEffect(() => {
        loadCumplimientos();
    }, [page, search, estadoFilter, anioFilter]);

    const loadCumplimientos = async () => {
        try {
            setLoading(true);
            const params: any = { page, limit: 10, search };
            if (estadoFilter) params.estado = estadoFilter;
            if (anioFilter) params.anio = parseInt(anioFilter);

            const response = await cumplimientosAPI.getAll(params);
            setCumplimientos(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading cumplimientos:', error);
        } finally {
            setLoading(false);
        }
    };

    const getEstadoBadge = (estado: string) => {
        const colors = {
            'cumple': 'bg-green-100 text-green-800',
            'no cumple': 'bg-red-100 text-red-800',
            'pendiente': 'bg-yellow-100 text-yellow-800',
        };
        return colors[estado as keyof typeof colors] || 'bg-gray-100 text-gray-800';
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Cumplimientos</h1>
                    <p className="text-secondary-600 mt-1">Gestión de registros de cumplimiento normativo</p>
                </div>
                {isAdmin && (
                    <button className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nuevo Cumplimiento</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar..."
                            value={search}
                            onChange={(e) => setSearch(e.target.value)}
                            className="input pl-10"
                        />
                    </div>
                    <select value={estadoFilter} onChange={(e) => setEstadoFilter(e.target.value)} className="input">
                        <option value="">Todos los estados</option>
                        <option value="cumple">Cumple</option>
                        <option value="no cumple">No Cumple</option>
                        <option value="pendiente">Pendiente</option>
                    </select>
                    <input
                        type="number"
                        placeholder="Año"
                        value={anioFilter}
                        onChange={(e) => setAnioFilter(e.target.value)}
                        className="input"
                    />
                    <button onClick={loadCumplimientos} className="btn btn-secondary flex items-center justify-center space-x-2">
                        <Filter className="w-4 h-4" />
                        <span>Filtrar</span>
                    </button>
                </div>

                {loading ? (
                    <div className="flex justify-center py-12">
                        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary-600"></div>
                    </div>
                ) : (
                    <>
                        <div className="overflow-x-auto">
                            <table className="table">
                                <thead className="table-header">
                                    <tr>
                                        <th className="table-cell font-semibold">ID</th>
                                        <th className="table-cell font-semibold">Empresa REUC</th>
                                        <th className="table-cell font-semibold">Sub-Norma</th>
                                        <th className="table-cell font-semibold">Año</th>
                                        <th className="table-cell font-semibold">Período</th>
                                        <th className="table-cell font-semibold">Estado</th>
                                        <th className="table-cell font-semibold">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {cumplimientos.map((cumpl) => (
                                        <tr key={cumpl.idCumplimiento} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900">{cumpl.idCumplimiento}</td>
                                            <td className="table-cell text-secondary-900">{cumpl.reuc?.nombreFantasia || '-'}</td>
                                            <td className="table-cell text-secondary-600">{cumpl.subNorma?.nombre || '-'}</td>
                                            <td className="table-cell text-secondary-600">{cumpl.anio || '-'}</td>
                                            <td className="table-cell text-secondary-600">{cumpl.periodoCumplimiento || '-'}</td>
                                            <td className="table-cell">
                                                <span className={`px-2 py-1 text-xs font-medium rounded-full ${getEstadoBadge(cumpl.estado)}`}>
                                                    {cumpl.estado}
                                                </span>
                                            </td>
                                            <td className="table-cell">
                                                <Link to={`/cumplimiento/${cumpl.idCumplimiento}`} className="p-1 hover:bg-primary-50 rounded text-primary-600 inline-flex">
                                                    <Eye className="w-4 h-4" />
                                                </Link>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>

                        {totalPages > 1 && (
                            <div className="flex items-center justify-between mt-4 pt-4 border-t border-secondary-200">
                                <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1} className="btn btn-secondary disabled:opacity-50">
                                    Anterior
                                </button>
                                <span className="text-sm text-secondary-600">Página {page} de {totalPages}</span>
                                <button onClick={() => setPage(p => Math.min(totalPages, p + 1))} disabled={page === totalPages} className="btn btn-secondary disabled:opacity-50">
                                    Siguiente
                                </button>
                            </div>
                        )}
                    </>
                )}
            </div>
        </div>
    );
};

export default CumplimientoList;
