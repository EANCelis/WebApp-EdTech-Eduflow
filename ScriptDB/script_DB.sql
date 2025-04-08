Create DataBase NCG57
Go 
Use NCG57
Go 

Create Table Roles(
    Id_Rol int Primary Key Identity(1,1),
    Descripcion VarChar(80) Not Null Unique 
)

Create Table Materias(
    Id_Materia Int Not Null Primary Key Identity(1,1),
    Nombre VarChar(200) Not Null Unique,
    Activo Bit
)

Create Table Parentescos(
    Id_parentesco Int Not Null Primary Key Identity(1,1),
    Descripcion VarChar(100) Not Null Unique
)

Create Table Tipos_Nota(
    Id_Tipo_Nota Int Not Null Primary Key Identity(1,1),
    Descripcion VarChar(100) Not Null Unique,
    Activo Bit
)

Create Table Usuarios(
    Id_Usuario BigInt Not Null Primary Key Identity(1,1),
    Id_Rol Int Not Null,
    Nombre VarChar(100) Not Null,
    Apellido VarChar(100) Not Null,
    DNI VarChar(8) Unique Not Null,
    Telefono VarChar(16) Not Null,
    Email VarChar(100) Unique Not Null,
    Fecha_Nacimiento Date Not Null,
    Fecha_Alta Date Not Null,
    Contrasenia VarChar(255) Not Null,
    Activo Bit Not Null,
    Foreign Key (Id_Rol) REFERENCES Roles(Id_Rol)
)


Create Table Mensajes(
    Id_Mensaje BigInt Not Null Primary Key Identity(1,1),
    Id_Usuario_Remitente BigInt Not Null,
    Id_Usuario_Destinatario BigInt Not Null,
    Detalle VarChar(500) Not Null,
    Fecha_Hora DateTime Not Null Default GetDate(),
    Leido Bit Not Null,
    Activo Bit Not Null
)

Create Table Materias_x_Profesor(
    Id_Usuario_Profesor BigInt Not Null,
    Id_Materia Int Not Null,
    Codigo_Comision BigInt Not Null Unique Identity(100,1),
    Activo Bit,
    Primary Key (Id_Usuario_Profesor, Id_Materia),
    Foreign Key (Id_Usuario_Profesor) REFERENCES Usuarios(Id_Usuario),
    Foreign Key (Id_Materia) REFERENCES Materias(Id_Materia)
)

Create Table Materias_x_Alumno(
    Id_Usuario_Alumno BigInt Not Null,
    Codigo_Comision BigInt Not Null,
    Activo Bit,
    Primary Key (Id_Usuario_Alumno, Codigo_Comision),
    Foreign Key (Id_Usuario_Alumno) REFERENCES Usuarios(Id_Usuario),
    Foreign Key (Codigo_Comision) REFERENCES Materias_x_Profesor(Codigo_Comision)
)

Create Table Tutor_x_Alumno(
    Id_Usuario_Alumno BigInt Not Null,
    Id_Usuario_Tutor BigInt Not Null,
    Id_Parentesco Int Not Null,
    Activo Bit,
    Primary Key (Id_Usuario_Alumno, Id_Usuario_Tutor),
    Foreign Key (Id_Usuario_Alumno) REFERENCES Usuarios(Id_Usuario),
    Foreign Key (Id_Usuario_Tutor) REFERENCES Usuarios(Id_Usuario),
    Check (Id_Usuario_Alumno <> Id_Usuario_Tutor)
)

Create Table Notas(
    Id_Usuario_Alumno BigInt Not Null,
    Codigo_Comision BigInt Not Null,
    Id_Tipo_Nota int Not Null,
    Calificacion Decimal(5,2) Not Null,
    Observaciones VarChar(250) Null,
    Primary Key (Id_Usuario_Alumno, Codigo_Comision, Id_Tipo_Nota),
    Foreign Key (Id_Usuario_Alumno) REFERENCES Usuarios(Id_Usuario),
    Foreign Key (Codigo_Comision) REFERENCES Materias_x_Profesor(Codigo_Comision),
    Foreign Key (Id_Tipo_Nota) REFERENCES Tipos_Nota(Id_Tipo_Nota)
)