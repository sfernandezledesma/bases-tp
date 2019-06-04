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
  SuperficieTotal INTEGER,
  IdOrganismo INTEGER,
  PRIMARY KEY (IdProvincia),
  FOREIGN KEY (IdOrganismo) REFERENCES Organismo(IdOrganismo)
);
INSERT INTO Provincia(IdProvincia, Nombre, SuperficieTotal, IdOrganismo) VALUES (1, 'Buenos Aires', 307571, 1);
INSERT INTO Provincia(IdProvincia, Nombre, SuperficieTotal, IdOrganismo) VALUES (2, 'La Pampa', 143440, 2);

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

CREATE TABLE ElementoNatural (
  IdElemento INTEGER, 
  nombreCientifico VARCHAR(50), 
  nombreVulgar VARCHAR(50), 
  tipoElemento VARCHAR(50),
  PRIMARY KEY (IdElemento),
  CONSTRAINT elemento_tipos CHECK (tipoElemento = 'Mineral' OR tipoElemento = 'Comestible')
);
INSERT INTO ElementoNatural(IdElemento, nombreCientifico, nombreVulgar, tipoElemento) VALUES (1, 'Arena', 'Arena', 'Mineral');
INSERT INTO ElementoNatural(IdElemento, nombreCientifico, nombreVulgar, tipoElemento) VALUES (2, 'Panthera tigris', 'Tigre', 'Comestible');
INSERT INTO ElementoNatural(IdElemento, nombreCientifico, nombreVulgar, tipoElemento) VALUES (3, 'Oryctolagus cuniculus', 'Conejo', 'Comestible');
INSERT INTO ElementoNatural(IdElemento, nombreCientifico, nombreVulgar, tipoElemento) VALUES (4, 'Trifolium', 'Trebol', 'Comestible');

CREATE TABLE Mineral (
  IdElemento INTEGER, 
  tipoMineral VARCHAR(50),
  PRIMARY KEY (IdElemento),
  FOREIGN KEY (IdElemento) REFERENCES ElementoNatural(IdElemento),
  CONSTRAINT mineral_tipos CHECK (tipoMineral = 'Roca' OR tipoMineral = 'Cristal')
);
INSERT INTO Mineral(IdElemento, tipoMineral) VALUES (1, 'Roca');

CREATE TABLE Comestible (
  IdElemento INTEGER, 
  tipoComestible VARCHAR(50),
  PRIMARY KEY (IdElemento),
  FOREIGN KEY (IdElemento) REFERENCES ElementoNatural(IdElemento),
  CONSTRAINT comestible_tipos CHECK (tipoComestible = 'Vegetal' OR tipoComestible = 'Animal')
);
INSERT INTO Comestible(IdElemento, tipoComestible) VALUES (2, 'Animal');
INSERT INTO Comestible(IdElemento, tipoComestible) VALUES (3, 'Animal');
INSERT INTO Comestible(IdElemento, tipoComestible) VALUES (4, 'Vegetal');

CREATE TABLE Vegetal (
  IdElemento INTEGER, 
  tipoVegetal VARCHAR(50),
  PRIMARY KEY (IdElemento),
  FOREIGN KEY (IdElemento) REFERENCES Comestible(IdElemento),
  CONSTRAINT vegetal_tipos CHECK (tipoVegetal = 'SinFloracion' OR tipoVegetal = 'ConFloracion')
);
INSERT INTO Vegetal (IdElemento, tipoVegetal) VALUES (4, 'ConFloracion');

CREATE TABLE ConFloracion (
  IdElemento INTEGER,
  periodoFloracion VARCHAR(50),
  PRIMARY KEY (IdElemento),
  FOREIGN KEY (IdElemento) REFERENCES Vegetal(IdElemento)
);
INSERT INTO ConFloracion(IdElemento, periodoFloracion) VALUES (4, 'fines agosto hasta mediados marzo');

CREATE TABLE Animal (
  IdElemento INTEGER, 
  tipoAlimentacion VARCHAR(50), 
  periodoCelo VARCHAR(50),
  PRIMARY KEY (IdElemento),
  FOREIGN KEY (IdElemento) REFERENCES Comestible(IdElemento),
  CONSTRAINT tipo_alimentacion CHECK (tipoAlimentacion = 'Herbivoro' OR tipoAlimentacion = 'Carnivoro' OR tipoAlimentacion = 'Omnivoro')
);
INSERT INTO Animal(IdElemento, tipoAlimentacion, periodoCelo) VALUES (2, 'Carnivoro', 'Anual');
INSERT INTO Animal(IdElemento, tipoAlimentacion, periodoCelo) VALUES (3, 'Herbivoro', 'Permanente');

CREATE TABLE SeAlimentaDe (
  IdDepredador INTEGER,
  IdPresa INTEGER,
  PRIMARY KEY (IdDepredador, IdPresa),
  FOREIGN KEY (IdDepredador) REFERENCES Animal(IdElemento),
  FOREIGN KEY (IdPresa) REFERENCES Comestible(IdElemento)
);
INSERT INTO SeAlimentaDe(IdDepredador, IdPresa) VALUES (2, 3);
INSERT INTO SeAlimentaDe(IdDepredador, IdPresa) VALUES (3, 4);

-- SELECT depredador.nombreVulgar AS depredador, presa.nombreVulgar AS presa
-- FROM SeAlimentaDe
-- JOIN ElementoNatural depredador ON depredador.IdElemento = SeAlimentaDe.IdDepredador
-- JOIN ElementoNatural presa ON presa.IdElemento = SeAlimentaDe.IdPresa;

CREATE TABLE RegistroElemento (
  IdRegistroElemento INTEGER,
  IdElemento INTEGER,
  IdArea INTEGER,
  PRIMARY KEY (IdRegistroElemento),
  FOREIGN KEY (IdElemento) REFERENCES ElementoNatural(IdElemento),
  FOREIGN KEY (IdArea) REFERENCES Area(IdArea)
);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (1, 1, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (2, 2, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (3, 3, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (4, 3, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (5, 3, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (6, 4, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (7, 4, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (8, 4, 1);
INSERT INTO RegistroElemento(IdRegistroElemento, IdElemento, IdArea) VALUES (9, 4, 1);

CREATE TABLE ElementosPerdidos (
  IdElementoPerdido SERIAL,
  nombreCientifico VARCHAR(50) NOT NULL,
  nombreVulgar VARCHAR(50),
  PRIMARY KEY (IdElementoPerdido)
);

CREATE OR REPLACE FUNCTION perdida_elemento() RETURNS TRIGGER AS $$
DECLARE
  nombreCientifico VARCHAR(50);
  nombreVulgar VARCHAR(50);
  id INTEGER;
BEGIN
  SELECT INTO id, nombreCientifico, nombreVulgar
  OLD.IdRegistroElemento, ElementoNatural.nombreCientifico, ElementoNatural.nombreVulgar
  FROM ElementoNatural 
  WHERE ElementoNatural.IdElemento = OLD.IdElemento;
  
  INSERT INTO ElementosPerdidos(IdElementoPerdido, nombreCientifico, nombreVulgar) 
  VALUES (id, nombreCientifico, nombreVulgar);
  
  perform pg_notify('perdida_elemento', CONCAT(nombreCientifico, ' (id=',id,')'));
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_perdida_elemento 
BEFORE DELETE 
ON RegistroElemento 
FOR EACH ROW 
EXECUTE PROCEDURE perdida_elemento();