import { IsString, IsNotEmpty, IsInt, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateSubNormaDto {
    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idNorma: number;

    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idDepartamento: number;

    @ApiProperty({ example: 'Sub-norma de capacitación' })
    @IsString()
    @IsNotEmpty()
    nombre: string;

    @ApiPropertyOptional({ example: '1.1' })
    @IsString()
    @IsOptional()
    numeral?: string;

    @ApiPropertyOptional({ example: 'Mensual' })
    @IsString()
    @IsOptional()
    periodicidad?: string;

    @ApiPropertyOptional({ example: 'Descripción detallada' })
    @IsString()
    @IsOptional()
    descripcion?: string;
}
