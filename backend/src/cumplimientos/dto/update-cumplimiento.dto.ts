import { PartialType } from '@nestjs/swagger';
import { CreateCumplimientoDto } from './create-cumplimiento.dto';

export class UpdateCumplimientoDto extends PartialType(CreateCumplimientoDto) { }
