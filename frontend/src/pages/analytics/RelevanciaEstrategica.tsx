import React, { useEffect, useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { Calendar, Star, TrendingUp, Target, RefreshCw } from 'lucide-react';
import { HorizontalBarChart } from '../../components/charts/HorizontalBarChart';
import { api } from '../../lib/api';

interface RelevanceItem {
    id: number;
    name: string;
    norma: string;
    totalCoordinados: number;
    cumplimiento: number;
    impactScore: number;
    riskScore: number;
    relevanceScore: number;
}

const RelevanciaEstrategica: React.FC = () => {
    const [relevanceData, setRelevanceData] = useState<RelevanceItem[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedYear, setSelectedYear] = useState<Date>(new Date());

    useEffect(() => {
        loadData();
    }, [selectedYear]);

    const loadData = async () => {
        try {
            setLoading(true);
            const year = selectedYear.getFullYear().toString();
            const response = await api.get(`/analytics/strategic-relevance?year=${year}`);
            setRelevanceData(response.data);
        } catch (error) {
            console.error('Error loading strategic relevance data:', error);
        } finally {
            setLoading(false);
        }
    };

    const getRelevanceColor = (score: number) => {
        if (score >= 70) return 'text-red-600 bg-red-50';
        if (score >= 40) return 'text-amber-600 bg-amber-50';
        return 'text-green-600 bg-green-50';
    };

    const topNormas = relevanceData.slice(0, 3);
    const avgRelevance = relevanceData.length > 0
        ? (relevanceData.reduce((acc, item) => acc + item.relevanceScore, 0) / relevanceData.length).toFixed(1)
        : '0';

    if (loading) {
        return (
            <div className="flex items-center justify-center h-screen bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-dashboard-dark mx-auto mb-4"></div>
                    <p className="text-gray-600">Cargando análisis de relevancia...</p>
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
                        onClick={loadData}
                        className="text-xs text-dashboard-dark hover:text-dashboard-blue font-medium flex items-center gap-1"
                    >
                        <RefreshCw className="w-3 h-3" />
                        Actualizar
                    </button>
                </div>

                <div className="space-y-6">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">Categoría de Coordinado</label>
                        <select className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue transition-all">
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
                            onChange={(date: Date | null) => date && setSelectedYear(date)}
                            showYearPicker
                            dateFormat="yyyy"
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue transition-all"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-2">Tipo de Norma</label>
                        <select className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue transition-all">
                            <option>Todos</option>
                        </select>
                    </div>

                    <div className="pt-4 border-t border-gray-200">
                        <p className="text-xs font-medium text-gray-600 mb-2">Filtros Activos</p>
                        <div className="text-xs text-gray-500 space-y-1">
                            <p>• Año: {selectedYear.getFullYear()}</p>
                            <p>• Todos los coordinados</p>
                        </div>
                    </div>
                </div>
            </div>

            {/* Main Content */}
            <div className="flex-1 overflow-y-auto">
                {/* Header */}
                <div className="bg-white border-b border-gray-200 px-8 py-6">
                    <div className="flex items-center justify-between">
                        <div>
                            <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
                                <Star className="w-6 h-6 text-amber-500" />
                                Relevancia Estratégica
                            </h1>
                            <p className="text-sm text-gray-500 mt-1">
                                Análisis de normas y coordinados con mayor relevancia para el cumplimiento
                            </p>
                        </div>
                    </div>
                </div>

                {/* Content */}
                <div className="px-8 py-6">
                    {/* Summary Cards */}
                    <div className="grid grid-cols-3 gap-6 mb-6">
                        <div className="bg-gradient-to-br from-amber-500 to-amber-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-amber-100 text-sm">Top Norma Relevante</p>
                                    <p className="text-xl font-bold mt-1 truncate">{topNormas[0]?.name || 'N/A'}</p>
                                    <p className="text-amber-200 text-sm mt-1">{topNormas[0]?.totalCoordinados || 0} coordinados</p>
                                </div>
                                <Star className="w-10 h-10 text-amber-200" />
                            </div>
                        </div>

                        <div className="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-blue-100 text-sm">Normas Analizadas</p>
                                    <p className="text-3xl font-bold mt-1">{relevanceData.length}</p>
                                    <p className="text-blue-200 text-sm mt-1">en {selectedYear.getFullYear()}</p>
                                </div>
                                <Target className="w-10 h-10 text-blue-200" />
                            </div>
                        </div>

                        <div className="bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-purple-100 text-sm">Relevancia Promedio</p>
                                    <p className="text-3xl font-bold mt-1">{avgRelevance}%</p>
                                    <p className="text-purple-200 text-sm mt-1">del período</p>
                                </div>
                                <TrendingUp className="w-10 h-10 text-purple-200" />
                            </div>
                        </div>
                    </div>

                    {/* Ranking Chart */}
                    <HorizontalBarChart
                        data={relevanceData.slice(0, 10).map(item => ({
                            name: item.name.length > 30 ? item.name.substring(0, 30) + '...' : item.name,
                            compliance: item.relevanceScore,
                        }))}
                        title="Ranking de Normas por Relevancia Estratégica"
                        subtitle={`Top 10 normas ordenadas por score de relevancia - ${selectedYear.getFullYear()}`}
                        dataKey="compliance"
                        nameKey="name"
                        color="#0A2540"
                    />

                    {/* Detailed Table */}
                    <div className="mt-6 bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                        <div className="px-6 py-4 border-b border-gray-100">
                            <h3 className="text-lg font-bold text-gray-900">Detalle de Relevancia por Norma</h3>
                        </div>
                        <div className="overflow-x-auto">
                            <table className="w-full">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th className="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Norma</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Coordinados</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Cumplimiento</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Impacto</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Riesgo</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Relevancia</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-gray-100">
                                    {relevanceData.slice(0, 15).map((item) => (
                                        <tr
                                            key={item.id}
                                            className="hover:bg-gray-50 cursor-pointer transition-colors"
                                        >
                                            <td className="px-6 py-4">
                                                <p className="font-medium text-gray-900 truncate max-w-xs">{item.name}</p>
                                                <p className="text-xs text-gray-500">{item.norma}</p>
                                            </td>
                                            <td className="px-6 py-4 text-center text-gray-600">{item.totalCoordinados}</td>
                                            <td className="px-6 py-4 text-center">
                                                <span className={`px-2 py-1 rounded-full text-xs font-medium ${item.cumplimiento >= 80 ? 'bg-green-100 text-green-700' :
                                                        item.cumplimiento >= 50 ? 'bg-amber-100 text-amber-700' :
                                                            'bg-red-100 text-red-700'
                                                    }`}>
                                                    {item.cumplimiento}%
                                                </span>
                                            </td>
                                            <td className="px-6 py-4 text-center text-gray-600">{item.impactScore}%</td>
                                            <td className="px-6 py-4 text-center text-gray-600">{item.riskScore}%</td>
                                            <td className="px-6 py-4 text-center">
                                                <span className={`px-3 py-1 rounded-full text-sm font-bold ${getRelevanceColor(item.relevanceScore)}`}>
                                                    {item.relevanceScore}%
                                                </span>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default RelevanciaEstrategica;

