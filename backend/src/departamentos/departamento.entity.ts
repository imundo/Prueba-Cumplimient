import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { SubNorma } from '../sub-normas/sub-norma.entity';

@Entity('departamento')
export class Departamento {
    @PrimaryGeneratedColumn({ name: 'id_departamento' })
    idDepartamento: number;

    @Column({ type: 'varchar', length: 255, nullable: true })
    nombre: string;

    @OneToMany(() => SubNorma, (subNorma) => subNorma.departamento)
    subNormas: SubNorma[];
}
