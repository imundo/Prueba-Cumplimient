import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { TipoSegmento } from './tipo-segmento.entity';
import { Reuc } from '../reuc/reuc.entity';

@Entity('reuc_tipo_segmento')
export class ReucTipoSegmento {
    @PrimaryGeneratedColumn({ name: 'id_reuc_tipo_segmento' })
    idReucTipoSegmento: number;

    @Column({ name: 'rut_reuc', type: 'varchar', length: 20, nullable: true })
    rutReuc: string;

    @Column({ name: 'id_tipo_segmento' })
    idTipoSegmento: number;

    @ManyToOne(() => TipoSegmento, (tipoSegmento) => tipoSegmento.reucSegmentos)
    @JoinColumn({ name: 'id_tipo_segmento' })
    tipoSegmento: TipoSegmento;

    @ManyToOne(() => Reuc, (reuc) => reuc.segmentos)
    @JoinColumn({ name: 'rut_reuc', referencedColumnName: 'rut' })
    reuc: Reuc;
}
