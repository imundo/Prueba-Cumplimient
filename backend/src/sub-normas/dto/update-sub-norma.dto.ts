import { PartialType } from '@nestjs/swagger';
import { CreateSubNormaDto } from './create-sub-norma.dto';

export class UpdateSubNormaDto extends PartialType(CreateSubNormaDto) { }
