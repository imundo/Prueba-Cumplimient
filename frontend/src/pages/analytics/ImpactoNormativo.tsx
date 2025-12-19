import React, { useEffect, useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { Calendar } from 'lucide-react';
import { HorizontalBarChart } from '../../components/charts/HorizontalBarChart';
import { ScatterChart } from '../../components/charts/ScatterChart';
import { api } from '../../lib/api';

const ImpactoNormativo: React.FC = () => {
    const [normasRanking, setNormasRanking] = useState<any[]>([]);
    const [impactMap, setImpactMap] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedYear, setSelectedYear] = useState<Date>(new Date());

    useEffect(() => {
        loadImpactData();
    }, [selectedYear]);

    const loadImpactData = async () => {
        try {
            setLoading(true);

            const year = selectedYear.getFullYear().toString();

            const [normasRes, impactRes] = await Promise.all([
                api.get(`/analytics/normas-ranking?limit=8&year=${year}`),
                api.get(`/analytics/impact-map?year=${year}`),
            ]);

            setNormasRanking(normasRes.data);
            setImpactMap(impactRes.data);
        } catch (error) {
            console.error('Error loading impact data:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center h-screen bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-dashboard-dark mx-auto mb-4"></div>
                    <p className="text-gray-600">Cargando datos...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="flex h-screen bg-gray-50">
            {/* Left Sidebar - Filters */}
            <div className="w-72 bg-white border-r border-gray-200 p-6 overflow-y-auto">
                <div className="flex items-center justify-between mb-6">
                    <h3 className="text-sm font-semibold text-gray-900">Filtros</h3>
                    <button
                        onClick={loadImpactData}
                        className="text-xs text-dashboard-dark hover:text-dashboard-blue font-medium"
                    >
                        Actualizar
                    </button>
                </div>

                <div className="space-y-6">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">Categoría de Coordinado</label>
                        <select className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue">
                            <option>Todos</option>
                        </select>
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">Zona del SEN</label>
                        <select className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue">
                            <option>Todos</option>
                        </select>
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center">
                            <Calendar className="w-3 h-3 mr-1" />
                            Año
                        </label>
                        <DatePicker
                            selected={selectedYear}
                            onChange={(date: Date) => setSelectedYear(date)}
                            showYearPicker
                            dateFormat="yyyy"
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">Tipo de Norma</label>
                        <select className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue">
                            <option>Todos</option>
                        </select>
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-3">Rango de Cumplimiento</label>
                        <div className="space-y-2">
                            <label className="flex items-center">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="text-sm">Alto (≥ 80%)</span>
                            </label>
                            <label className="flex items-center">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="text-sm">Medio (70-80%)</span>
                            </label>
                            <label className="flex items-center">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="text-sm">Bajo (&lt; 70%)</span>
                            </label>
                        </div>
                    </div>

                    <div className="pt-4 border-t border-gray-200">
                        <p className="text-xs font-medium text-gray-600 mb-2">Filtros Activos</p>
                        <div className="text-xs text-gray-500 space-y-1">
                            <p>• Año: {selectedYear.getFullYear()}</p>
                            <p>• Todos los coordinados</p>
                            <p>• Todas las categorías</p>
                        </div>
                    </div>
                </div>
            </div>

            {/* Main Content */}
            <div className="flex-1 overflow-y-auto">
                {/* Header */}
                <div className="bg-white border-b border-gray-200 px-8 py-6">
                    <h1 className="text-2xl font-bold text-gray-900">Impacto Normativo</h1>
                    <p className="text-sm text-gray-500 mt-1">
                        Análisis de exposición normativa: qué coordinados están más expuestos, y qué normas tienen mayor alcance
                    </p>
                </div>

                {/* Content */}
                <div className="px-8 py-6">
                    {/* Ranking Chart */}
                    <HorizontalBarChart
                        data={normasRanking}
                        title="Ranking de Coordinados por Número de Normas Aplicables"
                        subtitle={`Año ${selectedYear.getFullYear()} - Ordenados por mayor exposición normativa`}
                        dataKey="applicableCoordinados"
                        nameKey="descripcion"
                        color="#0A2540"
                    />

                    {/* Impact Map Scatter Plot */}
                    <ScatterChart
                        data={impactMap}
                        title="Mapa de Impacto: Normas vs Coordinados vs Cumplimiento"
                        subtitle={`Año ${selectedYear.getFullYear()} - Tamaño de burbuja = número de coordinados aplicables`}
                        xAxisLabel="Número de Coordinados Aplicables"
                        yAxisLabel="% Cumplimiento"
                    />

                    {/* Summary Cards */}
                    <div className="mt-6 grid grid-cols-3 gap-6">
                        <div className="bg-white rounded-lg shadow-sm p-6">
                            <p className="text-sm text-gray-600 mb-2">Normas con Mayor Impacto</p>
                            <p className="text-3xl font-bold text-gray-900">{normasRanking.length > 0 ? normasRanking[0]?.descripcion.substring(0, 20) + '...' : 'N/A'}</p>
                            <p className="text-sm text-success mt-1">
                                {normasRanking.length > 0 ? `${normasRanking[0]?.applicableCoordinados} coordinados` : ''}
                            </p>
                        </div>

                        <div className="bg-white rounded-lg shadow-sm p-6">
                            <p className="text-sm text-gray-600 mb-2">Total de Normas Analizadas</p>
                            <p className="text-3xl font-bold text-gray-900">{normasRanking.length}</p>
                            <p className="text-sm text-gray-500 mt-1">en {selectedYear.getFullYear()}</p>
                        </div>

                        <div className="bg-white rounded-lg shadow-sm p-6">
                            <p className="text-sm text-gray-600 mb-2">Cumplimiento Promedio</p>
                            <p className="text-3xl font-bold text-gray-900">
                                {impactMap.length > 0
                                    ? `${(impactMap.reduce((acc, item) => acc + item.avgCompliance, 0) / impactMap.length).toFixed(1)}%`
                                    : 'N/A'
                                }
                            </p>
                            <p className="text-sm text-gray-500 mt-1">del período</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ImpactoNormativo;
