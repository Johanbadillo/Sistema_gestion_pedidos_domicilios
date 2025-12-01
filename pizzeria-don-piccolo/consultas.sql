/*
Clientes con pedidos entre dos fechas (BETWEEN).
Pizzas más vendidas (GROUP BY y COUNT).
Pedidos por repartidor (JOIN).
Promedio de entrega por zona (AVG y JOIN).
Clientes que gastaron más de un monto (HAVING).
Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).
*/

-- 1. Clientes con pedidos entre dos fechas (BETWEEN).
DELIMITER //
CREATE PROCEDURE clientes_pedidos_rango(in v_fecha_inicio date,in v_fecha_fin date)
begin
SELECT concat(p.nombre,' ',p.apellido) as nombre_completo, pe.total, pe.descripcion, pe.tipo_pedido from pedidos pe left join persona p on pe.id_cliente=p.id
where DATE(pe.fecha) BETWEEN v_fecha_inicio and v_fecha_fin
ORDER BY pe.fecha DESC;
END; //
DELIMITER ;

call clientes_pedidos_rango('yyyy-mm-dd','yyyy-mm-dd');
call clientes_pedidos_rango('2025-01-01','2025-12-31');


-- 2. Pizzas más vendidas (GROUP BY y COUNT).
DELIMITER //
CREATE PROCEDURE top_pizzas()
BEGIN
SELECT COUNT(*) as cantidad_pizzas, MIN(pi.nombre) as nombre_pizza, MIN(pi.tipo_pizza) as tipo_pizza, sum(dp.subtotal) as total_ganado 
FROM detalle_pedido dp left join pizza pi on dp.id_pizza=pi.id 
GROUP BY  dp.id_pizza 
ORDER BY  cantidad_pizzas DESC;
END; //
DELIMITER ;

call top_pizzas;





















