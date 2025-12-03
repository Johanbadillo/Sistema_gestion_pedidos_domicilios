# 🍕 Sistema de Gestión de Pedidos y Domicilios - Pizzería Don Piccolo

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQL">
  <img src="https://img.shields.io/badge/status-en%20desarrollo-yellow?style=for-the-badge" alt="Estado">
</p>

<p align="center">
  <strong>Un sistema completo de base de datos relacional para gestionar pedidos, domicilios, clientes y repartidores en una pizzería.</strong>
</p>

---

## 🚀 Características del Sistema

- Gestión completa de clientes, pedidos y domicilios  
- Control de inventario de ingredientes y pizzas personalizadas  
- Seguimiento de repartidores y zonas de entrega  
- Reportes avanzados: pizzas más vendidas, clientes VIP, ganancias por zona, etc.  
- Procedimientos almacenados optimizados para consultas frecuentes  
- Vistas y triggers (en desarrollo)

## 📁 Estructura del Proyecto

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



## 📊 Consultas Destacadas (Procedimientos Almacenados)

| # | Nombre                          | Descripción                                                                 | Ejemplo de uso                              |
|---|----------------------------------|----------------------------------------------------------------------------|---------------------------------------------|
| 1 | `clientes_pedidos_rango`         | Clientes con pedidos en un rango de fechas                                 | `CALL clientes_pedidos_rango('2025-01-01', '2025-12-31');` |
| 2 | `top_pizzas`                     | Ranking de las pizzas más vendidas con ingresos totales                   | `CALL top_pizzas;`                          |
| 3 | `pedidos_repartidor`             | Todos los pedidos entregados por un repartidor                             | `CALL pedidos_repartidor(21);`              |
| 4 | `promedio_zona`                  | Ganancias y cantidad de pedidos por zona (ordenado de mayor a menor)      | `CALL promedio_zona;`                       |
| 5 | `clientes_vip`                   | Clientes que han gastado más de X monto                                    | `CALL clientes_vip(100000);`                |
| 6 | `busqueda_parcial`               | Búsqueda de pizzas por coincidencia parcial en el nombre                   | `CALL busqueda_parcial('hawai');`           |
| 7 | `clientes_frecuentes`            | Clientes con más de 5 pedidos (clientes fieles)                            | `CALL clientes_frecuentes();`               |


## 🛠️ Requisitos Previos

- MySQL 8.0+ o MariaDB 10.6+

## 🚀 Cómo Usar el Proyecto

1.  Clona o descarga este repositorio
2.  Abre tu cliente MySQL y crea una base de datos:
```sql
CREATE DATABASE pizzeria_don_piccolo;

USE pizzeria_don_piccolo;
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
select * from nombre_repartidor;
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



## **👨‍💻 Autor** 
<div align="center">


**Hecho con 🍕 y ❤️ para la Pizzería Don Piccolo**

<div>