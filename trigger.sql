CREATE TABLE ElementosPerdidos (
  IdPerdida SERIAL,
  IdRegistroElemento INTEGER NOT NULL,
  IdElemento INTEGER,
  IdArea INTEGER,
  EmailEnviado BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (IdPerdida),
  FOREIGN KEY (IdElemento) REFERENCES RegistroElemento(IdRegistroElemento),
  FOREIGN KEY (IdArea) REFERENCES Area(IdArea)
);

CREATE OR REPLACE FUNCTION perdida_elemento() RETURNS TRIGGER AS $$
DECLARE
  IdRegistroElemento INTEGER;
  IdElemento INTEGER;
  IdArea INTEGER;
  IdPerdida INTEGER;
BEGIN
  -- SELECT OLD.IdRegistroElemento, OLD.IdElemento, OLD.IdArea
  -- INTO IdRegistroElemento, IdElemento, IdArea;
  IdRegistroElemento := OLD.IdRegistroElemento;
  IdElemento := OLD.IdElemento;
  IdArea := OLD.IdArea;
  
  INSERT INTO ElementosPerdidos(IdRegistroElemento, IdElemento, IdArea) 
  VALUES (IdRegistroElemento, IdElemento, IdArea)
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