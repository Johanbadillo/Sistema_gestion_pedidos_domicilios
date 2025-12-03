/*Vistas
Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).
Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
Vista de stock de ingredientes por debajo del mínimo permitido.
*/

-- 1. Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).
CREATE VIEW pedidos_cliente AS
SELECT concat(per.nombre,' ',per.apellido) as nombre_completo_cliente, COUNT(*) as cantidad_pedidos, SUM(ped.total) as total_gastado
FROM pedidos ped LEFT JOIN persona per on ped.id_cliente=per.id GROUP BY id_cliente;

-- manera de buscarlo
SELECT * FROM pedidos_cliente;


-- 2. Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
CREATE VIEW desempeño_repartidor AS 
SELECT concat(per.nombre,' ',per.apellido) as nombre_completo_repartidor, 
COUNT(*) as numero_entregas, 
TIME_FORMAT(SEC_TO_TIME( AVG( TIME_TO_SEC( TIMEDIFF(hora_entrega, hora_salida) ) ) ), '%H:%i:%s' ) as tiempo_promedio
FROM domicilio do LEFT JOIN persona per on do.id_repartidor=per.id GROUP BY do.id_repartidor;

SELECT * FROM desempeño_repartidor;

/*
TIMEDIFF           → 00:25:00     y     00:30:00 calcula la diferencia en tiempo y regresa en time
    ↓
TIME_TO_SEC        → 1500         y     1800 covierte el time en numero
    ↓
AVG                → (1500 + 1800) / 2 = 1650 segundos promedia
    ↓
SEC_TO_TIME        → 00:27:30   ← promedio real y correcto convierte el numero a time
*/

-- 3. Vista de stock de ingredientes por debajo del mínimo permitido.

CREATE VIEW alerta_stock AS
SELECT id, nombre, stock, stock_minimo FROM ingredientes WHERE stock<=stock_minimo;

SELECT * FROM alerta_stock;

-- vista nombre repartidores
CREATE VIEW nombre_repartidor AS
select r.id, concat(per.nombre,' ',per.apellido) as nombre_completo from repartidores r left join persona per on r.id=per.id;