import React, { useEffect, useState } from 'react';
import { subNormasAPI } from '../../lib/api';
import { SubNorma } from '../../types';
import { Plus, Search, Edit, Trash2 } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import Modal from '../../components/ui/Modal';
import SubNormaForm from '../../components/forms/SubNormaForm';

const SubNormasList: React.FC = () => {
    const [subNormas, setSubNormas] = useState<SubNorma[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [page, setPage] = useState(1);
    const [totalPages, setTotalPages] = useState(1);
    const { isAdmin } = useAuth();
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [editingSubNorma, setEditingSubNorma] = useState<SubNorma | null>(null);

    useEffect(() => {
        loadSubNormas();
    }, [page, search]);

    const loadSubNormas = async () => {
        try {
            setLoading(true);
            const response = await subNormasAPI.getAll({ page, limit: 10, search });
            setSubNormas(response.data.data);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('Error loading sub-normas:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreate = () => {
        setEditingSubNorma(null);
        setIsModalOpen(true);
    };

    const handleEdit = (subNorma: SubNorma) => {
        setEditingSubNorma(subNorma);
        setIsModalOpen(true);
    };

    const handleDelete = async (id: number) => {
        if (!confirm('¿Está seguro de eliminar esta sub-norma?')) return;
        try {
            await subNormasAPI.delete(id);
            loadSubNormas();
        } catch (error) {
            console.error('Error deleting sub-norma:', error);
            alert('Error al eliminar la sub-norma');
        }
    };

    const handleFormSubmit = async (data: Partial<SubNorma>) => {
        try {
            if (editingSubNorma) {
                await subNormasAPI.update(editingSubNorma.idSubNorma, data);
            } else {
                await subNormasAPI.create(data);
            }
            setIsModalOpen(false);
            loadSubNormas();
        } catch (error) {
            console.error('Error saving sub-norma:', error);
            alert('Error al guardar la sub-norma');
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Sub-Normas</h1>
                    <p className="text-secondary-600 mt-1">Gestión de sub-normas</p>
                </div>
                {isAdmin && (
                    <button onClick={handleCreate} className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nueva Sub-Norma</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar sub-normas..."
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
                                        <th className="table-cell font-semibold">Nombre</th>
                                        <th className="table-cell font-semibold">Numeral</th>
                                        <th className="table-cell font-semibold">Periodicidad</th>
                                        <th className="table-cell font-semibold">Norma</th>
                                        <th className="table-cell font-semibold">Departamento</th>
                                        {isAdmin && <th className="table-cell font-semibold">Acciones</th>}
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-secondary-200">
                                    {subNormas.map((subNorma) => (
                                        <tr key={subNorma.idSubNorma} className="hover:bg-secondary-50">
                                            <td className="table-cell text-secondary-900">{subNorma.nombre}</td>
                                            <td className="table-cell text-secondary-600">{subNorma.numeral || '-'}</td>
                                            <td className="table-cell text-secondary-600">{subNorma.periodicidad || '-'}</td>
                                            <td className="table-cell text-secondary-600">{subNorma.norma?.descripcion || '-'}</td>
                                            <td className="table-cell text-secondary-600">{subNorma.departamento?.nombre || '-'}</td>
                                            {isAdmin && (
                                                <td className="table-cell">
                                                    <div className="flex items-center space-x-2">
                                                        <button
                                                            onClick={() => handleEdit(subNorma)}
                                                            className="p-1 hover:bg-primary-50 rounded text-primary-600"
                                                        >
                                                            <Edit className="w-4 h-4" />
                                                        </button>
                                                        <button
                                                            onClick={() => handleDelete(subNorma.idSubNorma)}
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
                title={editingSubNorma ? 'Editar Sub-Norma' : 'Nueva Sub-Norma'}
            >
                <SubNormaForm
                    initialData={editingSubNorma}
                    onSubmit={handleFormSubmit}
                    onCancel={() => setIsModalOpen(false)}
                />
            </Modal>
        </div>
    );
};

export default SubNormasList;
