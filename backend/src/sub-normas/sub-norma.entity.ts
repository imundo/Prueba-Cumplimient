import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, OneToMany, Index } from 'typeorm';
import { Norma } from '../normas/norma.entity';
import { Departamento } from '../departamentos/departamento.entity';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';
import { Homologacion } from '../homologaciones/homologacion.entity';

@Entity('sub_norma')
@Index(['idNorma'])
@Index(['idDepartamento'])
export class SubNorma {
    @PrimaryGeneratedColumn({ name: 'id_sub_norma' })
    idSubNorma: number;

    @Column({ name: 'id_norma' })
    idNorma: number;

    @Column({ name: 'id_departamento', nullable: true })
    idDepartamento: number;

    @Column({ type: 'varchar', length: 255, nullable: true })
    nombre: string;

    @Column({ type: 'varchar', length: 100, nullable: true })
    numeral: string;

    @Column({ type: 'varchar', length: 100, nullable: true })
    periodicidad: string;

    @Column({ type: 'text', nullable: true })
    descripcion: string;

    @ManyToOne(() => Norma, (norma) => norma.subNormas)
    @JoinColumn({ name: 'id_norma' })
    norma: Norma;

    @ManyToOne(() => Departamento, (departamento) => departamento.subNormas)
    @JoinColumn({ name: 'id_departamento' })
    departamento: Departamento;

    @OneToMany(() => Cumplimiento, (cumplimiento) => cumplimiento.subNorma)
    cumplimientos: Cumplimiento[];

    @OneToMany(() => Homologacion, (homologacion) => homologacion.subNorma)
    homologaciones: Homologacion[];
}
