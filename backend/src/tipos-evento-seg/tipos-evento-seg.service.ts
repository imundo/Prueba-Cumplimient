import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TipoEventoSeg } from './tipo-evento-seg.entity';
import { CreateTipoEventoSegDto, UpdateTipoEventoSegDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class TiposEventoSegService {
    constructor(
        @InjectRepository(TipoEventoSeg)
        private tipoEventoSegRepository: Repository<TipoEventoSeg>,
    ) { }

    async create(createDto: CreateTipoEventoSegDto): Promise<TipoEventoSeg> {
        const tipo = this.tipoEventoSegRepository.create(createDto);
        return this.tipoEventoSegRepository.save(tipo);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.tipoEventoSegRepository.createQueryBuilder('tipo');

        if (search) {
            queryBuilder.where('tipo.descripcion ILIKE :search OR tipo.estado ILIKE :search', { search: `%${search}%` });
        }

        if (sortBy) {
            queryBuilder.orderBy(`tipo.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('tipo.idTipoEventoSeg', sortOrder);
        }

        const [data, total] = await queryBuilder.skip(skip).take(limit).getManyAndCount();

        return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
    }

    async findOne(id: number): Promise<TipoEventoSeg> {
        const tipo = await this.tipoEventoSegRepository.findOne({ where: { idTipoEventoSeg: id } });
        if (!tipo) throw new NotFoundException(`TipoEventoSeg con ID ${id} no encontrado`);
        return tipo;
    }

    async update(id: number, updateDto: UpdateTipoEventoSegDto): Promise<TipoEventoSeg> {
        const tipo = await this.findOne(id);
        Object.assign(tipo, updateDto);
        return this.tipoEventoSegRepository.save(tipo);
    }

    async remove(id: number): Promise<void> {
        const tipo = await this.findOne(id);
        await this.tipoEventoSegRepository.remove(tipo);
    }
}
