import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, OneToMany, Index } from 'typeorm';
import { SubNorma } from '../sub-normas/sub-norma.entity';
import { TipoCumplimiento } from '../tipos-cumplimiento/tipo-cumplimiento.entity';
import { Reuc } from '../reuc/reuc.entity';
import { DetalleCumplimiento } from './detalle-cumplimiento.entity';
import { CartaIncpmt } from '../cartas-incpmt/carta-incpmt.entity';

@Entity('cumplimiento')
@Index(['idSubNorma'])
@Index(['idReuc'])
@Index(['anio'])
@Index(['periodoCumplimiento'])
@Index(['estado'])
export class Cumplimiento {
    @PrimaryGeneratedColumn({ name: 'id_cumplimiento' })
    idCumplimiento: number;

    @Column({ name: 'id_sub_norma' })
    idSubNorma: number;

    @Column({ name: 'id_tipo_cumplimiento' })
    idTipoCumplimiento: number;

    @Column({ type: 'varchar', length: 50, nullable: true })
    estado: string;

    @Column({ name: 'id_reuc', nullable: true })
    idReuc: number;

    @Column({ name: 'periodo_cumplimiento', type: 'varchar', length: 50, nullable: true })
    periodoCumplimiento: string;

    @Column({ name: 'fecha_carga', type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
    fechaCarga: Date;

    @Column({ type: 'int', nullable: true })
    anio: number;

    @Column({ type: 'varchar', length: 255, nullable: true })
    valor: string;

    @ManyToOne(() => SubNorma, (subNorma) => subNorma.cumplimientos)
    @JoinColumn({ name: 'id_sub_norma' })
    subNorma: SubNorma;

    @ManyToOne(() => TipoCumplimiento, (tipoCumplimiento) => tipoCumplimiento.cumplimientos)
    @JoinColumn({ name: 'id_tipo_cumplimiento' })
    tipoCumplimiento: TipoCumplimiento;

    @ManyToOne(() => Reuc, (reuc) => reuc.cumplimientos)
    @JoinColumn({ name: 'id_reuc' })
    reuc: Reuc;

    @OneToMany(() => DetalleCumplimiento, (detalle) => detalle.cumplimiento)
    detalles: DetalleCumplimiento[];

    @OneToMany(() => CartaIncpmt, (carta) => carta.cumplimiento)
    cartas: CartaIncpmt[];
}
