import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { LogIn } from 'lucide-react';

const Login: React.FC = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const { login } = useAuth();
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');
        setLoading(true);

        try {
            await login(username, password);
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
            navigate('/app');
        } catch (err: any) {
            setError(err.response?.data?.message || err.message || 'Credenciales inválidas');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-primary-600 to-primary-800 flex items-center justify-center p-4">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-8">
                <div className="text-center mb-8">
                    <div className="inline-flex items-center justify-center w-16 h-16 bg-primary-100 rounded-full mb-4">
                        <LogIn className="w-8 h-8 text-primary-600" />
                    </div>
                    <h1 className="text-3xl font-bold text-secondary-900">REUC</h1>
                    <p className="text-secondary-600 mt-2">Sistema de Gestión de Cumplimiento</p>
                </div>

                <form onSubmit={handleSubmit} className="space-y-6">
                    {error && (
                        <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
                            {error}
                        </div>
                    )}

                    <div>
                        <label htmlFor="username" className="block text-sm font-medium text-secondary-700 mb-2">
                            Usuario
                        </label>
                        <input
                            id="username"
                            type="text"
                            value={username}
                            onChange={(e) => setUsername(e.target.value)}
                            className="input"
                            placeholder="Ingrese su usuario"
                            required
                        />
                    </div>

                    <div>
                        <label htmlFor="password" className="block text-sm font-medium text-secondary-700 mb-2">
                            Contraseña
                        </label>
                        <input
                            id="password"
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            className="input"
                            placeholder="Ingrese su contraseña"
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={loading || !username || !password}
                        className="w-full btn btn-primary py-3 text-base font-semibold disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                        {loading ? 'Iniciando sesión...' : 'Iniciar Sesión'}
                    </button>
                </form>

                <div className="mt-6 p-4 bg-secondary-50 rounded-lg">
                    <p className="text-xs text-secondary-600 font-medium mb-3">Acceso rápido (pruebas):</p>
                    <div className="grid grid-cols-2 gap-2">
                        <button
                            type="button"
                            disabled={loading}
                            onClick={() => handleQuickLogin('admin', 'admin123')}
                            className="px-3 py-2 bg-blue-100 hover:bg-blue-200 text-blue-700 rounded-lg text-xs font-medium transition-colors disabled:opacity-50"
                        >
                            👤 Admin
                        </button>
                        <button
                            type="button"
                            disabled={loading}
                            onClick={() => handleQuickLogin('analista', 'analista123')}
                            className="px-3 py-2 bg-green-100 hover:bg-green-200 text-green-700 rounded-lg text-xs font-medium transition-colors disabled:opacity-50"
                        >
                            👤 Analista
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Login;


