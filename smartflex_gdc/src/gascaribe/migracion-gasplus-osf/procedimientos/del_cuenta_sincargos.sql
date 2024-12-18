CREATE OR REPLACE PROCEDURE "DEL_CUENTA_SINCARGOS" (ini number, fin number, pbd number) AS
nnn number;
CURSOR cucuencobr
IS
SELECT cucocodi
FROM
cuencobr
WHERE not exists ( SELECT 1 FROM cargos WHERE cargcuco=cucocodi)
AND cucocodi<>-1;
nuLogError number;
PROCEDURE MAYSERIAL IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    CURSOR cuSeriadoMinusculas
    IS
        SELECT  id_items_seriado, serie
        FROM ge_items_seriado
        WHERE lower(serie) = serie;
    rccuSeriadoMinusculas cuSeriadoMinusculas%rowtype;
    CURSOR cuElementoMinusculas
    IS
        SELECT  elmeidem, elmecodi
        FROM elemmedi
        WHERE lower(elmecodi) = elmecodi;
    rccuElementoMinusculas cuElementoMinusculas%rowtype;
    CURSOR cuElemServMinusculas
    IS
        SELECT  EMSSELME, EMSSCOEM
        FROM elmesesu
        WHERE lower(EMSSCOEM) = EMSSCOEM;
    rccuElemServMinusculas cuElemServMinusculas%rowtype;
    nuserie number;
    nuidseriado number;
    nuelmecodi number;
    nuidelmeidem number;
    nuEMSSCOEM number;
    nuidEMSSELME number;
BEGIN
    errors.Initialize;
--    ut_trace.Init;
--    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
--    ut_trace.SetLevel(0);
    ut_trace.Trace('INICIO');
    OPEN cuSeriadoMinusculas;
    LOOP
       FETCH cuSeriadoMinusculas INTO rccuSeriadoMinusculas ;
       EXIT WHEN cuSeriadoMinusculas%NOTFOUND;
       BEGIN
        SELECT to_number(replace(serie, '-', '')), id_items_seriado  INTO nuserie, nuidseriado
        FROM ge_items_seriado
        WHERE lower(serie) = rccuSeriadoMinusculas.serie
        AND id_items_seriado = rccuSeriadoMinusculas.id_items_seriado;
        EXCEPTION
            when others then
                UPDATE ge_items_seriado
                    SET serie = upper(serie)
                    WHERE lower(serie) = rccuSeriadoMinusculas.serie
                    AND id_items_seriado = rccuSeriadoMinusculas.id_items_seriado;
        END;
    END LOOP;
    CLOSE cuSeriadoMinusculas;
    commit;
    OPEN cuElementoMinusculas;
    LOOP
       FETCH cuElementoMinusculas INTO rccuElementoMinusculas;
       EXIT WHEN cuElementoMinusculas%NOTFOUND;
       BEGIN
        SELECT to_number(replace(elmecodi, '-', '')), elmeidem  INTO nuelmecodi, nuidelmeidem
        FROM elemmedi
        WHERE lower(elmecodi) = rccuElementoMinusculas.elmecodi
        AND elmeidem = rccuElementoMinusculas.elmeidem;
        EXCEPTION
            when others then
                UPDATE elemmedi
                    SET elmecodi = upper(elmecodi)
                    WHERE lower(elmecodi) = rccuElementoMinusculas.elmecodi
                    AND elmeidem = rccuElementoMinusculas.elmeidem;
        END;
    END LOOP;
    CLOSE cuElementoMinusculas;
    commit;
    OPEN cuElemServMinusculas;
    LOOP
       FETCH cuElemServMinusculas INTO rccuElemServMinusculas ;
       EXIT WHEN cuElemServMinusculas%NOTFOUND;
       BEGIN
        SELECT to_number(replace(EMSSCOEM, '-', '')), EMSSELME  INTO nuEMSSCOEM, nuidEMSSELME
        FROM elmesesu
        WHERE lower(EMSSCOEM) = rccuElemServMinusculas.EMSSCOEM
        AND EMSSELME = rccuElemServMinusculas.EMSSELME;
        EXCEPTION
            when others then
                UPDATE elmesesu
                    SET EMSSCOEM = upper(EMSSCOEM)
                    WHERE lower(EMSSCOEM) = rccuElemServMinusculas.EMSSCOEM
                    AND EMSSELME = rccuElemServMinusculas.EMSSELME;
        END;
    END LOOP;
    CLOSE cuElemServMinusculas;
    commit;
    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
BEGIN
    UPDATE migr_rango_procesos set raprfein=sysdate,raprterm='P' where raprcodi=284 and raprbase=pbd and raprrain=INI and raprrafi=FIn;  
    commit;
      PKLOG_MIGRACION.prInsLogMigra (284,284,1,'DEL_CUENTA_SINCARGOS',0,0,'Inicia Proceso','INICIO',nuLogError);
    --  MAYSERIAL;
    execute immediate 'alter trigger TRGAUALLOCATEQUOTEBALANCE disable';
    COMMIT;    
    for r in    cucuencobr
    loop
           select count(1) into nnn from LD_FA_DETADEPP where DEPPCUCO=r.cucocodi;
           if nnn=0 then
              DELETE FROM cuencobr WHERE cucocodi = r.cucocodi;
              COMMIT;
          else
             update LD_FA_DETADEPP set deppcuco=null where deppCUCO=r.cucocodi;
             DELETE FROM cuencobr WHERE cucocodi = r.cucocodi;
              COMMIT;
          end if;
    END loop;
    PKLOG_MIGRACION.prInsLogMigra (284,284,3,'DEL_CUENTA_SINCARGOS',0,0,'Termina Proceso','FIN',nuLogError);
    UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=284 and raprbase=pbd and raprrain=INI and raprrafi=FIn;  
    commit;
END; 
/
