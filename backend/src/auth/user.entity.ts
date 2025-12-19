import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('user')
export class User {
    @PrimaryGeneratedColumn({ name: 'id_user' })
    idUser: number;

    @Column({ type: 'varchar', length: 100, unique: true })
    username: string;

    @Column({ type: 'varchar', length: 255 })
    password: string;

    @Column({ type: 'varchar', length: 50 })
    role: string; // 'admin' or 'analista'

    @Column({ type: 'varchar', length: 255, nullable: true })
    email: string;

    @Column({ name: 'full_name', type: 'varchar', length: 255, nullable: true })
    fullName: string;
}
