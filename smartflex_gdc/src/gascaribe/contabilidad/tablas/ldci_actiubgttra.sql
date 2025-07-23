DECLARE

    -- OSF-4558
    sbSentencia VARCHAR2(32767);
	
	-- Tabla y columna origen del constraint
	sbTabla             VARCHAR2(30)    := UPPER('LDCI_ACTIUBGTTRA');
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
            sbSentencia := 'COMMENT ON COLUMN ' || sbEsquema || '.' || sbTabla || '.' || isbColumna || ' IS '|| '''' ||isbComentario|| '''';            
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
            ACBGDPTO  NUMBER(6),
            ACBGLOCA  NUMBER(6),
            ACBGTITR  NUMBER(10),
            ACBGACTI  VARCHAR2(12),
            ACBGSUBN  VARCHAR2(4),
            ACBGORIN  VARCHAR2(10)
        ) TABLESPACE ' || sbTableSpaceTabla;        
		
        pExecImm( sbSentencia  );

        pCreaComentario( NULL       ,   'Activo por Localidad por Tipo de Trabajo' );
        pCreaComentario( 'ACBGDPTO' ,   'Codigo del departamento' );
        pCreaComentario( 'ACBGLOCA' ,   'Codigo de la localidad' );
        pCreaComentario( 'ACBGTITR' ,   'Codigo del Tipo de Trabajo' );
        pCreaComentario( 'ACBGACTI' ,   'Codigo del Activo' );
        pCreaComentario( 'ACBGSUBN' ,   'Codigo del Subnumero' );
        pCreaComentario( 'ACBGORIN' ,   'Numero de la orden interna estadistica SAP' );
        
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe TABLA '|| sbEsquema || '.' || sbTabla );
        
    END IF;
     
END;
/

DECLARE

    -- OSF-4558
    sbSentencia VARCHAR2(32767);
	
	-- Tabla y columna origen del constraint
	sbTabla    VARCHAR2(30)		        := UPPER('LDCI_ACTIUBGTTRA');
	sbColsLlavePrimaria	VARCHAR2(4000)  := UPPER('ACBGDPTO,ACBGLOCA,ACBGTITR,ACBGACTI');
	sbEsquema   VARCHAR2(30)            := UPPER('OPEN');
		
    sbConstraint_Type 	VARCHAR2(50) 		:= 'P';

    sbConstraintName 		VARCHAR2(30)    := 'PK_LDCI_ACTIUBGTTRA'; 

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


DECLARE

    sbSentencia VARCHAR2(32767);
	
	TYPE tytbConstraintTypes IS TABLE OF VARCHAR2(100) index by VARCHAR2(2);
	
	tbConstraintTypes	TYtbConstraintTypes;

	-- Tabla y columna origen del constraint
	sbTablaOrigen		VARCHAR2(30)		:= UPPER('LDCI_ORDENINTERNA');
	sbColumnasOrigen	VARCHAR2(2000)        := UPPER('CODI_ORDEINTERNA');
	
	-- Tabla y columna destino del foreign key
	sbTablaDestino		VARCHAR2(30)		:= UPPER('LDCI_ACTIUBGTTRA');
	sbColumnasDestino	VARCHAR2(2000)		:= UPPER('ACBGORIN');
	
    sbConstraintName 		VARCHAR2(30)    := UPPER('FK_ORDEINTEACTI'); 

    CURSOR CU_DBA_CONSTRAINTS_R IS
    SELECT CONSTRAINT_NAME 
    FROM DBA_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = sbConstraintName 
    AND CONSTRAINT_TYPE = 'R';
    
    rcDBA_CONSTRAINTS_R CU_DBA_CONSTRAINTS_R%ROWTYPE;
    

    TYPE tyTabla IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;      
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;
    
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
	        
begin


    OPEN    CU_DBA_CONSTRAINTS_R;
    FETCH   CU_DBA_CONSTRAINTS_R INTO rcDBA_CONSTRAINTS_R;
    CLOSE   CU_DBA_CONSTRAINTS_R;
    
    IF rcDBA_CONSTRAINTS_R.CONSTRAINT_NAME IS NULL THEN
    
        sbSentencia := sbSentencia || 'ALTER TABLE ' || sbTablaDestino || ' ADD ';
        sbSentencia := sbSentencia || 'CONSTRAINT ' ||  sbConstraintName || CHR(10);
        sbSentencia := sbSentencia || 'FOREIGN KEY ' || '(' || sbColumnasDestino || ') '|| CHR(10);
        sbSentencia := sbSentencia || 'REFERENCES ' || sbTablaOrigen|| '(' || sbColumnasOrigen || ')'|| CHR(10);
        sbSentencia := sbSentencia || 'ENABLE NOVALIDATE';    
      		
        pExecImm( sbSentencia  );
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe ' || sbConstraintName );
        
    END IF;
     
