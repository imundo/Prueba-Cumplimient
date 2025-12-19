import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { CartasIncpmtSeg } from '../cartas-incpmt/cartas-incpmt-seg.entity';

@Entity('tipo_evento_seg')
export class TipoEventoSeg {
    @PrimaryGeneratedColumn({ name: 'id_tipo_evento_seg' })
    idTipoEventoSeg: number;

    @Column({ type: 'varchar', length: 50, nullable: true })
    estado: string;

    @Column({ type: 'text', nullable: true })
    descripcion: string;

    @OneToMany(() => CartasIncpmtSeg, (seguimiento) => seguimiento.tipoEvento)
    seguimientos: CartasIncpmtSeg[];
}
