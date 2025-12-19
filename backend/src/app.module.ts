import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { typeOrmConfig } from './config/typeorm.config';
import { AuthModule } from './auth/auth.module';
import { DepartamentosModule } from './departamentos/departamentos.module';
import { NormasModule } from './normas/normas.module';
import { SubNormasModule } from './sub-normas/sub-normas.module';
import { ReucModule } from './reuc/reuc.module';
import { TiposSegmentoModule } from './tipos-segmento/tipos-segmento.module';
import { TiposCumplimientoModule } from './tipos-cumplimiento/tipos-cumplimiento.module';
import { CumplimientosModule } from './cumplimientos/cumplimientos.module';
import { CartasIncpmtModule } from './cartas-incpmt/cartas-incpmt.module';
import { TiposEventoSegModule } from './tipos-evento-seg/tipos-evento-seg.module';
import { HomologacionesModule } from './homologaciones/homologaciones.module';
import { AnalyticsModule } from './analytics/analytics.module';

@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal: true,
        }),
        TypeOrmModule.forRoot(typeOrmConfig),
        AuthModule,
        AnalyticsModule,
        DepartamentosModule,
        NormasModule,
        SubNormasModule,
        ReucModule,
        TiposSegmentoModule,
        TiposCumplimientoModule,
        CumplimientosModule,
        CartasIncpmtModule,
        TiposEventoSegModule,
        HomologacionesModule,
    ],
})
export class AppModule { }
