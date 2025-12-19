import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CumplimientosService } from './cumplimientos.service';
import { CumplimientosController } from './cumplimientos.controller';
import { Cumplimiento } from './cumplimiento.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Cumplimiento])],
    controllers: [CumplimientosController],
    providers: [CumplimientosService],
    exports: [CumplimientosService],
})
export class CumplimientosModule { }
