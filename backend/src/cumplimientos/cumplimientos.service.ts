import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cumplimiento } from './cumplimiento.entity';
import { CreateCumplimientoDto } from './dto/create-cumplimiento.dto';
import { UpdateCumplimientoDto } from './dto/update-cumplimiento.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class CumplimientosService {
    constructor(
        @InjectRepository(Cumplimiento)
        private cumplimientoRepository: Repository<Cumplimiento>,
    ) { }

    async create(createDto: CreateCumplimientoDto): Promise<Cumplimiento> {
        const cumplimiento = this.cumplimientoRepository.create(createDto);
        return this.cumplimientoRepository.save(cumplimiento);
    }

    async findAll(paginationDto: PaginationDto & { anio?: number; estado?: string; idReuc?: number }) {
        const { page, limit, search, sortBy, sortOrder, anio, estado, idReuc } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.cumplimientoRepository
            .createQueryBuilder('cumplimiento')
            .leftJoinAndSelect('cumplimiento.subNorma', 'subNorma')
            .leftJoinAndSelect('cumplimiento.tipoCumplimiento', 'tipoCumplimiento')
            .leftJoinAndSelect('cumplimiento.reuc', 'reuc');

        if (search) {
            queryBuilder.where(
                'cumplimiento.estado ILIKE :search OR cumplimiento.periodoCumplimiento ILIKE :search OR cumplimiento.valor ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (anio) {
            queryBuilder.andWhere('cumplimiento.anio = :anio', { anio });
        }

        if (estado) {
            queryBuilder.andWhere('cumplimiento.estado = :estado', { estado });
        }

        if (idReuc) {
            queryBuilder.andWhere('cumplimiento.idReuc = :idReuc', { idReuc });
        }

        if (sortBy) {
            queryBuilder.orderBy(`cumplimiento.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('cumplimiento.idCumplimiento', sortOrder);
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

    async findAllWithDetails(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.cumplimientoRepository
            .createQueryBuilder('cumplimiento')
            .leftJoinAndSelect('cumplimiento.subNorma', 'subNorma')
            .leftJoinAndSelect('subNorma.norma', 'norma')
            .leftJoinAndSelect('cumplimiento.tipoCumplimiento', 'tipoCumplimiento')
            .leftJoinAndSelect('cumplimiento.reuc', 'reuc')
            .leftJoinAndSelect('cumplimiento.detalles', 'detalles');

        if (search) {
            queryBuilder.where(
                'cumplimiento.estado ILIKE :search OR reuc.nombreFantasia ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`cumplimiento.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('cumplimiento.idCumplimiento', sortOrder);
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

    async findByReuc(idReuc: number, paginationDto: PaginationDto) {
        const { page, limit } = paginationDto;
        const skip = (page - 1) * limit;

        const [data, total] = await this.cumplimientoRepository.findAndCount({
            where: { idReuc },
            relations: ['subNorma', 'tipoCumplimiento', 'reuc'],
            skip,
            take: limit,
            order: { idCumplimiento: 'DESC' },
        });

        return {
            data,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        };
    }

    async findBySubNorma(idSubNorma: number, paginationDto: PaginationDto) {
        const { page, limit } = paginationDto;
        const skip = (page - 1) * limit;

        const [data, total] = await this.cumplimientoRepository.findAndCount({
            where: { idSubNorma },
            relations: ['subNorma', 'tipoCumplimiento', 'reuc'],
            skip,
            take: limit,
            order: { idCumplimiento: 'DESC' },
        });

        return {
            data,
            total,
            page,
            limit,
            totalPages: Math.ceil(total / limit),
        };
    }

    async findOne(id: number): Promise<Cumplimiento> {
        const cumplimiento = await this.cumplimientoRepository.findOne({
            where: { idCumplimiento: id },
            relations: ['subNorma', 'subNorma.norma', 'tipoCumplimiento', 'reuc', 'detalles'],
        });

        if (!cumplimiento) {
            throw new NotFoundException(`Cumplimiento con ID ${id} no encontrado`);
        }

        return cumplimiento;
    }

    async update(id: number, updateDto: UpdateCumplimientoDto): Promise<Cumplimiento> {
        const cumplimiento = await this.findOne(id);
        Object.assign(cumplimiento, updateDto);
        return this.cumplimientoRepository.save(cumplimiento);
    }

    async remove(id: number): Promise<void> {
        const cumplimiento = await this.cumplimientoRepository.findOne({ where: { idCumplimiento: id } });
        if (!cumplimiento) {
            throw new NotFoundException(`Cumplimiento con ID ${id} no encontrado`);
        }
        await this.cumplimientoRepository.remove(cumplimiento);
    }
}
