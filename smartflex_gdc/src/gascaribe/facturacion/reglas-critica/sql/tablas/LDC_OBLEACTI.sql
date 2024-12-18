
DECLARE
    /*Constante con el nombre de la Tabla*/
    csbNameEntity VARCHAR2(50) := 'LDC_OBLEACTI';

    /* Consulta si existe el �ndice */
    CURSOR cuExistsTable
    IS
        SELECT  COUNT(*)
        FROM    DBA_TAB_COLUMNS
        WHERE   TABLE_NAME = UPPER(csbNameEntity)
		 and COLUMN_NAME = 'REGLOBLE';
		
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
        dbms_output.put_Line('La Tabla LDC_OBLEACTI ya existe');
        
    ELSE
        
        /* Instrucci�n para la creaci�n de la tabla */
        sbSql :='alter table LDC_OBLEACTI add REGLOBLE  NUMBER(15)'; 

        /* Ejecuta la instrucci�n */
        EXECUTE IMMEDIATE sbSql;

        delete from LDC_OBLEACTI;
               
        /* Crea los comentarios de los campos y de la tabla por transaccion */
        EXECUTE IMMEDIATE 'ALTER TABLE LDC_OBLEACTI DROP CONSTRAINT PK_LDC_OBLEACTI';
        EXECUTE IMMEDIATE 'ALTER TABLE LDC_OBLEACTI ADD CONSTRAINT PK_LDC_OBLEACTI PRIMARY KEY(OBLECODI, REGLOBLE)';
        EXECUTE IMMEDIATE 'ALTER TABLE LDC_OBLEACTI ADD CONSTRAINT FK_OBLEAC_REGLA FOREIGN KEY (REGLOBLE) REFERENCES LDC_RECROBLE(REOBCODI)';
		EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_OBLEACTI.REGLOBLE is ''Consecutivo de Configuracion de regla''';
        EXECUTE IMMEDIATE 'ALTER TABLE LDC_OBLEACTI ADD ESTACORTE  VARCHAR2(400)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_OBLEACTI.ESTACORTE is ''Estado de corte no permitidos''';
        
    
    END IF;
END;
/