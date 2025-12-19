import React, { useEffect, useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { Calendar, CheckCircle, BarChart3, RefreshCw } from 'lucide-react';
import { DonutChart } from '../../components/charts/DonutChart';
import { LineChart } from '../../components/charts/LineChart';
import { api } from '../../lib/api';
import Modal from '../../components/ui/Modal';

interface DistributionItem {
    name: string;
    value: number;
    color: string;
    percentage: number;
}

interface BehaviorMonth {
    month: string;
    cumple: number;
    noCumple: number;
    total: number;
}

const CumplimientoComportamiento: React.FC = () => {
    const [distribution, setDistribution] = useState<DistributionItem[]>([]);
    const [distributionTotal, setDistributionTotal] = useState(0);
    const [behaviorTrend, setBehaviorTrend] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [selectedYear, setSelectedYear] = useState<Date>(new Date());
    const [showDetailModal, setShowDetailModal] = useState(false);
    const [selectedState, setSelectedState] = useState<DistributionItem | null>(null);

    useEffect(() => {
        loadData();
    }, [selectedYear]);

    const loadData = async () => {
        try {
            setLoading(true);
            const year = selectedYear.getFullYear().toString();

            const [distributionRes, behaviorRes] = await Promise.all([
                api.get(`/analytics/compliance-distribution?year=${year}`),
                api.get(`/analytics/behavior-trend?year=${year}`),
            ]);

            setDistribution(distributionRes.data.distribution);
            setDistributionTotal(distributionRes.data.total);
            setBehaviorTrend(behaviorRes.data);
        } catch (error) {
            console.error('Error loading compliance data:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleStateClick = (state: DistributionItem) => {
        setSelectedState(state);
        setShowDetailModal(true);
    };

    // Transform behavior data for LineChart
    const chartData = behaviorTrend ? {
        currentYear: behaviorTrend.currentYear.data.map((d: BehaviorMonth) => ({
            month: d.month,
            value: d.total > 0 ? parseFloat(((d.cumple / d.total) * 100).toFixed(1)) : 0,
        })),
        previousYear: behaviorTrend.previousYear.data.map((d: BehaviorMonth) => ({
            month: d.month,
            value: d.total > 0 ? parseFloat(((d.cumple / d.total) * 100).toFixed(1)) : 0,
        })),
    } : null;

    const cumplePercentage = distribution.find(d => d.name === 'Cumple')?.percentage || 0;

    if (loading) {
        return (
            <div className="flex items-center justify-center h-screen bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-dashboard-dark mx-auto mb-4"></div>
                    <p className="text-gray-600">Cargando análisis de cumplimiento...</p>
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
                        <label className="block text-sm font-medium text-gray-700 mb-2">Estado de Cumplimiento</label>
                        <div className="space-y-2">
                            {distribution.map((item) => (
                                <label key={item.name} className="flex items-center cursor-pointer group">
                                    <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                    <span
                                        className="w-3 h-3 rounded-full mr-2"
                                        style={{ backgroundColor: item.color }}
                                    />
                                    <span className="text-sm group-hover:text-dashboard-blue transition-colors">{item.name}</span>
                                    <span className="ml-auto text-xs text-gray-500">{item.percentage}%</span>
                                </label>
                            ))}
                        </div>
                    </div>

                    <div className="pt-4 border-t border-gray-200">
                        <p className="text-xs font-medium text-gray-600 mb-2">Resumen</p>
                        <div className="text-xs text-gray-500 space-y-1">
                            <p>• Total registros: {distributionTotal.toLocaleString()}</p>
                            <p>• Año: {selectedYear.getFullYear()}</p>
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
                                <CheckCircle className="w-6 h-6 text-green-500" />
                                Cumplimiento y Comportamiento
                            </h1>
                            <p className="text-sm text-gray-500 mt-1">
                                Análisis de distribución y evolución del cumplimiento normativo
                            </p>
                        </div>
                    </div>
                </div>

                {/* Content */}
                <div className="px-8 py-6">
                    {/* Summary Cards */}
                    <div className="grid grid-cols-4 gap-4 mb-6">
                        {distribution.map((item) => (
                            <div
                                key={item.name}
                                onClick={() => handleStateClick(item)}
                                className="bg-white rounded-xl p-5 shadow-sm border border-gray-100 cursor-pointer hover:shadow-md hover:scale-[1.02] transition-all"
                            >
                                <div className="flex items-center justify-between mb-3">
                                    <div
                                        className="w-10 h-10 rounded-full flex items-center justify-center"
                                        style={{ backgroundColor: `${item.color}20` }}
                                    >
                                        <div
                                            className="w-4 h-4 rounded-full"
                                            style={{ backgroundColor: item.color }}
                                        />
                                    </div>
                                    <span className="text-2xl font-bold text-gray-900">{item.percentage}%</span>
                                </div>
                                <p className="text-sm font-medium text-gray-700">{item.name}</p>
                                <p className="text-xs text-gray-500">{item.value.toLocaleString()} registros</p>
                            </div>
                        ))}
                    </div>

                    {/* Charts Grid */}
                    <div className="grid grid-cols-2 gap-6 mb-6">
                        {/* Donut Chart */}
                        <DonutChart
                            data={distribution}
                            title="Distribución por Estado"
                            subtitle={`Año ${selectedYear.getFullYear()}`}
                            centerValue={`${cumplePercentage}%`}
                            centerLabel="Cumple"
                        />

                        {/* Behavior Trend */}
                        {chartData && (
                            <LineChart
                                data={chartData}
                                title="Evolución del Cumplimiento"
                                subtitle={`${behaviorTrend?.currentYear?.year} vs ${behaviorTrend?.previousYear?.year}`}
                            />
                        )}
                    </div>

                    {/* Monthly Summary Table */}
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                            <h3 className="text-lg font-bold text-gray-900 flex items-center gap-2">
                                <BarChart3 className="w-5 h-5 text-gray-500" />
                                Resumen Mensual {selectedYear.getFullYear()}
                            </h3>
                        </div>
                        <div className="overflow-x-auto">
                            <table className="w-full">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th className="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Mes</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Cumple</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">No Cumple</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Total</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">% Cumplimiento</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-gray-100">
                                    {behaviorTrend?.currentYear?.data?.map((month: BehaviorMonth) => {
                                        const pct = month.total > 0 ? ((month.cumple / month.total) * 100).toFixed(1) : '0.0';
                                        return (
                                            <tr key={month.month} className="hover:bg-gray-50 transition-colors">
                                                <td className="px-6 py-4 font-medium text-gray-900">{month.month}</td>
                                                <td className="px-6 py-4 text-center text-green-600 font-medium">{month.cumple}</td>
                                                <td className="px-6 py-4 text-center text-red-600 font-medium">{month.noCumple}</td>
                                                <td className="px-6 py-4 text-center text-gray-600">{month.total}</td>
                                                <td className="px-6 py-4 text-center">
                                                    <div className="flex items-center justify-center">
                                                        <div className="w-20 h-2 bg-gray-200 rounded-full overflow-hidden mr-2">
                                                            <div
                                                                className="h-full bg-green-500 rounded-full transition-all duration-500"
                                                                style={{ width: `${pct}%` }}
                                                            />
                                                        </div>
                                                        <span className="text-sm font-medium text-gray-700">{pct}%</span>
                                                    </div>
                                                </td>
                                            </tr>
                                        );
                                    })}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            {/* Detail Modal */}
            <Modal
                isOpen={showDetailModal}
                onClose={() => setShowDetailModal(false)}
                title={`Detalle: ${selectedState?.name || ''}`}
            >
                {selectedState && (
                    <div className="space-y-4">
                        <div className="flex items-center space-x-3">
                            <div
                                className="w-12 h-12 rounded-full flex items-center justify-center"
                                style={{ backgroundColor: `${selectedState.color}20` }}
                            >
                                <div
                                    className="w-6 h-6 rounded-full"
                                    style={{ backgroundColor: selectedState.color }}
                                />
                            </div>
                            <div>
                                <p className="text-2xl font-bold text-gray-900">{selectedState.value.toLocaleString()}</p>
                                <p className="text-sm text-gray-500">registros en estado {selectedState.name}</p>
                            </div>
                        </div>
                        <div className="bg-gray-50 rounded-lg p-4">
                            <p className="text-sm text-gray-600">
                                Representa el <span className="font-bold text-gray-900">{selectedState.percentage}%</span> del total
                                de {distributionTotal.toLocaleString()} registros del año {selectedYear.getFullYear()}.
                            </p>
                        </div>
                    </div>
                )}
            </Modal>
        </div>
    );
};

export default CumplimientoComportamiento;
