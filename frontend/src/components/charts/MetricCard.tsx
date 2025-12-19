import React from 'react';
import { TrendingUp, TrendingDown } from 'lucide-react';

interface MetricCardProps {
    title: string;
    value: string | number;
    trend?: number;
    icon: React.ReactNode;
    iconColor: string;
}

export const MetricCard: React.FC<MetricCardProps> = ({
    title,
    value,
    trend,
    icon,
    iconColor,
}) => {
    const trendIsPositive = trend && trend > 0;
    const trendIsNegative = trend && trend < 0;

    return (
        <div className="bg-white rounded-lg shadow-sm p-6 flex items-start justify-between hover:shadow-md transition-shadow">
            <div className="flex-1">
                <p className="text-sm font-medium text-gray-600 mb-2">{title}</p>
                <p className="text-3xl font-bold text-gray-900">{value}</p>
                {trend !== undefined && (
                    <div className="flex items-center mt-2 text-sm">
                        {trendIsPositive && (
                            <>
                                <TrendingUp className="w-4 h-4 text-success mr-1" />
                                <span className="text-success font-medium">+{Math.abs(trend)}</span>
                            </>
                        )}
                        {trendIsNegative && (
                            <>
                                <TrendingDown className="w-4 h-4 text-red-500 mr-1" />
                                <span className="text-red-500 font-medium">{trend}</span>
                            </>
                        )}
                        {!trendIsPositive && !trendIsNegative && (
                            <span className="text-gray-500 font-medium">{trend}</span>
                        )}
                        <span className="text-gray-500 ml-1">vs mes anterior</span>
                    </div>
                )}
            </div>
            <div className={`rounded-full p-3 ${iconColor}`}>
                {icon}
            </div>
        </div>
    );
};
