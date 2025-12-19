import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HomologacionesService } from './homologaciones.service';
import { HomologacionesController } from './homologaciones.controller';
import { Homologacion } from './homologacion.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Homologacion])],
    controllers: [HomologacionesController],
    providers: [HomologacionesService],
    exports: [HomologacionesService],
})
export class HomologacionesModule { }
