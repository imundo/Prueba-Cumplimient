import { DataSource } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { dataSourceOptions } from '../../config/typeorm.config';

async function seed() {
    const dataSource = new DataSource(dataSourceOptions);
    await dataSource.initialize();

    console.log('🌱 Starting database seeding...');

    // Create demo users
    const userRepository = dataSource.getRepository('user');

    // Check if users exist before creating
    const adminExists = await userRepository.findOneBy({ username: 'admin' });
    if (!adminExists) {
        const adminPassword = await bcrypt.hash('admin123', 10);
        await userRepository.save({
            username: 'admin',
            password: adminPassword,
            role: 'admin',
            email: 'admin@reuc.cl',
            fullName: 'Administrador del Sistema',
        });
    }

    const analistaExists = await userRepository.findOneBy({ username: 'analista' });
    if (!analistaExists) {
        const analistaPassword = await bcrypt.hash('analista123', 10);
        await userRepository.save({
            username: 'analista',
            password: analistaPassword,
            role: 'analista',
            email: 'analista@reuc.cl',
            fullName: 'Analista de Cumplimiento',
        });
    }

    console.log('✅ Users checked/created');

    // Create Departamentos
    const departamentoRepository = dataSource.getRepository('departamento');
    const deptosData = [
        { nombre: 'Departamento de Seguridad', jefatura: 'Jefatura de Seguridad', responsableNombre: 'Juan Pérez' },
        { nombre: 'Departamento de Recursos Humanos', jefatura: 'Jefatura RRHH', responsableNombre: 'María González' },
        { nombre: 'Departamento de Operaciones', jefatura: 'Gerencia de Operaciones', responsableNombre: 'Carlos Ruiz' },
        { nombre: 'Departamento de Medio Ambiente', jefatura: 'Jefatura Medio Ambiente', responsableNombre: 'Ana Silva' },
    ];

    const deptos = [];
    for (const d of deptosData) {
        let depto = await departamentoRepository.findOneBy({ nombre: d.nombre });
        if (!depto) {
            depto = await departamentoRepository.save(d);
        }
        deptos.push(depto);
    }
    console.log('✅ Departamentos created');

    // Create Normas
    const normaRepository = dataSource.getRepository('norma');
    const normasData = [
        { descripcion: 'Norma de Seguridad y Salud Ocupacional', articulo: 'Art. 184', cuerpoLegal: 'Código del Trabajo' },
        { descripcion: 'Ley de Subcontratación', articulo: 'Art. 183-A', cuerpoLegal: 'Ley 20.123' },
        { descripcion: 'Reglamento de Higiene y Seguridad', articulo: 'DS 40', cuerpoLegal: 'Ministerio de Salud' },
        { descripcion: 'Norma de Emisión de Ruidos', articulo: 'DS 38', cuerpoLegal: 'Ministerio del Medio Ambiente' },
    ];

    const normas = [];
    for (const n of normasData) {
        let norma = await normaRepository.findOneBy({ descripcion: n.descripcion });
        if (!norma) {
            norma = await normaRepository.save(n);
        }
        normas.push(norma);
    }
    console.log('✅ Normas created');

    // Create SubNormas
    const subNormaRepository = dataSource.getRepository('sub_norma');
    const subNormasData = [
        { idNorma: normas[0].idNorma, idDepartamento: deptos[0].idDepartamento, nombre: 'Capacitación en Seguridad', numeral: '1.1', periodicidad: 'Mensual', descripcion: 'Capacitación mensual en seguridad laboral' },
        { idNorma: normas[0].idNorma, idDepartamento: deptos[0].idDepartamento, nombre: 'Entrega de EPP', numeral: '1.2', periodicidad: 'Semestral', descripcion: 'Registro de entrega de equipos de protección personal' },
        { idNorma: normas[1].idNorma, idDepartamento: deptos[1].idDepartamento, nombre: 'Control de Asistencia', numeral: '2.1', periodicidad: 'Mensual', descripcion: 'Control de asistencia de trabajadores subcontratados' },
        { idNorma: normas[2].idNorma, idDepartamento: deptos[3].idDepartamento, nombre: 'Medición de Ruido', numeral: '3.1', periodicidad: 'Anual', descripcion: 'Informe técnico de medición de ruido perimetral' },
    ];

    const subNormas = [];
    for (const sn of subNormasData) {
        let subNorma = await subNormaRepository.findOneBy({ nombre: sn.nombre });
        if (!subNorma) {
            subNorma = await subNormaRepository.save(sn);
        }
        subNormas.push(subNorma);
    }
    console.log('✅ SubNormas created');

    // Create REUCs
    const reucRepository = dataSource.getRepository('reuc');
    const reucsData = [
        { nombreFantasia: 'Empresa Demo S.A.', rut: '76.123.456-7', gerenteGeneral: 'Carlos Rodríguez', correoElectronicoG: 'gerente@demo.cl', telefono: '+56911111111', direccion: 'Av. Principal 123', comuna: 'Santiago', encargadoTitular: 'Ana López', razonSocial: 'Empresa Demo S.A.', tipo: 'Grande', estado: 'activo' },
        { nombreFantasia: 'Constructora Norte Ltda.', rut: '77.222.333-4', gerenteGeneral: 'Pedro Martínez', correoElectronicoG: 'contacto@norte.cl', telefono: '+56922222222', direccion: 'Calle Norte 456', comuna: 'Antofagasta', encargadoTitular: 'Luis Soto', razonSocial: 'Constructora Norte Limitada', tipo: 'Mediana', estado: 'activo' },
        { nombreFantasia: 'Servicios Integrales SpA', rut: '78.333.444-5', gerenteGeneral: 'Laura Díaz', correoElectronicoG: 'ldiaz@servicios.cl', telefono: '+56933333333', direccion: 'Pasaje Sur 789', comuna: 'Concepción', encargadoTitular: 'Marta Gómez', razonSocial: 'Servicios Integrales SpA', tipo: 'Pequeña', estado: 'inactivo' },
        { nombreFantasia: 'Transportes Rápidos', rut: '79.444.555-6', gerenteGeneral: 'Jorge Ruiz', correoElectronicoG: 'jruiz@transporte.cl', telefono: '+56944444444', direccion: 'Ruta 5 Km 100', comuna: 'Rancagua', encargadoTitular: 'José Torres', razonSocial: 'Transportes Rápidos S.A.', tipo: 'Grande', estado: 'activo' },
    ];

    const reucs = [];
    for (const r of reucsData) {
        let reuc = await reucRepository.findOneBy({ rut: r.rut });
        if (!reuc) {
            reuc = await reucRepository.save({ ...r, fecha: new Date() });
        }
        reucs.push(reuc);
    }
    console.log('✅ REUCs created');

    // Create TiposCumplimiento
    const tipoCumplimientoRepository = dataSource.getRepository('tipo_cumplimiento');
    const tiposCumpData = ['Cumplimiento Total', 'Cumplimiento Parcial', 'No Cumple', 'No Aplica'];
    const tiposCump = [];
    for (const nombre of tiposCumpData) {
        let tc = await tipoCumplimientoRepository.findOneBy({ nombre });
        if (!tc) {
            tc = await tipoCumplimientoRepository.save({ nombre });
        }
        tiposCump.push(tc);
    }
    console.log('✅ TiposCumplimiento created');

    // Create Cumplimientos
    const cumplimientoRepository = dataSource.getRepository('cumplimiento');
    const cumplimientosData = [
        { idSubNorma: subNormas[0].idSubNorma, idTipoCumplimiento: tiposCump[0].idTipoCumplimiento, estado: 'cumple', idReuc: reucs[0].idReuc, periodoCumplimiento: 'Q1', anio: 2024, valor: '100%' },
        { idSubNorma: subNormas[1].idSubNorma, idTipoCumplimiento: tiposCump[1].idTipoCumplimiento, estado: 'pendiente', idReuc: reucs[0].idReuc, periodoCumplimiento: 'Q1', anio: 2024, valor: '50%' },
        { idSubNorma: subNormas[2].idSubNorma, idTipoCumplimiento: tiposCump[2].idTipoCumplimiento, estado: 'incumplimiento', idReuc: reucs[1].idReuc, periodoCumplimiento: 'Enero', anio: 2024, valor: '0%' },
        { idSubNorma: subNormas[0].idSubNorma, idTipoCumplimiento: tiposCump[0].idTipoCumplimiento, estado: 'cumple', idReuc: reucs[3].idReuc, periodoCumplimiento: 'Marzo', anio: 2024, valor: '100%' },
    ];

    const cumplimientos = [];
    for (const c of cumplimientosData) {
        const exists = await cumplimientoRepository.findOneBy({
            idSubNorma: c.idSubNorma,
            idReuc: c.idReuc,
            periodoCumplimiento: c.periodoCumplimiento,
            anio: c.anio
        });

        let cumpl;
        if (!exists) {
            cumpl = await cumplimientoRepository.save(c);
        } else {
            cumpl = exists;
        }
        cumplimientos.push(cumpl);
    }
    console.log('✅ Cumplimientos created');

    // Create CartasIncpmt
    const cartaRepository = dataSource.getRepository('carta_incpmt');
    if (cumplimientos[2]) { // Ensure we have an incumplimiento
        const cartaData = {
            idCumplimiento: cumplimientos[2].idCumplimiento,
            correlativoCorrespondencia: 'CARTA-2024-001',
            autoridad: 'Inspección del Trabajo',
            materiaMacro: 'Laboral',
            materiaMicro: 'Subcontratación',
            referencia: 'Fiscalización ordinaria',
            fechaCarta: new Date('2024-02-15'),
            fechaCreacion: new Date(),
        };

        const exists = await cartaRepository.findOneBy({ correlativoCorrespondencia: cartaData.correlativoCorrespondencia });
        if (!exists) {
            await cartaRepository.save(cartaData);
        }
    }
    console.log('✅ CartasIncpmt created');

    // Create Homologaciones
    const homologacionRepository = dataSource.getRepository('homologacion');
    const homologacionData = {
        idSubNorma: subNormas[0].idSubNorma,
        rutReuc: reucs[0].rut,
        valorInputNombreCoordinadoArchivoSubNorma: 'Capacitación Seg.',
        valorOutputEmpresaCc: 'CAP-SEG-001',
    };

    // Check existence logic simplified
    const homExists = await homologacionRepository.findOneBy({
        idSubNorma: homologacionData.idSubNorma,
        rutReuc: homologacionData.rutReuc
    });

    if (!homExists) {
        await homologacionRepository.save(homologacionData);
    }
    console.log('✅ Homologaciones created');

    console.log('🎉 Database seeding completed successfully!');
    console.log('\n📝 Demo credentials:');
    console.log('   Admin: username=admin, password=admin123');
    console.log('   Analista: username=analista, password=analista123');

    await dataSource.destroy();
}

seed().catch((error) => {
    console.error('❌ Error seeding database:', error);
    process.exit(1);
});
