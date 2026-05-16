
-- Eliminamos comandos para crear desde 0

DROP USER PRY2205_EFT CASCADE;
DROP USER PRY2205_EFT_DES CASCADE;
DROP USER PRY2205_EFT_CON CASCADE;

DROP ROLE PRY2205_ROL_D;
DROP ROLE PRY2205_ROL_C;

DROP PUBLIC SYNONYM SYN_DEUDOR;
DROP PUBLIC SYNONYM SYN_OCUPACION;
DROP PUBLIC SYNONYM SYN_TARJETA_DEUDOR;
DROP PUBLIC SYNONYM SYN_CUOTA_TARJETA;
DROP PUBLIC SYNONYM SYN_TRANSACCION;
DROP PUBLIC SYNONYM SYN_SUCURSAL;
-- ======================================================
-- USUARIO ADMIN
-- Creamos usuarios, sus roles y privilegios generales
-- ======================================================

    -- Usuario 1 / Owner: es dueño de los objetos del sistema y adminitstración lógica, 
    -- posee todos los privilegios.
    -- Es también quien puede otorgarlos o retirarlos en cualquier momento.
    CREATE USER PRY2205_EFT IDENTIFIED BY "U1_EvaluacionTransversal_S9"
    DEFAULT TABLESPACE DATA
    TEMPORARY TABLESPACE TEMP
    QUOTA 10M ON DATA; -- Cuota del tablespace 'Temp' por defecto 10 MegaBytes
    
    -- Usuario 2 / Usuario genérico: -- Desarrolla informes / vistas
    -- EL usuario será utilizado por el desarrollador con el fin de
    -- de generar consultas a la BD para analizar e implementar las
    -- soluciones del CASO 2.
    CREATE USER PRY2205_EFT_DES IDENTIFIED BY "U2_EvaluacionTransversal_S9"
    DEFAULT TABLESPACE DATA
    TEMPORARY TABLESPACE TEMP
    QUOTA 10M ON DATA;
    
    -- Usuario 3 / : Consume información final.
    -- A diferencia del usuario 2, este usuario no puede crear secuencias
    -- ni procedimientos ni vistas. 
    -- El Usuario 3 solo puede generar consultas
    CREATE USER PRY2205_EFT_CON IDENTIFIED BY "U3_EvaluacionTransversal_S9"
    DEFAULT TABLESPACE DATA
    TEMPORARY TABLESPACE TEMP
    QUOTA 10M ON DATA;

-- PRIVILEGIOS USUARIOS
-- Otorgamos permisos según principio de menor privilegio para cada usuario.
    -- Usuario 1 / Owner
    GRANT CREATE SESSION TO PRY2205_EFT;
    GRANT CREATE TABLE TO PRY2205_EFT;
    GRANT CREATE VIEW TO PRY2205_EFT;
    GRANT CREATE SEQUENCE TO PRY2205_EFT;
    GRANT CREATE SYNONYM TO PRY2205_EFT;
    GRANT CREATE PUBLIC SYNONYM TO PRY2205_EFT;
    GRANT CREATE INDEXTYPE TO PRY2205_EFT;
    
    -- Usuario 2 / Desarrollador
    GRANT CREATE SESSION TO PRY2205_EFT_DES;
    GRANT CREATE VIEW TO PRY2205_EFT_DES;
    GRANT CREATE SEQUENCE TO PRY2205_EFT_DES;
    GRANT CREATE PROCEDURE TO PRY2205_EFT_DES;
    
    -- Usuario 3 / Consultor
    GRANT CREATE SESSION TO PRY2205_EFT_CON;


-- ROLES 
-- Creamos los roles para Desarrollador y Consultor
-- para organizar permisos y administrar seguridad de la BD
CREATE ROLE PRY2205_ROL_D;
CREATE ROLE PRY2205_ROL_C;

-- Otorgamos roles creados para usuario correspondientes
-- para que puedan consultar información de las tablas del usuario EFT
GRANT PRY2205_ROL_D TO PRY2205_EFT_DES;
GRANT PRY2205_ROL_C TO PRY2205_EFT_CON;



