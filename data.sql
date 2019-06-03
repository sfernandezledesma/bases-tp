DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;

CREATE TABLE Organismo(
  IdOrganismo INTEGER, 
  Nombre VARCHAR(50),
  PRIMARY KEY (IdOrganismo)
);
INSERT INTO Organismo(IdOrganismo, Nombre) VALUES (1, 'Organismo Nacional');
INSERT INTO Organismo(IdOrganismo, Nombre) VALUES (2, 'Organismo La Pampa');

CREATE TABLE Provincia (
  IdProvincia INTEGER, 
  Nombre VARCHAR(50), 
  IdOrganismo INTEGER,
  PRIMARY KEY (IdProvincia),
  FOREIGN KEY (IdOrganismo) REFERENCES Organismo(IdOrganismo)
);
INSERT INTO Provincia(IdProvincia, Nombre, IdOrganismo) VALUES (1, 'Buenos Aires', 1);
INSERT INTO Provincia(IdProvincia, Nombre, IdOrganismo) VALUES (2, 'La Pampa', 2);

CREATE TABLE Parque (
  IdParque INTEGER, 
  Nombre VARCHAR(50), 
  FechaDeclaracion DATE, 
  EmailContacto VARCHAR(50),
  PRIMARY KEY (IdParque)
);
INSERT INTO Parque(IdParque, Nombre, FechaDeclaracion, EmailContacto) VALUES (1, 'Uno', '01/02/2000', 'asd@gmail.com');
INSERT INTO Parque(IdParque, Nombre, FechaDeclaracion, EmailContacto) VALUES (2, 'Dos', '02/03/2002', 'grge@gmail.com');

CREATE TABLE Contiene (
  IdProvincia INTEGER,
  idParque INTEGER,
  PRIMARY KEY (IdProvincia, IdParque),
  FOREIGN KEY (IdProvincia) REFERENCES Provincia(IdProvincia),
  FOREIGN KEY (idParque) REFERENCES Parque(idParque)
);
INSERT INTO Contiene(IdProvincia, IdParque) VALUES (1, 1);
INSERT INTO Contiene(IdProvincia, IdParque) VALUES (1, 2);
INSERT INTO Contiene(IdProvincia, IdParque) VALUES (2, 2);

CREATE TABLE Area (
  IdArea INTEGER, 
  Nombre VARCHAR(50), 
  Superficie INTEGER, 
  IdParque INTEGER,
  PRIMARY KEY (IdArea),
  FOREIGN KEY (IdParque) REFERENCES Parque(IdParque)
);
INSERT INTO Area(IdArea, Nombre, Superficie, IdParque) VALUES (1, '1.1', 2, 1);
INSERT INTO Area(IdArea, Nombre, Superficie, IdParque) VALUES (2, '1.2', 2, 1);
INSERT INTO Area(IdArea, Nombre, Superficie, IdParque) VALUES (3, '2.1', 2, 2);
INSERT INTO Area(IdArea, Nombre, Superficie, IdParque) VALUES (4, '2.2', 2, 2);