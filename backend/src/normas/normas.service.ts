import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Norma } from './norma.entity';
import { CreateNormaDto } from './dto/create-norma.dto';
import { UpdateNormaDto } from './dto/update-norma.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class NormasService {
    constructor(
        @InjectRepository(Norma)
        private normaRepository: Repository<Norma>,
    ) { }

    async create(createDto: CreateNormaDto): Promise<Norma> {
        const norma = this.normaRepository.create(createDto);
        return this.normaRepository.save(norma);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.normaRepository.createQueryBuilder('norma');

        if (search) {
            queryBuilder.where(
                'norma.descripcion ILIKE :search OR norma.articulo ILIKE :search OR norma.cuerpoLegal ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`norma.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('norma.idNorma', sortOrder);
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

    async findOne(id: number): Promise<Norma> {
        const norma = await this.normaRepository.findOne({
            where: { idNorma: id },
            relations: ['subNormas'],
        });

        if (!norma) {
            throw new NotFoundException(`Norma con ID ${id} no encontrada`);
        }

        return norma;
    }

    async update(id: number, updateDto: UpdateNormaDto): Promise<Norma> {
        const norma = await this.findOne(id);
        Object.assign(norma, updateDto);
        return this.normaRepository.save(norma);
    }

    async remove(id: number): Promise<void> {
        const norma = await this.normaRepository.findOne({ where: { idNorma: id } });
        if (!norma) {
            throw new NotFoundException(`Norma con ID ${id} no encontrada`);
        }
        await this.normaRepository.remove(norma);
    }
}
