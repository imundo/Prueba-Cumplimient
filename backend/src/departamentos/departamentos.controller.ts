import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { DepartamentosService } from './departamentos.service';
import { CreateDepartamentoDto } from './dto/create-departamento.dto';
import { UpdateDepartamentoDto } from './dto/update-departamento.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('departamentos')
@Controller('departamentos')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class DepartamentosController {
    constructor(private readonly departamentosService: DepartamentosService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear un nuevo departamento' })
    @ApiResponse({ status: 201, description: 'Departamento creado exitosamente' })
    create(@Body() createDto: CreateDepartamentoDto) {
        return this.departamentosService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todos los departamentos con paginación' })
    @ApiResponse({ status: 200, description: 'Lista de departamentos' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.departamentosService.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener un departamento por ID' })
    @ApiResponse({ status: 200, description: 'Departamento encontrado' })
    @ApiResponse({ status: 404, description: 'Departamento no encontrado' })
    findOne(@Param('id') id: string) {
        return this.departamentosService.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar un departamento' })
    @ApiResponse({ status: 200, description: 'Departamento actualizado' })
    update(@Param('id') id: string, @Body() updateDto: UpdateDepartamentoDto) {
        return this.departamentosService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar un departamento' })
    @ApiResponse({ status: 200, description: 'Departamento eliminado' })
    remove(@Param('id') id: string) {
        return this.departamentosService.remove(+id);
    }
}
