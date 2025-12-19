import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { LogIn, X, User, Lock, Sparkles } from 'lucide-react';

interface LoginModalProps {
    isOpen: boolean;
    onClose: () => void;
}

const LoginModal: React.FC<LoginModalProps> = ({ isOpen, onClose }) => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const { login } = useAuth();
    const navigate = useNavigate();

    // Reset form when modal opens/closes
    useEffect(() => {
        if (!isOpen) {
            setUsername('');
            setPassword('');
            setError('');
            setLoading(false);
        }
    }, [isOpen]);

    // Close on Escape key
    useEffect(() => {
        const handleEscape = (e: KeyboardEvent) => {
            if (e.key === 'Escape' && isOpen) {
                onClose();
            }
        };
        window.addEventListener('keydown', handleEscape);
        return () => window.removeEventListener('keydown', handleEscape);
    }, [isOpen, onClose]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');
        setLoading(true);

        try {
            await login(username, password);
            onClose();
            navigate('/app');
        } catch (err: any) {
            setError(err.response?.data?.message || err.message || 'Credenciales inválidas');
        } finally {
            setLoading(false);
        }
    };

    const handleQuickLogin = async (user: string, pass: string) => {
        setUsername(user);
        setPassword(pass);
        setError('');
        setLoading(true);

        try {
            await login(user, pass);
            onClose();
            navigate('/app');
        } catch (err: any) {
            setError(err.response?.data?.message || err.message || 'Credenciales inválidas');
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 overflow-y-auto">
            {/* Backdrop */}
            <div
                className="fixed inset-0 bg-black/60 backdrop-blur-sm transition-opacity"
                onClick={onClose}
            />

            {/* Modal Container */}
            <div className="flex min-h-full items-center justify-center p-4">
                {/* Modal Content */}
                <div
                    className="relative w-full max-w-md transform transition-all"
                    onClick={(e) => e.stopPropagation()}
                >
                    {/* Glassmorphism Card */}
                    <div className="relative bg-white/95 backdrop-blur-xl rounded-3xl shadow-2xl border border-white/20 overflow-hidden">
                        {/* Decorative gradient top */}
                        <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-teal-400 via-cyan-500 to-blue-500" />

                        {/* Close button */}
                        <button
                            onClick={onClose}
                            className="absolute top-4 right-4 p-2 rounded-full bg-gray-100 hover:bg-gray-200 text-gray-500 hover:text-gray-700 transition-all duration-200 hover:rotate-90"
                        >
                            <X className="w-5 h-5" />
                        </button>

                        <div className="p-8 pt-10">
                            {/* Header */}
                            <div className="text-center mb-8">
                                <div className="relative inline-flex items-center justify-center w-20 h-20 mb-4">
                                    <div className="absolute inset-0 bg-gradient-to-br from-teal-400 to-cyan-500 rounded-2xl rotate-6 opacity-20" />
                                    <div className="relative bg-gradient-to-br from-teal-50 to-cyan-50 rounded-2xl p-4 shadow-lg border border-teal-100">
                                        <LogIn className="w-10 h-10 text-teal-600" />
                                    </div>
                                </div>
                                <h2 className="text-2xl font-bold text-gray-900 tracking-tight">
                                    Bienvenido
                                </h2>
                                <p className="text-gray-500 mt-1 text-sm">
                                    Ingresa a la plataforma de cumplimiento
                                </p>
                            </div>

                            {/* Form */}
                            <form onSubmit={handleSubmit} className="space-y-5">
                                {error && (
                                    <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl text-sm flex items-center gap-2 animate-shake">
                                        <div className="w-2 h-2 bg-red-500 rounded-full" />
                                        {error}
                                    </div>
                                )}

                                <div className="space-y-1">
                                    <label htmlFor="modal-username" className="block text-sm font-semibold text-gray-700">
                                        Usuario
                                    </label>
                                    <div className="relative">
                                        <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                            <User className="h-5 w-5 text-gray-400" />
                                        </div>
                                        <input
                                            id="modal-username"
                                            type="text"
                                            value={username}
                                            onChange={(e) => setUsername(e.target.value)}
                                            className="w-full pl-12 pr-4 py-3.5 bg-gray-50 border border-gray-200 rounded-xl text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-teal-500/20 focus:border-teal-400 transition-all duration-200"
                                            placeholder="Ingrese su usuario"
                                            required
                                            autoComplete="username"
                                        />
                                    </div>
                                </div>

                                <div className="space-y-1">
                                    <label htmlFor="modal-password" className="block text-sm font-semibold text-gray-700">
                                        Contraseña
                                    </label>
                                    <div className="relative">
                                        <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                            <Lock className="h-5 w-5 text-gray-400" />
                                        </div>
                                        <input
                                            id="modal-password"
                                            type="password"
                                            value={password}
                                            onChange={(e) => setPassword(e.target.value)}
                                            className="w-full pl-12 pr-4 py-3.5 bg-gray-50 border border-gray-200 rounded-xl text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-teal-500/20 focus:border-teal-400 transition-all duration-200"
                                            placeholder="Ingrese su contraseña"
                                            required
                                            autoComplete="current-password"
                                        />
                                    </div>
                                </div>

                                <button
                                    type="submit"
                                    disabled={loading || !username || !password}
                                    className="w-full relative py-4 px-6 rounded-xl font-semibold text-white transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed group overflow-hidden"
                                >
                                    <div className="absolute inset-0 bg-gradient-to-r from-teal-500 via-cyan-500 to-teal-500 bg-[length:200%_100%] group-hover:animate-shimmer" />
                                    <div className="absolute inset-0 bg-gradient-to-r from-teal-600 to-cyan-600 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                                    <span className="relative flex items-center justify-center gap-2">
                                        {loading ? (
                                            <>
                                                <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                                                Iniciando sesión...
                                            </>
                                        ) : (
                                            <>
                                                <LogIn className="w-5 h-5" />
                                                Iniciar Sesión
                                            </>
                                        )}
                                    </span>
                                </button>
                            </form>

                            {/* Quick Access */}
                            <div className="mt-6 pt-6 border-t border-gray-100">
                                <div className="flex items-center gap-2 mb-3">
                                    <Sparkles className="w-4 h-4 text-amber-500" />
                                    <p className="text-xs text-gray-500 font-medium">Acceso rápido (pruebas)</p>
                                </div>
                                <div className="grid grid-cols-2 gap-3">
                                    <button
                                        type="button"
                                        disabled={loading}
                                        onClick={() => handleQuickLogin('admin', 'admin123')}
                                        className="flex items-center justify-center gap-2 px-4 py-3 bg-gradient-to-br from-blue-50 to-indigo-50 hover:from-blue-100 hover:to-indigo-100 text-blue-700 rounded-xl text-sm font-medium transition-all duration-200 border border-blue-100 hover:border-blue-200 hover:shadow-md disabled:opacity-50"
                                    >
                                        <div className="w-6 h-6 rounded-full bg-blue-200 flex items-center justify-center">
                                            <User className="w-3.5 h-3.5 text-blue-700" />
                                        </div>
                                        Admin
                                    </button>
                                    <button
                                        type="button"
                                        disabled={loading}
                                        onClick={() => handleQuickLogin('analista', 'analista123')}
                                        className="flex items-center justify-center gap-2 px-4 py-3 bg-gradient-to-br from-emerald-50 to-teal-50 hover:from-emerald-100 hover:to-teal-100 text-emerald-700 rounded-xl text-sm font-medium transition-all duration-200 border border-emerald-100 hover:border-emerald-200 hover:shadow-md disabled:opacity-50"
                                    >
                                        <div className="w-6 h-6 rounded-full bg-emerald-200 flex items-center justify-center">
                                            <User className="w-3.5 h-3.5 text-emerald-700" />
                                        </div>
                                        Analista
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default LoginModal;
