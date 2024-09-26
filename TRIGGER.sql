-- Cambia el delimitador temporalmente de ';' a '$$' para indicar que el bloque de código completo es parte de un trigger (disparador).
DELIMITER $$

-- Crea un trigger (disparador) llamado `after_cliente_insert`.
-- Este trigger se ejecutará automáticamente después de que se inserte un nuevo registro en la tabla `cliente`.
CREATE TRIGGER after_cliente_insert

-- Especifica que el trigger se activará después de que ocurra una inserción (AFTER INSERT) en la tabla `cliente`.
AFTER INSERT ON cliente

-- Este trigger se ejecutará para cada fila nueva que se inserte (FOR EACH ROW).
FOR EACH ROW

-- Comienza el bloque de código que se ejecutará cuando el trigger se active.
BEGIN

    -- Inserta un nuevo registro en la tabla `hueco` cada vez que se inserta un cliente.
    -- Se insertan valores en varias columnas de la tabla `hueco`. 
    -- '1' es el ID de la funeraria, y 'SI' indica que el hueco está ocupado.
    -- Los demás valores, como el tipo de hueco, la ubicación y las medidas, se dejan como NULL (sin valor).
    -- `NEW.id_cliente` se refiere al ID del cliente recién insertado y lo asigna a la columna `cliente_id_cliente` de la tabla `hueco`.
    INSERT INTO hueco(funeraria_id_funeraria, tipo_hueco, ocupado, ubicacion, medidas, cliente_id_cliente)
    VALUES (1, NULL, 'SI', NULL, NULL, NEW.id_cliente);

-- Finaliza el bloque de código del trigger.
END $$

-- Vuelve a cambiar el delimitador a su valor original ';' ya que hemos terminado de definir el trigger.
DELIMITER ;

-- Inserta un nuevo cliente en la tabla `cliente` con los siguientes valores: 
-- nombre 'Saol', apellido 'Márquez', fecha de fallecimiento '2010-04-15', tipo de cliente 'BENEFICIARIO', 
-- y asociado a la funeraria con ID 1.
-- Como resultado, el trigger se activará automáticamente y también se insertará un nuevo hueco para este cliente.
INSERT INTO gestion_funeraria.cliente (nombre, apellido, fecha_fallecimiento, tipo_cliente, funeraria_id_funeraria) 
VALUES ('Saol', 'Márquez', '2010-04-15', 'BENEFICIARIO', 1);
