import { Controller, Get, Query } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { AnalyticsService } from './analytics.service';
import { ENABLE_MAINTAINERS } from '../config/typeorm.config';

@ApiTags('analytics')
@Controller('analytics')
export class AnalyticsController {
    constructor(private readonly analyticsService: AnalyticsService) { }

    @Get('config')
    @ApiOperation({ summary: 'Get application configuration and feature flags' })
    getConfig() {
        return {
            enableMaintainers: ENABLE_MAINTAINERS,
            environment: process.env.NODE_ENV || 'production',
        };
    }

    @Get('dashboard')
    @ApiOperation({ summary: 'Get dashboard summary statistics' })
    @ApiQuery({ name: 'year', required: false, type: String })
    @ApiQuery({ name: 'tipoCoordinado', required: false, type: String })
    @ApiQuery({ name: 'tipoNorma', required: false, type: String })
    @ApiQuery({ name: 'region', required: false, type: String })
    async getDashboardSummary(
        @Query('year') year?: string,
        @Query('tipoCoordinado') tipoCoordinado?: string,
        @Query('tipoNorma') tipoNorma?: string,
        @Query('region') region?: string,
    ) {
        return this.analyticsService.getDashboardSummary({ year, tipoCoordinado, tipoNorma, region });
    }

    @Get('compliance-trend')
    @ApiOperation({ summary: 'Get compliance trend over time' })
    @ApiQuery({ name: 'year', required: false, type: String })
    @ApiQuery({ name: 'tipoCoordinado', required: false, type: String })
    async getComplianceTrend(
        @Query('year') year?: string,
        @Query('tipoCoordinado') tipoCoordinado?: string,
    ) {
        return this.analyticsService.getComplianceTrend({ year, tipoCoordinado });
    }

    @Get('coordinados-ranking')
    @ApiOperation({ summary: 'Get coordinados ranking by compliance' })
    @ApiQuery({ name: 'limit', required: false, type: Number })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getCoordinadosRanking(
        @Query('limit') limit?: number,
        @Query('year') year?: string,
    ) {
        return this.analyticsService.getCoordinadosRanking(limit || 10, { year });
    }

    @Get('normas-ranking')
    @ApiOperation({ summary: 'Get normas ranking by impact' })
    @ApiQuery({ name: 'limit', required: false, type: Number })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getNormasRanking(
        @Query('limit') limit?: number,
        @Query('year') year?: string,
    ) {
        return this.analyticsService.getNormasRanking(limit || 10, { year });
    }

    @Get('impact-map')
    @ApiOperation({ summary: 'Get impact map data for scatter plot' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getImpactMap(@Query('year') year?: string) {
        return this.analyticsService.getImpactMap({ year });
    }

    @Get('filter-options')
    @ApiOperation({ summary: 'Get available filter options' })
    async getFilterOptions() {
        return this.analyticsService.getFilterOptions();
    }

    @Get('strategic-relevance')
    @ApiOperation({ summary: 'Get strategic relevance analysis' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getStrategicRelevance(@Query('year') year?: string) {
        return this.analyticsService.getStrategicRelevance({ year });
    }

    @Get('compliance-distribution')
    @ApiOperation({ summary: 'Get compliance distribution by state' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getComplianceDistribution(@Query('year') year?: string) {
        return this.analyticsService.getComplianceDistribution({ year });
    }

    @Get('behavior-trend')
    @ApiOperation({ summary: 'Get behavior trend over time' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getBehaviorTrend(@Query('year') year?: string) {
        return this.analyticsService.getBehaviorTrend({ year });
    }

    @Get('risk-matrix')
    @ApiOperation({ summary: 'Get risk matrix data' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getRiskMatrix(@Query('year') year?: string) {
        return this.analyticsService.getRiskMatrix({ year });
    }

    @Get('alerts')
    @ApiOperation({ summary: 'Get active alerts' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getAlerts(@Query('year') year?: string) {
        return this.analyticsService.getAlerts({ year });
    }

    @Get('improvement-opportunities')
    @ApiOperation({ summary: 'Get improvement opportunities' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getImprovementOpportunities(@Query('year') year?: string) {
        return this.analyticsService.getImprovementOpportunities({ year });
    }

    @Get('public-compliance')
    @ApiOperation({ summary: 'Get public compliance data for public view' })
    @ApiQuery({ name: 'year', required: false, type: String })
    async getPublicCompliance(@Query('year') year?: string) {
        return this.analyticsService.getPublicCompliance({ year });
    }
}

