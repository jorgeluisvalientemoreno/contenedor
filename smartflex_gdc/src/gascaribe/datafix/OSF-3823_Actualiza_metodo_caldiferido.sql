
column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuJob NUMBER;
BEGIN
 DBMS_JOB.SUBMIT(nuJob,
        'DECLARE
  nuerror NUMBER;
  sbError VARCHAR2(4000);
  
   CURSOR cugetDiferidos IS
    SELECT diferido.*
    FROM open.diferido, suscripc
    WHERE diferido.difesape > 0
    AND diferido.difeinte <> 0 
    AND diferido.difetain = 2
    AND suscripc.susccodi = difesusc
    AND suscripc.suscnupr = 0
    AND diferido.difemeca = 2;
    
    TYPE tblDiferidos  IS TABLE OF cugetDiferidos%ROWTYPE;
    v_tblDiferidos   tblDiferidos;
    
     nuNominalPerc       NUMBER;
    nuCantidad          NUMBER;
    nuRoundFactor       NUMBER;
    nuMethod            NUMBER := 8;
    nuFactor            NUMBER := 0.2;
    nuQuotaValue        diferido.DIFEVACU%TYPE;
    inuIdCompany        NUMBER := 99;
    NUNumeroCuotas      NUMBER; 
    NUCuotaCalculada    NUMBER; 
    nuCuotas            NUMBER;
    sbProceso VARCHAR2(100) := ''ACTUALIZA_DIFERIDO'';

BEGIN
    pkg_estaproc.prinsertaestaproc( sbProceso , 0);
    
    execute immediate ''CREATE TABLE OPEN.TMP_DIFERIDO21012025 AS
  SELECT diferido.*
    FROM open.diferido, open.suscripc
    WHERE diferido.difesape > 0
    AND diferido.difeinte <> 0 
    AND diferido.difetain = 2
    AND suscripc.susccodi = difesusc
    AND suscripc.suscnupr = 0
    AND suscripc.susccicl in (401, 406)
    AND diferido.difemeca = 2'';
    

   OPEN cugetDiferidos;
    LOOP
        FETCH cugetDiferidos BULK COLLECT INTO v_tblDiferidos LIMIT 100;
          FOR idx IN 1..v_tblDiferidos.COUNT LOOP
         
              IF v_tblDiferidos(idx).difenucu > v_tblDiferidos(idx).difecupa THEN
                  nuCuotas :=  v_tblDiferidos(idx).difenucu  - v_tblDiferidos(idx).difecupa;
				  NUNumeroCuotas := v_tblDiferidos(idx).difecupa;
                   
                    -- Obtiene el valor de la cuota
                  pkDeferredMgr.CalculatePayment ( v_tblDiferidos(idx).difesape    , -- Saldo a Diferir (difesape)
                                                    nuCuotas , -- Numero de Cuotas  diferido
                                                     nuNominalPerc,                  -- Interes Nominal
                                                     nuMethod,                     -- Metodo de Calculo
                                                     nuFactor,       --nuSpread,              -- Spread
                                                     v_tblDiferidos(idx).difeinte + v_tblDiferidos(idx).DIFESPRE , -- Interes Efectivo mas Spread
                                                     nuQuotaValue   -- Valor de la Cuota (Salida)
                                                     );       
                                                                   
                                        
                   --  Obtiene el factor de redondeo para la suscripcion
                   FA_BOPoliticaRedondeo.ObtFactorRedondeo ( v_tblDiferidos(idx).difesusc,
                                                              nuRoundFactor,
                                                              inuIdCompany);
                        
                  
                 
                   NUCuotaCalculada := POWER ((1 + (nuFactor / 100)), NUNumeroCuotas);
    
                   nuQuotaValue := nuQuotaValue / NUCuotaCalculada;
              
                   --  Aplica politica de redondeo al valor de la cuota
                   nuQuotaValue := ROUND (nuQuotaValue, nuRoundFactor);
    
                   
              ELSE
                 nuCuotas := 1;
                 nuQuotaValue := v_tblDiferidos(idx).difesape;
              END IF;
              
               --Actualizar el valor de la cuota en el diferido
               UPDATE diferido SET difevacu = nuQuotaValue, difefagr = nuFactor, difemeca = nuMethod
               WHERE difecodi = v_tblDiferidos(idx).difecodi;
               
          END LOOP;
          COMMIT;
        EXIT   WHEN cugetDiferidos%NOTFOUND;
    END LOOP;
    CLOSE cugetDiferidos;
    COMMIT;
    pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
EXCEPTION
  WHEN OTHERS THEN
     pkg_error.seterror;
     pkg_error.geterror(nuerror, sbError);
      pkg_estaproc.practualizaestaproc( sbProceso, ''Error '', sbError  );
     ROLLBACK;
     dbms_output.put_line('' sbError ''||sbError);
END;',
    SYSDATE);
 COMMIT;
 DBMS_OUTPUT.PUT_LINE(' nuJob '||nuJob);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/