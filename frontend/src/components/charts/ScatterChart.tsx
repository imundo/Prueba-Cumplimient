import React from 'react';
import {
    ScatterChart as RechartsScatterChart,
    Scatter,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer,
    Cell,
    ZAxis,
} from 'recharts';

interface ScatterChartProps {
    data: any[];
    xKey: string;
    yKey: string;
    zKey?: string;
    nameKey?: string;
    colors?: string[];
    height?: number;
}

export const ScatterChart: React.FC<ScatterChartProps> = ({
    data,
    xKey,
    yKey,
    zKey = 'z',
    nameKey = 'name',
    colors = ['#3b82f6', '#8b5cf6', '#ec4899', '#f59e0b', '#10b981'],
    height = 400,
}) => {
    const CustomTooltip = ({ active, payload }: any) => {
        if (active && payload && payload.length) {
            const data = payload[0].payload;
            return (
                <div className="bg-white p-3 border border-gray-200 rounded-lg shadow-lg">
                    <p className="font-semibold text-gray-900">{data[nameKey]}</p>
                    <p className="text-sm text-gray-600">
                        X: <span className="font-medium">{data[xKey]}</span>
                    </p>
                    <p className="text-sm text-gray-600">
                        Y: <span className="font-medium">{data[yKey]}</span>
                    </p>
                    {data[zKey] && (
                        <p className="text-sm text-gray-600">
                            Tamaño: <span className="font-medium">{data[zKey]}</span>
                        </p>
                    )}
                </div>
            );
        }
        return null;
    };

    return (
        <ResponsiveContainer width="100%" height={height}>
            <RechartsScatterChart margin={{ top: 20, right: 20, bottom: 20, left: 20 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                <XAxis
                    type="number"
                    dataKey={xKey}
                    name={xKey}
                    stroke="#6b7280"
                    tick={{ fill: '#6b7280', fontSize: 12 }}
                />
                <YAxis
                    type="number"
                    dataKey={yKey}
                    name={yKey}
                    stroke="#6b7280"
                    tick={{ fill: '#6b7280', fontSize: 12 }}
                />
                <ZAxis type="number" dataKey={zKey} range={[50, 400]} />
                <Tooltip content={<CustomTooltip />} cursor={{ strokeDasharray: '3 3' }} />
                <Scatter data={data} fill="#3b82f6">
                    {data.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={colors[index % colors.length]} />
                    ))}
                </Scatter>
            </RechartsScatterChart>
        </ResponsiveContainer>
    );
};
