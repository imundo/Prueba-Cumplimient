import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { SubNorma } from './sub-norma.entity';
import { CreateSubNormaDto } from './dto/create-sub-norma.dto';
import { UpdateSubNormaDto } from './dto/update-sub-norma.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class SubNormasService {
    constructor(
        @InjectRepository(SubNorma)
        private subNormaRepository: Repository<SubNorma>,
    ) { }

    async create(createDto: CreateSubNormaDto): Promise<SubNorma> {
        const subNorma = this.subNormaRepository.create(createDto);
        return this.subNormaRepository.save(subNorma);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.subNormaRepository
            .createQueryBuilder('subNorma')
            .leftJoinAndSelect('subNorma.norma', 'norma')
            .leftJoinAndSelect('subNorma.departamento', 'departamento');

        if (search) {
            queryBuilder.where(
                'subNorma.nombre ILIKE :search OR subNorma.numeral ILIKE :search OR subNorma.descripcion ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`subNorma.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('subNorma.idSubNorma', sortOrder);
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

    async findOne(id: number): Promise<SubNorma> {
        const subNorma = await this.subNormaRepository.findOne({
            where: { idSubNorma: id },
            relations: ['norma', 'departamento'],
        });

        if (!subNorma) {
            throw new NotFoundException(`SubNorma con ID ${id} no encontrada`);
        }

        return subNorma;
    }

    async update(id: number, updateDto: UpdateSubNormaDto): Promise<SubNorma> {
        const subNorma = await this.findOne(id);
        Object.assign(subNorma, updateDto);
        return this.subNormaRepository.save(subNorma);
    }

    async remove(id: number): Promise<void> {
        const subNorma = await this.subNormaRepository.findOne({ where: { idSubNorma: id } });
        if (!subNorma) {
            throw new NotFoundException(`SubNorma con ID ${id} no encontrada`);
        }
        await this.subNormaRepository.remove(subNorma);
    }
}
