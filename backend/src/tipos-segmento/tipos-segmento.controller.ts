import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { TiposSegmentoService } from './tipos-segmento.service';
import { CreateTipoSegmentoDto, UpdateTipoSegmentoDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Controller('tipos-segmento')
export class TiposSegmentoController {
    constructor(private readonly tiposSegmentoService: TiposSegmentoService) { }

    @Post()
    create(@Body() createTipoSegmentoDto: CreateTipoSegmentoDto) {
        return this.tiposSegmentoService.create(createTipoSegmentoDto);
    }

    @Get()
    findAll(@Query() paginationDto: PaginationDto) {
        return this.tiposSegmentoService.findAll(paginationDto);
    }

    @Get(':id')
    findOne(@Param('id') id: string) {
        return this.tiposSegmentoService.findOne(+id);
    }

    @Patch(':id')
    update(@Param('id') id: string, @Body() updateTipoSegmentoDto: UpdateTipoSegmentoDto) {
        return this.tiposSegmentoService.update(+id, updateTipoSegmentoDto);
    }

    @Delete(':id')
    remove(@Param('id') id: string) {
        return this.tiposSegmentoService.remove(+id);
    }
}
