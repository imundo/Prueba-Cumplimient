// TipoSegmento DTOs
import { IsString, IsNotEmpty, IsOptional, IsBoolean } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateTipoSegmentoDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    name: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    description?: string;

    @ApiPropertyOptional({ default: true })
    @IsBoolean()
    @IsOptional()
    visible?: boolean;
}

export class UpdateTipoSegmentoDto {
    @IsString()
    @IsOptional()
    name?: string;

    @IsString()
    @IsOptional()
    description?: string;

    @IsBoolean()
    @IsOptional()
    visible?: boolean;
}

// TipoCumplimiento DTOs
export class CreateTipoCumplimientoDto {
    @ApiProperty()
    @IsString()
    @IsNotEmpty()
    nombre: string;
}

export class UpdateTipoCumplimientoDto {
    @IsString()
    @IsOptional()
    nombre?: string;
}

// TipoEventoSeg DTOs
export class CreateTipoEventoSegDto {
    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    estado?: string;

    @ApiPropertyOptional()
    @IsString()
    @IsOptional()
    descripcion?: string;
}

export class UpdateTipoEventoSegDto {
    @IsString()
    @IsOptional()
    estado?: string;

    @IsString()
    @IsOptional()
    descripcion?: string;
}
