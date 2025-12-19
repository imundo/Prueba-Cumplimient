import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Homologacion } from './homologacion.entity';
import { CreateHomologacionDto, UpdateHomologacionDto } from './dto/homologacion.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class HomologacionesService {
    constructor(
        @InjectRepository(Homologacion)
        private homologacionRepository: Repository<Homologacion>,
    ) { }

    async create(createDto: CreateHomologacionDto): Promise<Homologacion> {
        const homologacion = this.homologacionRepository.create(createDto);
        return this.homologacionRepository.save(homologacion);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.homologacionRepository
            .createQueryBuilder('homologacion')
            .leftJoinAndSelect('homologacion.subNorma', 'subNorma');

        if (search) {
            queryBuilder.where(
                'homologacion.rutReuc ILIKE :search OR homologacion.valorOutputEmpresaCc ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`homologacion.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('homologacion.idHomologacion', sortOrder);
        }

        const [data, total] = await queryBuilder.skip(skip).take(limit).getManyAndCount();

        return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
    }

    async findByRut(rut: string, paginationDto: PaginationDto) {
        const { page, limit } = paginationDto;
        const skip = (page - 1) * limit;

        const [data, total] = await this.homologacionRepository.findAndCount({
            where: { rutReuc: rut },
            relations: ['subNorma'],
            skip,
            take: limit,
        });

        return { data, total, page, limit, totalPages: Math.ceil(total / limit) };
    }

    async findOne(id: number): Promise<Homologacion> {
        const homologacion = await this.homologacionRepository.findOne({
            where: { idHomologacion: id },
            relations: ['subNorma'],
        });

        if (!homologacion) {
            throw new NotFoundException(`Homologación con ID ${id} no encontrada`);
        }

        return homologacion;
    }

    async update(id: number, updateDto: UpdateHomologacionDto): Promise<Homologacion> {
        const homologacion = await this.findOne(id);
        Object.assign(homologacion, updateDto);
        return this.homologacionRepository.save(homologacion);
    }

    async remove(id: number): Promise<void> {
        const homologacion = await this.findOne(id);
        await this.homologacionRepository.remove(homologacion);
    }
}
