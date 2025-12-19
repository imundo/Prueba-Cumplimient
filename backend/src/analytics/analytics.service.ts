import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';
import { Reuc } from '../reuc/reuc.entity';
import { Norma } from '../normas/norma.entity';
import { SubNorma } from '../sub-normas/sub-norma.entity';
import { TipoSegmento } from '../tipos-segmento/tipo-segmento.entity';
import { ReucTipoSegmento } from '../tipos-segmento/reuc-tipo-segmento.entity';

interface FilterOptions {
    year?: string;
    tipoCoordinado?: string;
    tipoNorma?: string;
    region?: string;
}

@Injectable()
export class AnalyticsService {
    constructor(
        @InjectRepository(Cumplimiento)
        private cumplimientoRepository: Repository<Cumplimiento>,
        @InjectRepository(Reuc)
        private reucRepository: Repository<Reuc>,
        @InjectRepository(Norma)
        private normaRepository: Repository<Norma>,
        @InjectRepository(SubNorma)
        private subNormaRepository: Repository<SubNorma>,
        @InjectRepository(TipoSegmento)
        private tipoSegmentoRepository: Repository<TipoSegmento>,
        @InjectRepository(ReucTipoSegmento)
        private reucTipoSegmentoRepository: Repository<ReucTipoSegmento>,
    ) { }

    async getDashboardSummary(filters: FilterOptions = {}) {
        const query = this.cumplimientoRepository.createQueryBuilder('c');

        if (filters.year) {
            query.andWhere('c.anio = :year', { year: filters.year });
        }

        const cumplimientos = await query.getMany();
        const cumpleCount = cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
        const totalCount = cumplimientos.length;

        const cumplimientoGlobal = totalCount > 0 ? ((cumpleCount / totalCount) * 100).toFixed(1) : '0.0';

        const coordinados = await this.reucRepository.count();
        const normasActivas = await this.normaRepository.count();

        return {
            cumplimientoGlobal: {
                value: parseFloat(cumplimientoGlobal),
                trend: 2.4,
            },
            numCoordinados: {
                value: coordinados,
                trend: 3,
            },
            normasActivas: {
                value: normasActivas,
                trend: 0,
            },
        };
    }

    async getComplianceTrend(filters: FilterOptions = {}) {
        const query = this.cumplimientoRepository.createQueryBuilder('c');

        if (filters.year) {
            query.where('c.anio = :year', { year: filters.year });
        } else {
            query.where("c.anio = '2025'");
        }

        const cumplimientos = await query.getMany();

        const monthMap = new Map<string, { cumple: number; total: number }>();

        cumplimientos.forEach(c => {
            const periodo = c.periodoCumplimiento || '1';
            if (!monthMap.has(periodo)) {
                monthMap.set(periodo, { cumple: 0, total: 0 });
            }
            const data = monthMap.get(periodo)!;
            data.total++;
            if (c.estado === 'CUMPLE' || c.estado === 'cumple') {
                data.cumple++;
            }
        });

        const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
        const currentYearData = months.map((month, index) => {
            const periodo = (index + 1).toString();
            const data = monthMap.get(periodo);
            const percentage = data && data.total > 0 ? (data.cumple / data.total) * 100 : 0;

            return {
                month,
                value: parseFloat(percentage.toFixed(1)),
            };
        });

        const prevYear = filters.year ? (parseInt(filters.year) - 1).toString() : '2024';
        const prevQuery = this.cumplimientoRepository.createQueryBuilder('c')
            .where('c.anio = :year', { year: prevYear });

        const prevCumplimientos = await prevQuery.getMany();
        const prevMonthMap = new Map<string, { cumple: number; total: number }>();

        prevCumplimientos.forEach(c => {
            const periodo = c.periodoCumplimiento || '1';
            if (!prevMonthMap.has(periodo)) {
                prevMonthMap.set(periodo, { cumple: 0, total: 0 });
            }
            const data = prevMonthMap.get(periodo)!;
            data.total++;
            if (c.estado === 'CUMPLE' || c.estado === 'cumple') {
                data.cumple++;
            }
        });

        const previousYearData = months.map((month, index) => {
            const periodo = (index + 1).toString();
            const data = prevMonthMap.get(periodo);
            const percentage = data && data.total > 0 ? (data.cumple / data.total) * 100 : 0;

            return {
                month,
                value: parseFloat(percentage.toFixed(1)),
            };
        });

        return {
            currentYear: currentYearData,
            previousYear: previousYearData,
        };
    }

