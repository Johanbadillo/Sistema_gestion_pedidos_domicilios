# Sistema de Gestión de Pedidos y Domicilios para Pizzería Don Piccolo

## Sistema de Gestión de Pedidos y Domicilios para Pizzería Don Piccolo

Este repositorio contiene el desarrollo de un sistema de base de datos relacional en MySQL para la Pizzería Don Piccolo. El objetivo principal es gestionar de manera eficiente los clientes, pizzas, ingredientes, pedidos, repartidores, domicilios y pagos, optimizando el proceso de ventas desde el registro de un pedido hasta su entrega y pago.

**Estado actual del proyecto:** El repositorio se encuentra en construcción. Se han implementado las tablas base, relaciones y algunas consultas, pero los requerimientos relacionados con disparadores (triggers) y funciones/procedimientos están en desarrollo. Se actualizará progresivamente para cumplir con todos los requerimientos funcionales descritos a continuación.

## Estructura del Proyecto

El proyecto sigue la siguiente estructura:

```
📁pizzeria-don-piccolo/
├── database.sql      # Script para creación de la base de datos y tablas con relaciones y la insercion de datos.
├── funciones.sql     # Script para funciones (en construcción).
├── triggers.sql      # Script para triggers (en construcción).
├── vistas.sql        # Script para creación de vistas, (view).
├── consultas.sql     # Script para creación de consultas SQL complejas(procedure).
└── README.md         # Este archivo con documentación.
```

## Ejemplos de Consultas

Estas consultas son procedimientos almacenados de la base de datos que se encuentra en disponibles en [consultas.sql](pizzeria-don-piccolo/consultas.sql):

- 1. Clientes con pedidos entre dos fechas:

```sql
call clientes_pedidos_rango('fecha inicial','fecha final');
```
Esta es la estrutura para hacer la busqueda y desde este punto tu puedes definir el rango de la busqueda que vas a hacer el tipo de dato que debes es ingresar una fecha en formato (año-mes-dia):

Ejemplo con la data encontrada en [database.sql](pizzeria-don-piccolo/database.sql):
```sql
call clientes_pedidos_rango('2025-01-01','2025-12-31');
```

- 2. Pizzas más vendidas:

En esta consulta nos traera en una tabla el nombre de la pizza mas vendida la cantidad de pizza vendidas de mayor a menor con el total de dinero ganado y el tipo de pizza.
```sql
call top_pizzas;
```
- 3. Pedidos por repartidor:
```sql
call pedidos_repartidor(id_repartidor);
```
Esta es la estructura para conocer los pedidos que han sido realizados por un repartidor para tener un mejor control de tanto los pedidos como los repartidores para llevar un registro de ellos.

Pero para conocer el id de los repartidores que se encuentra disponible ejecute esta consulta para conocer el id y el nombre de los repartidores con su zona asignada.
```sql
select r.id, concat(per.nombre,' ',per.apellido) as nombre_completo from repartidores r left join persona per on r.id=per.id;
```
Ejemplo con la data encontrada en [database.sql](pizzeria-don-piccolo/database.sql):
```sql
call pedidos_repartidor(21);
```
- 4. Promedio de entrega por zona:

Esta consulta promedia la cantidad de dinero ganado por zona, con el total de pedidos entregados en cada zona, con su respectivo nombre y se puede visualizar en que zonas tienen mas ganancias porque se encuentra ordenada de mayor a menor las ganancias.
```sql
call promedio_zona;
```
- 5. Clientes que gastaron más de un monto:

Esta consulta nos trae una tabla con los clientes que han gastado mas de un monto definido por el usuario, con su respectivo nombre, apellido y el total gastado.
```sql
call clientes_vip(monto_De_busqueda);
```
Ejemplo con la data encontrada en [database.sql](pizzeria-don-piccolo/database.sql):
```sql
call clientes_vip(100000);
```
- 6. Búsqueda por coincidencia parcial de nombre de pizza:

Esta consulta nos trae una tabla con las pizzas que coincidan con el nombre parcial que se ingrese, con su respectivo nombre, tipo de pizza y precio.
```sql
call busqueda_parcial('nombre para la busqueda parcial');
```
Ejemplo con la data encontrada en [database.sql](pizzeria-don-piccolo/database.sql):
```sql
call busqueda_parcial('s');
```
- 7. Subconsulta para obtener los clientes frecuentes:

Esta consulta nos trae una tabla con los clientes que han realizado mas de 5 pedidos, con su respectivo nombre, apellido y la cantidad de pedidos realizados.
```sql
call clientes_frecuentes();
```
---
### NOTA
Se necesita tener MySQL instalado y configurado para ejecutar los scripts SQL proporcionados en este repositorio. Asegúrate de revisar y adaptar los scripts según tus necesidades específicas y el entorno de tu base de datos.

Si no se ejecutan los scripts en el orden correcto, pueden generarse errores de dependencia entre tablas y relaciones. Se recomienda seguir el orden de los archivos tal como se presentan en la estructura del proyecto.




