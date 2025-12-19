import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { CartaIncpmt } from './carta-incpmt.entity';
import { TipoEventoSeg } from '../tipos-evento-seg/tipo-evento-seg.entity';

@Entity('cartas_incpmt_seg')
export class CartasIncpmtSeg {
    @PrimaryGeneratedColumn({ name: 'id_cartas_incpmt_seg' })
    idCartasIncpmtSeg: number;

    @Column({ type: 'text', nullable: true })
    descripcion: string;

    @Column({ name: 'id_tipo_evento_seg' })
    idTipoEventoSeg: number;

    @Column({ name: 'fecha_evento', type: 'timestamp', nullable: true })
    fechaEvento: Date;

    @Column({ name: 'id_carta_incpmt' })
    idCartaIncpmt: number;

    @ManyToOne(() => TipoEventoSeg, (tipoEvento) => tipoEvento.seguimientos)
    @JoinColumn({ name: 'id_tipo_evento_seg' })
    tipoEvento: TipoEventoSeg;

    @ManyToOne(() => CartaIncpmt, (carta) => carta.seguimientos)
    @JoinColumn({ name: 'id_carta_incpmt' })
    carta: CartaIncpmt;
}
