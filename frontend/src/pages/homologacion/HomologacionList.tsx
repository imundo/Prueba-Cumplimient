import React, { useEffect, useState } from 'react';
import { homologacionesAPI } from '../../lib/api';
import { Homologacion } from '../../types';
import { Plus, Search } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';

const HomologacionList: React.FC = () => {
    const [homologaciones, setHomologaciones] = useState<Homologacion[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();

    useEffect(() => {
        loadHomologaciones();
    }, [page, search]);

    const loadHomologaciones = async () => {
        try {
            setLoading(true);
            const response = await homologacionesAPI.getAll({ page, limit: 10, search });
            setHomologaciones(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading homologaciones:', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Homologaciones</h1>
                    <p className="text-secondary-600 mt-1">Gestión de reglas de homologación</p>
                </div>
                {isAdmin && (
                    <button className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nueva Homologación</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar homologaciones..."
                            value={search}
                            onChange={(e) => setSearch(e.target.value)}
                            className="input pl-10"
                        />
                    </div>
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
                                        <th className="table-cell font-semibold">Sub-Norma</th>
                                        <th className="table-cell font-semibold">RUT REUC</th>
                                        <th className="table-cell font-semibold">Valor Input</th>
                                        <th className="table-cell font-semibold">Valor Output</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {homologaciones.map((homol) => (
                                        <tr key={homol.idHomologacion} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900">{homol.idHomologacion}</td>
                                            <td className="table-cell text-secondary-900">{homol.subNorma?.nombre || '-'}</td>
                                            <td className="table-cell text-secondary-600">{homol.rutReuc || '-'}</td>
                                            <td className="table-cell text-secondary-600">{homol.valorInputNombreCoordinadoArchivoSubNorma || '-'}</td>
                                            <td className="table-cell text-secondary-600">{homol.valorOutputEmpresaCc || '-'}</td>
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

export default HomologacionList;
