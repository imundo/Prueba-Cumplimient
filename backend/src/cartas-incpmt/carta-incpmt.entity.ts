import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, OneToMany } from 'typeorm';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';
import { CartasIncpmtSeg } from './cartas-incpmt-seg.entity';

@Entity('carta_incpmt')
export class CartaIncpmt {
    @PrimaryGeneratedColumn({ name: 'id_carta_incpmt' })
    idCartaIncpmt: number;

    @Column({ name: 'fecha_creacion', type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    fechaCreacion: Date;

    @Column({ name: 'correlativo_correspondencia', type: 'varchar', length: 100, nullable: true })
    correlativoCorrespondencia: string;

    @Column({ name: 'id_cumplimiento', nullable: true })
    idCumplimiento: number;

    @Column({ type: 'text', nullable: true })
    hipervinculo: string;

    @Column({ type: 'varchar', length: 255, nullable: true })
    autoridad: string;

    @Column({ name: 'materia_macro', type: 'varchar', length: 255, nullable: true })
    materiaMacro: string;

    @Column({ name: 'materia_micro', type: 'varchar', length: 255, nullable: true })
    materiaMicro: string;

    @Column({ type: 'text', nullable: true })
    referencia: string;

    @Column({ name: 'fecha_carta', type: 'date', nullable: true })
    fechaCarta: Date;

    @ManyToOne(() => Cumplimiento, (cumplimiento) => cumplimiento.cartas, { nullable: true })
    @JoinColumn({ name: 'id_cumplimiento' })
    cumplimiento: Cumplimiento;

    @OneToMany(() => CartasIncpmtSeg, (seguimiento) => seguimiento.carta)
    seguimientos: CartasIncpmtSeg[];
}
