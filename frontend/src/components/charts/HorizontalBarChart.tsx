import React from 'react';
import {
    BarChart as RechartsBarChart,
    Bar,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer,
    Cell,
} from 'recharts';

interface HorizontalBarChartProps {
    data: any[];
    title: string;
    subtitle?: string;
    dataKey: string;
    nameKey: string;
    color?: string;
}

export const HorizontalBarChart: React.FC<HorizontalBarChartProps> = ({
    data,
    title,
    subtitle,
    dataKey,
    nameKey,
    color = '#0A2540',
}) => {
    return (
        <div className="bg-white rounded-lg shadow-sm p-6">
            <div className="mb-4">
                <h3 className="text-lg font-semibold text-gray-900 mb-1">{title}</h3>
                {subtitle && <p className="text-sm text-gray-600">{subtitle}</p>}
            </div>
            <ResponsiveContainer width="100%" height={300}>
                <RechartsBarChart
                    data={data}
                    layout="vertical"
                    margin={{ top: 5, right: 30, left: 100, bottom: 5 }}
                >
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" horizontal={false} />
                    <XAxis type="number" tick={{ fontSize: 12 }} stroke="#6b7280" />
                    <YAxis
                        dataKey={nameKey}
                        type="category"
                        tick={{ fontSize: 11 }}
                        stroke="#6b7280"
                        width={90}
                    />
                    <Tooltip
                        contentStyle={{
                            backgroundColor: '#fff',
                            border: '1px solid #e5e7eb',
                            borderRadius: '6px',
                            fontSize: '12px',
                        }}
                    />
                    <Bar dataKey={dataKey} radius={[0, 4, 4, 0]}>
                        {data.map((_entry, index) => (
                            <Cell key={`cell-${index}`} fill={color} />
                        ))}
                    </Bar>
                </RechartsBarChart>
            </ResponsiveContainer>
        </div>
    );
};
