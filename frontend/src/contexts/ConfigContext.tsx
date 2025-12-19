import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { api } from '../lib/api';

interface ConfigContextType {
    enableMaintainers: boolean;
    environment: string;
    loading: boolean;
}

const ConfigContext = createContext<ConfigContextType>({
    enableMaintainers: false,
    environment: 'production',
    loading: true,
});

export const useConfig = () => useContext(ConfigContext);

interface ConfigProviderProps {
    children: ReactNode;
}

export const ConfigProvider: React.FC<ConfigProviderProps> = ({ children }) => {
    const [config, setConfig] = useState<ConfigContextType>({
        enableMaintainers: false,
        environment: 'production',
        loading: true,
    });

    useEffect(() => {
        const loadConfig = async () => {
            try {
                const response = await api.get('/analytics/config');
                setConfig({
                    enableMaintainers: response.data.enableMaintainers || false,
                    environment: response.data.environment || 'production',
                    loading: false,
                });
            } catch (error) {
                console.error('Error loading config:', error);
                // Default to production/read-only mode on error
                setConfig({
                    enableMaintainers: false,
                    environment: 'production',
                    loading: false,
                });
            }
        };

        loadConfig();
    }, []);

    return (
        <ConfigContext.Provider value={config}>
            {children}
        </ConfigContext.Provider>
    );
};

export default ConfigContext;
