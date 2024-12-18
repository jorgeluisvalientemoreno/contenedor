/*****************************************************************
Propiedad intelectual de GDCA


Nombre: crtblHICAESPR.sql
Descripción: Creación de Tabla HICAESPR.

Autor : Isabel Becerra
Fecha : 21.09.2022 (Fecha Creación)  N° Tiquete (OSF-556)

Historia de Modificaciones

Fecha              Autor.                  Modificación
-----------    -------------------    -------------------------------------
21.09.2022         EDMLAR             ACTUALIZACION
******************************************************************/

DECLARE
    /*Constante con el nombre de la Tabla*/
    csbNameEntity VARCHAR2(30) := 'HICAESPR';

    /* Consulta si existe el índice */
    CURSOR cuExistsTable
    IS
        SELECT  COUNT(*)
        FROM    dba_all_tables
        WHERE   TABLE_NAME = UPPER(csbNameEntity);

    /*Variable para almacenar sentencia SQL*/
    sbSql VARCHAR2(2000);

    /* Indica si existe la columna */
    nuExistsTable NUMBER;

    /* Indica si existe el usuario reportes */
    nuExistsReportes NUMBER;

BEGIN

    /*Si el CURSOR se encuentra abierto se procede con su cierre*/
    IF (cuExistsTable%ISOPEN) THEN
        CLOSE cuExistsTable;
    END IF;

    /* Valida si la tabla existe */
    OPEN cuExistsTable;
    FETCH cuExistsTable INTO nuExistsTable;
    CLOSE cuExistsTable;

    IF (nuExistsTable <> 0) THEN

        /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
        dbms_output.put_Line('La Tabla HICAESPR ya existe');

    ELSE

        /* Instrucción para la creación de la tabla */
        sbSql :='CREATE TABLE HICAESPR
           (
            HCETNUSE NUMBER(10,0) NOT NULL ,
          HCETSUSC NUMBER(8,0)  NOT NULL ,
          HCETSERV NUMBER(4,0)  NOT NULL ,
          HCETEPAC NUMBER(3,0)  ,
          HCETEPAN NUMBER(3,0)  ,      
          HCETEFAC VARCHAR2(1)  ,
          HCETEFAN VARCHAR2(1)  ,      
          HCETFECH DATE         NOT NULL ,
          HCETUSUA VARCHAR2(40) NOT NULL ,
          HCETTERM VARCHAR2(60) NOT NULL ,
          HCETPROG VARCHAR2(10) NOT NULL ,
          HCETACAC NUMBER(15,0),
          HCETACAN NUMBER(15,0)
           )';

        /* Ejecuta la instrucción */
        EXECUTE IMMEDIATE sbSql;

        /* Crea los comentarios de los campos y de la tabla */
        EXECUTE IMMEDIATE 'COMMENT ON TABLE HICAESPR IS ''HIST CAMBIO ESTADO FINANCIERO Y ACT. DE SUSP''';

        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETNUSE IS ''Producto''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETSUSC IS ''Contrato''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETSERV IS ''Servicio''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETEPAC IS ''Estado producto actual''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETEPAN IS ''Estado producto anterior''';    
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETEFAC IS ''Estado financiero actual''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETEFAN IS ''Estado financiero anterior''';    
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETFECH IS ''Fecha cambio''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETUSUA IS ''Usuario que efectua el cambio''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETTERM IS ''Terminal donde se efectuo el cambio''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETPROG IS ''Programa que efectuo el cambio''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETACAN IS ''Actividad de suspensión anterior''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN HICAESPR.HCETACAC IS ''Actividad de suspensión actual''';

        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR01 ON HICAESPR (HCETSUSC, HCETNUSE)';
        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR03 ON HICAESPR (HCETFECH, HCETNUSE)';
        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR04 ON HICAESPR (HCETEPAC)';
        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR05 ON HICAESPR (HCETEPAN)';
        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR06 ON HICAESPR (HCETSUSC)';
        EXECUTE IMMEDIATE 'CREATE INDEX IX_HICAESPR07 ON HICAESPR (HCETNUSE)';
        
        /* Crea los grants sobre la tabla*/
        EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON HICAESPR TO SYSTEM_OBJ_PRIVS_ROLE';
        EXECUTE IMMEDIATE 'GRANT SELECT ON HICAESPR TO REPORTES';
        EXECUTE IMMEDIATE 'GRANT SELECT ON HICAESPR TO RSELOPEN';  

        /*Se informa por consola la existencia de la tabla*/
        dbms_output.put_Line('Tabla HICAESPR creada');

    END IF;
END;
/