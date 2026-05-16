-- =========================
-- USUARIO 3 / CONSULTOR / PRY2205_EFT_DES
-- =========================
-- Creamos vista para que el consultor tenga un 
-- informe mensual de análisis de cobranza

SHOW USER;

-- INFORME CASO 2
CREATE OR REPLACE VIEW VW_ANALISIS_DEUDORES_PERIODO AS
SELECT
    TO_CHAR(d.numrun, '99G999G999') || '-' || d.dvrun AS rut_deudor,
    INITCAP(d.pnombre || ' ' || d.appaterno || ' ' || d.apmaterno) AS nombre_deudor,
    COUNT(c.nro_cuota) AS total_cuotas,
    ROUND(AVG(c.valor_cuota)) AS promedio_valor_cuotas,
    TO_CHAR(MIN(c.fecha_venc_cuota), 'DD/MM/YYYY') AS fecha_mas_antigua,
    NVL(TO_CHAR(d.fono_contacto), 'Sin Información') AS telefono,
    UPPER(o.nombre_prof_ofic) AS ocupacion,
    td.cupo_disp_compra AS cupo_disp_compra
FROM SYN_DEUDOR d
JOIN SYN_OCUPACION o
    ON d.cod_ocupacion = o.cod_ocupacion
JOIN SYN_TARJETA_DEUDOR td
    ON d.numrun = td.numrun
JOIN SYN_CUOTA_TARJETA c
    ON td.nro_tarjeta = c.nro_tarjeta
WHERE UPPER(o.nombre_prof_ofic) NOT LIKE '%INGENIERO%'
  AND EXTRACT(YEAR FROM c.fecha_venc_cuota) = EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -12))
GROUP BY
    d.numrun,
    d.dvrun,
    d.pnombre,
    d.appaterno,
    d.apmaterno,
    d.fono_contacto,
    o.nombre_prof_ofic,
    td.cupo_disp_compra
HAVING ROUND(AVG(c.valor_cuota)) < (
    SELECT MAX(promedio_cuotas)
    FROM (
        SELECT ROUND(AVG(c2.valor_cuota)) AS promedio_cuotas
        FROM SYN_CUOTA_TARJETA c2
        GROUP BY c2.nro_tarjeta
    )
);

-- PRIVILEGIOS CASO 2
-- Otorgamos privilegio a Usuario 3 / Consultor / PRY2205_CON para 
-- que pueda ver los datos almacenados.
GRANT SELECT ON VW_ANALISIS_DEUDORES_PERIODO TO PRY2205_EFT_CON;


