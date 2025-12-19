import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { NormasService } from './normas.service';
import { CreateNormaDto } from './dto/create-norma.dto';
import { UpdateNormaDto } from './dto/update-norma.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('normas')
@Controller('normas')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class NormasController {
    constructor(private readonly normasService: NormasService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear una nueva norma' })
    create(@Body() createDto: CreateNormaDto) {
        return this.normasService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todas las normas' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.normasService.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener una norma por ID' })
    findOne(@Param('id') id: string) {
        return this.normasService.findOne(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar una norma' })
    update(@Param('id') id: string, @Body() updateDto: UpdateNormaDto) {
        return this.normasService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar una norma' })
    remove(@Param('id') id: string) {
        return this.normasService.remove(+id);
    }
}
