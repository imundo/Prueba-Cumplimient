import React, { useEffect, useState } from 'react';
import { departamentosAPI } from '../../lib/api';
import { Departamento } from '../../types';
import { Plus, Search, Edit, Trash2 } from 'lucide-react';
import { useAuth } from '../../contexts/AuthContext';
import Modal from '../../components/ui/Modal';
import DepartamentoForm from '../../components/forms/DepartamentoForm';

const DepartamentosList: React.FC = () => {
    const [departamentos, setDepartamentos] = useState<Departamento[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const { isAdmin } = useAuth();
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [editingDepto, setEditingDepto] = useState<Departamento | null>(null);

    useEffect(() => {
        loadDepartamentos();
    }, [search]);

    const loadDepartamentos = async () => {
        try {
            setLoading(true);
            const response = await departamentosAPI.getAll({ page: 1, limit: 100, search });
            setDepartamentos(response.data.data);
        } catch (error) {
            console.error('Error loading departamentos:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreate = () => {
        setEditingDepto(null);
        setIsModalOpen(true);
    };

    const handleEdit = (depto: Departamento) => {
        setEditingDepto(depto);
        setIsModalOpen(true);
    };

    const handleDelete = async (id: number) => {
        if (!confirm('¿Está seguro de eliminar este departamento?')) return;
        try {
            await departamentosAPI.delete(id);
            loadDepartamentos();
        } catch (error) {
            console.error('Error deleting departamento:', error);
            alert('Error al eliminar el departamento');
        }
    };

    const handleFormSubmit = async (data: Partial<Departamento>) => {
        try {
            if (editingDepto) {
                await departamentosAPI.update(editingDepto.idDepartamento, data);
            } else {
                await departamentosAPI.create(data);
            }
            setIsModalOpen(false);
            loadDepartamentos();
        } catch (error) {
            console.error('Error saving departamento:', error);
            alert('Error al guardar el departamento');
        }
    };

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-secondary-900">Departamentos</h1>
                    <p className="text-secondary-600 mt-1">Gestión de departamentos</p>
                </div>
                {isAdmin && (
                    <button onClick={handleCreate} className="btn btn-primary flex items-center space-x-2">
                        <Plus className="w-4 h-4" />
                        <span>Nuevo Departamento</span>
                    </button>
                )}
            </div>

            <div className="card">
                <div className="mb-4">
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-secondary-400" />
                        <input
                            type="text"
                            placeholder="Buscar departamentos..."
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
                    <div className="overflow-x-auto">
                        <table className="table">
                            <thead className="table-header">
                                <tr>
                                    <th className="table-cell font-semibold">Nombre</th>
                                    <th className="table-cell font-semibold">Jefatura</th>
                                    <th className="table-cell font-semibold">Responsable</th>
                                    {isAdmin && <th className="table-cell font-semibold">Acciones</th>}
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-secondary-200">
                                {departamentos.map((dept) => (
                                    <tr key={dept.idDepartamento} className="hover:bg-secondary-50">
                                        <td className="table-cell text-secondary-900">{dept.nombre}</td>
                                        <td className="table-cell text-secondary-600">{dept.jefatura || '-'}</td>
                                        <td className="table-cell text-secondary-600">{dept.responsableNombre || '-'}</td>
                                        {isAdmin && (
                                            <td className="table-cell">
                                                <div className="flex items-center space-x-2">
                                                    <button
                                                        onClick={() => handleEdit(dept)}
                                                        className="p-1 hover:bg-primary-50 rounded text-primary-600"
                                                    >
                                                        <Edit className="w-4 h-4" />
                                                    </button>
                                                    <button
                                                        onClick={() => handleDelete(dept.idDepartamento)}
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
                )}
            </div>

            <Modal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                title={editingDepto ? 'Editar Departamento' : 'Nuevo Departamento'}
            >
                <DepartamentoForm
                    initialData={editingDepto}
                    onSubmit={handleFormSubmit}
                    onCancel={() => setIsModalOpen(false)}
                />
            </Modal>
        </div>
    );
};

export default DepartamentosList;
