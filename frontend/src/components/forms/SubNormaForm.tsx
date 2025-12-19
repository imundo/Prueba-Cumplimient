import React, { useEffect, useState } from 'react';
import { useForm } from 'react-hook-form';
import { SubNorma, Norma, Departamento } from '../../types';
import { normasAPI, departamentosAPI } from '../../lib/api';

interface SubNormaFormProps {
    initialData?: SubNorma | null;
    onSubmit: (data: Partial<SubNorma>) => Promise<void>;
    onCancel: () => void;
}

const SubNormaForm: React.FC<SubNormaFormProps> = ({ initialData, onSubmit, onCancel }) => {
    const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Partial<SubNorma>>({
        defaultValues: initialData || {},
    });
    const [normas, setNormas] = useState<Norma[]>([]);
    const [departamentos, setDepartamentos] = useState<Departamento[]>([]);

    useEffect(() => {
        const loadDependencies = async () => {
            try {
                const [normasRes, deptosRes] = await Promise.all([
                    normasAPI.getAll({ limit: 100 }),
                    departamentosAPI.getAll({ limit: 100 })
                ]);
                setNormas(normasRes.data.data);
                setDepartamentos(deptosRes.data.data);
            } catch (error) {
                console.error('Error loading dependencies:', error);
            }
        };
        loadDependencies();
    }, []);

    useEffect(() => {
        if (initialData) {
            reset(initialData);
        } else {
            reset({});
        }
    }, [initialData, reset]);

    const handleFormSubmit = async (data: Partial<SubNorma>) => {
        // Convert string IDs to numbers
        if (data.idNorma) data.idNorma = Number(data.idNorma);
        if (data.idDepartamento) data.idDepartamento = Number(data.idDepartamento);
        await onSubmit(data);
    };

    return (
        <form onSubmit={handleSubmit(handleFormSubmit)} className="space-y-4">
            <div>
                <label className="block text-sm font-medium text-secondary-700">Nombre</label>
                <input
                    {...register('nombre', { required: 'El nombre es obligatorio' })}
                    className="input mt-1"
                    placeholder="Ej: Capacitación en Seguridad"
                />
                {errors.nombre && <span className="text-red-500 text-sm">{errors.nombre.message}</span>}
            </div>

            <div className="grid grid-cols-2 gap-4">
                <div>
                    <label className="block text-sm font-medium text-secondary-700">Norma</label>
                    <select
                        {...register('idNorma', { required: 'La norma es obligatoria' })}
                        className="input mt-1"
                    >
                        <option value="">Seleccione Norma</option>
                        {normas.map(n => (
                            <option key={n.idNorma} value={n.idNorma}>{n.descripcion}</option>
                        ))}
                    </select>
                    {errors.idNorma && <span className="text-red-500 text-sm">{errors.idNorma.message}</span>}
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Departamento</label>
                    <select
                        {...register('idDepartamento', { required: 'El departamento es obligatorio' })}
                        className="input mt-1"
                    >
                        <option value="">Seleccione Departamento</option>
                        {departamentos.map(d => (
                            <option key={d.idDepartamento} value={d.idDepartamento}>{d.nombre}</option>
                        ))}
                    </select>
                    {errors.idDepartamento && <span className="text-red-500 text-sm">{errors.idDepartamento.message}</span>}
                </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
                <div>
                    <label className="block text-sm font-medium text-secondary-700">Numeral</label>
                    <input
                        {...register('numeral')}
                        className="input mt-1"
                        placeholder="Ej: 1.1"
                    />
                </div>
                <div>
                    <label className="block text-sm font-medium text-secondary-700">Periodicidad</label>
                    <input
                        {...register('periodicidad')}
                        className="input mt-1"
                        placeholder="Ej: Mensual"
                    />
                </div>
            </div>

            <div>
                <label className="block text-sm font-medium text-secondary-700">Descripción</label>
                <textarea
                    {...register('descripcion')}
                    className="input mt-1"
                    rows={3}
                    placeholder="Descripción detallada..."
                />
            </div>

            <div className="flex justify-end space-x-3 pt-4">
                <button
                    type="button"
                    onClick={onCancel}
                    className="btn btn-secondary"
                    disabled={isSubmitting}
                >
                    Cancelar
                </button>
                <button
                    type="submit"
                    className="btn btn-primary"
                    disabled={isSubmitting}
                >
                    {isSubmitting ? 'Guardando...' : 'Guardar'}
                </button>
            </div>
        </form>
    );
};

export default SubNormaForm;
