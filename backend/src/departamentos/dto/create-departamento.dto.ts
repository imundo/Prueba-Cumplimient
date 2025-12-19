import { IsString, IsNotEmpty, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateDepartamentoDto {
    @ApiProperty({ example: 'Departamento de Recursos Humanos' })
    @IsString()
    @IsNotEmpty()
    nombre: string;

    @ApiPropertyOptional({ example: 'Jefatura RRHH' })
    @IsString()
    @IsOptional()
    jefatura?: string;

    @ApiPropertyOptional({ example: 'Juan Pérez' })
    @IsString()
    @IsOptional()
    responsableNombre?: string;
}
