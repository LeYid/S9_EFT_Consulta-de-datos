# Evaluación Transversal S9 - Oracle SQL Developer

## Descripción
Implementación de una estrategia de seguridad, acceso y optimización de datos en Oracle Database para una empresa financiera dedicada a la gestión de cobranzas y tarjetas de crédito.

El proyecto considera:
- Creación de usuarios y roles.
- Asignación de privilegios bajo principio de menor privilegio.
- Uso de sinónimos públicos.
- Construcción de vistas para informes.
- Uso de secuencias.
- Creación de índices y análisis de planes de ejecución.

---

# Estructura de usuarios

## PRY2205_EFT
Usuario owner encargado de:
- creación de objetos
- secuencias
- índices
- sinónimos
- tablas de análisis

## PRY2205_EFT_DES
Usuario desarrollador encargado de:
- creación de vistas
- generación de informes
- consultas de análisis

## PRY2205_EFT_CON
Usuario consultor con permisos de solo lectura para visualizar informes.

---

# Casos implementados

## Caso 1
- Creación de usuarios
- Roles y privilegios
- Estrategia de sinónimos públicos

## Caso 2
- Vista `VW_ANALISIS_DEUDORES_PERIODO`
- Informe de análisis de cobranza
- Uso de joins, subconsultas, HAVING y funciones SQL

## Caso 3.1
- Tabla `T_ANALISIS_TARJETAS`
- Secuencia `SEQ_T_ANALISIS`
- Informe de análisis de transacciones

## Caso 3.2
- Optimización mediante índices
- Uso de `EXPLAIN PLAN`
- Comparación de planes de ejecución antes y después de índices

---

# Tecnologías utilizadas
- Oracle SQL Developer
- Oracle Database 19c
- SQL
