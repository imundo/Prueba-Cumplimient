import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TipoSegmento } from './tipo-segmento.entity';
import { CreateTipoSegmentoDto, UpdateTipoSegmentoDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class TiposSegmentoService {
    constructor(
        @InjectRepository(TipoSegmento)
        private tipoSegmentoRepository: Repository<TipoSegmento>,
    ) { }

    async create(createDto: CreateTipoSegmentoDto): Promise<TipoSegmento> {
        const tipo = this.tipoSegmentoRepository.create(createDto);
        return this.tipoSegmentoRepository.save(tipo);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.tipoSegmentoRepository.createQueryBuilder('tipo');

        if (search) {
            queryBuilder.where('tipo.name ILIKE :search OR tipo.description ILIKE :search', { search: `%${search}%` });
        }

        if (sortBy) {
            queryBuilder.orderBy(`tipo.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('tipo.id', sortOrder);
        }

        const [data, total] = await queryBuilder.skip(skip).take(limit).getManyAndCount();

        return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
    }

    async findOne(id: number): Promise<TipoSegmento> {
        const tipo = await this.tipoSegmentoRepository.findOne({ where: { id } });
        if (!tipo) throw new NotFoundException(`TipoSegmento con ID ${id} no encontrado`);
        return tipo;
    }

    async update(id: number, updateDto: UpdateTipoSegmentoDto): Promise<TipoSegmento> {
        const tipo = await this.findOne(id);
        Object.assign(tipo, updateDto);
        return this.tipoSegmentoRepository.save(tipo);
    }

    async remove(id: number): Promise<void> {
        const tipo = await this.findOne(id);
        await this.tipoSegmentoRepository.remove(tipo);
    }
}
