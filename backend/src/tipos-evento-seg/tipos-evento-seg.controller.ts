import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { TiposEventoSegService } from './tipos-evento-seg.service';
import { CreateTipoEventoSegDto, UpdateTipoEventoSegDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('tipos-evento-seg')
@Controller('tipos-evento-seg')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class TiposEventoSegController {
    constructor(private readonly service: TiposEventoSegService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear tipo de evento de seguimiento' })
    create(@Body() createDto: CreateTipoEventoSegDto) {
        return this.service.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar tipos de evento de seguimiento' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.service.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener tipo de evento por ID' })
    findOne(@Param('id') id: string) {
        return this.service.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar tipo de evento' })
    update(@Param('id') id: string, @Body() updateDto: UpdateTipoEventoSegDto) {
        return this.service.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar tipo de evento' })
    remove(@Param('id') id: string) {
        return this.service.remove(+id);
    }
}
