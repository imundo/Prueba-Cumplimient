import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { cartasIncpmtAPI } from '../../lib/api';
import { CartaIncpmt } from '../../types';
import { Plus, Search, Eye } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';

const CartasList: React.FC = () => {
    const [cartas, setCartas] = useState<CartaIncpmt[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();

    useEffect(() => {
        loadCartas();
    }, [page, search]);

    const loadCartas = async () => {
        try {
            setLoading(true);
            const response = await cartasIncpmtAPI.getAll({ page, limit: 10, search });
            setCartas(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading cartas:', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Cartas de Incumplimiento</h1>
                    <p className="text-secondary-600 mt-1">Gestión de cartas y seguimientos</p>
                </div>
                {isAdmin && (
                    <button className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nueva Carta</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar cartas..."
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
                                        <th className="table-cell font-semibold">Correlativo</th>
                                        <th className="table-cell font-semibold">Fecha Creación</th>
                                        <th className="table-cell font-semibold">Autoridad</th>
                                        <th className="table-cell font-semibold">Empresa</th>
                                        <th className="table-cell font-semibold">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {cartas.map((carta) => (
                                        <tr key={carta.idCartaIncpmt} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900">{carta.idCartaIncpmt}</td>
                                            <td className="table-cell text-secondary-600">{carta.correlativoCorrespondencia || '-'}</td>
                                            <td className="table-cell text-secondary-600">
                                                {new Date(carta.fechaCreacion).toLocaleDateString('es-CL')}
                                            </td>
                                            <td className="table-cell text-secondary-600">{carta.autoridad || '-'}</td>
                                            <td className="table-cell text-secondary-600">{carta.cumplimiento?.reuc?.nombreFantasia || '-'}</td>
                                            <td className="table-cell">
                                                <Link to={`/cartas/${carta.idCartaIncpmt}`} className="p-1 hover:bg-primary-50 rounded text-primary-600 inline-flex">
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

export default CartasList;
