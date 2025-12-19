import { IsString, IsNotEmpty, IsInt, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateCartaIncpmtDto {
    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idCumplimiento: number;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    correlativoCorrespondencia?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    hipervinculo?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    autoridad?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    materiaMacro?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    materiaMicro?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    referencia?: string;

    @ApiPropertyOptional()
    @IsDateString()
    @IsOptional()
    fechaCarta?: Date;
}

export class UpdateCartaIncpmtDto {
    @IsInt()
    @IsOptional()
    idCumplimiento?: number;

    @IsString()
    @IsOptional()
    correlativoCorrespondencia?: string;

    @IsString()
    @IsOptional()
    hipervinculo?: string;

    @IsString()
    @IsOptional()
    autoridad?: string;

    @IsString()
    @IsOptional()
    materiaMacro?: string;

    @IsString()
    @IsOptional()
    materiaMicro?: string;

    @IsString()
    @IsOptional()
    referencia?: string;

    @IsDateString()
    @IsOptional()
    fechaCarta?: Date;
}
