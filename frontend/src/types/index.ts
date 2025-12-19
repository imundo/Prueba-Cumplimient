export interface User {
    id: number;
    username: string;
    role: 'admin' | 'analista';
    email?: string;
    fullName?: string;
}

export interface Departamento {
    idDepartamento: number;
    nombre: string;
    jefatura?: string;
    responsableNombre?: string;
}

export interface Norma {
    idNorma: number;
    descripcion: string;
    articulo?: string;
    cuerpoLegal?: string;
}

export interface SubNorma {
    idSubNorma: number;
    idNorma: number;
    idDepartamento: number;
    nombre: string;
    numeral?: string;
    periodicidad?: string;
    descripcion?: string;
    norma?: Norma;
    departamento?: Departamento;
}

export interface Reuc {
    idReuc: number;
    nombreFantasia: string;
    rut: string;
    gerenteGeneral?: string;
    correoElectronicoG?: string;
    telefono?: string;
    direccion?: string;
    comuna?: string;
    encargadoTitular?: string;
    razonSocial?: string;
    tipo?: string;
    correoElectronicoEt?: string;
    encargadoSuplente?: string;
    correoElectronicoEs?: string;
    encargadoFacturacion?: string;
    correoElectronicoFac?: string;
    estado: string;
    fecha?: Date;
}

export interface TipoCumplimiento {
    idTipoCumplimiento: number;
    nombre: string;
}

export interface Cumplimiento {
    idCumplimiento: number;
    idSubNorma: number;
    idTipoCumplimiento: number;
    estado: string;
    idReuc: number;
    periodoCumplimiento?: string;
    fechaCarga: Date;
    anio?: number;
    valor?: string;
    subNorma?: SubNorma;
    tipoCumplimiento?: TipoCumplimiento;
    reuc?: Reuc;
}

export interface CartaIncpmt {
    idCartaIncpmt: number;
    fechaCreacion: Date;
    correlativoCorrespondencia?: string;
    idCumplimiento: number;
    hipervinculo?: string;
    autoridad?: string;
    materiaMacro?: string;
    materiaMicro?: string;
    referencia?: string;
    fechaCarta?: Date;
    cumplimiento?: Cumplimiento;
}

export interface TipoSegmento {
    idTipoSegmento: number;
    name: string;
    description?: string;
    visible: boolean;
}

export interface TipoEventoSeg {
    idTipoEventoSeg: number;
    estado?: string;
    descripcion?: string;
}

export interface Homologacion {
    idHomologacion: number;
    idSubNorma: number;
    valorInputNombreCoordinadoArchivoSubNorma?: string;
    valorOutputEmpresaCc?: string;
    rutReuc?: string;
    subNorma?: SubNorma;
}

export interface PaginatedResponse<T> {
    data: T[];
    total: number;
    page: number;
    limit: number;
    totalPages: number;
}
