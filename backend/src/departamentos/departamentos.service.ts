import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Like } from 'typeorm';
import { Departamento } from './departamento.entity';
import { CreateDepartamentoDto } from './dto/create-departamento.dto';
import { UpdateDepartamentoDto } from './dto/update-departamento.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class DepartamentosService {
    constructor(
        @InjectRepository(Departamento)
        private departamentoRepository: Repository<Departamento>,
    ) { }

    async create(createDto: CreateDepartamentoDto): Promise<Departamento> {
        const departamento = this.departamentoRepository.create(createDto);
        return this.departamentoRepository.save(departamento);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.departamentoRepository.createQueryBuilder('departamento');

        if (search) {
            queryBuilder.where(
                'departamento.nombre ILIKE :search OR departamento.jefatura ILIKE :search OR departamento.responsableNombre ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`departamento.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('departamento.idDepartamento', sortOrder);
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

    async findOne(id: number): Promise<Departamento> {
        const departamento = await this.departamentoRepository.findOne({
            where: { idDepartamento: id },
        });

        if (!departamento) {
            throw new NotFoundException(`Departamento con ID ${id} no encontrado`);
        }

        return departamento;
    }

    async update(id: number, updateDto: UpdateDepartamentoDto): Promise<Departamento> {
        const departamento = await this.findOne(id);
        Object.assign(departamento, updateDto);
        return this.departamentoRepository.save(departamento);
    }

    async remove(id: number): Promise<void> {
        const departamento = await this.findOne(id);
        await this.departamentoRepository.remove(departamento);
    }
}
