import React, { createContext, useContext, useState, useEffect } from 'react';
import { User } from '../types';

interface AuthContextType {
    user: User | null;
    token: string | null;
    login: (username: string, password: string) => Promise<void>;
    logout: () => void;
    isAuthenticated: boolean;
    isAdmin: boolean;
}

// Mock users for testing - BYPASS API completely
const MOCK_USERS = [
    {
        id: 1,
        username: 'admin',
        password: 'admin123',
        role: 'admin' as const,
        email: 'admin@coordinador.cl',
        fullName: 'Administrador Sistema',
    },
    {
        id: 2,
        username: 'analista',
        password: 'analista123',
        role: 'analista' as const,
        email: 'analista@coordinador.cl',
        fullName: 'Analista Cumplimiento',
    },
];

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [user, setUser] = useState<User | null>(null);
    const [token, setToken] = useState<string | null>(null);

    useEffect(() => {
        // Load user and token from localStorage on mount
        const storedToken = localStorage.getItem('token');
        const storedUser = localStorage.getItem('user');

        if (storedToken && storedUser) {
            setToken(storedToken);
            setUser(JSON.parse(storedUser));
        }
    }, []);

    const login = async (username: string, password: string) => {
        // Use mock users directly - BYPASS API
        const mockUser = MOCK_USERS.find(
            u => u.username === username && u.password === password
        );

        if (mockUser) {
            const userData: User = {
                id: mockUser.id,
                username: mockUser.username,
                role: mockUser.role,
                email: mockUser.email,
                fullName: mockUser.fullName,
            };
            const mockToken = `mock-token-${Date.now()}`;

            setToken(mockToken);
            setUser(userData);

            localStorage.setItem('token', mockToken);
            localStorage.setItem('user', JSON.stringify(userData));

            console.log('✅ Logged in with mock user:', mockUser.username);
            return;
        }

        throw new Error('Credenciales inválidas. Use admin/admin123 o analista/analista123');
    };

    const logout = () => {
        setUser(null);
        setToken(null);
        localStorage.removeItem('token');
        localStorage.removeItem('user');
    };

    const value = {
        user,
        token,
        login,
        logout,
        isAuthenticated: !!token,
        isAdmin: user?.role === 'admin',
    };

    return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (context === undefined) {
        throw new Error('useAuth must be used within an AuthProvider');
    }
    return context;
};
