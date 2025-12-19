import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { useAuth } from './contexts/AuthContext';
import { ConfigProvider } from './contexts/ConfigContext';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import MainLayout from './components/layout/MainLayout';

// Analytics pages
import ImpactoNormativo from './pages/analytics/ImpactoNormativo';
import RelevanciaEstrategica from './pages/analytics/RelevanciaEstrategica';
import CumplimientoComportamiento from './pages/analytics/CumplimientoComportamiento';
import RiesgoMejora from './pages/analytics/RiesgoMejora';

// Normativa pages
import NormasList from './pages/normativa/NormasList';
import SubNormasList from './pages/normativa/SubNormasList';
import DepartamentosList from './pages/normativa/DepartamentosList';

// REUC pages
import ReucList from './pages/reuc/ReucList';
import ReucDetail from './pages/reuc/ReucDetail';

// Cumplimiento pages
import CumplimientoList from './pages/cumplimiento/CumplimientoList';
import CumplimientoDetail from './pages/cumplimiento/CumplimientoDetail';

// Cartas pages
import CartasList from './pages/cartas/CartasList';
import CartaDetail from './pages/cartas/CartaDetail';

// Homologación pages
import HomologacionList from './pages/homologacion/HomologacionList';

// Public pages
import CumplimientoPublico from './pages/public/CumplimientoPublico';

const ProtectedRoute: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const { isAuthenticated } = useAuth();
    return isAuthenticated ? <>{children}</> : <Navigate to="/" />;
};

function App() {
    return (
        <ConfigProvider>
            <AuthProvider>
                <BrowserRouter>
                    <Routes>
                        {/* Public routes */}
                        <Route path="/" element={<CumplimientoPublico />} />
                        <Route path="/login" element={<Login />} />

                        {/* Protected routes under /app */}
                        <Route
                            path="/app"
                            element={
                                <ProtectedRoute>
                                    <MainLayout />
                                </ProtectedRoute>
                            }
                        >
                            <Route index element={<Dashboard />} />

                            {/* Analytics routes */}
                            <Route path="impacto-normativo" element={<ImpactoNormativo />} />
                            <Route path="relevancia-estrategica" element={<RelevanciaEstrategica />} />
                            <Route path="cumplimiento-comportamiento" element={<CumplimientoComportamiento />} />
                            <Route path="riesgo-mejora" element={<RiesgoMejora />} />

                            {/* Normativa routes */}
                            <Route path="normativa/normas" element={<NormasList />} />
                            <Route path="normativa/sub-normas" element={<SubNormasList />} />
                            <Route path="normativa/departamentos" element={<DepartamentosList />} />

                            {/* REUC routes */}
                            <Route path="reuc" element={<ReucList />} />
                            <Route path="reuc/:id" element={<ReucDetail />} />

                            {/* Cumplimiento routes */}
                            <Route path="cumplimiento" element={<CumplimientoList />} />
                            <Route path="cumplimiento/:id" element={<CumplimientoDetail />} />

                            {/* Cartas routes */}
                            <Route path="cartas" element={<CartasList />} />
                            <Route path="cartas/:id" element={<CartaDetail />} />

                            {/* Homologación routes */}
                            <Route path="homologacion" element={<HomologacionList />} />
                        </Route>
                    </Routes>
                </BrowserRouter>
            </AuthProvider>
        </ConfigProvider>
    );
}

export default App;


