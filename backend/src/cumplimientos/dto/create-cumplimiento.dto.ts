import { IsString, IsNotEmpty, IsInt, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateCumplimientoDto {
    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idSubNorma: number;

    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idTipoCumplimiento: number;

    @ApiProperty({ example: 'cumple' })
    @IsString()
    @IsNotEmpty()
    estado: string;

    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idReuc: number;

    @ApiPropertyOptional({ example: 'Q1' })
    @IsString()
    @IsOptional()
    periodoCumplimiento?: string;

    @ApiPropertyOptional()
    @IsDateString()
    @IsOptional()
    fechaCarga?: Date;

    @ApiPropertyOptional({ example: 2024 })
    @IsInt()
    @IsOptional()
    anio?: number;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    valor?: string;
}
