declare

    -- OSF-3987
    sbSentencia     VARCHAR2(32767);

    sbTabla         VARCHAR2(30)    := 'SECUENCIA_TIPODOCU_EMFAEL'; 
    sbEsquema       VARCHAR2(30)    := 'PERSONALIZACIONES';    

    CURSOR CU_DBA_TABLES
    (
        isbTabla    VARCHAR2,
        isbEsquema  VARCHAR2
    ) IS
    SELECT TABLE_NAME 
    FROM DBA_TABLES 
    WHERE TABLE_NAME = isbTabla 
    AND OWNER = isbEsquema;
    
    rcDBA_TABLES CU_DBA_TABLES%ROWTYPE;
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;

        DBMS_OUTPUT.PUT_LINE( 'INFO:Ok[' || sbSentencia || ']');
            
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'ERROR[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
        
    PROCEDURE pCreaComenColumna
    (
        isbColumna      VARCHAR2,
        isbComentario   VARCHAR2
    )
    IS
    BEGIN
    
        sbSentencia :=  'COMMENT ON COLUMN ' || sbEsquema || '.' ||sbTabla || '.' || isbColumna || ' IS ' || '''' || isbComentario || '''';
        pExecImm( sbSentencia  );    
        
    END pCreaComenColumna;

begin

    OPEN    CU_DBA_TABLES( sbTabla, sbEsquema);
    FETCH   CU_DBA_TABLES INTO rcDBA_TABLES;
    CLOSE   CU_DBA_TABLES;
    
    IF rcDBA_TABLES.TABLE_NAME IS NULL THEN
        
        sbSentencia := NULL;
    
        sbSentencia := sbSentencia || 'CREATE TABLE ' || sbEsquema || '.' || sbTabla || CHR(10);
        sbSentencia := sbSentencia || '(' || CHR(10);
        sbSentencia := sbSentencia || 'EMPRESA             		VARCHAR2(10),' || CHR(10);
        sbSentencia := sbSentencia || 'TIPO_DOCUMENTO           NUMBER(15,0),' || CHR(10);
        sbSentencia := sbSentencia || 'NOMBRE_SECUENCIA         VARCHAR2(30)' || CHR(10)||')';
        sbSentencia := sbSentencia || 'TABLESPACE TSD_DEFAULT' || CHR(10);        

		
        pExecImm( sbSentencia  );

        sbSentencia :=  'COMMENT ON TABLE ' || sbEsquema || '.' ||sbTabla || ' IS ' || '''' || 'Secuencia tipo documento por empresa - factura electronica' || '''';
        pExecImm( sbSentencia  );

        pCreaComenColumna('EMPRESA', 'Codigo de empresa para la secuencia');
        pCreaComenColumna('TIPO_DOCUMENTO', 'Tipo documento factura electronica');        
        pCreaComenColumna('NOMBRE_SECUENCIA', 'Nombre de la secuencia');     
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe la tabla '|| sbEsquema || '.' || sbTabla );
        
    END IF;
     
