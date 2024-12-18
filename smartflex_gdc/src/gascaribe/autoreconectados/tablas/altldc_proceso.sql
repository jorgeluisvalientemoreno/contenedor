-- Fuente="Propiedad Intelectual de Empresas Públicas de Medellín"
-- altldc_proceso.sql
-- Lubin Pineda
-- 18-03-2024
-- Se agrega la columna LDC_PROCESO.PROCESO_AUTOMATICO
-- OSF-2341

declare

    sbSentencia VARCHAR2(32767);

    sbTabla VARCHAR2(30)      := 'LDC_PROCESO'; 
    sbColumna VARCHAR2(50) := 'PROCESO_AUTOMATICO';

    CURSOR CU_USER_TAB_COLUMNS( isbTabla VARCHAR2, isbColumna VARCHAR2) IS
    SELECT TABLE_NAME FROM 
    USER_TAB_COLUMNS 
    WHERE TABLE_NAME = isbTabla 
    AND COLUMN_NAME  = isbColumna;
    
    rcUser_Tab_Columns CU_USER_TAB_COLUMNS%ROWTYPE;
    
    PROCEDURE pExecImm( isbSent VARCHAR2) IS
    BEGIN
    
        EXECUTE IMMEDIATE isbSent;
    
        EXCEPTION WHEN OTHERS THEN        
            DBMS_OUTPUT.PUT_LINE( 'Error[' || isbSent || '][' || sqlerrm || ']' );
            RAISE;
        
    END pExecImm;
        
begin

    OPEN    CU_USER_TAB_COLUMNS( sbTabla,  sbColumna );
    FETCH   CU_USER_TAB_COLUMNS INTO rcUser_Tab_Columns;
    CLOSE   CU_USER_TAB_COLUMNS;
    
    IF rcUser_Tab_Columns.table_name IS NULL THEN

        sbSentencia := sbSentencia || 'ALTER TABLE  ' || sbTabla || '
         ADD ' || sbColumna || ' VARCHAR2(1) DEFAULT ' || '''' || 'N' || '''';        
		
        pExecImm( sbSentencia  );
        
        DBMS_OUTPUT.PUT_LINE( 'Se agregó la columna '|| USER || '.' || sbTabla || '.' || sbColumna );
        		       
    ELSE
        
        DBMS_OUTPUT.PUT_LINE( 'Ya existe la columna '|| USER || '.' || sbTabla || '.' || sbColumna );
                
    END IF;
     
END;
/