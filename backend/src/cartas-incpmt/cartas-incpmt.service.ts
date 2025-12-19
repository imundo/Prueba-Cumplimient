import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CartaIncpmt } from './carta-incpmt.entity';
import { CreateCartaIncpmtDto, UpdateCartaIncpmtDto } from './dto/carta-incpmt.dto';
import { PaginationDto } from '../common/dto/pagination.dto';

@Injectable()
export class CartasIncpmtService {
    constructor(
        @InjectRepository(CartaIncpmt)
        private cartaRepository: Repository<CartaIncpmt>,
    ) { }

    async create(createDto: CreateCartaIncpmtDto): Promise<CartaIncpmt> {
        const carta = this.cartaRepository.create(createDto);
        return this.cartaRepository.save(carta);
    }

    async findAll(paginationDto: PaginationDto) {
        const { page, limit, search, sortBy, sortOrder } = paginationDto;
        const skip = (page - 1) * limit;

        const queryBuilder = this.cartaRepository
            .createQueryBuilder('carta')
            .leftJoinAndSelect('carta.cumplimiento', 'cumplimiento')
            .leftJoinAndSelect('cumplimiento.reuc', 'reuc');

        if (search) {
            queryBuilder.where(
                'carta.correlativoCorrespondencia ILIKE :search OR carta.autoridad ILIKE :search',
                { search: `%${search}%` },
            );
        }

        if (sortBy) {
            queryBuilder.orderBy(`carta.${sortBy}`, sortOrder);
        } else {
            queryBuilder.orderBy('carta.idCartaIncpmt', sortOrder);
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

    async findOne(id: number): Promise<CartaIncpmt> {
        const carta = await this.cartaRepository.findOne({
            where: { idCartaIncpmt: id },
            relations: ['cumplimiento', 'cumplimiento.reuc', 'seguimientos', 'seguimientos.tipoEvento'],
        });

        if (!carta) {
            throw new NotFoundException(`Carta con ID ${id} no encontrada`);
        }

        return carta;
    }

    async findSeguimiento(idCarta: number) {
        const carta = await this.findOne(idCarta);
        return carta.seguimientos;
    }

    async update(id: number, updateDto: UpdateCartaIncpmtDto): Promise<CartaIncpmt> {
        const carta = await this.findOne(id);
        Object.assign(carta, updateDto);
        return this.cartaRepository.save(carta);
    }

    async remove(id: number): Promise<void> {
        const carta = await this.cartaRepository.findOne({ where: { idCartaIncpmt: id } });
        if (!carta) {
            throw new NotFoundException(`Carta con ID ${id} no encontrada`);
        }
        await this.cartaRepository.remove(carta);
    }
}
