import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm';
import { SubNorma } from '../sub-normas/sub-norma.entity';

@Entity('norma')
export class Norma {
    @PrimaryGeneratedColumn({ name: 'id_norma' })
    idNorma: number;

    @Column({ type: 'text', nullable: true })
    descripcion: string;

    @OneToMany(() => SubNorma, (subNorma) => subNorma.norma)
    subNormas: SubNorma[];
}
