import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { NormasService } from './normas.service';
import { NormasController } from './normas.controller';
import { Norma } from './norma.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Norma])],
    controllers: [NormasController],
    providers: [NormasService],
    exports: [NormasService],
})
export class NormasModule { }
