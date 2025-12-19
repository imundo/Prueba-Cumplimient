import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { HomologacionesService } from './homologaciones.service';
import { CreateHomologacionDto, UpdateHomologacionDto } from './dto/homologacion.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('homologaciones')
@Controller('homologaciones')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class HomologacionesController {
    constructor(private readonly service: HomologacionesService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear una nueva homologación' })
    create(@Body() createDto: CreateHomologacionDto) {
        return this.service.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todas las homologaciones' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.service.findAll(paginationDto);
    }

    @Get('reuc/:rut')
    @ApiOperation({ summary: 'Listar homologaciones por RUT de empresa REUC' })
    findByRut(@Param('rut') rut: string, @Query() paginationDto: PaginationDto) {
        return this.service.findByRut(rut, paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener una homologación por ID' })
    findOne(@Param('id') id: string) {
        return this.service.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar una homologación' })
    update(@Param('id') id: string, @Body() updateDto: UpdateHomologacionDto) {
        return this.service.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar una homologación' })
    remove(@Param('id') id: string) {
        return this.service.remove(+id);
    }
}