END;
/
-- Crear llave Primaria
DECLARE

    sbSentencia VARCHAR2(32767);
	
	TYPE tytbConstraintTypes IS TABLE OF VARCHAR2(100) index by VARCHAR2(2);
	
	tbConstraintTypes	TYtbConstraintTypes;

	-- Tabla y columna origen del constraint
	sbTableO	VARCHAR2(30)    := UPPER('SECUENCIA_TIPODOCU_EMFAEL');
	sbColumnO	VARCHAR2(30)    := UPPER('EMPRESA'||','||'TIPO_DOCUMENTO');
	sbEsquemaO  VARCHAR2(30)    := 'PERSONALIZACIONES';
	
	-- Tabla y columna destino del foreign key
	sbTableD	VARCHAR2(30)		;
	sbColumnD	VARCHAR2(30)		;
	
    sbConstraint_Type 	VARCHAR2(50) 		:= 'P';

    sbConstraint_Mnemonico 	VARCHAR2(50) 	:= 'PK';

    sbNombreRestriccion 	VARCHAR2(30)    ; 

    CURSOR CU_DBA_CONSTRAINTS
    ( 
        isbNombreRestriccion VARCHAR2, 
        isbConstraint_Type VARCHAR2,
        isbEsquema  VARCHAR2
    ) IS
    SELECT CONSTRAINT_NAME 
    FROM DBA_CONSTRAINTS 
    WHERE CONSTRAINT_NAME = isbNombreRestriccion 
    AND CONSTRAINT_TYPE = isbConstraint_Type
    AND OWNER = isbEsquema;
    
    rcDBA_CONSTRAINTS CU_DBA_CONSTRAINTS%ROWTYPE;
    
    sbSeparador VARCHAR2(1) := '_';  
    
    TYPE tyTabla IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;      
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;
    
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
	
	PROCEDURE pCargaTbConstraintTypes IS
	BEGIN

		tbConstraintTypes('PK') := 	'PRIMARY KEY';	
		tbConstraintTypes('FK') := 	'FOREIGN KEY';
		tbConstraintTypes('UK') :=	'UNIQUE KEY';		
		tbConstraintTypes('NN')	:= 	'NOT NULL';
		tbConstraintTypes('CC')	:= 	'CHECK CONSTRAINT';
		
	END pCargaTbConstraintTypes;
	    
    PROCEDURE ParseString (ivaCadena  IN  VARCHAR2,
                           ivaToken   IN  VARCHAR2,
                           otbSalida  OUT tyTabla 
                          ) 
    IS
        
        sbCadena          VARCHAR2(32767) := ivaCadena;
        nuIndArgumentos   NUMBER := 1;
        
    BEGIN
        
        WHILE sbCadena IS NOT NULL LOOP
          
              dbms_output.put_line(sbCadena);
              
              IF instr(sbCadena, ivaToken,1) > 0 THEN
              
                otbSalida(nuIndArgumentos) := substr( sbCadena, 1, instr(sbCadena, ivaToken,1) -1);
                
                sbCadena := substr( sbCadena, instr(sbCadena, ivaToken,1)+1);
              
              ELSE
                
                otbSalida(nuIndArgumentos) := sbCadena;
                
                sbCadena := NULL;             
                
              END IF;
                            
              nuIndArgumentos := nuIndArgumentos + 1;                            
            
        END LOOP;
        
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END ParseString;
    
    FUNCTION fsbTableMnemo( isbTabla VARCHAR) RETURN VARCHAR2 IS
        tbTabla tyTabla;
        
        sbTableMnemo    VARCHAR2(30);
        
    BEGIN
    
        tbTabla.Delete;
        
        ParseString( isbTabla, sbSeparador, tbTabla );    
        
        CASE tbTabla.count
            
            WHEN 4 then
        
                sbTableMnemo := tbTabla(1) || sbSeparador || 
                                tbTabla(2) || sbSeparador ||
                                SUBSTR(tbTabla(3),1,2) ||                               
                                SUBSTR(tbTabla(4),1,2);
            
            WHEN 3 then            
        
                sbTableMnemo := tbTabla(1) || sbSeparador || 
                                SUBSTR(tbTabla(2),1,2) ||                           
                                SUBSTR(tbTabla(3),1,2);

            WHEN 2 then            
        
                sbTableMnemo := tbTabla(1) || sbSeparador || 
                                SUBSTR(tbTabla(2),1,4);
                                
            WHEN 1 then            
        
                sbTableMnemo := SUBSTR(tbTabla(1),1,4);   
                
            ELSE
            
                sbTableMnemo := SUBSTR(isbTabla,1,4); 
                                
        END CASE;                             
        
        RETURN sbTableMnemo;
    
    END fsbTableMnemo;
    
	FUNCTION fsbCalcPkName ( isbMnemonico VARCHAR2,  isbTableO VARCHAR2 ) RETURN VARCHAR2 IS
	
        sbPkName        VARCHAR2(30);
                        
	BEGIN
	               
        sbPkName := isbMnemonico || sbSeparador || isbTableO ;
        
        RETURN sbPkName;
        
	END fsbCalcPkName;    
	
	FUNCTION fsbCalcFkName ( isbMnemonico VARCHAR2,  isbTableO VARCHAR2, isbTableD VARCHAR2) RETURN VARCHAR2 IS
	
        sbFkName        VARCHAR2(30);
        
        sbTableOMnemo   VARCHAR2(30);
        
        sbTableDMnemo   VARCHAR2(30);
                
	BEGIN
	        
        sbTableOMnemo := fsbTableMnemo( isbTableO );

        sbTableDMnemo := fsbTableMnemo( isbTableD );
        
        sbFkName := isbMnemonico || sbSeparador || sbTableOMnemo || sbSeparador || sbTableDMnemo ;
        
        RETURN sbFkName;
        
	END fsbCalcFkName;
	
	FUNCTION fsbCalcConstraintName RETURN VARCHAR2 IS
        sbNombreRestriccion VARCHAR2(30);
	BEGIN
	
        CASE sbConstraint_Mnemonico 
            WHEN 'PK' THEN
                sbNombreRestriccion    :=  fsbCalcPkName ( sbConstraint_Mnemonico,  sbTableO ); 
            WHEN 'FK' THEN
                sbNombreRestriccion    :=  fsbCalcFkName ( sbConstraint_Mnemonico,  sbTableO , sbTableD ); 
        END CASE;
        
        RETURN sbNombreRestriccion;
	
	END fsbCalcConstraintName;
    
begin

	pCargaTbConstraintTypes;

    sbNombreRestriccion    :=  fsbCalcConstraintName; 

    OPEN    CU_DBA_CONSTRAINTS( sbNombreRestriccion,  sbConstraint_Type, sbEsquemaO );
    FETCH   CU_DBA_CONSTRAINTS INTO rcDBA_CONSTRAINTS;
    CLOSE   CU_DBA_CONSTRAINTS;
    
    IF rcDBA_CONSTRAINTS.CONSTRAINT_NAME IS NULL THEN

        CASE sbConstraint_Mnemonico 
        
            WHEN 'PK' THEN
            
                sbSentencia := sbSentencia || 'ALTER TABLE ' || sbEsquemaO || '.' || sbTableO || ' ADD (';
                sbSentencia := sbSentencia || 'CONSTRAINT ' ||  sbNombreRestriccion || CHR(10);
                sbSentencia := sbSentencia || tbConstraintTypes(sbConstraint_Mnemonico) || '(' || sbColumnO || ') ';
                sbSentencia := sbSentencia || 'USING INDEX TABLESPACE TSI_DEFAULT'|| CHR(10);
                sbSentencia := sbSentencia || ')'|| CHR(10);  
                    
            WHEN 'FK' THEN
    
                sbSentencia := sbSentencia || 'ALTER TABLE ' || sbEsquemaO || '.'|| sbTableO || ' ADD (';
                sbSentencia := sbSentencia || 'CONSTRAINT ' ||  sbNombreRestriccion || CHR(10);
                sbSentencia := sbSentencia || tbConstraintTypes(sbConstraint_Mnemonico) || '(' || sbColumnO || ') ';
                sbSentencia := sbSentencia || 'REFERENCES ' || sbTableD|| '(' || sbColumnD || ')';
                sbSentencia := sbSentencia || ')';          
      
        END CASE;
		
        pExecImm( sbSentencia  );
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe '|| sbEsquemaO || '.' || sbNombreRestriccion );
        
    END IF;
     
END;
/

