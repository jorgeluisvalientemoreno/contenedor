REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		ldc_susp_autoreco.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		30-03-2023
REM Descripcion	 :		Se crea la columna LDC_SUSP_AUTORECO.SAREPROC
REM				 :		Se actualiza LDC_SUSP_AUTORECO.SAREPROC
REM				 :		Se crea constraint not null sobre LDC_SUSP_AUTORECO.SAREPROC
REM				 :		Se crea índice sobre LDC_SUSP_AUTORECO.SAREPROC
REM Caso	     :		OSF-962
REM Historia Modificaciones
REM AUTOR			FECHA		DESCRIPCION
DECLARE
    
    sbUsuario           VARCHAR2(30) := 'OPEN';
    sbTabla             VARCHAR2(30) := 'LDC_SUSP_AUTORECO';
    sbTablaOrigen       VARCHAR2(100) := sbUsuario || '.' || sbTabla;
    sbColumna           VARCHAR2(30) := 'SAREPROC';

    CURSOR cuColumna ( isbUsuario VARCHAR2, isbTabla VARCHAR2, isbColumna VARCHAR2 )
    IS
    SELECT column_name
    FROM ALL_TAB_COLUMNS
    WHERE owner = isbUsuario
    AND table_name = isbTabla
    AND column_name = isbColumna;

    rcColumna   cuColumna%ROWTYPE;
    
    sbSentencia     VARCHAR2(32000);
        
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;
    
   
BEGIN

    OPEN cuColumna( sbUsuario, sbTabla, sbColumna );
    FETCH cuColumna INTO rcColumna;
    CLOSE cuColumna;
                
    IF rcColumna.column_name IS NULL THEN
    
        sbSentencia := 'ALTER TABLE ' || sbTablaOrigen || ' ADD ' || sbColumna || ' VARCHAR2(15)';

        pExecImmediate(sbSentencia);

        dbms_output.put_line('Se creó la columna ' || sbTablaOrigen || '.' || sbColumna );

        sbSentencia := 'COMMENT ON COLUMN ' || sbTablaOrigen || '.' || sbColumna ||' IS ' || '''' || 'NUMERO DE ORDEN' || '''';

        pExecImmediate(sbSentencia);
        
        dbms_output.put_line('Se creo comentario a la columna ' || sbTablaOrigen || '.' || sbColumna );
        
    ELSE

        dbms_output.put_line('Ya existe la columna ' || sbTablaOrigen || '.' || sbColumna );
        
    END IF;
        
END;
/

DECLARE

    TYPE tytbActiviProc IS TABLE OF NUMBER(15) INDEX BY VARCHAR2(50);
    
    tbActiviProc    tytbActiviProc;

    PROCEDURE pCargatbActiviProc IS
    
        CURSOR cuActi
        IS
        SELECT activity_id, count(1)
        FROM ldc_proceso_actividad
        GROUP BY activity_id
        HAVING COUNT(1) = 1;
        
        CURSOR cuProcActi( inuActi NUMBER)
        IS
        SELECT *
        FROM ldc_proceso_actividad
        WHERE activity_id = inuActi;
        
    BEGIN
    
        tbActiviProc.DELETE;
    
        FOR rgActi IN cuActi LOOP

            FOR rgProcActi IN cuProcActi ( rgActi.activity_id ) LOOP
                tbActiviProc( rgActi.activity_id ) := rgProcActi.proceso_id;
            END LOOP;
        
        END LOOP;
    
    END pCargatbActiviProc;
    
    PROCEDURE pActuSAREPROC
    IS
    
        nuUltSareCodiProc   NUMBER := -1;
    
        CURSOR cuLDC_SUSP_AUTORECO ( inuUltSareCodiProc NUMBER)
        IS
        SELECT *
        FROM LDC_SUSP_AUTORECO
        WHERE sareproc IS NULL
        AND sarecodi > inuUltSareCodiProc
        ORDER BY 1;
        
        TYPE tytbLDC_SUSP_AUTORECO IS TABLE OF LDC_SUSP_AUTORECO%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        tbLDC_SUSP_AUTORECO tytbLDC_SUSP_AUTORECO;
                
    BEGIN
        
        dbms_output.put_line( 'Inicia pActuSAREPROC');
    
        pCargatbActiviProc;
    
        LOOP
        
            tbLDC_SUSP_AUTORECO.DELETE;
            
            OPEN cuLDC_SUSP_AUTORECO( nuUltSareCodiProc );
            FETCH cuLDC_SUSP_AUTORECO BULK COLLECT INTO tbLDC_SUSP_AUTORECO LIMIT 100;
            CLOSE cuLDC_SUSP_AUTORECO;
            
            EXIT WHEN tbLDC_SUSP_AUTORECO.Count = 0;
            
            FOR indtb IN 1..tbLDC_SUSP_AUTORECO.COUNT LOOP
        
                IF tbActiviProc.Exists ( tbLDC_SUSP_AUTORECO(indtb).SAREACTI ) THEN
                
                    BEGIN
                    
                        UPDATE LDC_SUSP_AUTORECO
                        SET sareproc = tbActiviProc( tbLDC_SUSP_AUTORECO(indtb).SAREACTI )
                        WHERE sarecodi = tbLDC_SUSP_AUTORECO(indtb).sarecodi;
                        
                        COMMIT;
                        
                        EXCEPTION
                            WHEN OTHERS THEN
                                dbms_output.put_line( 'Error pActuSAREPROC sarecodi|' || tbLDC_SUSP_AUTORECO(indtb).sarecodi|| '|'||  sqlerrm);
                                ROLLBACK;
                    END;
                    
                END IF;
               
            END LOOP;

            nuUltSareCodiProc := tbLDC_SUSP_AUTORECO(tbLDC_SUSP_AUTORECO.COUNT).sarecodi;
        
        END LOOP;
        
        dbms_output.put_line( 'Termina pActuSAREPROC');
        
    END pActuSAREPROC;

