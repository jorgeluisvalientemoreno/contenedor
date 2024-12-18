
DECLARE
    /*Constante con el nombre de la Tabla*/
    csbNameEntity VARCHAR2(50) := 'LDC_RECROBLE';

    /* Consulta si existe el �ndice */
    CURSOR cuExistsTable
    IS
        SELECT  COUNT(*)
        FROM    dba_all_tables
        WHERE   TABLE_NAME = UPPER(csbNameEntity);
		
	/* Consulta si el usuario REPORTES existe */
    CURSOR cuExisteReportes
    IS
        SELECT  COUNT(*)
        FROM    all_users 
        WHERE username = 'REPORTES';
    
    /*Variable para almacenar sentencia SQL*/
    sbSql VARCHAR2(2000);

    /* Indica si existe la tabla */
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
        dbms_output.put_Line('La Tabla LDC_CONFAUTO_FACT ya existe');
        
    ELSE
        
        /* Instrucci�n para la creaci�n de la tabla */
        sbSql :='
        CREATE TABLE LDC_RECROBLE 
				(	REOBCODI NUMBER(15,0) NOT NULL ENABLE, 
				  REOBDESC VARCHAR2(500 BYTE) NOT NULL ENABLE, 
				  REOBREOB NUMBER(15,0), 
				 CONSTRAINT PK_LDC_RECROBLE PRIMARY KEY (REOBCODI), 
				CONSTRAINT FK_CALI_REGLA FOREIGN KEY (REOBCODI)
				REFERENCES LDC_CALIFICACION_CONS (CONSECUTIVO) ENABLE
				)'; 

        /* Ejecuta la instrucci�n */
        EXECUTE IMMEDIATE sbSql;
                
        /* Crea los comentarios de los campos y de la tabla por transaccion */
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_RECROBLE.REOBCODI IS ''Consecutivo de Configuracion de regla''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_RECROBLE.REOBDESC IS ''Descripcion de la regla''';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_RECROBLE.REOBREOB IS ''Recurrencia de las observaciones''';
        EXECUTE IMMEDIATE 'COMMENT ON TABLE LDC_RECROBLE IS ''Reglas de observaciones de no lectura''';
        
        /* Crea los grants sobre la tabla*/
        EXECUTE IMMEDIATE 'GRANT SELECT,UPDATE,DELETE,INSERT ON LDC_RECROBLE TO SYSTEM_OBJ_PRIVS_ROLE';
		
		EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_RECROBLE TO RSELOPEN';
		
		IF (cuExisteReportes%ISOPEN) THEN
            CLOSE cuExisteReportes;
        END IF;        
        OPEN cuExisteReportes;
        FETCH cuExisteReportes INTO nuExistsReportes;
        CLOSE cuExisteReportes;
        
        /* Asigna permisos al usuario de reportes, si existe */
        IF (nuExistsReportes > 0) THEN
            EXECUTE IMMEDIATE 'GRANT SELECT ON LDC_RECROBLE TO REPORTES';
        END IF;
        
        /*Se informa por consola la existencia de la tabla*/
        dbms_output.put_Line('Tabla LDC_RECROBLE creada');
    
    END IF;
END;
/