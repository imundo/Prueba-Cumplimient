import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ReucService } from './reuc.service';
import { ReucController } from './reuc.controller';
import { Reuc } from './reuc.entity';

@Module({
    imports: [TypeOrmModule.forFeature([Reuc])],
    controllers: [ReucController],
    providers: [ReucService],
    exports: [ReucService],
})
export class ReucModule { }