END;
/  


DECLARE

    -- OSF-4558
    sbSentencia VARCHAR2(32767);
	
	-- Tabla y columna origen del constraint
	sbTabla             VARCHAR2(30)    := UPPER('LDCI_ACTIUBGTTRA');
	sbEsquema           VARCHAR2(30)    := UPPER('OPEN');
	
    sbNuevasColumnas        VARCHAR2(4000)  :=  'ACBGSOCI' ;
    sbTiposColumnas          VARCHAR2(4000)  :=  'VARCHAR2(10)';
    sbComentarioColumnas    VARCHAR2(4000)  :=  'Sociedad a la que pertenece el activo';
	
    CURSOR CU_DBA_TABLES IS
    SELECT TABLE_NAME 
    FROM DBA_TABLES 
    WHERE OWNER =  sbEsquema
    AND TABLE_NAME = sbTabla;
    
    rcDBA_TABLES CU_DBA_TABLES%ROWTYPE;
    
    CURSOR cuDBA_TAB_COLUMNS( isbColumna VARCHAR2)
    IS
    SELECT column_name, data_length
    FROM DBA_TAB_COLUMNS
    WHERE owner = sbEsquema
    AND table_name = sbTabla
    AND column_name = isbColumna;
    
    rcDBA_TAB_COLUMNS cuDBA_TAB_COLUMNS%ROWTYPE;

    tbNuevasColumnas        tStringTable;
    tbTiposColumnas          tStringTable;
    tbComentarioColumnas    tStringTable;
    
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
            sbSentencia := 'COMMENT ON COLUMN ' || sbEsquema || '.' || sbTabla || '.' || isbColumna || ' IS '|| '''' ||isbComentario|| '''';            
        END IF;
    
        pExecImm( sbSentencia );
        
    END pCreaComentario;
    
begin

    OPEN    CU_DBA_TABLES;
    FETCH   CU_DBA_TABLES INTO rcDBA_TABLES;
    CLOSE   CU_DBA_TABLES;
    
    IF rcDBA_TABLES.TABLE_NAME IS NOT NULL THEN
    
        tbNuevasColumnas := ldc_bcConsGenerales.ftbSplitString( sbNuevasColumnas, '|' );
        tbTiposColumnas := ldc_bcConsGenerales.ftbSplitString( sbTiposColumnas, '|' );
        tbComentarioColumnas := ldc_bcConsGenerales.ftbSplitString( sbComentarioColumnas, '|' );
            
        FOR indTb IN 1..tbNuevasColumnas.COUNT LOOP
        
            OPEN cuDBA_TAB_COLUMNS( tbNuevasColumnas(indTb));
            FETCH cuDBA_TAB_COLUMNS INTO rcDBA_TAB_COLUMNS;
            CLOSE cuDBA_TAB_COLUMNS;
        
            IF rcDBA_TAB_COLUMNS.COLUMN_NAME IS NULL THEN
            
                sbSentencia := NULL;
                sbSentencia := sbSentencia || 'ALTER TABLE  ' || sbEsquema ||'.' || sbTabla || ' ADD (';
                sbSentencia := sbSentencia || tbNuevasColumnas(indTb) || ' ' ||  tbTiposColumnas  (indTb) || ')';         
                      
                pExecImm( sbSentencia  );

                pCreaComentario(  tbNuevasColumnas(indTb),tbComentarioColumnas(indTb) );
                                
                
            ELSE
                DBMS_OUTPUT.PUT_LINE( 'INFO[Ya existe la columna '|| sbEsquema || '.' || sbTabla || '.' || tbNuevasColumnas(indTb) || ']');        

                IF rcDBA_TAB_COLUMNS.DATA_LENGTH < 10 THEN

                    DBMS_OUTPUT.PUT_LINE( 'INFO[El tamaño de la columna '|| sbEsquema || '.' || sbTabla || '.' || tbNuevasColumnas(indTb) || '] es menor a 10');        
                
                    sbSentencia := NULL;
                    sbSentencia := sbSentencia || 'ALTER TABLE  ' || sbEsquema ||'.' || sbTabla || ' MODIFY ' || tbNuevasColumnas(indTb)  ||  ' ' || tbTiposColumnas(indTb);

                    pExecImm( sbSentencia  );
                    
                    DBMS_OUTPUT.PUT_LINE( 'INFO[Se aumento a 10 El tamaño de la columna '|| sbEsquema || '.' || sbTabla || '.' || tbNuevasColumnas(indTb) || ']');        
                
                ELSE
                    DBMS_OUTPUT.PUT_LINE( 'INFO[El tamaño de la columna '|| sbEsquema || '.' || sbTabla || '.' || tbNuevasColumnas(indTb) || '] es ['||rcDBA_TAB_COLUMNS.DATA_LENGTH|| ']' );     
                
                END IF;
                
            END IF;
            
        END LOOP;
        
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'ERROR[NO existe TABLA '|| sbEsquema || '.' || sbTabla || ']');
        
    END IF;
     
