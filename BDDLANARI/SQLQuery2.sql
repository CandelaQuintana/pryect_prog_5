
--INSERTAR ROL
INSERT INTO ROL(Descripcion) VALUES
('ADMINISTRADOR'),
('DOCENTE'),
('ALUMNO')

GO

--INSERTAR MENU
INSERT INTO MENU(Nombre,Icono) VALUES
('Configuraciones',''),
('Usuarios',''),
('Alumnos',''),
('Docentes',''),
('Cursos',''),
('Matricula','')

GO

-- Pner aca las cosas para el submenu (*)

INSERT INTO SUBMENU(IdMenu,Nombre,NombreFormulario,Accion) VALUES
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Crear Usuario','Usuario','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Crear Rol','Rol','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Asignar rol permisos','RolPermiso','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Alumnos'),'Crear Alumnos','Alumno','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Alumnos'),'Consulta y Reporte','Alumno','Reporte'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Crear Docentes','Docente','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Agregar Curricula','Docente','Curricula'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Agregar Calificacion','Docente','Calificacion'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Cursos'),'Crear Cursos','Curso','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Matricula'),'Crear Matricula','Matricula','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Matricula'),'Consulta y Reporte','Matricula','Reporte'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Periodo','Periodo','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Nivel Academico','NivelAcademico','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Grados y Secciones','GradoSeccion','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Grados por Niveles','GradoporNivel','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Cursos por Niveles','Curso','Asignar'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Vacantes','Vacante','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Horario','Horario','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Docentes por Cursos','Docente','Asignar')

go


-- De aca para abajo las funciones
insert into USUARIO(Nombres,Apellidos,IdRol,LoginUsuario,LoginClave,DescripcionReferencia,IdReferencia)
values('Good','Code',(select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'),'GoodCode','Admin123','NINGUNA',0)

go

INSERT INTO PERMISOS(IdRol,IdSubMenu)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'), IdSubMenu FROM SUBMENU
GO
INSERT INTO PERMISOS(IdRol,IdSubMenu,Activo)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'DOCENTE'),IdSubMenu,0 FROM SUBMENU
GO
INSERT INTO PERMISOS(IdRol,IdSubMenu,Activo)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'ALUMNO'),IdSubMenu,0 FROM SUBMENU

GO

update p set p.Activo = 1 from PERMISOS p
inner join SUBMENU sm on sm.IdSubMenu = p.IdSubMenu
where sm.NombreFormulario in ('frmAgregarCurricula','frmAgregarCalificacion') and p.IdRol = (select TOP 1 IdRol from ROL where Descripcion = 'DOCENTE')

go


insert into PERIODO(Descripcion,FechaInicio,FechaFin,Activo) values
('PERIODO 2019','13/03/2020','13/12/2020',0),
('PERIODO 2020','10/03/2021','20/12/2021',0),
('PERIODO 2021','10/03/2022','17/12/2022',1)

GO

insert into NIVEL(IdPeriodo,DescripcionNivel,DescripcionTurno,HoraInicio,HoraFin,Activo) values
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO 2021'),
'PRIMARIA','MAÑANA','08:30:00.0000000','12:35:00.0000000',0
),
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO 2021'),
'SECUNDARIA','TARDE','13:00:00.0000000','18:00:00.0000000',0
),
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO 2022'),
'PRIMARIA','MAÑANA','08:30:00.0000000','12:35:00.0000000',1
),
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO 2022'),
'SECUNDARIA','TARDE','13:00:00.0000000','18:00:00.0000000',1
)


GO

INSERT INTO GRADO_SECCION(DescripcionGrado,DescripcionSeccion) VALUES
('PRIMERO','A'),
('PRIMERO','B'),
('PRIMERO','C'),
('SEGUNDO','A'),
('SEGUNDO','B'),
('SEGUNDO','C'),
('TERCERO','A'),
('TERCERO','B'),
('TERCERO','C')

GO


INSERT INTO NIVEL_DETALLE(IdNivel,IdGradoSeccion,TotalVacantes,VacantesDisponibles,VacantesOcupadas)
select 
(select top 1 IdNivel from NIVEL where IdPeriodo = 3 ),
IdGradoSeccion,30,30,0
from GRADO_SECCION where IdGradoSeccion in (1,2,3)


GO

INSERT INTO CURSO(Descripcion) VALUES
('Lengua'),
('Matematicas'),
('Ciencias Sociales'),
('Ciencias Naturales'),
('Tecnologia'),
('Educacion Fisica'),
('Plastica'),
('Tutoria')

GO


 INSERT INTO NIVEL_DETALLE_CURSO(IdNivelDetalle,IdCurso) VALUES
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),1),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),2),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),3),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),4),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),5),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),6),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),7),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),8)


GO
-- Insertar los horarios (buscar bien si se puede poner el horario)

 insert into HORARIO(IdNivelDetalleCurso,DiaSemana,HoraInicio,HoraFin) values
(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 1),
 'Lunes','08:30:00.0000000','09:30:00.0000000'),

(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 2),
 'Lunes','09:30:00.0000000','10:30:00.0000000'),

(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 3),
 'Lunes','10:30:00.0000000','11:30:00.0000000'),
 
(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 4),
 'Lunes','11:30:00.0000000','12:35:00.0000000')

 GO
 -- Registros 
  insert into DOCENTE(ValorCodigo,Codigo,DocumentoIdentidad,Nombres,Apellidos,FechaNacimiento,Sexo,GradoEstudio,Ciudad,Direccion,Email,NumeroTelefono) values
 (1,'DO000001','78945612','Diego','Quintana','1980-07-19','Masculino','BACHICHERATO','Buenos Aires','Guamnini5596','DIEGO@GMAIL.COM','936798490'),
 (2,'DO000002','78894500','Norberto','Gonzales','1970-02-06','Masculino','TITULADO','Buenos Aires','Madariaga1234','NOR@GMAIL.COM','987654321'),
 (3,'DO000003','789458923','Paola','Maio','1979-02-06','Femenino','TITULADO','Buenos Aires','Guamini5576','PAOLA@GMAIL.COM','964852100')

 GO


 INSERT INTO ALUMNO(ValorCodigo,Codigo,Nombres,Apellidos,DocumentoIdentidad,FechaNacimiento,Sexo,Ciudad,Direccion) VALUES
 (1,'AL000001','Maria','Robotnik','78974545','1999-02-16','Femenino','Buenos Aires','Lugano'),
 (2,'AL000002','Tomas','Quintana','78946548','2000-02-08','Masculino','Buenos Aires','Lugano'),
 (3,'AL000003','Helen','Madariaga','79005645','2000-12-23','Femenino','Buenos Aires','Lugano'),
 (4,'AL000004','Camila','Torres','76345623','2001-06-12','Femenino','Buenos Aires','Lugano'),
 (5,'AL000005','Juan','Perez','70795647','2001-07-10','Masculino','Buenos Aires','Lugano'),
 (6,'AL000006','Candela', 'Quntana','76453626','2000-08-17','Masculino','Buenos Aires','Lugano')

 GO


 INSERT INTO DOCENTE_NIVELDETALLE_CURSO(IdNivelDetalleCurso,IdDocente) values
(1,1),
(2,2)

GO


INSERT INTO CURRICULA(IdDocenteNivelDetalleCurso,Descripcion) VALUES
(1,'EVALUACION 001'),
(1,'EVALUACION 002'),
(1,'EVALUACION 003')

