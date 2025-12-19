import React, { useEffect, useState } from 'react';
import {
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    Legend,
    ResponsiveContainer,
    Area,
    AreaChart,
} from 'recharts';
import { TrendingUp, Calendar, LogIn, Shield, BarChart3, Zap, ChevronRight } from 'lucide-react';
import { api } from '../../lib/api';
import LoginModal from '../../components/ui/LoginModal';

interface ComplianceData {
    month: string;
    value: number;
}

interface SegmentCompliance {
    segmentId: number;
    segmentName: string;
    months: { month: string; compliance: number }[];
    average: number;
}

interface PublicComplianceData {
    complianceTrend: {
        currentYear: ComplianceData[];
        previousYear: ComplianceData[];
    };
    complianceBySegment: SegmentCompliance[];
    years: string[];
    currentYear: string;
}

const getComplianceGradient = (value: number): string => {
    if (value >= 90) return 'from-emerald-500 to-emerald-600';
    if (value >= 80) return 'from-emerald-400 to-emerald-500';
    if (value >= 70) return 'from-yellow-400 to-yellow-500';
    if (value >= 60) return 'from-orange-400 to-orange-500';
    if (value >= 50) return 'from-orange-500 to-orange-600';
    return 'from-red-500 to-red-600';
};

const CumplimientoPublico: React.FC = () => {
    const [data, setData] = useState<PublicComplianceData | null>(null);
    const [loading, setLoading] = useState(true);
    const [selectedYear, setSelectedYear] = useState<string>('2025');
    const [availableYears, setAvailableYears] = useState<string[]>([]);
    const [showLoginModal, setShowLoginModal] = useState(false);

    useEffect(() => {
        loadData();
    }, [selectedYear]);

    const loadData = async () => {
        try {
            setLoading(true);
            const response = await api.get(`/analytics/public-compliance?year=${selectedYear}`);
            setData(response.data);
            if (response.data.years && response.data.years.length > 0) {
                setAvailableYears(response.data.years);
            }
        } catch (error) {
            console.error('Error loading public compliance data:', error);
        } finally {
            setLoading(false);
        }
    };

    const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];

    // Prepare chart data
    const chartData = data?.complianceTrend.currentYear.map((item, index) => ({
        month: item.month,
        current: item.value,
        previous: data?.complianceTrend.previousYear[index]?.value || 0,
    })) || [];

    // Calculate summary stats
    const currentValues = data?.complianceTrend.currentYear.filter(v => v.value > 0) || [];
    const avgCompliance = currentValues.length > 0
        ? (currentValues.reduce((a, b) => a + b.value, 0) / currentValues.length).toFixed(1)
        : '0';

    if (loading) {
        return (
            <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex items-center justify-center">
                <div className="text-center">
                    <div className="relative">
                        <div className="w-16 h-16 border-4 border-teal-500/30 rounded-full animate-pulse" />
                        <div className="absolute inset-0 w-16 h-16 border-4 border-transparent border-t-teal-400 rounded-full animate-spin" />
                    </div>
                    <p className="text-slate-300 mt-6 font-medium">Cargando datos de cumplimiento...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 relative overflow-hidden">
            {/* Background decorations */}
            <div className="absolute inset-0 overflow-hidden pointer-events-none">
                <div className="absolute -top-40 -right-40 w-96 h-96 bg-teal-500/10 rounded-full blur-3xl" />
                <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-cyan-500/10 rounded-full blur-3xl" />
                <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-gradient-radial from-teal-500/5 to-transparent rounded-full" />
            </div>

            {/* Header */}
            <header className="relative z-10 border-b border-slate-700/50 bg-slate-900/90 backdrop-blur-xl sticky top-0">
                <div className="w-full px-4 lg:px-8 py-3">
                    <div className="flex items-center justify-between">
                        {/* Logo & Brand */}
                        <div className="flex items-center gap-4">
                            <div className="relative">
                                <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-teal-400 to-cyan-500 flex items-center justify-center shadow-lg shadow-teal-500/25">
                                    <Shield className="w-6 h-6 text-white" />
                                </div>
                                <div className="absolute -bottom-1 -right-1 w-4 h-4 bg-emerald-400 rounded-full border-2 border-slate-900 flex items-center justify-center">
                                    <Zap className="w-2.5 h-2.5 text-slate-900" />
                                </div>
                            </div>
                            <div>
                                <h1 className="text-xl font-bold text-white tracking-tight">
                                    Cumplimiento Normativo
                                </h1>
                                <p className="text-xs text-slate-400">Coordinador Eléctrico Nacional</p>
                            </div>
                        </div>

                        {/* Login Button */}
                        <button
                            onClick={() => setShowLoginModal(true)}
                            className="group relative px-6 py-2.5 rounded-xl font-semibold text-white transition-all duration-300 overflow-hidden"
                        >
                            <div className="absolute inset-0 bg-gradient-to-r from-teal-500 to-cyan-500 group-hover:from-teal-400 group-hover:to-cyan-400 transition-all duration-300" />
                            <div className="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                                <div className="absolute inset-0 bg-gradient-to-r from-teal-400 via-cyan-400 to-teal-400 bg-[length:200%_100%] animate-shimmer" />
                            </div>
                            <span className="relative flex items-center gap-2 text-sm">
                                <LogIn className="w-4 h-4" />
                                Iniciar Sesión
                                <ChevronRight className="w-4 h-4 group-hover:translate-x-0.5 transition-transform" />
                            </span>
                        </button>
                    </div>
                </div>
            </header>

            {/* Main Content */}
            <main className="relative z-10 w-full px-4 lg:px-8 py-6">
                {/* Stats Cards */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                    <div className="group relative bg-gradient-to-br from-slate-800/90 to-slate-900/90 backdrop-blur-xl rounded-xl border border-slate-700/50 p-5 hover:border-teal-500/50 transition-all duration-300 overflow-hidden hover:shadow-lg hover:shadow-teal-500/10">
                        <div className="absolute inset-0 bg-gradient-to-br from-teal-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                        <div className="relative">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="w-10 h-10 rounded-xl bg-teal-500/20 flex items-center justify-center">
                                    <TrendingUp className="w-5 h-5 text-teal-400" />
                                </div>
                                <span className="text-sm font-medium text-slate-400">Cumplimiento Promedio</span>
                            </div>
                            <div className="flex items-baseline gap-2">
                                <span className="text-4xl font-bold text-white">{avgCompliance}</span>
                                <span className="text-xl text-teal-400">%</span>
                            </div>
                            <p className="text-xs text-slate-500 mt-2">Año {selectedYear}</p>
                        </div>
                    </div>

                    <div className="group relative bg-gradient-to-br from-slate-800/90 to-slate-900/90 backdrop-blur-xl rounded-xl border border-slate-700/50 p-5 hover:border-cyan-500/50 transition-all duration-300 overflow-hidden hover:shadow-lg hover:shadow-cyan-500/10">
                        <div className="absolute inset-0 bg-gradient-to-br from-cyan-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                        <div className="relative">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="w-10 h-10 rounded-xl bg-cyan-500/20 flex items-center justify-center">
                                    <BarChart3 className="w-5 h-5 text-cyan-400" />
                                </div>
                                <span className="text-sm font-medium text-slate-400">Meses Analizados</span>
                            </div>
                            <div className="flex items-baseline gap-2">
                                <span className="text-4xl font-bold text-white">{currentValues.length}</span>
                                <span className="text-xl text-cyan-400">/ 12</span>
                            </div>
                            <p className="text-xs text-slate-500 mt-2">Períodos con datos</p>
                        </div>
                    </div>

                    <div className="group relative bg-gradient-to-br from-slate-800/90 to-slate-900/90 backdrop-blur-xl rounded-xl border border-slate-700/50 p-5 hover:border-indigo-500/50 transition-all duration-300 overflow-hidden hover:shadow-lg hover:shadow-indigo-500/10">
                        <div className="absolute inset-0 bg-gradient-to-br from-indigo-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                        <div className="relative">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="w-10 h-10 rounded-xl bg-indigo-500/20 flex items-center justify-center">
                                    <Calendar className="w-5 h-5 text-indigo-400" />
                                </div>
                                <span className="text-sm font-medium text-slate-400">Año Seleccionado</span>
                            </div>
                            <select
                                value={selectedYear}
                                onChange={(e) => setSelectedYear(e.target.value)}
                                className="w-full bg-slate-800/80 text-white text-2xl font-bold border border-slate-600 rounded-xl px-4 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-500/50 focus:border-indigo-400 transition-all cursor-pointer"
                            >
                                {availableYears.map((year) => (
                                    <option key={year} value={year}>
                                        {year}
                                    </option>
                                ))}
                            </select>
                        </div>
                    </div>
                </div>

                {/* Compliance Evolution Chart */}
                <div className="bg-gradient-to-br from-slate-800/80 to-slate-900/80 backdrop-blur-xl rounded-xl border border-slate-700/50 p-5 mb-6 shadow-xl">
                    <div className="flex items-center justify-between mb-6">
                        <div>
                            <h2 className="text-xl font-bold text-white mb-1 flex items-center gap-3">
                                <div className="w-1.5 h-6 rounded-full bg-gradient-to-b from-teal-400 to-cyan-500" />
                                Evolución del Cumplimiento Normativo
                            </h2>
                            <p className="text-sm text-slate-400 ml-5">
                                Comparación interanual del nivel de cumplimiento
                            </p>
                        </div>
                    </div>
                    <ResponsiveContainer width="100%" height={380}>
                        <AreaChart data={chartData}>
                            <defs>
                                <linearGradient id="currentGradient" x1="0" y1="0" x2="0" y2="1">
                                    <stop offset="0%" stopColor="#14b8a6" stopOpacity={0.4} />
                                    <stop offset="100%" stopColor="#14b8a6" stopOpacity={0} />
                                </linearGradient>
                                <linearGradient id="previousGradient" x1="0" y1="0" x2="0" y2="1">
                                    <stop offset="0%" stopColor="#64748b" stopOpacity={0.2} />
                                    <stop offset="100%" stopColor="#64748b" stopOpacity={0} />
                                </linearGradient>
                            </defs>
                            <CartesianGrid strokeDasharray="3 3" stroke="#334155" strokeOpacity={0.5} />
                            <XAxis
                                dataKey="month"
                                tick={{ fontSize: 12, fill: '#94a3b8' }}
                                stroke="#475569"
                                axisLine={{ stroke: '#475569' }}
                                tickLine={{ stroke: '#475569' }}
                            />
                            <YAxis
                                tick={{ fontSize: 12, fill: '#94a3b8' }}
                                stroke="#475569"
                                domain={[0, 100]}
                                axisLine={{ stroke: '#475569' }}
                                tickLine={{ stroke: '#475569' }}
                                tickFormatter={(value) => `${value}%`}
                            />
                            <Tooltip
                                contentStyle={{
                                    backgroundColor: 'rgba(15, 23, 42, 0.95)',
                                    border: '1px solid rgba(51, 65, 85, 0.5)',
                                    borderRadius: '12px',
                                    color: '#f1f5f9',
                                    boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.5)',
                                }}
                                formatter={(value: number, name: string) => [
                                    `${value.toFixed(1)}%`,
                                    name === 'current' ? selectedYear : `${parseInt(selectedYear) - 1}`
                                ]}
                                labelStyle={{ color: '#94a3b8', fontWeight: 600 }}
                            />
                            <Legend
                                wrapperStyle={{ fontSize: '12px', color: '#94a3b8' }}
                                iconType="circle"
                                formatter={(value) => (
                                    <span className="text-slate-300">
                                        {value === 'current' ? selectedYear : `${parseInt(selectedYear) - 1}`}
                                    </span>
                                )}
                            />
                            <Area
                                type="monotone"
                                dataKey="previous"
                                stroke="#64748b"
                                strokeWidth={2}
                                strokeDasharray="5 5"
                                fill="url(#previousGradient)"
                                name="previous"
                            />
                            <Area
                                type="monotone"
                                dataKey="current"
                                stroke="#14b8a6"
                                strokeWidth={3}
                                fill="url(#currentGradient)"
                                name="current"
                                dot={{ fill: '#14b8a6', r: 4, strokeWidth: 2, stroke: '#0f172a' }}
                                activeDot={{ r: 8, fill: '#14b8a6', stroke: '#0f172a', strokeWidth: 3 }}
                            />
                        </AreaChart>
                    </ResponsiveContainer>
                </div>

                {/* Compliance by Segment Heatmap */}
                <div className="bg-gradient-to-br from-slate-800/80 to-slate-900/80 backdrop-blur-xl rounded-xl border border-slate-700/50 p-5 shadow-xl">
                    <div className="flex items-center justify-between mb-6">
                        <div>
                            <h2 className="text-xl font-bold text-white mb-1 flex items-center gap-3">
                                <div className="w-1.5 h-6 rounded-full bg-gradient-to-b from-cyan-400 to-blue-500" />
                                Cumplimiento por Categoría
                            </h2>
                            <p className="text-sm text-slate-400 ml-5">
                                Nivel de cumplimiento por tipo de segmento y período
                            </p>
                        </div>
                    </div>

                    {/* Legend */}
                    <div className="flex items-center gap-6 mb-6 flex-wrap p-4 bg-slate-800/50 rounded-xl">
                        <span className="text-xs text-slate-400 font-medium">Nivel de cumplimiento:</span>
                        <div className="flex items-center gap-4 flex-wrap">
                            {[
                                { color: 'bg-emerald-500', label: '≥90%' },
                                { color: 'bg-emerald-400', label: '80-89%' },
                                { color: 'bg-yellow-400', label: '70-79%' },
                                { color: 'bg-orange-400', label: '60-69%' },
                                { color: 'bg-orange-500', label: '50-59%' },
                                { color: 'bg-red-500', label: '<50%' },
                            ].map((item) => (
                                <div key={item.label} className="flex items-center gap-2">
                                    <div className={`w-4 h-4 rounded-md ${item.color} shadow-sm`} />
                                    <span className="text-xs text-slate-300">{item.label}</span>
                                </div>
                            ))}
                        </div>
                    </div>

                    {/* Heatmap Table */}
                    <div className="overflow-x-auto rounded-xl border border-slate-700/50">
                        <table className="w-full">
                            <thead>
                                <tr className="bg-slate-800/80">
                                    <th className="text-left text-sm font-semibold text-slate-300 py-4 px-4 min-w-[200px]">
                                        Segmento
                                    </th>
                                    {months.map((month) => (
                                        <th
                                            key={month}
                                            className="text-center text-sm font-medium text-slate-400 py-4 px-1 min-w-[55px]"
                                        >
                                            {month}
                                        </th>
                                    ))}
                                    <th className="text-center text-sm font-semibold text-slate-300 py-4 px-4 min-w-[90px]">
                                        Promedio
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {data?.complianceBySegment.map((segment) => (
                                    <tr key={segment.segmentId} className="border-t border-slate-700/50 hover:bg-slate-800/30 transition-colors">
                                        <td className="py-3 px-4">
                                            <span className="text-sm font-medium text-white">
                                                {segment.segmentName}
                                            </span>
                                        </td>
                                        {segment.months.map((monthData, monthIdx) => (
                                            <td key={monthIdx} className="py-3 px-1">
                                                <div
                                                    className={`
                                                        w-full h-11 rounded-lg flex items-center justify-center
                                                        bg-gradient-to-br ${getComplianceGradient(monthData.compliance)}
                                                        text-white text-xs font-bold
                                                        transition-all duration-200 hover:scale-105 cursor-default
                                                        shadow-lg shadow-black/20
                                                    `}
                                                    title={`${segment.segmentName} - ${monthData.month}: ${monthData.compliance.toFixed(1)}%`}
                                                >
                                                    {monthData.compliance > 0 ? `${monthData.compliance.toFixed(0)}%` : '-'}
                                                </div>
                                            </td>
                                        ))}
                                        <td className="py-3 px-4">
                                            <div
                                                className={`
                                                    px-4 py-2.5 rounded-xl text-center
                                                    bg-gradient-to-br ${getComplianceGradient(segment.average)}
                                                    text-white text-sm font-bold
                                                    shadow-lg shadow-black/20
                                                `}
                                            >
                                                {segment.average > 0 ? `${segment.average.toFixed(1)}%` : '-'}
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    {(!data?.complianceBySegment || data.complianceBySegment.length === 0) && (
                        <div className="text-center py-16">
                            <div className="w-16 h-16 rounded-full bg-slate-700/50 flex items-center justify-center mx-auto mb-4">
                                <BarChart3 className="w-8 h-8 text-slate-500" />
                            </div>
                            <p className="text-slate-400 font-medium">No hay datos de segmentos disponibles</p>
                            <p className="text-slate-500 text-sm mt-1">Los datos se mostrarán cuando estén configurados</p>
                        </div>
                    )}
                </div>

                {/* Footer */}
                <footer className="mt-12 pt-8 border-t border-slate-700/50">
                    <div className="flex flex-col md:flex-row items-center justify-between gap-4">
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-teal-400 to-cyan-500 flex items-center justify-center">
                                <Shield className="w-4 h-4 text-white" />
                            </div>
                            <span className="text-sm text-slate-400">
                                Coordinador Eléctrico Nacional
                            </span>
                        </div>
                        <p className="text-xs text-slate-500">
                            Datos actualizados periódicamente • Plataforma de Cumplimiento Normativo
                        </p>
                    </div>
                </footer>
            </main>

            {/* Login Modal */}
            <LoginModal isOpen={showLoginModal} onClose={() => setShowLoginModal(false)} />
        </div>
    );
};

export default CumplimientoPublico;
