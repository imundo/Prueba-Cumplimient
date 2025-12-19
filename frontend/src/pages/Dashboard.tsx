import React, { useEffect, useState } from 'react';
import { CheckCircle2, Users, FileText, Calendar } from 'lucide-react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { MetricCard } from '../components/charts/MetricCard';
import { LineChart } from '../components/charts/LineChart';
import { HorizontalBarChart } from '../components/charts/HorizontalBarChart';
import { api } from '../lib/api';

interface DashboardSummary {
    cumplimientoGlobal: { value: number; trend: number };
    numCoordinados: { value: number; trend: number };
    normasActivas: { value: number; trend: number };
}

interface FilterOptions {
    years: string[];
    tiposCoordinado: string[];
    tiposNorma: string[];
    regiones: string[];
}

const Dashboard: React.FC = () => {
    const [summary, setSummary] = useState<DashboardSummary | null>(null);
    const [complianceTrend, setComplianceTrend] = useState<any>(null);
    const [coordinadosRanking, setCoordinadosRanking] = useState<any[]>([]);
    const [normasRanking, setNormasRanking] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [filterOptions, setFilterOptions] = useState<FilterOptions | null>(null);

    // Filters
    const [selectedYear, setSelectedYear] = useState<Date>(new Date());
    const [selectedTipoCoordinado, setSelectedTipoCoordinado] = useState('Todos');
    const [selectedTipoNorma, setSelectedTipoNorma] = useState('Todos');
    const [selectedRegion, setSelectedRegion] = useState('Todas las regiones');

    useEffect(() => {
        loadFilterOptions();
    }, []);

    useEffect(() => {
        if (filterOptions) {
            loadDashboardData();
        }
    }, [selectedYear, selectedTipoCoordinado, selectedTipoNorma, selectedRegion, filterOptions]);

    const loadFilterOptions = async () => {
        try {
            const response = await api.get('/analytics/filter-options');
            setFilterOptions(response.data);
        } catch (error) {
            console.error('Error loading filter options:', error);
        }
    };

    const loadDashboardData = async () => {
        try {
            setLoading(true);

            const year = selectedYear.getFullYear().toString();
            const params = new URLSearchParams();
            params.append('year', year);
            if (selectedTipoCoordinado !== 'Todos') params.append('tipoCoordinado', selectedTipoCoordinado);
            if (selectedTipoNorma !== 'Todos') params.append('tipoNorma', selectedTipoNorma);
            if (selectedRegion !== 'Todas las regiones') params.append('region', selectedRegion);

            const queryString = params.toString();

            // Fetch all dashboard data
            const [summaryRes, trendRes, coordinadosRes, normasRes] = await Promise.all([
                api.get(`/analytics/dashboard?${queryString}`),
                api.get(`/analytics/compliance-trend?${queryString}`),
                api.get(`/analytics/coordinados-ranking?limit=8&${queryString}`),
                api.get(`/analytics/normas-ranking?limit=8&${queryString}`),
            ]);

            setSummary(summaryRes.data);
            setComplianceTrend(trendRes.data);
            setCoordinadosRanking(coordinadosRes.data);
            setNormasRanking(normasRes.data);
        } catch (error) {
            console.error('Error loading dashboard data:', error);
        } finally {
            setLoading(false);
        }
    };

    if (loading || !filterOptions) {
        return (
            <div className="flex items-center justify-center h-screen bg-gray-50">
                <div className="text-center">
                    <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-dashboard-dark mx-auto mb-4"></div>
                    <p className="text-gray-600">Cargando dashboard...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="flex-1 bg-gray-50">
            {/* Header */}
            <div className="bg-white border-b border-gray-200 px-8 py-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900">Inicio / Dashboard General</h1>
                        <p className="text-sm text-gray-500 mt-1">Vista general del cumplimiento normativo</p>
                    </div>
                    <div className="flex items-center space-x-2">
                        <button
                            onClick={loadDashboardData}
                            className="px-4 py-2 bg-dashboard-dark text-white rounded-lg text-sm font-medium hover:bg-dashboard-blue transition-colors"
                        >
                            Actualizar
                        </button>
                        <button className="px-4 py-2 bg-white border border-gray-300 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">
                            Exportar Dashboard
                        </button>
                    </div>
                </div>
            </div>

            {/* Filters */}
            <div className="px-8 py-6 bg-white border-b border-gray-200">
                <h3 className="text-sm font-semibold text-gray-700 mb-4">Filtros</h3>
                <div className="grid grid-cols-4 gap-4">
                    <div>
                        <label className="block text-xs font-medium text-gray-600 mb-2">Tipo de Coordinado</label>
                        <select
                            value={selectedTipoCoordinado}
                            onChange={(e) => setSelectedTipoCoordinado(e.target.value)}
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue"
                        >
                            {filterOptions.tiposCoordinado.map(tipo => (
                                <option key={tipo} value={tipo}>{tipo}</option>
                            ))}
                        </select>
                    </div>
                    <div>
                        <label className="block text-xs font-medium text-gray-600 mb-2">Tipo de Norma</label>
                        <select
                            value={selectedTipoNorma}
                            onChange={(e) => setSelectedTipoNorma(e.target.value)}
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue"
                        >
                            {filterOptions.tiposNorma.map(tipo => (
                                <option key={tipo} value={tipo}>{tipo}</option>
                            ))}
                        </select>
                    </div>
                    <div>
                        <label className="block text-xs font-medium text-gray-600 mb-2 flex items-center">
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
                        <label className="block text-xs font-medium text-gray-600 mb-2">Región</label>
                        <select
                            value={selectedRegion}
                            onChange={(e) => setSelectedRegion(e.target.value)}
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-dashboard-blue"
                        >
                            {filterOptions.regiones.map(region => (
                                <option key={region} value={region}>{region}</option>
                            ))}
                        </select>
                    </div>
                </div>
                <div className="mt-3 flex items-center text-xs text-gray-500">
                    <span className="font-medium mr-2">Filtros activos:</span>
                    <span>Año: {selectedYear.getFullYear()}</span>
                    {selectedTipoCoordinado !== 'Todos' && <span className="ml-2">• {selectedTipoCoordinado}</span>}
                    {selectedTipoNorma !== 'Todos' && <span className="ml-2">• {selectedTipoNorma}</span>}
                    {selectedRegion !== 'Todas las regiones' && <span className="ml-2">• {selectedRegion}</span>}
                </div>
            </div>

            {/* Main Content */}
            <div className="px-8 py-6">
                {/* Metric Cards */}
                <div className="grid grid-cols-3 gap-6 mb-6">
                    <MetricCard
                        title="Cumplimiento Global"
                        value={`${summary?.cumplimientoGlobal.value || 0}%`}
                        trend={summary?.cumplimientoGlobal.trend}
                        icon={<CheckCircle2 className="w-6 h-6 text-white" />}
                        iconColor="bg-success"
                    />
                    <MetricCard
                        title="N° de Coordinados"
                        value={summary?.numCoordinados.value || 0}
                        trend={summary?.numCoordinados.trend}
                        icon={<Users className="w-6 h-6 text-white" />}
                        iconColor="bg-info"
                    />
                    <MetricCard
                        title="Normas Activas"
                        value={summary?.normasActivas.value || 0}
                        trend={summary?.normasActivas.trend}
                        icon={<FileText className="w-6 h-6 text-white" />}
                        iconColor="bg-warning"
                    />
                </div>

                {/* Compliance Trend Chart */}
                {complianceTrend && (
                    <div className="mb-6">
                        <LineChart
                            data={complianceTrend}
                            title="Tendencia de Cumplimiento: Comparación Interanual"
                            subtitle={`Año ${selectedYear.getFullYear()} vs ${selectedYear.getFullYear() - 1}`}
                        />
                    </div>
                )}

                {/* Rankings */}
                <div className="grid grid-cols-2 gap-6">
                    <HorizontalBarChart
                        data={coordinadosRanking}
                        title="Ranking de Coordinados por Cumplimiento"
                        subtitle="Top coordinados ordenados por % de cumplimiento"
                        dataKey="compliance"
                        nameKey="name"
                        color="#0A2540"
                    />
                    <HorizontalBarChart
                        data={normasRanking}
                        title="Ranking de Normas por Cumplimiento"
                        subtitle="Normas con mayor cantidad de coordinados afectados"
                        dataKey="applicableCoordinados"
                        nameKey="descripcion"
                        color="#CBD5E1"
                    />
                </div>
            </div>
        </div>
    );
};

export default Dashboard;
