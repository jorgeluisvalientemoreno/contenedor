DECLARE
    nuError     NUMBER;
    sbError     VARCHAR2(2000);
    ircDeferred open.diferido%rowtype;
    tbQuotas    pkDeferredMgr.tytbCuotas;
    nuTotal     number := 0;
    
    CURSOR cuDiferidos IS
        SELECT  difecodi, difenuse, difefein, 501200 difesape, -- saldo que tiene a la fecha de corte
      difeinte, difespre,
                difemeca, difevacu, difenucu, difesign, difevatd, difefagr
        FROM    diferido
        WHERE   difecodi = 8836206; -- Numero del diferido

BEGIN

    pkErrors.SetApplication ('TEST');
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO', 1);
    pkErrors.TraceOn ;
    pkGeneralServices.SetTraceDataOn ;


    for ircDeferred in cuDiferidos loop

        dbms_output.put_Line('Diferido --> '||ircDeferred.difecodi);

        -- Simula el plan de cuotas
        pkDeferredMgr.StoreInstallments
        (
            ircDeferred.difenuse, -- Producto
          ircDeferred.difefein, -- Fecha del diferido
          ircDeferred.difesape, -- Saldo pendiente
          ircDeferred.difeinte, -- Porcentaje interes
          ircDeferred.difespre, -- Spread
          ircDeferred.difemeca, -- Método de cálculo del diferido
          ircDeferred.difevacu, -- Valor de la cuota
          ircDeferred.difenucu, -- Número de cuotas del diferido
          ircDeferred.difesign, -- Signo del diferido
          ircDeferred.difevatd, -- Valor total del diferido
          ircDeferred.difefagr, -- Factor gradiente
          tbQuotas              -- Salida--> Tabla con las cuotas
        );

        for i in tbQuotas.first..tbQuotas.last loop
            dbms_output.put_Line(tbQuotas(i).sbPeriodo||'|'||tbQuotas(i).nuVlrCapital||'|'||tbQuotas(i).nuSigno);
            nuTotal := nuTotal + tbQuotas(i).nuVlrCapital;
        END loop;

        dbms_output.put_Line(nuTotal||'|'||ircDeferred.difesape);
        dbms_output.put_Line('-------------------------------------------');
        
        nuTotal := 0;
    
    END loop;
    
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END;
/
ldc_ciercome
