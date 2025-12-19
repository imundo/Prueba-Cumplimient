import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { ReucTipoSegmento } from './reuc-tipo-segmento.entity';

@Entity('tipo_segmento')
export class TipoSegmento {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'varchar', length: 255, nullable: true })
    name: string;

    @Column({ type: 'text', nullable: true })
    description: string;

    @Column({ type: 'boolean', default: true })
    visible: boolean;

    @OneToMany(() => ReucTipoSegmento, (reucTipoSegmento) => reucTipoSegmento.tipoSegmento)
    reucSegmentos: ReucTipoSegmento[];
}

