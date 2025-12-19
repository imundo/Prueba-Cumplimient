import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { ReucService } from './reuc.service';
import { CreateReucDto } from './dto/create-reuc.dto';
import { UpdateReucDto } from './dto/update-reuc.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('reuc')
@Controller('reuc')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class ReucController {
    constructor(private readonly reucService: ReucService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear una nueva empresa REUC' })
    create(@Body() createDto: CreateReucDto) {
        return this.reucService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todas las empresas REUC' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.reucService.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener una empresa REUC por ID' })
    findOne(@Param('id') id: string) {
        return this.reucService.findOne(+id);
    }

    @Get('rut/:rut')
    @ApiOperation({ summary: 'Obtener una empresa REUC por RUT' })
    findByRut(@Param('rut') rut: string) {
        return this.reucService.findByRut(rut);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar una empresa REUC' })
    update(@Param('id') id: string, @Body() updateDto: UpdateReucDto) {
        return this.reucService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar una empresa REUC' })
    remove(@Param('id') id: string) {
        return this.reucService.remove(+id);
    }
}
