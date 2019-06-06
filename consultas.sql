--- CREO UNA VIEW CON CANTIDAD DE PARQUES POR PROVINCIA
CREATE OR REPLACE VIEW provincia_cantparques AS
SELECT p.idProvincia,p.nombre,COUNT(DISTINCT pq.idParque) cantparques FROM Provincia p
INNER JOIN Contiene c ON c.idProvincia = p.idProvincia
INNER JOIN Parque pq ON pq.idParque = c.idParque
GROUP BY p.idProvincia;

--- USO ESA VIEW PARA RESPONDER LA CONSULTA 1
SELECT nombre FROM provincia_cantparques
WHERE cantparques = (SELECT MAX(cantparques) from provincia_cantparques);


---  CONSULTA 2
SELECT e.idElemento, e.nombreVulgar FROM Parque p
INNER JOIN Area a ON a.idParque = p.idParque
INNER JOIN RegistroElemento r ON a.idArea = r.idArea
INNER JOIN ElementoNatural e ON e.idElemento = r.idElemento
INNER JOIN Vegetal v ON v.idElemento = e.idElemento
GROUP BY e.idElemento
HAVING COUNT(DISTINCT p.idParque)  > ((SELECT COUNT(*) FROM Parque) / 2);


---CONSULTA 3

SELECT COUNT(DISTINCT v.idVisitante) FROM Alojamiento a
INNER JOIN Estadia e  ON a.idAlojamiento = e.idAlojamiento
INNER JOIN OcupadoPor o ON e.idAlojamiento = o.idAlojamiento AND e.fecha = o.fechaEstadia
INNER JOIN Visitante v ON v.idVisitante = o.idVisitante
WHERE a.idParque = 3 OR a.idParque = 1;
