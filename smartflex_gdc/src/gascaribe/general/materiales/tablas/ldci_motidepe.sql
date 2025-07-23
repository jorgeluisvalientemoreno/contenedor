prompt "Creando la tabla open.ldci_motidepe"
declare

    -- OSF-XXXX
    sbSentencia     VARCHAR2(32767);

    sbTabla         VARCHAR2(30)    := UPPER('ldci_motidepe' ); 
    sbEsquema       VARCHAR2(30)    := 'OPEN';    

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
        sbSentencia := sbSentencia || 'MDPECODI  VARCHAR2(4),' || CHR(10);
        sbSentencia := sbSentencia || 'MDPEDESC  VARCHAR2(60) NOT NULL,' || CHR(10);
        sbSentencia := sbSentencia || 'MDPECLDO  VARCHAR2(4))' || CHR(10);
        sbSentencia := sbSentencia || 'TABLESPACE TSD_DEFAULT' || CHR(10);
		
        pExecImm( sbSentencia  );

        --sbSentencia :=  'COMMENT ON TABLE ' || sbEsquema || '.' ||sbTabla || ' IS ' || '''' || 'Contratos por empresa' || '''';
        --pExecImm( sbSentencia  );

        pCreaComenColumna('MDPECODI','Codigo del motivo');

        pCreaComenColumna('MDPEDESC','Descripcion del motivo');

        pCreaComenColumna('MDPECLDO','Clase de Documento');
 		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe la tabla '|| sbEsquema || '.' || sbTabla );
        
    END IF;
     
END;
/
prompt "Creando llave primaria para la tabla open.ldci_motidepe"
DECLARE

    -- OSF-XXXX
    sbSentencia VARCHAR2(32767);
	
	TYPE tytbConstraintTypes IS TABLE OF VARCHAR2(100) index by VARCHAR2(2);
	
	tbConstraintTypes	TYtbConstraintTypes;

	-- Tabla y columna origen del constraint
	sbTableO	VARCHAR2(30)    := UPPER('ldci_motidepe');
	sbColumnO	VARCHAR2(30)    := UPPER('MDPECODI');
	sbEsquemaO  VARCHAR2(30)    := 'OPEN';
	
	-- Tabla y columna destino del foreign key
	sbTableD		VARCHAR2(30)		;
	sbColumnD	VARCHAR2(30)		    ;
	
    sbConstraint_Type 	VARCHAR2(50) 		:= 'P'; -- P : Primary ; R : Foreign ; U : Unique

    sbConstraint_Mnemonico 	VARCHAR2(50) 	:= 'PK'; -- LDCI_MOTIPEDI_PK

    sbNombreRestriccion 		VARCHAR2(30)      	; 

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
    
	FUNCTION fsbCalcPkName ( isbMnemonico VARCHAR2,  isbTableO VARCHAR2 ) RETURN VARCHAR2 IS
	
        sbPkName        VARCHAR2(30);
                        
	BEGIN
	               
        sbPkName :=   isbTableO || sbSeparador || isbMnemonico;
        
        RETURN sbPkName;
        
	END fsbCalcPkName;    
		
	FUNCTION fsbCalcConstraintName RETURN VARCHAR2 IS
        sbNombreRestriccion VARCHAR2(30);
	BEGIN
	
        sbNombreRestriccion    :=  fsbCalcPkName ( sbConstraint_Mnemonico,  sbTableO ); 
        
        RETURN sbNombreRestriccion;
	
	END fsbCalcConstraintName;
    
begin

	pCargaTbConstraintTypes;

    IF sbNombreRestriccion IS NULL THEN
        sbNombreRestriccion    :=  fsbCalcConstraintName; 
    END IF;
    
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
                
            ELSE
                DBMS_OUTPUT.PUT_LINE( 'ERROR[No se puede crear el constraint porque no se ha definido el tipo]' );
                               
        END CASE;
		
        pExecImm( sbSentencia  );
		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe '|| sbEsquemaO || '.' || sbNombreRestriccion );
        
    END IF;
     
END;
/

Prompt Agregando columna open.ldci_motidepe.empresa
DECLARE

    -- OSF-4259
    sbEsquema   VARCHAR2(30 ) := 'OPEN';
    sbTabla      VARCHAR2(30 ) :=  UPPER('ldci_motidepe' );
    sbColumna   VARCHAR2(30 ) := 'EMPRESA';
    
    sbComando   VARCHAR2(2000);
    sbSentencia VARCHAR2(2000);
    
    CURSOR cuDba_Tab_COLUMNS
    IS
    SELECT *
    FROM dba_tab_columns
    WHERE owner = sbEsquema
    AND table_name = sbTabla
    AND column_name = sbColumna;
    
    rcDba_Tab_COLUMNS   cuDba_Tab_COLUMNS%ROWTYPE;

    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;

        DBMS_OUTPUT.PUT_LINE( 'INFO[ OK [' || isbSent || ']]' );
                
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
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
    
BEGIN

    OPEN cuDba_Tab_COLUMNS;
    FETCH cuDba_Tab_COLUMNS INTO rcDba_Tab_COLUMNS;
    CLOSE cuDba_Tab_COLUMNS;
    
    IF rcDba_Tab_COLUMNS.COLUMN_NAME IS NULL THEN
    
        sbComando := 'ALTER TABLE '|| sbEsquema || '.' || sbTabla || ' ADD ' || sbColumna || ' VARCHAR2(10)';
        
        pExecImm( sbComando );
            
        pCreaComenColumna( sbColumna, 'Empresa' ) ;

    ELSE
        dbms_output.put_line('INFO[Ya existe ' || sbEsquema || '.' || sbTabla || '.' || sbColumna );
    END IF;

END;
/

BEGIN

    dbms_output.put_line('Otorgando permisos sobre ldci_motidepe a MIGRA, ROLESELOPEN, RSELOPEN, RSELUSELOPEN');
    EXECUTE IMMEDIATE ('GRANT SELECT ON OPEN.ldci_motidepe TO MIGRA, ROLESELOPEN, RSELOPEN,RSELUSELOPEN ');

    dbms_output.put_line('Otorgando permisos sobre ldci_motidepe a RDMLOPEN');
    EXECUTE IMMEDIATE ('GRANT DELETE, INSERT, UPDATE ON OPEN.ldci_motidepe TO RDMLOPEN');

    dbms_output.put_line('Otorgando permisos sobre ldci_motidepe a PERSONALIZACIONES y SYSTEM_OBJ_PRIVS_ROLE');
    pkg_utilidades.prAplicarPermisos( upper('ldci_motidepe') , 'OPEN');
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR['|| SQLERRM || ']');
END;
/
