-- --- Introducir incidentes ----
USE bicing;
DROP PROCEDURE IF EXISTS nuevos_incidentes;
DELIMITER //
CREATE PROCEDURE nuevos_incidentes(IN id CHAR(4), -- id de incidente
                                   IN id_bic CHAR(3), -- id de bicicleta
                                   In cod_est CHAR(4), -- código estación
                                   IN def TEXT) -- descripción de la averia.
BEGIN
INSERT INTO MANTENIMIENTO VALUES (id, id_bic,NOW(), cod_est, def,NULL);
END
// DELIMITER ;
-- --- Indicar que la bicicleta está nuevamente operativa ----
DROP PROCEDURE IF EXISTS bic_arreglada;
USE bicing;
CREATE PROCEDURE  bic_arreglada(IN id CHAR(4))
BEGIN
UPDATE MANTENIMIENTO SET `Fecha de alta`= NOW() WHERE Id = id;
END
// DELIMITER ;
