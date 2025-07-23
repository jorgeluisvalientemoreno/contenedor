/***************************************************************** 
Propiedad intelectual de GDC S.A. E.S.P.
Desarrollado por GDC

Nombre: CLIENTES_ESTACIONALES.sql
Descripcion: Creacion de Tabla CLIENTES_ESTACIONALES. 

Autor : Jhon Eduar Erazo Guachavez
Fecha : 4-10-2024

Historia de Modificaciones

Fecha           Autor.                  Modificacion
-----------     -------------------    	-------------------------------------
12-12-2024		jeerazomvm				OSF-3713: 1. Se elimina la llave primaria PK_CLIENEESTAC_CONTRA
												  2. Se agrega la columna FECHA_INACTIVACION
4-10-2024		jerazomvm              	OSF-3241: Creacion
******************************************************************/
PROMPT - Script :   CLIENTES_ESTACIONALES.sql
PROMPT
PROMPT - Creando entidad CLIENTES_ESTACIONALES ...

DECLARE

    /*Constante con el nombre de la Tabla*/
    csbNameEntity VARCHAR2(50) := 'CLIENTES_ESTACIONALES';

    /* Consulta si existe la tabla */
    CURSOR cuExistsTable
    IS
        SELECT  COUNT(*)
        FROM    dba_all_tables
        WHERE   TABLE_NAME = UPPER(csbNameEntity);
		
	/* Consulta si la llave primaria existe*/
	CURSOR cuLlavePrimaria(sbTabla VARCHAR2, sbLlavePrimaria VARCHAR2) 
	IS
		select *
		from user_constraints uc
		where uc.constraint_type = 'P'
		and uc.table_name = sbTabla
		and uc.CONSTRAINT_NAME = sbLlavePrimaria;
		
	rccuLlavePrimaria cuLlavePrimaria%ROWTYPE;
	
	CURSOR cuValidaColumna(sbTabla VARCHAR2, sbColumba VARCHAR2)
	IS
		SELECT 	COUNT(1) 
		FROM all_tab_columns
		WHERE table_name = sbTabla
		AND column_name = sbColumba;
		
	nuExisteColumna	NUMBER;
    
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
	
	/*----------------------------------------- OSF-3713 -----------------------------------------------------------------*/
	
	-- Retira llave primaria de CLIENTES_ESTACIONALES
	OPEN cuLlavePrimaria(csbNameEntity, 'PK_CLIENEESTAC_CONTRA');
	FETCH cuLlavePrimaria INTO rccuLlavePrimaria;
	
	IF (cuLlavePrimaria%FOUND) THEN
		EXECUTE IMMEDIATE 'alter table CLIENTES_ESTACIONALES drop primary key';
		EXECUTE IMMEDIATE 'CREATE INDEX IDX_CLIENTES_ESTACIONALES_01 ON CLIENTES_ESTACIONALES(CONTRATO)';
		Dbms_Output.Put_Line('Se retira llave primaria PK_CLIENEESTAC_CONTRA de la entidad CLIENTES_ESTACIONALES');
		Dbms_Output.Put_Line('Se crea el indice IDX_CLIENTES_ESTACIONALES_01 para la entidad CLIENTES_ESTACIONALES columna CONTRATO');
	ELSE
		Dbms_Output.Put_Line('***************llave primaria PK_CLIENEESTAC_CONTRA No existe');
	END IF;
	CLOSE cuLlavePrimaria;
	
	IF(cuValidaColumna%ISOPEN) THEN
		CLOSE cuValidaColumna;
	END IF;
		
	-- Consulta si la columna FECHA_INACTIVACION existe
	OPEN cuValidaColumna(csbNameEntity, 'FECHA_INACTIVACION');
    FETCH cuValidaColumna INTO nuExisteColumna;
    CLOSE cuValidaColumna;
	
	IF (nuExisteColumna = 0) THEN
		EXECUTE IMMEDIATE 'ALTER TABLE CLIENTES_ESTACIONALES ADD FECHA_INACTIVACION DATE';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN CLIENTES_ESTACIONALES.FECHA_INACTIVACION IS ''Fecha de inactivación''';
		Dbms_Output.Put_Line('Se añade la columna FECHA_INACTIVACION a la entidad CLIENTES_ESTACIONALES');
	ELSE
		Dbms_Output.Put_Line('***************La columna FECHA_INACTIVACION ya existe en la tabla CLIENTES_ESTACIONALES');
	END IF;
	
END;
/