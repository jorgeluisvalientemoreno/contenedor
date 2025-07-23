DECLARE

    -- OSF-4558
    sbSentencia VARCHAR2(32767);
	
	-- Tabla y columna origen del constraint
	sbTabla             VARCHAR2(30)    := UPPER('LDCI_ACTIVOENCURSO');
	sbEsquema           VARCHAR2(30)    := UPPER('OPEN');
	
	sbTableSpaceTabla   VARCHAR2(30)    :=  'TSD_DEFAULT';

    CURSOR CU_DBA_OBJECTS( isbObject VARCHAR2, isbObject_Type VARCHAR2) IS
    SELECT OBJECT_NAME 
    FROM DBA_OBJECTS 
    WHERE OBJECT_NAME = isbObject 
    AND OBJECT_TYPE = isbObject_Type;
    
    rcDBA_OBJECTS CU_DBA_OBJECTS%ROWTYPE;
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;
    
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
    
    PROCEDURE pCreaComentario( isbColumna VARCHAR2, isbComentario VARCHAR2)
    IS
    BEGIN
    
        IF isbColumna IS NULL THEN
            sbSentencia := 'COMMENT ON TABLE ' || sbEsquema || '.' || sbTabla || ' IS '|| '''' ||isbComentario|| '''';
        ELSE
            sbSentencia := 'COMMENT ON COLUMN ' || sbEsquema || sbTabla || '.' || isbColumna || ' IS '|| '''' ||isbComentario|| '''';            
        END IF;
    
        pExecImm( sbSentencia );
        
    END pCreaComentario;
    
begin

    OPEN    CU_DBA_OBJECTS( sbTabla,  'TABLE' );
    FETCH   CU_DBA_OBJECTS INTO rcDBA_OBJECTS;
    CLOSE   CU_DBA_OBJECTS;
    
    IF rcDBA_OBJECTS.OBJECT_NAME IS NULL THEN

        sbSentencia := sbSentencia || 'CREATE TABLE  ' || sbEsquema ||'.' || sbTabla || '
        (
            CODIGO_ACTIVO VARCHAR2(12),
            SUBNUMERO     VARCHAR2(4),
            SOCIEDAD      VARCHAR2(4),
            TEXTO_BREVE   VARCHAR2(50)
        ) TABLESPACE ' || sbTableSpaceTabla;        
		
        pExecImm( sbSentencia  );

        pCreaComentario( null , 'Codigos de activos en curso' );

        pCreaComentario( 'CODIGO_ACTIVO' , 'Codigo de activo' );

        pCreaComentario( 'SUBNUMERO' , 'Subnumero' );

        pCreaComentario( 'SOCIEDAD' , 'Sociedad a la que pertenece el activo' );

        pCreaComentario( 'TEXTO_BREVE' , 'Descripcion del activo' );

    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe TABLA '|| sbEsquema || '.' || sbTabla );
        
    END IF;
     
END;
/
  
