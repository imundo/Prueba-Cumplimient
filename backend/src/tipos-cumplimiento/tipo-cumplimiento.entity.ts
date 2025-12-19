import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';

@Entity('tipo_cumplimiento')
export class TipoCumplimiento {
    @PrimaryGeneratedColumn({ name: 'id_tipo_cumplimiento' })
    idTipoCumplimiento: number;

    @Column({ type: 'varchar', length: 255, nullable: true })
    nombre: string;

    @Column({ type: 'text', nullable: true })
    descripcion: string;

    @OneToMany(() => Cumplimiento, (cumplimiento) => cumplimiento.tipoCumplimiento)
    cumplimientos: Cumplimiento[];
}
