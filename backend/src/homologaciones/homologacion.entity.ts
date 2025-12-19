import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { SubNorma } from '../sub-normas/sub-norma.entity';

@Entity('homologacion')
export class Homologacion {
    @PrimaryGeneratedColumn({ name: 'id_homologacion' })
    idHomologacion: number;

    @Column({ name: 'id_sub_norma' })
    idSubNorma: number;

    @Column({ name: 'valor_input_nombre_coordinado_archivo_sub_norma', type: 'varchar', length: 255, nullable: true })
    valorInputNombreCoordinadoArchivoSubNorma: string;

    @Column({ name: 'valor_output_empresa_cc', type: 'varchar', length: 255, nullable: true })
    valorOutputEmpresaCc: string;

    @Column({ name: 'rut_reuc', type: 'varchar', length: 20, nullable: true })
    rutReuc: string;

    @ManyToOne(() => SubNorma, (subNorma) => subNorma.homologaciones)
    @JoinColumn({ name: 'id_sub_norma' })
    subNorma: SubNorma;
}
