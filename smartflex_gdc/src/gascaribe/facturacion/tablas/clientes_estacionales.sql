/***************************************************************** 
Propiedad intelectual de GDC S.A. E.S.P.
Desarrollado por GDC

Nombre: CLIENTES_ESTACIONALES.sql
Descripcion: Creacion de Tabla CLIENTES_ESTACIONALES. 

Autor : Jhon Eduar Erazo Guachavez
Fecha : 4-10-2024

Historia de Modificaciones

Fecha           Autor.                  Modificacion
-----------     -------------------    -------------------------------------
4-10-2024		jerazomvm              OSF-3241: Creacion
******************************************************************/
PROMPT - Script :   CLIENTES_ESTACIONALES.sql
PROMPT
PROMPT - Creando entidad CLIENTES_ESTACIONALES ...

DECLARE
    /*Constante con el nombre de la Tabla*/
    csbNameEntity VARCHAR2(50) := 'CLIENTES_ESTACIONALES';

    /* Consulta si existe el indice */
    CURSOR cuExistsTable
    IS
        SELECT  COUNT(*)
        FROM    dba_all_tables
        WHERE   TABLE_NAME = UPPER(csbNameEntity);
    
    /*Variable para almacenar sentencia SQL*/
    sbSql VARCHAR2(2000);

    /* Indica si existe la tabla */
    nuExistsTable NUMBER;
    
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
        dbms_output.put_Line('La Tabla CLIENTES_ESTACIONALES ya existe');
        
    ELSE
        
        /* Instruccion para la creacion de la tabla */
        sbSql :='
        CREATE TABLE CLIENTES_ESTACIONALES (
			CONTRATO NUMBER(8) NOT NULL,
            PRODUCTO NUMBER(15) NOT NULL,
            FECHA_REGISTRO DATE NOT NULL,
            FECHA_INICIAL_VIGENCIA DATE NOT NULL,
            FECHA_FINAL_VIGENCIA DATE NOT NULL,
            ACTIVO VARCHAR2(1) NOT NULL)'; 

        /* Ejecuta la instrucci�n */
        EXECUTE IMMEDIATE sbSql;
                
        /* Crea los comentarios de los campos y de la tabla por transaccion */
        EXECUTE IMMEDIATE 'COMMENT ON TABLE CLIENTES_ESTACIONALES IS ''CONFIGURACION DE PROCESOS AUTOMATICOS DE FACTURACION X CICLO''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.CONTRATO IS ''Identificador del contrato''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.PRODUCTO IS ''Identificador del producto de gas''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.FECHA_REGISTRO IS ''Fecha de registro''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.FECHA_INICIAL_VIGENCIA IS ''Fecha inicial de vigencia''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.FECHA_FINAL_VIGENCIA IS ''Fecha final de vigencia''';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.ACTIVO IS ''Activo''';
		
		EXECUTE IMMEDIATE 'ALTER TABLE CLIENTES_ESTACIONALES ADD CONSTRAINT PK_CLIENEESTAC_CONTRA PRIMARY KEY (CONTRATO)';
		EXECUTE IMMEDIATE 'ALTER TABLE CLIENTES_ESTACIONALES ADD CONSTRAINT CK_CLIENEESTAC_ACTI CHECK(ACTIVO IN(''Y'',''N''))';
        
        /* Crea los grants sobre la tabla*/
        --EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON CLIENTES_ESTACIONALES TO SYSTEM_OBJ_PRIVS_ROLE';
		
		BEGIN
			pkg_utilidades.prAplicarPermisos('CLIENTES_ESTACIONALES','OPEN');
		END;
		
		BEGIN
			pkg_Utilidades.prCrearSinonimos(upper('CLIENTES_ESTACIONALES'), 'OPEN');
		END;
        
        /*Se informa por consola la existencia de la tabla*/
        dbms_output.put_Line('Tabla CLIENTES_ESTACIONALES creada');
    
    END IF;
END;
/