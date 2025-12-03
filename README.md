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

Estas consultas son procedimientos almacenados de la base de datos que se encuentra en disponibles en ([consultas.sql](pizzeria-don-piccolo/consultas.sql)):

- 1. Clientes con pedidos entre dos fechas:

```sql
call clientes_pedidos_rango('fecha inicial','fecha final');
```
Esta es la estrutura para hacer la busqueda y desde este punto tu puedes definir el rango de la busqueda que vas a hacer el tipo de dato que debes es ingresar una fecha en formato (año-mes-dia) ejemplo:
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
- 4. Promedio de entrega por zona
```sql
call promedio_zona;
```
- 5. Clientes que gastaron más de un monto
```sql
call clientes_vip(monto_De_busqueda);
```
- 6. Búsqueda por coincidencia parcial de nombre de pizza
```sql
call busqueda_parcial('nombre para la busqueda parcial');
```
- 7. Subconsulta para obtener los clientes frecuentes
```sql
call clientes_frecuentes();
```