    async getCoordinadosRanking(limit: number = 10, filters: FilterOptions = {}) {
        const coordinados = await this.reucRepository.find({
            take: 100,
        });

        const rankings = await Promise.all(
            coordinados.map(async (reuc) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idReuc = :idReuc', { idReuc: reuc.idReuc });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const cumplimientos = await query.getMany();
                const cumpleCount = cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
                const total = cumplimientos.length;
                const compliance = total > 0 ? (cumpleCount / total) * 100 : 0;

                return {
                    name: reuc.nombreFantasia || reuc.razonSocial || `REUC ${reuc.idReuc}`,
                    compliance: parseFloat(compliance.toFixed(1)),
                };
            })
        );

        return rankings
            .filter(r => r.compliance > 0)
            .sort((a, b) => b.compliance - a.compliance)
            .slice(0, limit);
    }

    async getNormasRanking(limit: number = 10, filters: FilterOptions = {}) {
        const subNormas = await this.subNormaRepository.find({
            relations: ['norma'],
            take: 100,
        });

        const rankings = await Promise.all(
            subNormas.map(async (subNorma) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idSubNorma = :idSubNorma', { idSubNorma: subNorma.idSubNorma });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const count = await query.getCount();

                return {
                    id: subNorma.idSubNorma,
                    descripcion: subNorma.nombre || subNorma.descripcion || `SubNorma ${subNorma.idSubNorma}`,
                    applicableCoordinados: count,
                };
            })
        );

        return rankings
            .filter(r => r.applicableCoordinados > 0)
            .sort((a, b) => b.applicableCoordinados - a.applicableCoordinados)
            .slice(0, limit);
    }

    async getImpactMap(filters: FilterOptions = {}) {
        const subNormas = await this.subNormaRepository.find({
            take: 50,
        });

        const impactData = await Promise.all(
            subNormas.map(async (subNorma) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idSubNorma = :idSubNorma', { idSubNorma: subNorma.idSubNorma });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const cumplimientos = await query.getMany();
                const cumpleCount = cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
                const total = cumplimientos.length;
                const avgCompliance = total > 0 ? (cumpleCount / total) * 100 : 0;

                return {
                    normaId: subNorma.idSubNorma,
                    numCoordinados: total,
                    avgCompliance: parseFloat(avgCompliance.toFixed(1)),
                    bubbleSize: total,
                };
            })
        );

        return impactData.filter(item => item.numCoordinados > 0);
    }

    async getFilterOptions() {
        const years = await this.cumplimientoRepository
            .createQueryBuilder('c')
            .select('DISTINCT c.anio', 'year')
            .where('c.anio IS NOT NULL')
            .getRawMany();

        return {
            years: years.map(y => y.year).filter(y => y).sort().reverse(),
            tiposCoordinado: ['Todos'],
            tiposNorma: ['Todos'],
            regiones: ['Todas las regiones'],
        };
    }

    async getStrategicRelevance(filters: FilterOptions = {}) {
        const subNormas = await this.subNormaRepository.find({
            relations: ['norma'],
            take: 50,
        });

        const relevanceData = await Promise.all(
            subNormas.map(async (subNorma) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idSubNorma = :idSubNorma', { idSubNorma: subNorma.idSubNorma });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const cumplimientos = await query.getMany();
                const total = cumplimientos.length;
                const cumpleCount = cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
                const incumpleCount = total - cumpleCount;

                // Strategic relevance score based on impact and compliance
                const impactScore = Math.min(total * 10, 100);
                const riskScore = total > 0 ? ((incumpleCount / total) * 100) : 0;

                return {
                    id: subNorma.idSubNorma,
                    name: subNorma.nombre || subNorma.descripcion || `SubNorma ${subNorma.idSubNorma}`,
                    norma: subNorma.norma?.descripcion || 'Sin norma',
                    totalCoordinados: total,
                    cumplimiento: total > 0 ? parseFloat(((cumpleCount / total) * 100).toFixed(1)) : 0,
                    impactScore: parseFloat(impactScore.toFixed(1)),
                    riskScore: parseFloat(riskScore.toFixed(1)),
                    relevanceScore: parseFloat(((impactScore * 0.6) + (riskScore * 0.4)).toFixed(1)),
                };
            })
        );

        return relevanceData
            .filter(r => r.totalCoordinados > 0)
            .sort((a, b) => b.relevanceScore - a.relevanceScore)
            .slice(0, 20);
    }

    async getComplianceDistribution(filters: FilterOptions = {}) {
        const query = this.cumplimientoRepository.createQueryBuilder('c');

        if (filters.year) {
            query.where('c.anio = :year', { year: filters.year });
        }

        const cumplimientos = await query.getMany();

        const distribution = {
            cumple: cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length,
            noCumple: cumplimientos.filter(c => c.estado === 'NO CUMPLE' || c.estado === 'no cumple').length,
            pendiente: cumplimientos.filter(c => c.estado === 'PENDIENTE' || c.estado === 'pendiente').length,
            noAplica: cumplimientos.filter(c => c.estado === 'NO APLICA' || c.estado === 'no aplica' || c.estado === 'N/A').length,
        };

        const total = Object.values(distribution).reduce((a, b) => a + b, 0);

        return {
            distribution: [
                { name: 'Cumple', value: distribution.cumple, color: '#22c55e', percentage: total > 0 ? parseFloat(((distribution.cumple / total) * 100).toFixed(1)) : 0 },
                { name: 'No Cumple', value: distribution.noCumple, color: '#ef4444', percentage: total > 0 ? parseFloat(((distribution.noCumple / total) * 100).toFixed(1)) : 0 },
                { name: 'Pendiente', value: distribution.pendiente, color: '#f59e0b', percentage: total > 0 ? parseFloat(((distribution.pendiente / total) * 100).toFixed(1)) : 0 },
                { name: 'No Aplica', value: distribution.noAplica, color: '#6b7280', percentage: total > 0 ? parseFloat(((distribution.noAplica / total) * 100).toFixed(1)) : 0 },
            ],
            total,
        };
    }

    async getBehaviorTrend(filters: FilterOptions = {}) {
        const currentYear = filters.year || new Date().getFullYear().toString();
        const previousYear = (parseInt(currentYear) - 1).toString();

        const [currentData, previousData] = await Promise.all([
            this.getMonthlyBehavior(currentYear),
            this.getMonthlyBehavior(previousYear),
        ]);

        return {
            currentYear: { year: currentYear, data: currentData },
            previousYear: { year: previousYear, data: previousData },
        };
    }

    private async getMonthlyBehavior(year: string) {
        const cumplimientos = await this.cumplimientoRepository
            .createQueryBuilder('c')
            .where('c.anio = :year', { year })
            .getMany();

        const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];

        return months.map((month, index) => {
            const periodo = (index + 1).toString();
            const monthData = cumplimientos.filter(c => c.periodoCumplimiento === periodo);
            const cumple = monthData.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
            const noCumple = monthData.filter(c => c.estado === 'NO CUMPLE' || c.estado === 'no cumple').length;

            return {
                month,
                cumple,
                noCumple,
                total: monthData.length,
            };
        });
    }

    async getRiskMatrix(filters: FilterOptions = {}) {
        const coordinados = await this.reucRepository.find({ take: 50 });

        const riskData = await Promise.all(
            coordinados.map(async (reuc) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idReuc = :idReuc', { idReuc: reuc.idReuc });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const cumplimientos = await query.getMany();
                const total = cumplimientos.length;
                const incumpleCount = cumplimientos.filter(c => c.estado === 'NO CUMPLE' || c.estado === 'no cumple').length;

                // Probability: % of non-compliance
                const probability = total > 0 ? (incumpleCount / total) * 100 : 0;
                // Impact: based on number of obligations
                const impact = Math.min(total * 5, 100);

                // Risk quadrant
                let quadrant = 'low';
                if (probability >= 50 && impact >= 50) quadrant = 'critical';
                else if (probability >= 50 && impact < 50) quadrant = 'high';
                else if (probability < 50 && impact >= 50) quadrant = 'medium';

                return {
                    id: reuc.idReuc,
                    name: reuc.nombreFantasia || reuc.razonSocial || `REUC ${reuc.idReuc}`,
                    probability: parseFloat(probability.toFixed(1)),
                    impact: parseFloat(impact.toFixed(1)),
                    quadrant,
                    incumplimientos: incumpleCount,
                };
            })
        );

        return riskData.filter(r => r.probability > 0 || r.impact > 0);
    }

    async getAlerts(filters: FilterOptions = {}) {
        const query = this.cumplimientoRepository
            .createQueryBuilder('c')
            .leftJoinAndSelect('c.reuc', 'reuc')
            .leftJoinAndSelect('c.subNorma', 'subNorma')
            .where("(c.estado = 'NO CUMPLE' OR c.estado = 'no cumple')");

        if (filters.year) {
            query.andWhere('c.anio = :year', { year: filters.year });
        }

        const incumplimientos = await query.take(20).getMany();

        return incumplimientos.map((c, index) => ({
            id: index + 1,
            type: 'incumplimiento',
            priority: 'alta',
            title: `Incumplimiento detectado`,
            description: `${c.reuc?.nombreFantasia || 'Coordinado'} - ${c.subNorma?.nombre || 'Norma'}`,
            coordinado: c.reuc?.nombreFantasia || 'Sin nombre',
            norma: c.subNorma?.nombre || 'Sin norma',
            fecha: c.fechaCarga,
            periodo: c.periodoCumplimiento,
        }));
    }

    async getImprovementOpportunities(filters: FilterOptions = {}) {
        const coordinados = await this.reucRepository.find({ take: 30 });

        const opportunities = await Promise.all(
            coordinados.map(async (reuc) => {
                const query = this.cumplimientoRepository
                    .createQueryBuilder('c')
                    .where('c.idReuc = :idReuc', { idReuc: reuc.idReuc });

                if (filters.year) {
                    query.andWhere('c.anio = :year', { year: filters.year });
                }

                const cumplimientos = await query.getMany();
                const total = cumplimientos.length;
                const cumpleCount = cumplimientos.filter(c => c.estado === 'CUMPLE' || c.estado === 'cumple').length;
                const incumpleCount = cumplimientos.filter(c => c.estado === 'NO CUMPLE' || c.estado === 'no cumple').length;

                // Improvement potential: coordinados with some compliance but room to grow
                const currentCompliance = total > 0 ? (cumpleCount / total) * 100 : 0;
                const potentialGain = 100 - currentCompliance;

                return {
                    id: reuc.idReuc,
                    name: reuc.nombreFantasia || reuc.razonSocial || `REUC ${reuc.idReuc}`,
                    currentCompliance: parseFloat(currentCompliance.toFixed(1)),
                    potentialGain: parseFloat(potentialGain.toFixed(1)),
                    incumplimientos: incumpleCount,
                    totalObligaciones: total,
                    priority: potentialGain > 50 ? 'alta' : potentialGain > 25 ? 'media' : 'baja',
                };
            })
        );

        return opportunities
            .filter(o => o.potentialGain > 0 && o.totalObligaciones > 0)
            .sort((a, b) => b.potentialGain - a.potentialGain)
            .slice(0, 15);
    }

    async getPublicCompliance(filters: FilterOptions = {}) {
        const year = filters.year || new Date().getFullYear().toString();

        // Get compliance trend (reusing existing logic)
        const complianceTrend = await this.getComplianceTrend({ year });

        // Get available years
        const yearsResult = await this.cumplimientoRepository
            .createQueryBuilder('c')
            .select('DISTINCT c.anio', 'year')
            .where('c.anio IS NOT NULL')
            .getRawMany();

        const years = yearsResult
            .map(y => y.year)
            .filter(y => y)
            .sort()
            .reverse();

        const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];

        // Try to get compliance by segment, but handle case where tables don't exist
        let filteredSegments = [];
        try {
            // Get all visible segments
            const segments = await this.tipoSegmentoRepository.find({
                where: { visible: true },
            });

            // Get compliance data for each segment
            const complianceBySegment = await Promise.all(
                segments.map(async (segment) => {
                    // Get all REUCs that belong to this segment
                    const reucSegments = await this.reucTipoSegmentoRepository.find({
                        where: { idTipoSegmento: segment.id },
                        relations: ['reuc'],
                    });

                    const rutsList = reucSegments.map(rs => rs.rutReuc).filter(rut => rut);

                    if (rutsList.length === 0) {
                        return {
                            segmentId: segment.id,
                            segmentName: segment.name || `Segmento ${segment.id}`,
                            months: months.map(month => ({ month, compliance: 0 })),
                            average: 0,
                        };
                    }

                    // Get cumplimientos for these REUCs in the selected year
                    const cumplimientos = await this.cumplimientoRepository
                        .createQueryBuilder('c')
                        .leftJoin('c.reuc', 'reuc')
                        .where('c.anio = :year', { year })
                        .andWhere('reuc.rut IN (:...ruts)', { ruts: rutsList })
                        .getMany();

                    // Calculate compliance per month
                    const monthlyData = months.map((month, index) => {
                        const periodo = (index + 1).toString();
                        const monthCumplimientos = cumplimientos.filter(
                            c => c.periodoCumplimiento === periodo
                        );
                        const cumpleCount = monthCumplimientos.filter(
                            c => c.estado === 'CUMPLE' || c.estado === 'cumple'
                        ).length;
                        const total = monthCumplimientos.length;
                        const compliance = total > 0 ? (cumpleCount / total) * 100 : 0;

                        return {
                            month,
                            compliance: parseFloat(compliance.toFixed(1)),
                        };
                    });

                    // Calculate average
                    const validMonths = monthlyData.filter(m => m.compliance > 0);
                    const average = validMonths.length > 0
                        ? validMonths.reduce((acc, m) => acc + m.compliance, 0) / validMonths.length
                        : 0;

                    return {
                        segmentId: segment.id,
                        segmentName: segment.name || `Segmento ${segment.id}`,
                        months: monthlyData,
                        average: parseFloat(average.toFixed(1)),
                    };
                })
            );

            // Filter out segments with no data and sort by average
            filteredSegments = complianceBySegment
                .filter(s => s.average > 0 || s.months.some(m => m.compliance > 0))
                .sort((a, b) => b.average - a.average);
        } catch (error) {
            console.warn('Could not load segment compliance data:', error.message);
            // Return empty segments if tables don't exist
            filteredSegments = [];
        }

        return {
            complianceTrend,
            complianceBySegment: filteredSegments,
            years,
            currentYear: year,
        };
    }
}

