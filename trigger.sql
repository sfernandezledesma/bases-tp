CREATE TABLE ElementosPerdidos (
  IdPerdida SERIAL,
  IdElementoPerdido INTEGER NOT NULL,
  nombreCientifico VARCHAR(50) NOT NULL,
  nombreVulgar VARCHAR(50),
  PRIMARY KEY (IdPerdida)
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