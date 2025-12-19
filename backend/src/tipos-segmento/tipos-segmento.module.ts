import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TiposSegmentoService } from './tipos-segmento.service';
import { TiposSegmentoController } from './tipos-segmento.controller';
import { TipoSegmento } from './tipo-segmento.entity';

@Module({
    imports: [TypeOrmModule.forFeature([TipoSegmento])],
    controllers: [TiposSegmentoController],
    providers: [TiposSegmentoService],
    exports: [TiposSegmentoService],
})
export class TiposSegmentoModule { }