BEGIN

    pActuSAREPROC;

END;
/


DECLARE
    
    sbUsuario           VARCHAR2(30) := 'OPEN';
    sbTabla             VARCHAR2(30) := 'LDC_SUSP_AUTORECO';
    sbTablaOrigen       VARCHAR2(100) := sbUsuario || '.' || sbTabla;
    sbColumna           VARCHAR2(30) := 'SAREPROC';
    sbConstName         VARCHAR2(30) := sbColumna || '_NN';

    CURSOR cuConsColumn ( isbUsuario VARCHAR2, isbTabla VARCHAR2, isbColumna VARCHAR2, isbConsName VARCHAR2)
    IS
    SELECT column_name
    FROM ALL_CONS_COLUMNS
    WHERE owner = isbUsuario
    AND table_name = isbTabla
    AND column_name = isbColumna
    AND constraint_name = isbConsName;

    rcConsColumn   cuConsColumn%ROWTYPE;
    
    sbSentencia     VARCHAR2(32000);
        
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;
    
   
BEGIN

    OPEN cuConsColumn( sbUsuario, sbTabla, sbColumna, sbConstName );
    FETCH cuConsColumn INTO rcConsColumn;
    CLOSE cuConsColumn;
                
    IF rcConsColumn.column_name IS NULL THEN
    
        sbSentencia := 'ALTER TABLE ' || sbTablaOrigen || ' MODIFY ' || sbColumna || ' CONSTRAINT ' || sbConstName || ' NOT NULL';

        pExecImmediate(sbSentencia);

        dbms_output.put_line('Se creó el constraint ' || sbTablaOrigen || '.' || sbConstName );
        
    ELSE

        dbms_output.put_line('Ya existe el constraint ' || sbTablaOrigen || '.' || sbConstName );
        
    END IF;
        
END;
/

DECLARE

    sbUsuarioDestino    VARCHAR2(30) := 'OPEN';
    sbTabla             VARCHAR2(30) := 'LDC_SUSP_AUTORECO';
    sbTablaDestino      VARCHAR2(100) := sbUsuarioDestino|| '.' || sbTabla;

    sbSentencia         VARCHAR2(32000);
    
    sbIndice         VARCHAR2(100) := 'IDX002_'||sbTabla;

    CURSOR cuALL_INDEXES( isbUsuario VARCHAR2, isbIndice VARCHAR2, isbTabla VARCHAR2)
    IS
    SELECT *
    FROM all_indexes
    WHERE owner = isbUsuario
    AND index_name = isbIndice
    AND table_name = isbTabla;
    
    rcALL_INDEXES cuALL_INDEXES%ROWTYPE;    
    
    PROCEDURE pExecImmediate( isbSentencia VARCHAR2)
    IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSentencia;
    
        EXCEPTION WHEN OTHERS THEN
            dbms_output.put_line( 'Error pExecImmediate[' || isbSentencia || '][' || SQLERRM || ']');
            RAISE;
    END pExecImmediate;    

BEGIN

    OPEN cuALL_INDEXES( sbUsuarioDestino, sbIndice, sbTabla );
    FETCH cuALL_INDEXES INTO rcALL_INDEXES;
    CLOSE cuALL_INDEXES;

    IF rcALL_INDEXES.index_name IS NULL THEN

        sbSentencia := 'CREATE INDEX ' || sbUsuarioDestino || '.' || sbIndice || ' ON ' || sbTablaDestino||
                        '(SAREPROC)';
                        
        pExecImmediate ( sbSentencia );

        dbms_output.put_line( 'Se creó el indice ' || sbUsuarioDestino || '.' || sbIndice || ' sobre la tabla ' || sbTablaDestino );    
        
    ELSE
        dbms_output.put_line( 'Ya existe el indice ' || sbUsuarioDestino || '.' || sbIndice || ' sobre la tabla ' || sbTablaDestino );    
    END IF;

END;
/

