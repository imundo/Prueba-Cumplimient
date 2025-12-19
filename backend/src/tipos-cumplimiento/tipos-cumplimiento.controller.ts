import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { TiposCumplimientoService } from './tipos-cumplimiento.service';
import { CreateTipoCumplimientoDto, UpdateTipoCumplimientoDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('tipos-cumplimiento')
@Controller('tipos-cumplimiento')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class TiposCumplimientoController {
    constructor(private readonly service: TiposCumplimientoService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear tipo de cumplimiento' })
    create(@Body() createDto: CreateTipoCumplimientoDto) {
        return this.service.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar tipos de cumplimiento' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.service.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener tipo de cumplimiento por ID' })
    findOne(@Param('id') id: string) {
        return this.service.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar tipo de cumplimiento' })
    update(@Param('id') id: string, @Body() updateDto: UpdateTipoCumplimientoDto) {
        return this.service.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar tipo de cumplimiento' })
    remove(@Param('id') id: string) {
        return this.service.remove(+id);
    }
}
