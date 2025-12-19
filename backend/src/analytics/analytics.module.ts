import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AnalyticsController } from './analytics.controller';
import { AnalyticsService } from './analytics.service';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';
import { Reuc } from '../reuc/reuc.entity';
import { Norma } from '../normas/norma.entity';
import { SubNorma } from '../sub-normas/sub-norma.entity';
import { TipoSegmento } from '../tipos-segmento/tipo-segmento.entity';
import { ReucTipoSegmento } from '../tipos-segmento/reuc-tipo-segmento.entity';

@Module({
    imports: [
        TypeOrmModule.forFeature([Cumplimiento, Reuc, Norma, SubNorma, TipoSegmento, ReucTipoSegmento]),
    ],
    controllers: [AnalyticsController],
    providers: [AnalyticsService],
})
export class AnalyticsModule { }

