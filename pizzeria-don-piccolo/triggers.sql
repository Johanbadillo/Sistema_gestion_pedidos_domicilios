/*\Triggers
Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.
Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.
Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.*/

-- Estructura de un trigger
/*
delimiter // 
create trigger validar_stock_producto_al_vender
before insert on detalle_venta
for each row
begin 
    declare v_stock int default -1;
    declare v_precio int default 0;

    if NEW.tipo_venta = 'producto' THEN
        select stock,precio_compra into v_stock,v_precio from producto where id=NEW.codigo;
        if v_stock = -1 then
            signal sqlstate '45000' set message_text='producto no existe';
            elseif NEW.cantidad>v_stock then
                signal sqlstate '45000' set message_text='stock insuficiente';
        else 
            set NEW.subtotal=v_precioNEW.cantidad;
            update producto set stock=stock-NEW.cantidad where id=NEW.codigo;
            end if;
    end if;
end; //
delimiter ;
*/


-- 1. Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.
-- Pedido agarro las pizzas y de las pizzas agarro los ingredientes y la cantidad que se necesita de cada ingrediente para restarlo

SELECT p.nombre,
    d.id_ingredientes,
    dp.cantidad*d.cantidad,
    i.stock
FROM detalle_pedido dp
LEFT JOIN pizza p
ON dp.id_pizza = p.id
JOIN detalle_pizza d ON p.id = d.id_pizza
LEFT JOIN ingredientes i ON d.id_ingredientes = i.id
WHERE p.id = 1;

UPDATE ingredientes
SET stock = stock - d.cantidad
WHERE id = d.id_ingredientes;
-- ahora agarra el stock del ingrediente y verifica si hay stock suficiente para restar la cantidad necesaria
-- si no hay stock suficiente lanza un error


-- al stock de ingredientes.
-- error porque esta regresando varias lineas 
-- posibles soluciones puede hacerce un ciclo while o un cursor
delimiter //
CREATE Trigger actualizar_stock_ingredientes
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;
    DECLARE v_cantidad_ingredientes INT;
    DECLARE v_id_ingrediente INT;

    SELECT d.id_ingredientes,
    dp.cantidad*d.cantidad,
    i.stock
    into v_id_ingrediente, v_cantidad_ingredientes, v_stock
    FROM detalle_pedido dp
    LEFT JOIN pizza p
    ON dp.id_pizza = p.id
    JOIN detalle_pizza d ON p.id = d.id_pizza
    LEFT JOIN ingredientes i ON d.id_ingredientes = i.id
    WHERE p.id = new.id_pizza;

    IF v_stock < v_cantidad_ingredientes THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para el ingrediente';
    ELSE
        UPDATE ingredientes SET stock = stock - v_cantidad_ingredientes WHERE id = d.id_ingrediente;
    END IF;
END; //
delimiter ;


-- 2. Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.
DROP TRIGGER IF EXISTS registrar_cambio_precio_pizza;
DELIMITER //
CREATE TRIGGER registrar_cambio_precio_pizza
AFTER UPDATE ON pizza
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO historial_precios (id_pizza, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.id, OLD.precio, NEW.precio, NOW());
    END IF;
END; //
DELIMITER ;


-- 3. Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.
DROP TRIGGER IF EXISTS marcar_repartidor_disponible;
DELIMITER //
CREATE TRIGGER marcar_repartidor_disponible
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'entregado' THEN
        UPDATE repartidores r
        JOIN domicilio d ON d.id_repartidor = r.id
        SET r.estado = 'disponible'
        WHERE d.id_pedido = NEW.id;
    END IF;
END; //
DELIMITER ;

-- Campos de prueba para la validación de los triggers
UPDATE repartidores SET estado = 'no_disponible' WHERE id = 25;
update pedidos set estado = 'pendiente' where id=6;

-- actaualizar el pedido a entregado para que el trigger se ejecute
update pedidos set estado = 'entregado' where id=6;