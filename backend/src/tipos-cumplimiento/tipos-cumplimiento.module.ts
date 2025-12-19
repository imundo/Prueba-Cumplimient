import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TiposCumplimientoService } from './tipos-cumplimiento.service';
import { TiposCumplimientoController } from './tipos-cumplimiento.controller';
import { TipoCumplimiento } from './tipo-cumplimiento.entity';

@Module({
    imports: [TypeOrmModule.forFeature([TipoCumplimiento])],
    controllers: [TiposCumplimientoController],
    providers: [TiposCumplimientoService],
    exports: [TiposCumplimientoService],
})
export class TiposCumplimientoModule { }
