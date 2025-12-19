import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Reuc } from '../../types';

interface ReucFormProps {
    initialData?: Reuc | null;
    onSubmit: (data: Partial<Reuc>) => Promise<void>;
    onCancel: () => void;
}

const ReucForm: React.FC<ReucFormProps> = ({ initialData, onSubmit, onCancel }) => {
    const { register, handleSubmit, reset, formState: { errors, isSubmitting } } = useForm<Partial<Reuc>>({
        defaultValues: initialData || { estado: 'activo' },
    });

    useEffect(() => {
        if (initialData) {
            reset(initialData);
        } else {
            reset({ estado: 'activo' });
        }
    }, [initialData, reset]);

    const handleFormSubmit = async (data: Partial<Reuc>) => {
        await onSubmit(data);
    };

    return (
        <form onSubmit={handleSubmit(handleFormSubmit)} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label className="block text-sm font-medium text-secondary-700">Nombre Fantasía</label>
                    <input
                        {...register('nombreFantasia', { required: 'El nombre es obligatorio' })}
                        className="input mt-1"
                    />
                    {errors.nombreFantasia && <span className="text-red-500 text-sm">{errors.nombreFantasia.message}</span>}
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">RUT</label>
                    <input
                        {...register('rut', { required: 'El RUT es obligatorio' })}
                        className="input mt-1"
                        placeholder="12.345.678-9"
                    />
                    {errors.rut && <span className="text-red-500 text-sm">{errors.rut.message}</span>}
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Razón Social</label>
                    <input
                        {...register('razonSocial')}
                        className="input mt-1"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Gerente General</label>
                    <input
                        {...register('gerenteGeneral')}
                        className="input mt-1"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Email Gerente</label>
                    <input
                        {...register('correoElectronicoG')}
                        className="input mt-1"
                        type="email"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Teléfono</label>
                    <input
                        {...register('telefono')}
                        className="input mt-1"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Dirección</label>
                    <input
                        {...register('direccion')}
                        className="input mt-1"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Comuna</label>
                    <input
                        {...register('comuna')}
                        className="input mt-1"
                    />
                </div>

                <div>
                    <label className="block text-sm font-medium text-secondary-700">Estado</label>
                    <select
                        {...register('estado')}
                        className="input mt-1"
                    >
                        <option value="activo">Activo</option>
                        <option value="inactivo">Inactivo</option>
                    </select>
                </div>
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

export default ReucForm;
