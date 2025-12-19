import { Entity, PrimaryGeneratedColumn, Column, OneToMany, Index } from 'typeorm';
import { Cumplimiento } from '../cumplimientos/cumplimiento.entity';
import { ReucTipoSegmento } from '../tipos-segmento/reuc-tipo-segmento.entity';

@Entity('reuc')
@Index(['rut'], { unique: true })
export class Reuc {
    @PrimaryGeneratedColumn({ name: 'id_reuc' })
    idReuc: number;

    @Column({ name: 'nombre_fantasia', type: 'varchar', length: 255, nullable: true })
    nombreFantasia: string;

    @Column({ type: 'varchar', length: 20, unique: true, nullable: true })
    rut: string;

    @Column({ name: 'gerente_general', type: 'varchar', length: 255, nullable: true })
    gerenteGeneral: string;

    @Column({ name: 'correo_electronico_g', type: 'varchar', length: 255, nullable: true })
    correoElectronicoG: string;

    @Column({ type: 'varchar', length: 50, nullable: true })
    telefono: string;

    @Column({ type: 'varchar', length: 255, nullable: true })
    direccion: string;

    @Column({ type: 'varchar', length: 100, nullable: true })
    comuna: string;

    @Column({ name: 'encargado_titular', type: 'varchar', length: 255, nullable: true })
    encargadoTitular: string;

    @Column({ name: 'razon_social', type: 'varchar', length: 255, nullable: true })
    razonSocial: string;

    // Column might not exist in production - making it optional with select: false
    @Column({ type: 'varchar', length: 100, nullable: true, select: false })
    tipo: string;

    @Column({ name: 'correo_electronico_et', type: 'varchar', length: 255, nullable: true })
    correoElectronicoEt: string;

    @Column({ name: 'encargado_suplente', type: 'varchar', length: 255, nullable: true })
    encargadoSuplente: string;

    @Column({ name: 'correo_electronico_es', type: 'varchar', length: 255, nullable: true })
    correoElectronicoEs: string;

    @Column({ name: 'encargado_facturacion', type: 'varchar', length: 255, nullable: true })
    encargadoFacturacion: string;

    @Column({ name: 'correo_electronico_fac', type: 'varchar', length: 255, nullable: true })
    correoElectronicoFac: string;

    @Column({ type: 'varchar', length: 50, nullable: true, select: false })
    estado: string;

    @Column({ type: 'date', nullable: true, select: false })
    fecha: Date;

    @OneToMany(() => Cumplimiento, (cumplimiento) => cumplimiento.reuc)
    cumplimientos: Cumplimiento[];

    @OneToMany(() => ReucTipoSegmento, (reucTipoSegmento) => reucTipoSegmento.reuc)
    segmentos: ReucTipoSegmento[];
}

