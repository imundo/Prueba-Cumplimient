import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { cumplimientosAPI } from '../../lib/api';
import { Cumplimiento } from '../../types';
import { CheckCircle } from 'lucide-react';

const CumplimientoDetail: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [cumplimiento, setCumplimiento] = useState<Cumplimiento | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if (id) loadCumplimiento(parseInt(id));
    }, [id]);

    const loadCumplimiento = async (cumplimientoId: number) => {
        try {
            const response = await cumplimientosAPI.getOne(cumplimientoId);
            setCumplimiento(response.data);
        } catch (error) {
            console.error('Error loading cumplimiento:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div className="flex justify-center py-12">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
        );
    }

    if (!cumplimiento) {
        return <div className="text-center py-12">Cumplimiento no encontrado</div>;
    }

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-3xl font-bold text-secondary-900">Detalle de Cumplimiento #{cumplimiento.idCumplimiento}</h1>
                <p className="text-secondary-600 mt-1">Información completa del registro de cumplimiento</p>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="card">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4 flex items-center">
                        <CheckCircle className="w-5 h-5 mr-2 text-primary-600" />
                        Información General
                    </h2>
                    <div className="space-y-3">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Estado</p>
                            <span className={`px-2 py-1 text-xs font-medium rounded-full ${cumplimiento.estado === 'cumple' ? 'bg-green-100 text-green-800' :
                                    cumplimiento.estado === 'no cumple' ? 'bg-red-100 text-red-800' :
                                        'bg-yellow-100 text-yellow-800'
                                }`}>
                                {cumplimiento.estado}
                            </span>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Año</p>
                            <p className="text-secondary-900">{cumplimiento.anio || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Período</p>
                            <p className="text-secondary-900">{cumplimiento.periodoCumplimiento || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Valor</p>
                            <p className="text-secondary-900">{cumplimiento.valor || '-'}</p>
                        </div>
                    </div>
                </div>

                <div className="card">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4">Empresa REUC</h2>
                    <div className="space-y-3">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Nombre</p>
                            <p className="text-secondary-900">{cumplimiento.reuc?.nombreFantasia || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">RUT</p>
                            <p className="text-secondary-900">{cumplimiento.reuc?.rut || '-'}</p>
                        </div>
                    </div>
                </div>

                <div className="card lg:col-span-2">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4">Normativa</h2>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Sub-Norma</p>
                            <p className="text-secondary-900">{cumplimiento.subNorma?.nombre || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Tipo de Cumplimiento</p>
                            <p className="text-secondary-900">{cumplimiento.tipoCumplimiento?.nombre || '-'}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default CumplimientoDetail;
