import { IsString, IsNotEmpty, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateNormaDto {
    @ApiProperty({ example: 'Norma de seguridad laboral' })
    @IsString()
    @IsNotEmpty()
    descripcion: string;

    @ApiPropertyOptional({ example: 'Art. 184' })
    @IsString()
    @IsOptional()
    articulo?: string;

    @ApiPropertyOptional({ example: 'Código del Trabajo' })
    @IsString()
    @IsOptional()
    cuerpoLegal?: string;
}
