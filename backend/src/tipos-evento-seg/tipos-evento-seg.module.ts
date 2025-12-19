import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TiposEventoSegService } from './tipos-evento-seg.service';
import { TiposEventoSegController } from './tipos-evento-seg.controller';
import { TipoEventoSeg } from './tipo-evento-seg.entity';

@Module({
    imports: [TypeOrmModule.forFeature([TipoEventoSeg])],
    controllers: [TiposEventoSegController],
    providers: [TiposEventoSegService],
    exports: [TiposEventoSegService],
})
export class TiposEventoSegModule { }
