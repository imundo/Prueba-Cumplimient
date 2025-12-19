import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import {
    LayoutDashboard,
    FileText,
    TrendingUp,
    Star,
    CheckCircle,
    AlertTriangle,
    ChevronDown,
    ChevronRight
} from 'lucide-react';

const Sidebar: React.FC = () => {
    const location = useLocation();
    const [expandedMenus, setExpandedMenus] = useState<string[]>(['Detalle por Coordinado / Norma']);

    const toggleMenu = (label: string) => {
        setExpandedMenus(prev =>
            prev.includes(label)
                ? prev.filter(item => item !== label)
                : [...prev, label]
        );
    };

    const menuItems = [
        { path: '/app', label: 'Inicio / Dashboard General', icon: LayoutDashboard },
        { path: '/app/impacto-normativo', label: 'Impacto Normativo', icon: TrendingUp },
        { path: '/app/relevancia-estrategica', label: 'Relevancia Estratégica', icon: Star },
        { path: '/app/cumplimiento-comportamiento', label: 'Cumplimiento y Comportamiento', icon: CheckCircle },
        { path: '/app/riesgo-mejora', label: 'Riesgo y Mejora', icon: AlertTriangle },
        {
            label: 'Detalle por Coordinado / Norma',
            icon: FileText,
            submenu: [
                { path: '/app/normativa/normas', label: 'Normas' },
                { path: '/app/normativa/sub-normas', label: 'Sub-Normas' },
                { path: '/app/normativa/departamentos', label: 'Departamentos' },
                { path: '/app/reuc', label: 'Empresas REUC' },
                { path: '/app/cumplimiento', label: 'Cumplimiento' },
                { path: '/app/cartas', label: 'Cartas de Incumplimiento' },
                { path: '/app/homologacion', label: 'Homologación' },
            ],
        },
    ];

    return (
        <aside className="w-64 bg-dashboard-dark min-h-screen text-white">
            <div className="p-6 border-b border-white/10">
                <div className="flex items-center space-x-3">
                    <div className="bg-white rounded-lg p-2">
                        <span className="text-dashboard-dark font-bold text-lg">CEN</span>
                    </div>
                    <div>
                        <h1 className="text-lg font-bold">Coordinador El éctrico</h1>
                        <p className="text-xs text-gray-300">Nacional</p>
                    </div>
                </div>
            </div>

            <nav className="px-4 py-4 space-y-1">
                {menuItems.map((item, index) => (
                    <div key={index}>
                        {item.submenu ? (
                            <div>
                                <button
                                    onClick={() => toggleMenu(item.label)}
                                    className="flex items-center justify-between w-full px-4 py-2.5 text-sm font-medium text-white hover:bg-white/10 rounded-lg transition-colors"
                                >
                                    <div className="flex items-center">
                                        <item.icon className="w-4 h-4 mr-3" />
                                        <span className="text-xs">{item.label}</span>
                                    </div>
                                    {expandedMenus.includes(item.label) ? (
                                        <ChevronDown className="w-4 h-4" />
                                    ) : (
                                        <ChevronRight className="w-4 h-4" />
                                    )}
                                </button>
                                {expandedMenus.includes(item.label) && (
                                    <div className="ml-7 mt-1 space-y-1">
                                        {item.submenu.map((subItem) => (
                                            <Link
                                                key={subItem.path}
                                                to={subItem.path}
                                                className={`block px-4 py-2 text-xs rounded-lg transition-colors ${location.pathname === subItem.path
                                                    ? 'bg-white/20 text-white font-medium'
                                                    : 'text-gray-300 hover:bg-white/10 hover:text-white'
                                                    }`}
                                            >
                                                {subItem.label}
                                            </Link>
                                        ))}
                                    </div>
                                )}
                            </div>
                        ) : (
                            <Link
                                to={item.path!}
                                className={`flex items-center px-4 py-2.5 text-sm font-medium rounded-lg transition-colors ${location.pathname === item.path
                                    ? 'bg-white/20 text-white'
                                    : 'text-gray-300 hover:bg-white/10 hover:text-white'
                                    }`}
                            >
                                <item.icon className="w-4 h-4 mr-3" />
                                <span className="text-xs">{item.label}</span>
                            </Link>
                        )}
                    </div>
                ))}
            </nav>
        </aside>
    );
};

export default Sidebar;
