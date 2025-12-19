import React from 'react';
import { AlertTriangle, AlertCircle, Info, XCircle, ChevronRight } from 'lucide-react';

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

interface AlertsListProps {
    alerts: Alert[];
    title: string;
    subtitle?: string;
    onAlertClick?: (alert: Alert) => void;
}

const priorityConfig = {
    alta: {
        icon: XCircle,
        bgColor: 'bg-red-50',
        borderColor: 'border-red-200',
        textColor: 'text-red-700',
        iconColor: 'text-red-500',
        badgeColor: 'bg-red-100 text-red-700',
    },
    media: {
        icon: AlertTriangle,
        bgColor: 'bg-amber-50',
        borderColor: 'border-amber-200',
        textColor: 'text-amber-700',
        iconColor: 'text-amber-500',
        badgeColor: 'bg-amber-100 text-amber-700',
    },
    baja: {
        icon: Info,
        bgColor: 'bg-blue-50',
        borderColor: 'border-blue-200',
        textColor: 'text-blue-700',
        iconColor: 'text-blue-500',
        badgeColor: 'bg-blue-100 text-blue-700',
    },
};

export const AlertsList: React.FC<AlertsListProps> = ({
    alerts,
    title,
    subtitle,
    onAlertClick,
}) => {
    return (
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="flex items-center justify-between mb-4">
                <div>
                    <h3 className="text-lg font-bold text-gray-900">{title}</h3>
                    {subtitle && <p className="text-sm text-gray-500 mt-1">{subtitle}</p>}
                </div>
                <div className="flex items-center space-x-2">
                    <span className="px-3 py-1 bg-red-100 text-red-700 text-xs font-semibold rounded-full">
                        {alerts.filter(a => a.priority === 'alta').length} críticas
                    </span>
                </div>
            </div>

            <div className="space-y-3 max-h-96 overflow-y-auto pr-2">
                {alerts.length === 0 ? (
                    <div className="text-center py-8">
                        <AlertCircle className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                        <p className="text-gray-500">No hay alertas activas</p>
                    </div>
                ) : (
                    alerts.map((alert, index) => {
                        const config = priorityConfig[alert.priority];
                        const Icon = config.icon;

                        return (
                            <div
                                key={alert.id || index}
                                onClick={() => onAlertClick?.(alert)}
                                className={`
                                    ${config.bgColor} ${config.borderColor} border rounded-lg p-4
                                    transition-all duration-200 cursor-pointer
                                    hover:shadow-md hover:scale-[1.01] active:scale-[0.99]
                                    animate-fade-in
                                `}
                                style={{ animationDelay: `${index * 50}ms` }}
                            >
                                <div className="flex items-start space-x-3">
                                    <Icon className={`w-5 h-5 ${config.iconColor} flex-shrink-0 mt-0.5`} />
                                    <div className="flex-1 min-w-0">
                                        <div className="flex items-center justify-between">
                                            <p className={`font-semibold ${config.textColor}`}>{alert.title}</p>
                                            <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${config.badgeColor}`}>
                                                {alert.priority.toUpperCase()}
                                            </span>
                                        </div>
                                        <p className="text-sm text-gray-600 mt-1 line-clamp-2">{alert.description}</p>
                                        {(alert.coordinado || alert.periodo) && (
                                            <div className="flex items-center mt-2 text-xs text-gray-500 space-x-4">
                                                {alert.coordinado && <span>📍 {alert.coordinado}</span>}
                                                {alert.periodo && <span>📅 Periodo {alert.periodo}</span>}
                                            </div>
                                        )}
                                    </div>
                                    <ChevronRight className="w-5 h-5 text-gray-400 flex-shrink-0" />
                                </div>
                            </div>
                        );
                    })
                )}
            </div>
        </div>
    );
};

export default AlertsList;
