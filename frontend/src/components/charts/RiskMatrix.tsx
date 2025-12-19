import React from 'react';

interface RiskPoint {
    id: number;
    name: string;
    probability: number;
    impact: number;
    quadrant: 'critical' | 'high' | 'medium' | 'low';
    incumplimientos?: number;
}

interface RiskMatrixProps {
    data: RiskPoint[];
    title: string;
    subtitle?: string;
    onPointClick?: (point: RiskPoint) => void;
}

const quadrantColors = {
    critical: 'bg-red-500',
    high: 'bg-orange-400',
    medium: 'bg-yellow-400',
    low: 'bg-green-400',
};

const quadrantLabels = {
    critical: 'Crítico',
    high: 'Alto',
    medium: 'Medio',
    low: 'Bajo',
};

export const RiskMatrix: React.FC<RiskMatrixProps> = ({
    data,
    title,
    subtitle,
    onPointClick,
}) => {
    // Normalize values to percentage (0-100)
    const normalizeValue = (value: number) => Math.min(Math.max(value, 0), 100);

    return (
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="mb-6">
                <h3 className="text-lg font-bold text-gray-900">{title}</h3>
                {subtitle && <p className="text-sm text-gray-500 mt-1">{subtitle}</p>}
            </div>

            {/* Matrix Container */}
            <div className="relative">
                {/* Y-axis label */}
                <div className="absolute -left-8 top-1/2 -translate-y-1/2 -rotate-90 text-xs font-medium text-gray-500 whitespace-nowrap">
                    Probabilidad de Incumplimiento →
                </div>

                {/* Matrix Grid */}
                <div className="ml-4 relative" style={{ height: '320px' }}>
                    {/* Background quadrants */}
                    <div className="absolute inset-0 grid grid-cols-2 grid-rows-2">
                        <div className="bg-orange-100/50 border-r border-b border-gray-200 flex items-start justify-start p-2">
                            <span className="text-xs font-medium text-orange-700 opacity-60">Alto Riesgo</span>
                        </div>
                        <div className="bg-red-100/50 border-b border-gray-200 flex items-start justify-end p-2">
                            <span className="text-xs font-medium text-red-700 opacity-60">Crítico</span>
                        </div>
                        <div className="bg-green-100/50 border-r border-gray-200 flex items-end justify-start p-2">
                            <span className="text-xs font-medium text-green-700 opacity-60">Bajo Riesgo</span>
                        </div>
                        <div className="bg-yellow-100/50 flex items-end justify-end p-2">
                            <span className="text-xs font-medium text-yellow-700 opacity-60">Medio</span>
                        </div>
                    </div>

                    {/* Data points */}
                    {data.map((point, index) => {
                        const x = normalizeValue(point.impact);
                        const y = 100 - normalizeValue(point.probability);

                        return (
                            <div
                                key={point.id || index}
                                onClick={() => onPointClick?.(point)}
                                className={`
                                    absolute w-4 h-4 rounded-full ${quadrantColors[point.quadrant]}
                                    transform -translate-x-1/2 -translate-y-1/2
                                    cursor-pointer transition-all duration-200
                                    hover:scale-150 hover:z-10 hover:shadow-lg
                                    animate-scale-in
                                `}
                                style={{
                                    left: `${x}%`,
                                    top: `${y}%`,
                                    animationDelay: `${index * 30}ms`,
                                }}
                                title={`${point.name}: Prob. ${point.probability}%, Impacto ${point.impact}%`}
                            >
                                <div className="absolute left-1/2 -translate-x-1/2 -top-8 bg-gray-900 text-white text-xs px-2 py-1 rounded opacity-0 hover:opacity-100 transition-opacity whitespace-nowrap pointer-events-none">
                                    {point.name}
                                </div>
                            </div>
                        );
                    })}

                    {/* Axis lines */}
                    <div className="absolute left-1/2 top-0 bottom-0 border-l border-gray-300 border-dashed" />
                    <div className="absolute top-1/2 left-0 right-0 border-t border-gray-300 border-dashed" />
                </div>

                {/* X-axis label */}
                <div className="text-center mt-4 text-xs font-medium text-gray-500">
                    Impacto (Número de Obligaciones) →
                </div>
            </div>

            {/* Legend */}
            <div className="mt-6 flex items-center justify-center space-x-6">
                {Object.entries(quadrantLabels).map(([key, label]) => (
                    <div key={key} className="flex items-center space-x-2">
                        <div className={`w-3 h-3 rounded-full ${quadrantColors[key as keyof typeof quadrantColors]}`} />
                        <span className="text-xs text-gray-600">{label}</span>
                    </div>
                ))}
            </div>

            {/* Summary stats */}
            <div className="mt-4 grid grid-cols-4 gap-2 text-center">
                {Object.entries(quadrantLabels).map(([key, label]) => {
                    const count = data.filter(d => d.quadrant === key).length;
                    return (
                        <div key={key} className="p-2 bg-gray-50 rounded-lg">
                            <p className="text-lg font-bold text-gray-900">{count}</p>
                            <p className="text-xs text-gray-500">{label}</p>
                        </div>
                    );
                })}
            </div>
        </div>
    );
};

export default RiskMatrix;
