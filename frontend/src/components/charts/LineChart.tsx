import React from 'react';
import {
    LineChart as RechartsLineChart,
    Line,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    Legend,
    ResponsiveContainer,
} from 'recharts';

interface LineChartProps {
    data: { currentYear: any[]; previousYear: any[] };
    title: string;
    subtitle?: string;
}

export const LineChart: React.FC<LineChartProps> = ({ data, title, subtitle }) => {
    // Merge current and previous year data
    const chartData = data.currentYear.map((item, index) => ({
        month: item.month,
        current: item.value,
        previous: data.previousYear[index]?.value || 0,
    }));

    return (
        <div className="bg-white rounded-lg shadow-sm p-6">
            <div className="mb-4">
                <h3 className="text-lg font-semibold text-gray-900 mb-1">{title}</h3>
                {subtitle && <p className="text-sm text-gray-600">{subtitle}</p>}
            </div>
            <ResponsiveContainer width="100%" height={300}>
                <RechartsLineChart data={chartData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                    <XAxis
                        dataKey="month"
                        tick={{ fontSize: 12 }}
                        stroke="#6b7280"
                    />
                    <YAxis
                        tick={{ fontSize: 12 }}
                        stroke="#6b7280"
                        domain={[75, 85]}
                    />
                    <Tooltip
                        contentStyle={{
                            backgroundColor: '#fff',
                            border: '1px solid #e5e7eb',
                            borderRadius: '6px',
                        }}
                    />
                    <Legend
                        wrapperStyle={{ fontSize: '12px' }}
                        iconType="line"
                    />
                    <Line
                        type="monotone"
                        dataKey="previous"
                        stroke="#94a3b8"
                        strokeWidth={2}
                        strokeDasharray="5 5"
                        name="Oct 2023 - Oct 2024"
                        dot={false}
                    />
                    <Line
                        type="monotone"
                        dataKey="current"
                        stroke="#1e40af"
                        strokeWidth={2}
                        name="Oct 2024"
                        dot={{ fill: '#1e40af', r: 4 }}
                    />
                </RechartsLineChart>
            </ResponsiveContainer>
        </div>
    );
};
