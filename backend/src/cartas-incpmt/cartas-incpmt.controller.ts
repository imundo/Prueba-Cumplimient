import { Controller, Get, Post, Body, Patch, Param, Delete, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { CartasIncpmtService } from './cartas-incpmt.service';
import { CreateCartaIncpmtDto, UpdateCartaIncpmtDto } from './dto/carta-incpmt.dto';
import { PaginationDto } from '../common/dto/pagination.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';

@ApiTags('cartas')
@Controller('cartas-incpmt')
@UseGuards(AuthGuard('jwt'), RolesGuard)
@ApiBearerAuth()
export class CartasIncpmtController {
    constructor(private readonly cartasService: CartasIncpmtService) { }

    @Post()
    @Roles('admin')
    @ApiOperation({ summary: 'Crear una nueva carta de incumplimiento' })
    create(@Body() createDto: CreateCartaIncpmtDto) {
        return this.cartasService.create(createDto);
    }

    @Get()
    @ApiOperation({ summary: 'Listar todas las cartas de incumplimiento' })
    findAll(@Query() paginationDto: PaginationDto) {
        return this.cartasService.findAll(paginationDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'Obtener una carta por ID' })
    findOne(@Param('id') id: string) {
        return this.cartasService.findOne(+id);
    }

    @Get(':id/seguimiento')
    @ApiOperation({ summary: 'Obtener seguimiento de una carta' })
    findSeguimiento(@Param('id') id: string) {
        return this.cartasService.findSeguimiento(+id);
    }

    @Patch(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Actualizar una carta' })
    update(@Param('id') id: string, @Body() updateDto: UpdateCartaIncpmtDto) {
        return this.cartasService.update(+id, updateDto);
    }

    @Delete(':id')
    @Roles('admin')
    @ApiOperation({ summary: 'Eliminar una carta' })
    remove(@Param('id') id: string) {
        return this.cartasService.remove(+id);
    }
}
