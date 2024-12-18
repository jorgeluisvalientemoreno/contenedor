CREATE OR REPLACE PROCEDURE      ldc_actconcceroultplafi4(
                                              nupano  NUMBER,
                                              nupmes  NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error   OUT NUMBER) IS

 TYPE array_cursor IS RECORD(
                              iden VARCHAR2(1000)
                             ,prod ldc_osf_sesucier.producto%TYPE
                             ,mace ldc_osf_sesucier.consumos_cero%TYPE
                             ,ulpl ldc_osf_sesucier.ultimo_plan_fina%TYPE
                             );

TYPE t_array_cursor IS TABLE OF array_cursor;
v_array_cursor t_array_cursor;

CURSOR cuservcus    is
 SELECT ROWID ident
         ,e.producto
         ,e.consumos_cero
         ,e.ultimo_plan_fina
     FROM ldc_osf_sesucier_tmp4 e;
nuerror              NUMBER(3):= 0;
nucontareg           NUMBER(15) DEFAULT 0;
nucantiregtot        NUMBER(15) DEFAULT 0;
limit_in             INTEGER := 100;
BEGIN
 nuerror := -1;
 sbmensa := NULL;
 error := 0;
 nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 nuerror := -2;
 limit_in   := nucontareg;
 nuerror := -3;
 -- Recorremos los productos
 OPEN cuservcus;
 LOOP
  FETCH cuservcus BULK COLLECT INTO v_array_cursor LIMIT limit_in;
  --EXIT WHEN cuservcus%NOTFOUND;
   FOR i IN 1..v_array_cursor.count LOOP
     -- v_array_cursor(i).mace := open.ldc_fnuGetZeroConsPer(v_array_cursor(i).prod,nupano,nupmes); CA 184 LJLB -- se quita por no uso del campo
    v_array_cursor(i).ulpl:=  open.ldc_fncreculultplanfinan(v_array_cursor(i).prod);
   nucantiregtot := nucantiregtot + 1;
   END LOOP;
   FORALL i IN 1 .. v_array_cursor.count
      UPDATE ldc_osf_sesucier_tmp4 y
         SET /*y.consumos_cero    = v_array_cursor(i).mace
            ,*/y.ultimo_plan_fina = v_array_cursor(i).ulpl
        WHERE ROWID = v_array_cursor(i).iden;
  EXIT WHEN cuservcus%NOTFOUND;
 END LOOP;
 CLOSE cuservcus;
 COMMIT;
   nuerror := -4;
   sbmensa := 'Proceso terminó Ok. Se procesaron '||to_char(nucantiregtot)||' registros.';
   error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_actconcceroultplafi4 lineas error '||nuerror||' '||sqlerrm;
  error := -1;
END;
/