END;
/

DECLARE

    sbSentencia VARCHAR2(32767);
	
	TYPE tytbConstraintTypes IS TABLE OF VARCHAR2(100) index by VARCHAR2(2);
	
	tbConstraintTypes	TYtbConstraintTypes;

	-- Tabla y columna origen del constraint
	sbTablaOrigen		VARCHAR2(30)		:= UPPER('ldci_activoencurso');
	sbColumnasOrigen	VARCHAR2(2000)        := UPPER('CODIGO_ACTIVO,SUBNUMERO,SOCIEDAD');
	
	-- Tabla y columna destino del foreign key
	sbTablaDestino		VARCHAR2(30)		:= UPPER('ldci_actiubgttra');
	sbColumnasDestino	VARCHAR2(2000)		:= UPPER('ACBGACTI,ACBGSUBN,ACBGSOCI');
	
    sbConstraintName 		VARCHAR2(30)    := UPPER('fk_actiubgttra'); 

    CURSOR CU_DBA_CONSTRAINTS_R IS
    SELECT CONSTRAINT_NAME 
    FROM DBA_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = sbConstraintName 
    AND CONSTRAINT_TYPE = 'R';
    
    rcDBA_CONSTRAINTS_R CU_DBA_CONSTRAINTS_R%ROWTYPE;
    

    TYPE tyTabla IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;      
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;
    
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
	    
    
begin


    OPEN    CU_DBA_CONSTRAINTS_R;
    FETCH   CU_DBA_CONSTRAINTS_R INTO rcDBA_CONSTRAINTS_R;
    CLOSE   CU_DBA_CONSTRAINTS_R;
    
    IF rcDBA_CONSTRAINTS_R.CONSTRAINT_NAME IS NULL THEN
    
        sbSentencia := sbSentencia || 'ALTER TABLE ' || sbTablaDestino || ' ADD ';
        sbSentencia := sbSentencia || 'CONSTRAINT ' ||  sbConstraintName || CHR(10);
        sbSentencia := sbSentencia || 'FOREIGN KEY ' || '(' || sbColumnasDestino || ') ';
        sbSentencia := sbSentencia || 'REFERENCES ' || sbTablaOrigen|| '(' || sbColumnasOrigen || ')';    
      		
        pExecImm( sbSentencia  );
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe ' || sbConstraintName );
        
    END IF;
     
END;
/
  

GRANT SELECT ON OPEN.LDCI_ACTIUBGTTRA TO MIGRA;
GRANT DELETE, INSERT, UPDATE ON OPEN.LDCI_ACTIUBGTTRA TO RDMLOPEN;
GRANT SELECT ON OPEN.LDCI_ACTIUBGTTRA TO RGISOSF;
GRANT SELECT ON OPEN.LDCI_ACTIUBGTTRA TO ROLESELOPEN;
GRANT SELECT ON OPEN.LDCI_ACTIUBGTTRA TO RSELOPEN;
GRANT SELECT ON OPEN.LDCI_ACTIUBGTTRA TO RSELUSELOPEN;
GRANT DELETE, INSERT, SELECT, UPDATE ON OPEN.LDCI_ACTIUBGTTRA TO SYSTEM_OBJ_PRIVS_ROLE;
/


