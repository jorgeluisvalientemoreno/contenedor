CREATE OR REPLACE PROCEDURE ldc_actconcceroultplafi_tmp(
                                              sbptable VARCHAR2,
                                              sbmensa OUT VARCHAR2,
                                              error   OUT NUMBER) IS


 TYPE refCursor IS REF CURSOR;
 rcDatos          refCursor;

CURSOR cuservcus    is
 SELECT ROWID ident
         ,e.producto
         ,e.consumos_cero
         ,e.ultimo_plan_fina
         ,e.nuano
         ,e.numes
     FROM ldc_osf_sesucier_tmp e;

regDatos  cuservcus%rowtype;

nuerror              NUMBER(3):= 0;
nucontareg           NUMBER(15) DEFAULT 0;
nucantiregtot        NUMBER(15) DEFAULT 0;
limit_in             INTEGER := 100;
nuConsumoCero NUMBER;
nuUltiFina NUMBER;
NUCONTA NUMBER:= 0;
 sbejecuta           VARCHAR2(4000);
 nuUltiPLan NUMBER;
 nuConsuCero NUMBER;

BEGIN
 nuerror := -1;
 sbmensa := NULL;
 error := 0;
 nuerror := -3;
  sbejecuta := ' SELECT ROWID ident
                       ,producto
                       ,consumos_cero
                       ,ultimo_plan_fina
                       ,nuano
                       ,numes
                   FROM '||TRIM(sbptable);

 -- Recorremos los productos
   OPEN rcDatos FOR sbejecuta;
    LOOP
        FETCH rcDatos INTO regDatos;
        EXIT WHEN rcDatos%NOTFOUND;
         nuUltiPLan := 0;
          nuConsuCero := 0;
          nuUltiPLan :=  open.ldc_fncreculultplanfinan(regDatos.producto);
          nuConsuCero := open.ldc_fnuGetZeroConsPer(regDatos.producto,regDatos.Nuano,regDatos.numes);
        /*  Dbms_Output.Put_LINE('UPDATE '||TRIM(sbptable)||' s SET  S.ULTIMO_PLAN_FINA = '||nuUltiPLan||' '||
                            'WHERE s.ROWID = '''||regDatos.ident||'''');*/
          EXECUTE IMMEDIATE 'UPDATE '||TRIM(sbptable)||' s SET  S.ULTIMO_PLAN_FINA = '||nuUltiPLan||', S.CONSUMOS_CERO = '||nuConsuCero||' '||
                            'WHERE s.ROWID = '''||regDatos.ident||'''';

          NUCONTA := NUCONTA + 1;
          IF  mod(NUCONTA, 1000) = 0 THEN
             commit;
          END IF;
    END LOOP;
 CLOSE rcDatos;

 COMMIT;

   nuerror := -4;
   sbmensa := 'Proceso terminó Ok. Se procesaron '||to_char(NUCONTA)||' registros.';
   error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_actconcceroultplafi lineas error '||nuerror||' '||sqlerrm;
  error := -1;
END;
/
