import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Departamento } from '../../types';

interface DepartamentoFormProps {
    initialData?: Departamento | null;
    onSubmit: (data: Partial<Departamento>) => Promise<void>;
    onCancel: () => void;
}

const DepartamentoForm: React.FC<DepartamentoFormProps> = ({ initialData, onSubmit, onCancel }) => {
    const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Partial<Departamento>>({
        defaultValues: initialData || {},
    });

    useEffect(() => {
        if (initialData) {
            reset(initialData);
        } else {
            reset({});
        }
    }, [initialData, reset]);

    const handleFormSubmit = async (data: Partial<Departamento>) => {
        await onSubmit(data);
    };

    return (
        <form onSubmit={handleSubmit(handleFormSubmit)} className="space-y-4">
            <div>
                <label className="block text-sm font-medium text-secondary-700">Nombre</label>
                <input
                    {...register('nombre', { required: 'El nombre es obligatorio' })}
                    className="input mt-1"
                    placeholder="Ej: Departamento de Seguridad"
                />
                {errors.nombre && <span className="text-red-500 text-sm">{errors.nombre.message}</span>}
            </div>

            <div>
                <label className="block text-sm font-medium text-secondary-700">Jefatura</label>
                <input
                    {...register('jefatura')}
                    className="input mt-1"
                    placeholder="Ej: Jefatura de Prevención"
                />
            </div>

            <div>
                <label className="block text-sm font-medium text-secondary-700">Responsable</label>
                <input
                    {...register('responsableNombre')}
                    className="input mt-1"
                    placeholder="Ej: Juan Pérez"
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

export default DepartamentoForm;
