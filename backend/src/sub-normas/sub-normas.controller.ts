import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { SubNormasService } from './sub-normas.service';
import { CreateSubNormaDto } from './dto/create-sub-norma.dto';
import { UpdateSubNormaDto } from './dto/update-sub-norma.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('sub-normas')
@Controller('sub-normas')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class SubNormasController {
    constructor(private readonly subNormasService: SubNormasService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear una nueva sub-norma' })
    create(@Body() createDto: CreateSubNormaDto) {
        return this.subNormasService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todas las sub-normas' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.subNormasService.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener una sub-norma por ID' })
    findOne(@Param('id') id: string) {
        return this.subNormasService.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar una sub-norma' })
    update(@Param('id') id: string, @Body() updateDto: UpdateSubNormaDto) {
        return this.subNormasService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar una sub-norma' })
    remove(@Param('id') id: string) {
        return this.subNormasService.remove(+id);
    }
}