DECLARE

    -- OSF-4558
    sbSentencia VARCHAR2(32767);
	
	-- Tabla y columna origen del constraint
	sbTabla    VARCHAR2(30)		        := UPPER('LDCI_ACTIVOENCURSO');
	sbColsLlavePrimaria	VARCHAR2(4000)  := UPPER('CODIGO_ACTIVO,SUBNUMERO,SOCIEDAD');
	sbEsquema   VARCHAR2(30)            := UPPER('OPEN');
		
    sbConstraint_Type 	VARCHAR2(50) 		:= 'P';

    sbConstraintName 		VARCHAR2(30)    := 'PK_TITROIAC'; 

	sbTableSpaceIndice   VARCHAR2(30)    :=  'TSI_DEFAULT';
	
    CURSOR CU_DBA_CONSTRAINTS( isbConstraintName VARCHAR2, isbConstraint_Type VARCHAR2) IS
    SELECT CONSTRAINT_NAME 
    FROM DBA_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = isbConstraintName 
    AND CONSTRAINT_TYPE = isbConstraint_Type;
    
    rcDBA_CONSTRAINTS CU_DBA_CONSTRAINTS%ROWTYPE;
        
    TYPE tyTabla IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;      
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;

        DBMS_OUTPUT.PUT_LINE( 'INFO[' || isbSent || '][OK]' );
                
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'ERROR[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;

    PROCEDURE prcCreaIndicePrimaria
    IS
    BEGIN

        sbSentencia := NULL;
        sbSentencia := sbSentencia || 'CREATE UNIQUE INDEX ' || sbConstraintName || CHR(10);
        sbSentencia := sbSentencia || 'ON ' || sbEsquema ||'.' || sbTabla || '(' || sbColsLlavePrimaria || ') ' || CHR(10);                  
        sbSentencia := sbSentencia || 'TABLESPACE '|| sbTableSpaceIndice || CHR(10); 
		
        pExecImm( sbSentencia  );
        
    END  prcCreaIndicePrimaria;  

	    
    PROCEDURE prcCreaLlavePrimaria
    IS
    BEGIN
    
        prcCreaIndicePrimaria;

        sbSentencia := NULL;
        sbSentencia := sbSentencia || 'ALTER TABLE ' || sbTabla || ' ADD ' || CHR(10);
        sbSentencia := sbSentencia || 'CONSTRAINT ' ||  sbConstraintName || CHR(10);
        sbSentencia := sbSentencia || 'PRIMARY KEY' || '(' || sbColsLlavePrimaria || ') ' || CHR(10);
        sbSentencia := sbSentencia || ' USING INDEX ' || sbConstraintName;                    
		
        pExecImm( sbSentencia  );
        
    END  prcCreaLlavePrimaria;  
        
    FUNCTION fblColsLlavePrimOK RETURN BOOLEAN
    IS
        
        nuCantidadColumnasPk    NUMBER := 0;
        
        sbColumnaPk             VARCHAR2(30);
        
        CURSOR cuDBA_CONS_COLUMNS(inuPosicion NUMBER, isbColumna VARCHAR2)
        IS
        SELECT COLUMN_NAME
        FROM DBA_CONS_COLUMNS
        WHERE OWNER = sbEsquema
        AND CONSTRAINT_NAME = sbConstraintName
        AND TABLE_NAME = sbTabla
        AND COLUMN_NAME = isbColumna
        AND POSITION = inuPosicion;
        
        tbColsLlavePrimaria tStringTable;
       
    BEGIN
    
    
        tbColsLlavePrimaria := ldc_bcConsGenerales.ftbSplitString( sbColsLlavePrimaria, ',' );
        
        FOR indTb IN 1..tbColsLlavePrimaria.COUNT LOOP
        
            sbColumnaPk := NULL;
            
            OPEN cuDBA_CONS_COLUMNS( indTb, tbColsLlavePrimaria(indTb) ) ;
            FETCH cuDBA_CONS_COLUMNS INTO sbColumnaPk;
            CLOSE cuDBA_CONS_COLUMNS;
            
            IF sbColumnaPk IS NOT null THEN
            
                nuCantidadColumnasPk := nuCantidadColumnasPk + 1;
                
            END IF;
                    
        END LOOP;    
            
        RETURN nuCantidadColumnasPk = tbColsLlavePrimaria.COUNT;
    
    END fblColsLlavePrimOK;
    
    
    PROCEDURE prcBorraLlavePrimaria
    IS
    BEGIN

        sbSentencia := NULL;
        sbSentencia := sbSentencia || 'ALTER TABLE '  || sbEsquema || '.' || sbTabla  || CHR(10);              
        sbSentencia := sbSentencia || 'DROP CONSTRAINT '   || sbConstraintName ;                    
        
        pExecImm( sbSentencia  );
                
    END prcBorraLlavePrimaria;   
    
    PROCEDURE prcBorraIndiceLlavePrimaria
    IS

        CURSOR CU_DBA_INDEXES
        IS
        SELECT *
        FROM DBA_INDEXES
        WHERE OWNER = sbEsquema 
        AND INDEX_NAME =  sbConstraintName
        AND TABLE_NAME = sbTabla
        AND UNIQUENESS = 'UNIQUE';
        
        rcDBA_INDEXES   CU_DBA_INDEXES%ROWTYPE;
       
    BEGIN

        OPEN    CU_DBA_INDEXES;
        FETCH   CU_DBA_INDEXES INTO rcDBA_INDEXES;
        CLOSE   CU_DBA_INDEXES;

        IF rcDBA_INDEXES.INDEX_NAME IS NOT NULL THEN
            sbSentencia := NULL;
            sbSentencia := sbSentencia || 'DROP INDEX ' || sbConstraintName;

            pExecImm( sbSentencia  );        

            DBMS_OUTPUT.PUT_LINE( 'INFO[Se borro el indice unico ' || sbConstraintName || ']' );       
            
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'INFO[No existe el indice unico ' || sbConstraintName || ']' );                    
        END IF;

    END prcBorraIndiceLlavePrimaria;
     
    
begin

    OPEN    CU_DBA_CONSTRAINTS( sbConstraintName,  sbConstraint_Type );
    FETCH   CU_DBA_CONSTRAINTS INTO rcDBA_CONSTRAINTS;
    CLOSE   CU_DBA_CONSTRAINTS;
    
    IF rcDBA_CONSTRAINTS.CONSTRAINT_NAME IS NULL THEN
                  
        prcCreaLlavePrimaria;
		       
    ELSE
                
        IF NOT fblColsLlavePrimOK THEN
        
            DBMS_OUTPUT.PUT_LINE( 'INFO[Ya existe Llave Primaria '|| sbEsquema || '.' || sbConstraintName || ' pero no tiene las columnas (' || sbColsLlavePrimaria || ')]' );        
                    
            prcBorraLlavePrimaria;

            prcBorraIndiceLlavePrimaria;
                        
            prcCreaLlavePrimaria;
        
        ELSE

            DBMS_OUTPUT.PUT_LINE( 'INFO[Ya existe Llave Primaria '|| sbEsquema || '.' || sbConstraintName || '(' || sbColsLlavePrimaria || ')]' );        
        
        END IF;
        
    END IF;
     
END;
/
GRANT SELECT ON OPEN.LDCI_ACTIVOENCURSO TO MIGRA;

GRANT DELETE, INSERT, UPDATE ON OPEN.LDCI_ACTIVOENCURSO TO RDMLOPEN;

GRANT SELECT ON OPEN.LDCI_ACTIVOENCURSO TO RGISOSF;

GRANT SELECT ON OPEN.LDCI_ACTIVOENCURSO TO ROLESELOPEN;

GRANT SELECT ON OPEN.LDCI_ACTIVOENCURSO TO RSELOPEN;

GRANT SELECT ON OPEN.LDCI_ACTIVOENCURSO TO RSELUSELOPEN;

GRANT ALTER, DELETE, INSERT, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK ON OPEN.LDCI_ACTIVOENCURSO TO SYSTEM_OBJ_PRIVS_ROLE;
/