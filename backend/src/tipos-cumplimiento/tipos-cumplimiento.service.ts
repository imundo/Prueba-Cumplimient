import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TipoCumplimiento } from './tipo-cumplimiento.entity';
import { CreateTipoCumplimientoDto, UpdateTipoCumplimientoDto } from '../common/dto/tipos.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class TiposCumplimientoService {
    constructor(
        @InjectRepository(TipoCumplimiento)
        private tipoCumplimientoRepository: Repository<TipoCumplimiento>,
    ) { }

    async create(createDto: CreateTipoCumplimientoDto): Promise<TipoCumplimiento> {
        const tipo = this.tipoCumplimientoRepository.create(createDto);
        return this.tipoCumplimientoRepository.save(tipo);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.tipoCumplimientoRepository.createQueryBuilder('tipo');

        if (search) {
            queryBuilder.where('tipo.nombre ILIKE :search', { search: `%${search}%` });
        }

        if (sortBy) {
            queryBuilder.orderBy(`tipo.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('tipo.idTipoCumplimiento', sortOrder);
        }

        const [data, total] = await queryBuilder.skip(skip).take(limit).getManyAndCount();

        return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
    }

    async findOne(id: number): Promise<TipoCumplimiento> {
        const tipo = await this.tipoCumplimientoRepository.findOne({ where: { idTipoCumplimiento: id } });
        if (!tipo) throw new NotFoundException(`TipoCumplimiento con ID ${id} no encontrado`);
        return tipo;
    }

    async update(id: number, updateDto: UpdateTipoCumplimientoDto): Promise<TipoCumplimiento> {
        const tipo = await this.findOne(id);
        Object.assign(tipo, updateDto);
        return this.tipoCumplimientoRepository.save(tipo);
    }

    async remove(id: number): Promise<void> {
        const tipo = await this.findOne(id);
        await this.tipoCumplimientoRepository.remove(tipo);
    }
}
