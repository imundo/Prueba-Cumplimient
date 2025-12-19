import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { reucAPI } from '../../lib/api';
import { Reuc } from '../../types';
import { Plus, Search, Eye, Edit, Trash2 } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import Modal from '../../components/ui/Modal';
import ReucForm from '../../components/forms/ReucForm';

const ReucList: React.FC = () => {
    const [reucs, setReucs] = useState<Reuc[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [editingReuc, setEditingReuc] = useState<Reuc | null>(null);

    useEffect(() => {
        loadReucs();
    }, [page, search]);

    const loadReucs = async () => {
        try {
            setLoading(true);
            const response = await reucAPI.getAll({ page, limit: 10, search });
            setReucs(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading REUCs:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreate = () => {
        setEditingReuc(null);
        setIsModalOpen(true);
    };

    const handleEdit = (reuc: Reuc) => {
        setEditingReuc(reuc);
        setIsModalOpen(true);
    };

    const handleDelete = async (id: number) => {
        if (!confirm('¿Está seguro de eliminar esta empresa REUC?')) return;
        try {
            await reucAPI.delete(id);
            loadReucs();
        } catch (error) {
            console.error('Error deleting REUC:', error);
            alert('Error al eliminar la empresa REUC');
        }
    };

    const handleFormSubmit = async (data: Partial<Reuc>) => {
        try {
            if (editingReuc) {
                await reucAPI.update(editingReuc.idReuc, data);
            } else {
                await reucAPI.create(data);
            }
            setIsModalOpen(false);
            loadReucs();
        } catch (error) {
            console.error('Error saving REUC:', error);
            alert('Error al guardar la empresa REUC');
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Empresas REUC</h1>
                    <p className="text-secondary-600 mt-1">Gestión de empresas coordinadas</p>
                </div>
                {isAdmin && (
                    <button onClick={handleCreate} className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nueva Empresa</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar por nombre, RUT o comuna..."
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
                                        <th className="table-cell font-semibold">Nombre Fantasía</th>
                                        <th className="table-cell font-semibold">RUT</th>
                                        <th className="table-cell font-semibold">Comuna</th>
                                        <th className="table-cell font-semibold">Tipo</th>
                                        <th className="table-cell font-semibold">Estado</th>
                                        <th className="table-cell font-semibold">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {reucs.map((reuc) => (
                                        <tr key={reuc.idReuc} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900 font-medium">{reuc.nombreFantasia}</td>
                                            <td className="table-cell text-secondary-600">{reuc.rut}</td>
                                            <td className="table-cell text-secondary-600">{reuc.comuna || '-'}</td>
                                            <td className="table-cell text-secondary-600">{reuc.tipo || '-'}</td>
                                            <td className="table-cell">
                                                <span className={`px-2 py-1 text-xs font-medium rounded-full ${reuc.estado === 'activo' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                                                    }`}>
                                                    {reuc.estado}
                                                </span>
                                            </td>
                                            <td className="table-cell">
                                                <div className="flex items-center space-x-2">
                                                    <Link to={`/reuc/${reuc.idReuc}`} className="p-1 hover:bg-primary-50 rounded text-primary-600 inline-flex">
                                                        <Eye className="w-4 h-4" />
                                                    </Link>
                                                    {isAdmin && (
                                                        <>
                                                            <button
                                                                onClick={() => handleEdit(reuc)}
                                                                className="p-1 hover:bg-primary-50 rounded text-primary-600"
                                                            >
                                                                <Edit className="w-4 h-4" />
                                                            </button>
                                                            <button
                                                                onClick={() => handleDelete(reuc.idReuc)}
                                                                className="p-1 hover:bg-red-50 rounded text-red-600"
                                                            >
                                                                <Trash2 className="w-4 h-4" />
                                                            </button>
                                                        </>
                                                    )}
                                                </div>
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

            <Modal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                title={editingReuc ? 'Editar Empresa REUC' : 'Nueva Empresa REUC'}
            >
                <ReucForm
                    initialData={editingReuc}
                    onSubmit={handleFormSubmit}
                    onCancel={() => setIsModalOpen(false)}
                />
            </Modal>
        </div>
    );
};

export default ReucList;
