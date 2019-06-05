CREATE TABLE ElementosPerdidos (
  IdPerdida SERIAL,
  IdElementoPerdido INTEGER NOT NULL,
  nombreCientifico VARCHAR(50) NOT NULL,
  nombreVulgar VARCHAR(50),
  PRIMARY KEY (IdPerdida)
);

CREATE TABLE UltimoEmailEnviado (
  id INTEGER PRIMARY KEY DEFAULT 1,
  ultimoId INTEGER NOT NULL DEFAULT 1,
  CONSTRAINT unaFila CHECK (id = 1)
);

CREATE OR REPLACE FUNCTION perdida_elemento() RETURNS TRIGGER AS $$
DECLARE
  nombreCientifico VARCHAR(50);
  nombreVulgar VARCHAR(50);
  IdRegistroElemento INTEGER;
  IdPerdida INTEGER;
BEGIN
  SELECT INTO IdRegistroElemento, nombreCientifico, nombreVulgar
  OLD.IdRegistroElemento, ElementoNatural.nombreCientifico, ElementoNatural.nombreVulgar
  FROM ElementoNatural 
  WHERE ElementoNatural.IdElemento = OLD.IdElemento;
  
  INSERT INTO ElementosPerdidos(IdElementoPerdido, nombreCientifico, nombreVulgar) 
  VALUES (IdRegistroElemento, nombreCientifico, nombreVulgar)
  RETURNING ElementosPerdidos.IdPerdida INTO IdPerdida;
  
  perform pg_notify('perdida_elemento', IdPerdida::TEXT);
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_perdida_elemento 
BEFORE DELETE 
ON RegistroElemento 
FOR EACH ROW 
EXECUTE PROCEDURE perdida_elemento();