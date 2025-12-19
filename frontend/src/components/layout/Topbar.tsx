import React from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { LogOut, User } from 'lucide-react';

const Topbar: React.FC = () => {
    const { user, logout } = useAuth();

    return (
        <header className="bg-white border-b border-secondary-200 px-6 py-4">
            <div className="flex items-center justify-between">
                <div>
                    <h2 className="text-lg font-semibold text-secondary-900">
                        Sistema de Gestión de Cumplimiento Normativo
                    </h2>
                </div>

                <div className="flex items-center space-x-4">
                    <div className="flex items-center space-x-2">
                        <User className="w-5 h-5 text-secondary-600" />
                        <div className="text-sm">
                            <p className="font-medium text-secondary-900">{user?.fullName || user?.username}</p>
                            <p className="text-secondary-600 capitalize">{user?.role}</p>
                        </div>
                    </div>

                    <button
                        onClick={logout}
                        className="flex items-center space-x-2 px-4 py-2 text-sm font-medium text-secondary-700 hover:bg-secondary-100 rounded-lg transition-colors"
                    >
                        <LogOut className="w-4 h-4" />
                        <span>Cerrar Sesión</span>
                    </button>
                </div>
            </div>
        </header>
    );
};

export default Topbar;
