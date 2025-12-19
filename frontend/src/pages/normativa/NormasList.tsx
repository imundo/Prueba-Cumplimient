import React, { useEffect, useState } from 'react';
import { normasAPI } from '../../lib/api';
import { Norma } from '../../types';
import { Plus, Edit, Trash2, Search } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import Modal from '../../components/ui/Modal';
import NormaForm from '../../components/forms/NormaForm';

const NormasList: React.FC = () => {
    const [normas, setNormas] = useState<Norma[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();

    const [isModalOpen, setIsModalOpen] = useState(false);
    const [editingNorma, setEditingNorma] = useState<Norma | null>(null);

    useEffect(() => {
        loadNormas();
    }, [page, search]);

    const loadNormas = async () => {
        try {
            setLoading(true);
            const response = await normasAPI.getAll({ page, limit: 10, search });
            setNormas(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading normas:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreate = () => {
        setEditingNorma(null);
        setIsModalOpen(true);
    };

    const handleEdit = (norma: Norma) => {
        setEditingNorma(norma);
        setIsModalOpen(true);
    };

    const handleDelete = async (id: number) => {
        if (!confirm('¿Está seguro de eliminar esta norma?')) return;

        try {
            await normasAPI.delete(id);
            loadNormas();
        } catch (error) {
            console.error('Error deleting norma:', error);
            alert('Error al eliminar la norma');
        }
    };

    const handleFormSubmit = async (data: Partial<Norma>) => {
        try {
            if (editingNorma) {
                await normasAPI.update(editingNorma.idNorma, data);
            } else {
                await normasAPI.create(data);
            }
            setIsModalOpen(false);
            loadNormas();
        } catch (error) {
            console.error('Error saving norma:', error);
            alert('Error al guardar la norma');
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Normas</h1>
                    <p className="text-secondary-600 mt-1">Gestión de normas legales</p>
                </div>
                {isAdmin && (
                    <button onClick={handleCreate} className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nueva Norma</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar normas..."
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
                                        <th className="table-cell font-semibold text-secondary-900">ID</th>
                                        <th className="table-cell font-semibold text-secondary-900">Descripción</th>
                                        <th className="table-cell font-semibold text-secondary-900">Artículo</th>
                                        <th className="table-cell font-semibold text-secondary-900">Cuerpo Legal</th>
                                        {isAdmin && <th className="table-cell font-semibold text-secondary-900">Acciones</th>}
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {normas.map((norma) => (
                                        <tr key={norma.idNorma} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900">{norma.idNorma}</td>
                                            <td className="table-cell text-secondary-900">{norma.descripcion}</td>
                                            <td className="table-cell text-secondary-600">{norma.articulo || '-'}</td>
                                            <td className="table-cell text-secondary-600">{norma.cuerpoLegal || '-'}</td>
                                            {isAdmin && (
                                                <td className="table-cell">
                                                    <div className="flex items-center space-x-2">
                                                        <button
                                                            onClick={() => handleEdit(norma)}
                                                            className="p-1 hover:bg-primary-50 rounded text-primary-600"
                                                        >
                                                            <Edit className="w-4 h-4" />
                                                        </button>
                                                        <button
                                                            onClick={() => handleDelete(norma.idNorma)}
                                                            className="p-1 hover:bg-red-50 rounded text-red-600"
                                                        >
                                                            <Trash2 className="w-4 h-4" />
                                                        </button>
                                                    </div>
                                                </td>
                                            )}
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>

                        {totalPages > 1 && (
                            <div className="flex items-center justify-between mt-4 pt-4 border-t border-secondary-200">
                                <button
                                    onClick={() => setPage(p => Math.max(1, p - 1))}
                                    disabled={page === 1}
                                    className="btn btn-secondary disabled:opacity-50"
                                >
                                    Anterior
                                </button>
                                <span className="text-sm text-secondary-600">
                                    Página {page} de {totalPages}
                                </span>
                                <button
                                    onClick={() => setPage(p => Math.min(totalPages, p + 1))}
                                    disabled={page === totalPages}
                                    className="btn btn-secondary disabled:opacity-50"
                                >
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
                title={editingNorma ? 'Editar Norma' : 'Nueva Norma'}
            >
                <NormaForm
                    initialData={editingNorma}
                    onSubmit={handleFormSubmit}
                    onCancel={() => setIsModalOpen(false)}
                />
            </Modal>
        </div>
    );
};

export default NormasList;
