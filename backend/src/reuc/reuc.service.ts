import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Reuc } from './reuc.entity';
import { CreateReucDto } from './dto/create-reuc.dto';
import { UpdateReucDto } from './dto/update-reuc.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class ReucService {
    constructor(
        @InjectRepository(Reuc)
        private reucRepository: Repository<Reuc>,
    ) { }

    async create(createDto: CreateReucDto): Promise<Reuc> {
        const reuc = this.reucRepository.create(createDto);
        return this.reucRepository.save(reuc);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.reucRepository.createQueryBuilder('reuc');

        if (search) {
            queryBuilder.where(
                'reuc.nombreFantasia ILIKE :search OR reuc.rut ILIKE :search OR reuc.razonSocial ILIKE :search OR reuc.comuna ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`reuc.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('reuc.idReuc', sortOrder);
        }

        const [data, total] = await queryBuilder
            .skip(skip)
            .take(limit)
            .getManyAndCount();

        return {
            data,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        };
    }

    async findOne(id: number): Promise<Reuc> {
        const reuc = await this.reucRepository.findOne({
            where: { idReuc: id },
            relations: ['segmentos', 'segmentos.tipoSegmento'],
        });

        if (!reuc) {
            throw new NotFoundException(`REUC con ID ${id} no encontrada`);
        }

        return reuc;
    }

    async findByRut(rut: string): Promise<Reuc> {
        const reuc = await this.reucRepository.findOne({
            where: { rut },
            relations: ['segmentos', 'segmentos.tipoSegmento'],
        });

        if (!reuc) {
            throw new NotFoundException(`REUC con RUT ${rut} no encontrada`);
        }

        return reuc;
    }

    async update(id: number, updateDto: UpdateReucDto): Promise<Reuc> {
        const reuc = await this.findOne(id);
        Object.assign(reuc, updateDto);
        return this.reucRepository.save(reuc);
    }

    async remove(id: number): Promise<void> {
        const reuc = await this.reucRepository.findOne({ where: { idReuc: id } });
        if (!reuc) {
            throw new NotFoundException(`REUC con ID ${id} no encontrada`);
        }
        await this.reucRepository.remove(reuc);
    }
}
