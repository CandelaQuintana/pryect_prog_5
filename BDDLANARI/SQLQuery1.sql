
CREATE DATABASE BDLANARI

GO

USE BDLANARI

GO

create table MENU(
IdMenu int primary key identity(1,1),
Nombre varchar(60),
Icono varchar(60),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

GO

create table SUBMENU(
IdSubMenu int primary key identity(1,1),
IdMenu int references MENU(IdMenu),
Nombre varchar(60),
NombreFormulario varchar(60),
Accion varchar(50),
Activo bit default 1,
FechaRegistro datetime default getdate()
)


GO

create table ROL(
IdRol int primary key identity(1,1),
Descripcion varchar(60),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

GO

create table PERMISOS(
IdPermisos int primary key identity(1,1),
IdRol int references ROL(IdRol),
IdSubMenu int references SUBMENU(IdSubMenu),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table USUARIO(
IdUsuario int primary key identity(1,1),
Nombres varchar(100),
Apellidos varchar(100),
IdRol int references ROL(IdRol),
LoginUsuario varchar(50),
LoginClave varchar(50),
DescripcionReferencia varchar(50),
IdReferencia int,
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table ALUMNO(
IdAlumno int primary key identity(1,1),
ValorCodigo int,
Codigo varchar(50),
Nombres varchar(100),
Apellidos varchar(100),
DocumentoIdentidad varchar(100),
FechaNacimiento date,
Sexo varchar(50),
Ciudad varchar(100),
Direccion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table DOCENTE(
IdDocente int primary key identity(1,1),
ValorCodigo int,
Codigo varchar(50),
DocumentoIdentidad varchar(100),
Nombres varchar(100),
Apellidos varchar(100),
FechaNacimiento date,
Sexo varchar(50),
GradoEstudio varchar(100),
Ciudad varchar(100),
Direccion varchar(100),
Email varchar(50),
NumeroTelefono varchar(50),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table APODERADO(
IdApoderado int primary key identity(1,1),
TipoRelacion varchar(50),
Nombres varchar(100),
Apellidos varchar(100),
DocumentoIdentidad varchar(100),
FechaNacimiento date,
Sexo varchar(50),
EstadoCivil varchar(50),
Ciudad varchar(100),
Direccion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table PERIODO(
IdPeriodo int primary key identity(1,1),
Descripcion varchar(50),
FechaInicio date,
FechaFin Date,
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table GRADO_SECCION(
IdGradoSeccion int primary key identity(1,1),
DescripcionGrado varchar(100),
DescripcionSeccion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go

create table CURSO(
IdCurso int primary key identity(1,1),
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go

create table NIVEL(
IdNivel int primary key identity(1,1),
IdPeriodo int references PERIODO(IdPeriodo),
DescripcionNivel varchar(100),
DescripcionTurno varchar(100),
HoraInicio time,
HoraFin time,
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


create table NIVEL_DETALLE(
IdNivelDetalle int primary key identity(1,1),
IdNivel int references NIVEL(IdNivel),
IdGradoSeccion int references GRADO_SECCION(IdGradoSeccion),
TotalVacantes int,
VacantesDisponibles int,
VacantesOcupadas int,
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


create table NIVEL_DETALLE_CURSO(
IdNivelDetalleCurso int primary key identity(1,1),
IdNivelDetalle int references NIVEL_DETALLE(IdNivelDetalle),
IdCurso int references CURSO(IdCurso),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go


create table HORARIO(
IdHorario int primary key identity(1,1),
IdNivelDetalleCurso int references NIVEL_DETALLE_CURSO(IdNivelDetalleCurso),
DiaSemana varchar(50),
HoraInicio time,
HoraFin time,
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


create table DOCENTE_NIVELDETALLE_CURSO(
IdDocenteNivelDetalleCurso int primary key identity(1,1),
IdNivelDetalleCurso int references NIVEL_DETALLE_CURSO(IdNivelDetalleCurso),
IdDocente int references DOCENTE(IdDocente),
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


create table CURRICULA(
IdCurricula int primary key identity(1,1),
IdDocenteNivelDetalleCurso int references DOCENTE_NIVELDETALLE_CURSO(IdDocenteNivelDetalleCurso),
Descripcion varchar(100),
Activo bit default 1,
FechaRegistro datetime default getdate()
)
go

create table CALIFICACION(
IdCalificacion int primary key identity(1,1),
IdCurricula int references CURRICULA(IdCurricula),
IdAlumno int references ALUMNO(IdAlumno),
Nota float,
Activo bit default 1,
FechaRegistro datetime default getdate()
)

go


create table MATRICULA(
IdMatricula int primary key identity(1,1),
ValorCodigo int,
Codigo varchar(50),
Situacion varchar(50),
IdAlumno int references ALUMNO(IdAlumno),
IdNivelDetalle int references NIVEL_DETALLE(IdNivelDetalle),
IdApoderado int references APODERADO(IdApoderado),
InstitucionProcedencia varchar(50),
EsRepitente bit,
Activo bit default 1,
FechaRegistro datetime default getdate()
)