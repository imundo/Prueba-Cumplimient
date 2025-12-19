import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { reucAPI } from '../../lib/api';
import { Reuc } from '../../types';
import { Building2, Mail, Phone, MapPin } from 'lucide-react';

const ReucDetail: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [reuc, setReuc] = useState<Reuc | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if (id) loadReuc(parseInt(id));
    }, [id]);

    const loadReuc = async (reucId: number) => {
        try {
            const response = await reucAPI.getOne(reucId);
            setReuc(response.data);
        } catch (error) {
            console.error('Error loading REUC:', error);
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

    if (!reuc) {
        return <div className="text-center py-12">Empresa no encontrada</div>;
    }

    return (
        <div className="space-y-6">
            <div>
                <h1 className="text-3xl font-bold text-secondary-900">{reuc.nombreFantasia}</h1>
                <p className="text-secondary-600 mt-1">RUT: {reuc.rut}</p>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="card">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4 flex items-center">
                        <Building2 className="w-5 h-5 mr-2 text-primary-600" />
                        Información General
                    </h2>
                    <div className="space-y-3">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Razón Social</p>
                            <p className="text-secondary-900">{reuc.razonSocial || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Tipo</p>
                            <p className="text-secondary-900">{reuc.tipo || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Estado</p>
                            <span className={`px-2 py-1 text-xs font-medium rounded-full ${reuc.estado === 'activo' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                                }`}>
                                {reuc.estado}
                            </span>
                        </div>
                    </div>
                </div>

                <div className="card">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4 flex items-center">
                        <MapPin className="w-5 h-5 mr-2 text-primary-600" />
                        Ubicación
                    </h2>
                    <div className="space-y-3">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Dirección</p>
                            <p className="text-secondary-900">{reuc.direccion || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Comuna</p>
                            <p className="text-secondary-900">{reuc.comuna || '-'}</p>
                        </div>
                        <div className="flex items-center space-x-2">
                            <Phone className="w-4 h-4 text-secondary-600" />
                            <p className="text-secondary-900">{reuc.telefono || '-'}</p>
                        </div>
                    </div>
                </div>

                <div className="card lg:col-span-2">
                    <h2 className="text-lg font-semibold text-secondary-900 mb-4 flex items-center">
                        <Mail className="w-5 h-5 mr-2 text-primary-600" />
                        Contactos
                    </h2>
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Gerente General</p>
                            <p className="text-secondary-900">{reuc.gerenteGeneral || '-'}</p>
                            <p className="text-sm text-secondary-600">{reuc.correoElectronicoG || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Encargado Titular</p>
                            <p className="text-secondary-900">{reuc.encargadoTitular || '-'}</p>
                            <p className="text-sm text-secondary-600">{reuc.correoElectronicoEt || '-'}</p>
                        </div>
                        <div>
                            <p className="text-sm font-medium text-secondary-600">Encargado Suplente</p>
                            <p className="text-secondary-900">{reuc.encargadoSuplente || '-'}</p>
                            <p className="text-sm text-secondary-600">{reuc.correoElectronicoEs || '-'}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ReucDetail;
