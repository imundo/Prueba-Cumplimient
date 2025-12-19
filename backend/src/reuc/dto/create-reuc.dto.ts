import { IsString, IsNotEmpty, IsOptional, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateReucDto {
    @ApiProperty({ example: 'Empresa REUC S.A.' })
    @IsString()
    @IsNotEmpty()
    nombreFantasia: string;

    @ApiProperty({ example: '76.123.456-7' })
    @IsString()
    @IsNotEmpty()
    rut: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    gerenteGeneral?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    correoElectronicoG?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    telefono?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    direccion?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    comuna?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    encargadoTitular?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    razonSocial?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    tipo?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    correoElectronicoEt?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    encargadoSuplente?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    correoElectronicoEs?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    encargadoFacturacion?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    correoElectronicoFac?: string;

    @ApiPropertyOptional({ example: 'activo' })
    @IsString()
    @IsOptional()
    estado?: string;

    @ApiPropertyOptional()
    @IsDateString()
    @IsOptional()
    fecha?: Date;
}
