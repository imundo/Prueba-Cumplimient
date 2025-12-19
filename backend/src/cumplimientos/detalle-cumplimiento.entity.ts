import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Cumplimiento } from './cumplimiento.entity';

@Entity('detalle_cumplimiento')
export class DetalleCumplimiento {
    @PrimaryGeneratedColumn({ name: 'id_detalle_cumplimiento' })
    idDetalleCumplimiento: number;

    @Column({ name: 'valor_cumplimiento', type: 'varchar', length: 255, nullable: true })
    valorCumplimiento: string;

    @Column({ type: 'varchar', length: 50, nullable: true })
    estado: string;

    @Column({ name: 'id_cumplimiento' })
    idCumplimiento: number;

    @Column({ name: 'nombre_empresa_cc', type: 'varchar', length: 255, nullable: true })
    nombreEmpresaCc: string;

    @ManyToOne(() => Cumplimiento, (cumplimiento) => cumplimiento.detalles)
    @JoinColumn({ name: 'id_cumplimiento' })
    cumplimiento: Cumplimiento;
}
