import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { cartasIncpmtAPI } from '../../lib/api';
import { CartaIncpmt } from '../../types';
import { Mail } from 'lucide-react';

const CartaDetail: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [carta, setCarta] = useState<CartaIncpmt | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if (id) loadCarta(parseInt(id));
    }, [id]);

    const loadCarta = async (cartaId: number) => {
        try {
            const response = await cartasIncpmtAPI.getOne(cartaId);
            setCarta(response.data);
        } catch (error) {
            console.error('Error loading carta:', error);
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

    if (!carta) {
        return <div className="text-center py-12">Carta no encontrada</div>;
    }

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-3xl font-bold text-secondary-900">Carta de Incumplimiento #{carta.idCartaIncpmt}</h1>
                <p className="text-secondary-600 mt-1">Detalle de la carta y seguimiento</p>
            </div>

            <div className="card">
                <h2 className="text-lg font-semibold text-secondary-900 mb-4 flex items-center">
                    <Mail className="w-5 h-5 mr-2 text-primary-600" />
                    Información de la Carta
                </h2>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <p className="text-sm font-medium text-secondary-600">Correlativo</p>
                        <p className="text-secondary-900">{carta.correlativoCorrespondencia || '-'}</p>
                    </div>
                    <div>
                        <p className="text-sm font-medium text-secondary-600">Fecha Creación</p>
                        <p className="text-secondary-900">{new Date(carta.fechaCreacion).toLocaleDateString('es-CL')}</p>
                    </div>
                    <div>
                        <p className="text-sm font-medium text-secondary-600">Autoridad</p>
                        <p className="text-secondary-900">{carta.autoridad || '-'}</p>
                    </div>
                    <div>
                        <p className="text-sm font-medium text-secondary-600">Fecha Carta</p>
                        <p className="text-secondary-900">{carta.fechaCarta ? new Date(carta.fechaCarta).toLocaleDateString('es-CL') : '-'}</p>
                    </div>
                    <div className="md:col-span-2">
                        <p className="text-sm font-medium text-secondary-600">Materia Macro</p>
                        <p className="text-secondary-900">{carta.materiaMacro || '-'}</p>
                    </div>
                    <div className="md:col-span-2">
                        <p className="text-sm font-medium text-secondary-600">Materia Micro</p>
                        <p className="text-secondary-900">{carta.materiaMicro || '-'}</p>
                    </div>
                    <div className="md:col-span-2">
                        <p className="text-sm font-medium text-secondary-600">Referencia</p>
                        <p className="text-secondary-900">{carta.referencia || '-'}</p>
                    </div>
                    {carta.hipervinculo && (
                        <div className="md:col-span-2">
                            <p className="text-sm font-medium text-secondary-600">Hipervínculo</p>
                            <a href={carta.hipervinculo} target="_blank" rel="noopener noreferrer" className="text-primary-600 hover:underline">
                                {carta.hipervinculo}
                            </a>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default CartaDetail;
