-- ----- Cálculo del importe -----
use bicing;
DROP PROCEDURE IF EXISTS cal_importe;
DELIMITER //
CREATE PROCEDURE cal_importe(IN cod_user VARCHAR(10),-- Código de usuario 
                             IN fi DATETIME,IN ff DATETIME, -- Fechas inicial y final
                             IN id_bic CHAR(3), -- Código de la bicicleta
                             OUT importe FLOAT) -- Importe 
BEGIN
SET @tf = (SELECT Id_tarifa_fija FROM FACTURACION_ANUAL WHERE Codigo_usuario= cod_user ORDER BY `fecha_abono` DESC LIMIT 1);
SET @tb = (SELECT Id_tipo_bicicleta FROM BICICLETAS WHERE Id = id_bic);
SET @h = TIMESTAMPDIFF(HOUR, ti, tf);
IF @h < 0.5 THEN
   SET @ot = "ot1";
ELSEIF @h < 2 THEN
   SET @ot ="ot2";
ELSE SET @ot = "ot3";
END IF;
SET @precio = (SELECT Precio FROM Tarifa_variable 
               WHERE Id_uso_variable=@ot AND Id_tipo_bicicleta=@tb AND
               Id_tarifa_fija=@tf);
IF @ot="ot3" THEN 
   SET @precio= @precio * @h;
END IF;
END //
DELIMITER ;

--  ---  INICIO DESPLAZAMIENTO ----
USE bicing;
DROP PROCEDURE IF EXISTS inicio_despl;
DELIMITER //
CREATE PROCEDURE inicio_despl(IN cod_ref CHAR(3), -- código de referencia
                              IN cod_user VARHCAR(12), -- código de usuario
                              IN id_bic CHAR(3), -- tipo de bicicleta
                              IN cod_est CHAR(3)) -- código de la estación de origen
BEGIN
INSERT INTO DESPLAZAMIENTOS VALUES (cod_ref,cod_user,id_bic,NOW(),cod_est,DEFAULT,DEFAULT,DEFAULT,DEFAULT);
END
// DELIMITER ; 

--  --- FINAL DESPLAZAMIENTO -----
USE bicing;
DROO PROCEDURE IF EXISTS fin_despl;
DELIMITER //
CREATE PROCEDURE fin_despl(IN cod_ref CHAR(3),-- código de referencia
                           IN cod_est CHAR(3))-- código de la estación de destino
BEGIN
UPDATE DESPLAZAMIENTOS SET Cod_estacion_final = cod_est WHERE Codigo_referencia = cod_ref;
END
// DELIMITER ;
-- ---Asignación del coste ---
-- Una vez hecha la actualización cuando se devuelve la bicicleta en la estación de destino.
use bicing;
DROP TRIGGER IF EXISTS asignacion_coste;
DELIMITER //
CREATE TRIGGER asignacion_coste BEFORE UPDATE ON desplazamientos FOR EACH ROW 
BEGIN
SET NEW.`Fecha final`= NOW();
SET NEW.Tiempo_transcurrido = TIMESTAMPDIFF(NEW.`Fecha final`,OLD.`Fecha inicio`);
CALL cal_importe(OLD.Codigo_usuario,OLD.`Fecha inicio`,NEW.`Fecha final`,OLD.id_bicicleta,@importe);
SET NEW.importe= @importe;
END //
DELIMITER ;



