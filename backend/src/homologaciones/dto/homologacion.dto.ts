import { IsString, IsNotEmpty, IsInt, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateHomologacionDto {
    @ApiProperty({ example: 1 })
    @IsInt()
    @IsNotEmpty()
    idSubNorma: number;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    valorInputNombreCoordinadoArchivoSubNorma?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    valorOutputEmpresaCc?: string;

    @ApiPropertyOptional({ example: '76.123.456-7' })
    @IsString()
    @IsOptional()
    rutReuc?: string;
}

export class UpdateHomologacionDto {
    @IsInt()
    @IsOptional()
    idSubNorma?: number;

    @IsString()
    @IsOptional()
    valorInputNombreCoordinadoArchivoSubNorma?: string;

    @IsString()
    @IsOptional()
    valorOutputEmpresaCc?: string;

    @IsString()
    @IsOptional()
    rutReuc?: string;
}
