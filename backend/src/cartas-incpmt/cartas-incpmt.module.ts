import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CartasIncpmtService } from './cartas-incpmt.service';
import { CartasIncpmtController } from './cartas-incpmt.controller';
import { CartaIncpmt } from './carta-incpmt.entity';

@Module({
    imports: [TypeOrmModule.forFeature([CartaIncpmt])],
    controllers: [CartasIncpmtController],
    providers: [CartasIncpmtService],
    exports: [CartasIncpmtService],
})
export class CartasIncpmtModule { }
