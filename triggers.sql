use bicing;

-- ----- Cálculo del importe por uso -----
DROP PROCEDURE IF EXISTS cal_importe;
DELIMITER //
CREATE PROCEDURE cal_importe(IN cod_user VARCHAR(10),
                             IN fi DATETIME,IN ff DATETIME, 
                             IN id_bic CHAR(3),OUT importe FLOAT)
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

-- ---Asignación del coste una vez devuelto la bicicleta ---
DROP TRIGGER IF EXISTS asignacion_coste;
DELIMITER //
CREATE TRIGGER asignacion_coste 



