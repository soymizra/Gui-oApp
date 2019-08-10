
CREATE DATABASE IF NOT EXISTS winkdb;
use winkdb;

CREATE TABLE IF NOT EXISTS VIDEOS(
	id INT AUTO_INCREMENT NOT NULL,
    nombreVideo VARCHAR(50) NOT NULL,
    urlVideo VARCHAR(150) NOT NULL,
    semana INT NOT NULL,
    idClase INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS CARRERAS(
	id INT NOT NULL AUTO_INCREMENT,
    nombreCarrera VARCHAR(50) NOT NULL,
    idGrado INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS GRADOS(
	id INT AUTO_INCREMENT NOT NULL,
    grado VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS CLASES(
	id INT NOT NULL AUTO_INCREMENT ,
    nombreClase VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS CARRERA_CLASE(
	id INT AUTO_INCREMENT NOT NULL,
    idCarrera INT NOT NULL,
    idClase INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS CARRERA_USUARIO(
	id INT NOT NULL AUTO_INCREMENT,
    idCarrera INT NOT NULL,
    idUsuario INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS USUARIOS(
	id INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    cuenta VARCHAR(20) NOT NULL,
    contrasena VARCHAR(150) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS ROLES(
	id INT AUTO_INCREMENT NOT NULL,
    nombreRol VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS USUARIO_ROL(
	id INT AUTO_INCREMENT NOT NULL,
    idUsuario INT NOT NULL,
    idRol INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS CATEGORIAS(
	id INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS FRASES(
	id INT AUTO_INCREMENT NOT NULL,
    frase VARCHAR(60) NOT NULL,
    urlFrase VARCHAR(150) NOT NULL,
    idCategoria INT NOT NULL,
    idUsuario INT NOT NULL,
    PRIMARY KEY(id)
);



/********INICIO DE CREACION DE CONSTRAINTS PARA LLAVES FORANEAS******/

-- relacionar VIDEOS con CLASES
ALTER TABLE VIDEOS
	ADD CONSTRAINT FK_idClase
	  FOREIGN KEY(idClase) REFERENCES CLASES(id) ON DELETE CASCADE;

-- relacionar CARRERA_CLASE
ALTER TABLE CARRERA_CLASE
  ADD CONSTRAINT FK_idCarrera
    FOREIGN KEY (idCarrera) REFERENCES CARRERAS(id) ON DELETE CASCADE;
ALTER TABLE CARRERA_CLASE
  ADD CONSTRAINT FK_Clase
    FOREIGN KEY (idClase) REFERENCES CLASES(id) ON DELETE CASCADE;
    
-- relacionar CARRERA_USUARIO
ALTER TABLE CARRERA_USUARIO
	ADD CONSTRAINT FK_Carrera
	  FOREIGN KEY (idCarrera) REFERENCES CARRERAS(id) ON DELETE CASCADE;
ALTER TABLE CARRERA_USUARIO
	ADD CONSTRAINT FK_Usuario
	  FOREIGN KEY (idUsuario) REFERENCES USUARIOS(id) ON DELETE CASCADE;
-- establecer como unico correo de USUARIO
ALTER TABLE USUARIOS
	ADD CONSTRAINT UNICO_correo
	  UNIQUE (correo);
-- relacionar USUARIO_ROL
ALTER TABLE USUARIO_ROL
	ADD CONSTRAINT FK_id_Usuario
      FOREIGN KEY (idUsuario) REFERENCES USUARIOS(id) ON DELETE CASCADE;
ALTER TABLE USUARIO_ROL
	ADD CONSTRAINT FK_id_Rol
      FOREIGN KEY (idRol) REFERENCES ROLES(id) ON DELETE CASCADE;

-- relacionar FRASES con Usuario
ALTER TABLE FRASES
	ADD CONSTRAINT FK_id_Categoria
	  FOREIGN KEY (idCategoria) REFERENCES CATEGORIAS(id) ON DELETE CASCADE;
ALTER TABLE FRASES
	ADD CONSTRAINT FK_iid_Usuario
	  FOREIGN KEY (idUsuario) REFERENCES USUARIOS(id) ON DELETE CASCADE;

-- relacionar CARRERAS con GRADOS
ALTER TABLE CARRERAS
	ADD CONSTRAINT FK_idGrado
      FOREIGN KEY (idGrado) REFERENCES GRADOS(id) ON DELETE CASCADE;
      
-- agregar campos a tabla CLASES
ALTER TABLE CLASES
	ADD codigo VARCHAR(40) NOT NULL,
    ADD horas INT NOT NULL,
    ADD creditos INT NOT NULL,
    ADD color VARCHAR(10);

      