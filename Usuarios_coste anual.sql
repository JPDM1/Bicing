--  --- NUEVOS CLIENTES ----
USE bicing;
DROP PROCEDURE IF EXISTS clientes;
DELIMITER //
CREATE PROCEDURE clientes(IN cod_user VARCHAR(10),-- código inscrito a mano
                          IN dni CHAR(9),
                          IN nombre VARCHAR(45),
                          IN apellidos VARCHAR(45),
                          IN dir VARCHAR(45),
                          IN cta_cte VARCHAR(15))-- número cuenta corriente
BEGIN
IF dni IN (SELECT DNI FROM clientes) THEN
   SELECT "No es cliente nuevo" AS "Mensaje";
ELSE
   INSERT INTO USUARIOS VALUES(cod_user,NOW(),dni,nombre,apellidos,dir,cta_cte);
END IF;
END
// DELIMITER ;
--  --- FACTURACIÓN ANUAL ----
USE bicing;
DROP PROCEDURE IF EXISTS cobro_anual;
DELIMITER //
CREATE PROCEDURE cobro_anual(IN id CHAR(5), -- id de la factura
                             IN cod_user VARCHAR(10), -- código de usuario 
                             IN id_tafifa CHAR(4)) -- tipo de tarifa anual
BEGIN
INSERT INTO FACTURACION_ANUAL VALUES (id,cod_user,DEFAULT,id_tafifa);
END
// DELIMITER ;


