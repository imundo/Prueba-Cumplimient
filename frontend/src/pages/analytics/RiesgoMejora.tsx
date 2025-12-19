import React, { useEffect, useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { Calendar, AlertTriangle, TrendingUp, Shield, RefreshCw, ArrowUpRight } from 'lucide-react';
import { RiskMatrix } from '../../components/charts/RiskMatrix';
import { AlertsList } from '../../components/charts/AlertsList';
import { api } from '../../lib/api';
import Modal from '../../components/ui/Modal';

interface RiskPoint {
    id: number;
    name: string;
    probability: number;
    impact: number;
    quadrant: 'critical' | 'high' | 'medium' | 'low';
    incumplimientos?: number;
}

interface Alert {
    id: number;
    type: string;
    priority: 'alta' | 'media' | 'baja';
    title: string;
    description: string;
    coordinado?: string;
    norma?: string;
    fecha?: string;
    periodo?: string;
}

interface Opportunity {
    id: number;
    name: string;
    currentCompliance: number;
    potentialGain: number;
    incumplimientos: number;
    totalObligaciones: number;
    priority: 'alta' | 'media' | 'baja';
}

const RiesgoMejora: React.FC = () => {
    const [riskData, setRiskData] = useState<RiskPoint[]>([]);
    const [alerts, setAlerts] = useState<Alert[]>([]);
    const [opportunities, setOpportunities] = useState<Opportunity[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedYear, setSelectedYear] = useState<Date>(new Date());
    const [showRiskModal, setShowRiskModal] = useState(false);
    const [selectedRisk, setSelectedRisk] = useState<RiskPoint | null>(null);

    useEffect(() => {
        loadData();
    }, [selectedYear]);

    const loadData = async () => {
        try {
            setLoading(true);
            const year = selectedYear.getFullYear().toString();

            const [riskRes, alertsRes, opportunitiesRes] = await Promise.all([
                api.get(`/analytics/risk-matrix?year=${year}`),
                api.get(`/analytics/alerts?year=${year}`),
                api.get(`/analytics/improvement-opportunities?year=${year}`),
            ]);

            setRiskData(riskRes.data);
            setAlerts(alertsRes.data);
            setOpportunities(opportunitiesRes.data);
        } catch (error) {
            console.error('Error loading risk data:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleRiskClick = (point: RiskPoint) => {
        setSelectedRisk(point);
        setShowRiskModal(true);
    };

    const criticalCount = riskData.filter(r => r.quadrant === 'critical').length;
    const highCount = riskData.filter(r => r.quadrant === 'high').length;
    const globalRiskScore = riskData.length > 0
        ? (riskData.reduce((acc, r) => acc + (r.probability * r.impact) / 100, 0) / riskData.length).toFixed(1)
        : '0';

    const priorityColors = {
        alta: 'bg-red-100 text-red-700 border-red-200',
        media: 'bg-amber-100 text-amber-700 border-amber-200',
        baja: 'bg-green-100 text-green-700 border-green-200',
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center h-screen bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-dashboard-dark mx-auto mb-4"></div>
                    <p className="text-gray-600">Cargando análisis de riesgo...</p>
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
                        <label className="block text-sm font-medium text-gray-700 mb-2">Nivel de Riesgo</label>
                        <div className="space-y-2">
                            <label className="flex items-center cursor-pointer group">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="w-3 h-3 rounded-full bg-red-500 mr-2" />
                                <span className="text-sm">Crítico ({criticalCount})</span>
                            </label>
                            <label className="flex items-center cursor-pointer group">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="w-3 h-3 rounded-full bg-orange-400 mr-2" />
                                <span className="text-sm">Alto ({highCount})</span>
                            </label>
                            <label className="flex items-center cursor-pointer group">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="w-3 h-3 rounded-full bg-yellow-400 mr-2" />
                                <span className="text-sm">Medio</span>
                            </label>
                            <label className="flex items-center cursor-pointer group">
                                <input type="checkbox" className="mr-2 rounded" defaultChecked />
                                <span className="w-3 h-3 rounded-full bg-green-400 mr-2" />
                                <span className="text-sm">Bajo</span>
                            </label>
                        </div>
                    </div>

                    <div className="pt-4 border-t border-gray-200">
                        <p className="text-xs font-medium text-gray-600 mb-2">Resumen de Riesgo</p>
                        <div className="text-xs text-gray-500 space-y-1">
                            <p>• Coordinados analizados: {riskData.length}</p>
                            <p>• Alertas activas: {alerts.length}</p>
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
                                <AlertTriangle className="w-6 h-6 text-amber-500" />
                                Riesgo y Mejora
                            </h1>
                            <p className="text-sm text-gray-500 mt-1">
                                Matriz de riesgo, alertas activas y oportunidades de mejora
                            </p>
                        </div>
                    </div>
                </div>

                {/* Content */}
                <div className="px-8 py-6">
                    {/* Summary Cards */}
                    <div className="grid grid-cols-3 gap-6 mb-6">
                        <div className="bg-gradient-to-br from-red-500 to-red-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-red-100 text-sm">Riesgo Global</p>
                                    <p className="text-3xl font-bold mt-1">{globalRiskScore}%</p>
                                    <p className="text-red-200 text-sm mt-1">{criticalCount} críticos, {highCount} altos</p>
                                </div>
                                <Shield className="w-10 h-10 text-red-200" />
                            </div>
                        </div>

                        <div className="bg-gradient-to-br from-amber-500 to-amber-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-amber-100 text-sm">Alertas Activas</p>
                                    <p className="text-3xl font-bold mt-1">{alerts.length}</p>
                                    <p className="text-amber-200 text-sm mt-1">{alerts.filter(a => a.priority === 'alta').length} de alta prioridad</p>
                                </div>
                                <AlertTriangle className="w-10 h-10 text-amber-200" />
                            </div>
                        </div>

                        <div className="bg-gradient-to-br from-emerald-500 to-emerald-600 rounded-xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-emerald-100 text-sm">Oportunidades</p>
                                    <p className="text-3xl font-bold mt-1">{opportunities.length}</p>
                                    <p className="text-emerald-200 text-sm mt-1">coordinados con potencial</p>
                                </div>
                                <TrendingUp className="w-10 h-10 text-emerald-200" />
                            </div>
                        </div>
                    </div>

                    {/* Risk Matrix and Alerts */}
                    <div className="grid grid-cols-2 gap-6 mb-6">
                        <RiskMatrix
                            data={riskData}
                            title="Matriz de Riesgo"
                            subtitle={`Probabilidad vs Impacto - ${selectedYear.getFullYear()}`}
                            onPointClick={handleRiskClick}
                        />

                        <AlertsList
                            alerts={alerts}
                            title="Alertas Activas"
                            subtitle="Incumplimientos que requieren atención"
                        />
                    </div>

                    {/* Improvement Opportunities */}
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                            <div>
                                <h3 className="text-lg font-bold text-gray-900 flex items-center gap-2">
                                    <ArrowUpRight className="w-5 h-5 text-emerald-500" />
                                    Oportunidades de Mejora
                                </h3>
                                <p className="text-sm text-gray-500">Coordinados con mayor potencial de mejora</p>
                            </div>
                        </div>
                        <div className="overflow-x-auto">
                            <table className="w-full">
                                <thead className="bg-gray-50">
                                    <tr>
                                        <th className="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase">Coordinado</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Cumplimiento Actual</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Potencial de Mejora</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Incumplimientos</th>
                                        <th className="px-6 py-3 text-center text-xs font-semibold text-gray-600 uppercase">Prioridad</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-gray-100">
                                    {opportunities.slice(0, 10).map((opp, index) => (
                                        <tr
                                            key={opp.id}
                                            className="hover:bg-gray-50 cursor-pointer transition-colors"
                                            style={{ animationDelay: `${index * 30}ms` }}
                                        >
                                            <td className="px-6 py-4">
                                                <p className="font-medium text-gray-900">{opp.name}</p>
                                                <p className="text-xs text-gray-500">{opp.totalObligaciones} obligaciones</p>
                                            </td>
                                            <td className="px-6 py-4">
                                                <div className="flex items-center justify-center">
                                                    <div className="w-24 h-2 bg-gray-200 rounded-full overflow-hidden mr-2">
                                                        <div
                                                            className="h-full bg-blue-500 rounded-full transition-all duration-500"
                                                            style={{ width: `${opp.currentCompliance}%` }}
                                                        />
                                                    </div>
                                                    <span className="text-sm font-medium text-gray-700">{opp.currentCompliance}%</span>
                                                </div>
                                            </td>
                                            <td className="px-6 py-4 text-center">
                                                <span className="text-lg font-bold text-emerald-600">+{opp.potentialGain}%</span>
                                            </td>
                                            <td className="px-6 py-4 text-center">
                                                <span className="px-2 py-1 bg-red-100 text-red-700 rounded-full text-sm font-medium">
                                                    {opp.incumplimientos}
                                                </span>
                                            </td>
                                            <td className="px-6 py-4 text-center">
                                                <span className={`px-3 py-1 rounded-full text-xs font-semibold border ${priorityColors[opp.priority]}`}>
                                                    {opp.priority.toUpperCase()}
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

            {/* Risk Detail Modal */}
            <Modal
                isOpen={showRiskModal}
                onClose={() => setShowRiskModal(false)}
                title={`Detalle de Riesgo: ${selectedRisk?.name || ''}`}
            >
                {selectedRisk && (
                    <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                            <div className="bg-gray-50 rounded-lg p-4 text-center">
                                <p className="text-sm text-gray-500">Probabilidad</p>
                                <p className="text-2xl font-bold text-gray-900">{selectedRisk.probability}%</p>
                            </div>
                            <div className="bg-gray-50 rounded-lg p-4 text-center">
                                <p className="text-sm text-gray-500">Impacto</p>
                                <p className="text-2xl font-bold text-gray-900">{selectedRisk.impact}%</p>
                            </div>
                        </div>
                        <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                            <p className="text-sm text-red-700">
                                <span className="font-bold">{selectedRisk.incumplimientos}</span> incumplimientos detectados
                            </p>
                        </div>
                        <div className={`rounded-lg p-3 text-center ${selectedRisk.quadrant === 'critical' ? 'bg-red-100 text-red-700' :
                            selectedRisk.quadrant === 'high' ? 'bg-orange-100 text-orange-700' :
                                selectedRisk.quadrant === 'medium' ? 'bg-yellow-100 text-yellow-700' :
                                    'bg-green-100 text-green-700'
                            }`}>
                            <p className="font-semibold">Nivel de Riesgo: {selectedRisk.quadrant.toUpperCase()}</p>
                        </div>
                    </div>
                )}
            </Modal>
        </div>
    );
};

export default RiesgoMejora;
