import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SubNormasService } from './sub-normas.service';
import { SubNormasController } from './sub-normas.controller';
import { SubNorma } from './sub-norma.entity';

@Module({
    imports: [TypeOrmModule.forFeature([SubNorma])],
    controllers: [SubNormasController],
    providers: [SubNormasService],
    exports: [SubNormasService],
})
export class SubNormasModule { }
