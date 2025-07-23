declare
    
    CURSOR cuContratos
    IS
    select sc.susccodi, sc.RowId rId, rownum Contador
    from suscripc sc
    where sc.suscclie 	= 1613997
    and susccodi 		IN (67050298, 67050339);

    gsbProc     VARCHAR(30);

    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, irId ROWID, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
            
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  isbTabla || '|' || REPLACE(isbColumnas,',','|') );
        END IF;
                
        sbQuery := 'SELECT ' || REPLACE ( isbColumnas, ',' , ' ||' || '''' || '|' || ''''  ||  '|| '  ) || ' FROM ' || isbTabla || ' WHERE ROWID = ' || '''' || irId || '''';
    
        DBMS_OUTPUT.PUT_LINE ( sbQuery );

        OPEN    rfcCursor FOR sbQuery;
        FETCH   rfcCursor   INTO sbRes;
        CLOSE   rfcCursor;

        sbRes := isbMomento || '|' || sbRes;

        DBMS_OUTPUT.PUT_LINE(  sbRes );

    
    END pFOTO;
    
    PROCEDURE pUpdSuscClie( iRowid ROWID )
    IS            
    BEGIN

        
        gsbProc         := 'pUpdSuscClie';
        
        dbms_output.put_line('Inicia ' || gsbProc);
            
        -- Foto de los datos antes de los cambios
        pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCLIE', iRowid, 'ANTES' , FALSE);
        
        UPDATE suscripc
        SET suscclie = 1383131
        WHERE ROWID = iRowid;

        -- Foto de los datos despues de los cambios
        pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCLIE', iRowid, 'DESPU' , FALSE);
                
        dbms_output.put_line('Termina ' || gsbProc);
        
    END pUpdSuscClie;
    
    PROCEDURE pProcesaCont( irId ROWID, inuContrato NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        
        pUpdSuscClie ( irId );
        
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR ' || gsbProc || '|inuContrato|' || inuContrato || '|' || osbMensError);
            ROLLBACK;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT ' || gsbProc || '|inuContrato|' || inuContrato || '|' || osbMensError );
            ROLLBACK;
    END pProcesaCont;         

begin

	dbms_output.put_line('Inicio Datafix OSF-4174');

    dbms_output.put_line('MOMENTO|SUSCRIPC|SUSCCLIE');
            
    FOR rgContratos IN cuContratos LOOP
        
        pProcesaCont( rgContratos.rId, rgContratos.susccodi );
        
        IF MOD(  rgContratos.contador, 10 ) = 0 THEN
           COMMIT;
        END IF;
     
    END LOOP;
    
    COMMIT;

	dbms_output.put_line('Termina Datafix OSF-4174');
	
end;
/