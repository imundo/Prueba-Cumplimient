import { PartialType } from '@nestjs/swagger';
import { CreateReucDto } from './create-reuc.dto';

export class UpdateReucDto extends PartialType(CreateReucDto) { }
