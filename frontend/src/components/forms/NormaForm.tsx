import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Norma } from '../../types';

interface NormaFormProps {
    initialData?: Norma | null;
    onSubmit: (data: Partial<Norma>) => Promise<void>;
    onCancel: () => void;
}

const NormaForm: React.FC<NormaFormProps> = ({ initialData, onSubmit, onCancel }) => {
    const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Partial<Norma>>({
        defaultValues: initialData || {},
    });

    useEffect(() => {
        if (initialData) {
            reset(initialData);
        } else {
            reset({});
        }
    }, [initialData, reset]);

    const handleFormSubmit = async (data: Partial<Norma>) => {
        await onSubmit(data);
    };

    return (
        <form onSubmit={handleSubmit(handleFormSubmit)} className="space-y-4">
            <div>
                <label className="block text-sm font-medium text-secondary-700">Descripción</label>
                <input
                    {...register('descripcion', { required: 'La descripción es obligatoria' })}
                    className="input mt-1"
                    placeholder="Ej: Norma de Seguridad..."
                />
                {errors.descripcion && <span className="text-red-500 text-sm">{errors.descripcion.message}</span>}
            </div>

            <div>
                <label className="block text-sm font-medium text-secondary-700">Artículo</label>
                <input
                    {...register('articulo')}
                    className="input mt-1"
                    placeholder="Ej: Art. 184"
                />
            </div>

            <div>
                <label className="block text-sm font-medium text-secondary-700">Cuerpo Legal</label>
                <input
                    {...register('cuerpoLegal')}
                    className="input mt-1"
                    placeholder="Ej: Código del Trabajo"
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

export default NormaForm;
