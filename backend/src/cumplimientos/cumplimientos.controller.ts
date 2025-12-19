import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { CumplimientosService } from './cumplimientos.service';
import { CreateCumplimientoDto } from './dto/create-cumplimiento.dto';
import { UpdateCumplimientoDto } from './dto/update-cumplimiento.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('cumplimientos')
@Controller('cumplimientos')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class CumplimientosController {
    constructor(private readonly cumplimientosService: CumplimientosService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear un nuevo cumplimiento' })
    create(@Body() createDto: CreateCumplimientoDto) {
        return this.cumplimientosService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todos los cumplimientos' })
    @ApiQuery({ name: 'anio', required: false, type: Number })
    @ApiQuery({ name: 'estado', required: false, type: String })
    @ApiQuery({ name: 'idReuc', required: false, type: Number })
    findAll(@Query() paginationDto: PaginationDto & { anio?: number; estado?: string; idReuc?: number }) {
        return this.cumplimientosService.findAll(paginationDto);
    }

    @Get('con-detalle')
    @ApiOperation({ summary: 'Listar cumplimientos con detalles completos (joins)' })
    findAllWithDetails(@Query() paginationDto: PaginationDto) {
        return this.cumplimientosService.findAllWithDetails(paginationDto);
    }

    @Get('reuc/:idReuc')
    @ApiOperation({ summary: 'Listar cumplimientos por empresa REUC' })
    findByReuc(@Param('idReuc') idReuc: string, @Query() paginationDto: PaginationDto) {
        return this.cumplimientosService.findByReuc(+idReuc, paginationDto);
    }

    @Get('sub-norma/:idSubNorma')
    @ApiOperation({ summary: 'Listar cumplimientos por sub-norma' })
    findBySubNorma(@Param('idSubNorma') idSubNorma: string, @Query() paginationDto: PaginationDto) {
        return this.cumplimientosService.findBySubNorma(+idSubNorma, paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener un cumplimiento por ID' })
    findOne(@Param('id') id: string) {
        return this.cumplimientosService.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar un cumplimiento' })
    update(@Param('id') id: string, @Body() updateDto: UpdateCumplimientoDto) {
        return this.cumplimientosService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar un cumplimiento' })
    remove(@Param('id') id: string) {
        return this.cumplimientosService.remove(+id);
    }
}
