CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCRECULULTPLANFINAN" (nunuse servsusc.sesunuse%TYPE) RETURN NUMBER IS
-- Ultimo plan de financiacion del producto
CURSOR cuultref(nupprod NUMBER) IS
 SELECT
        d.difecofi codigo_financiacion
      ,d.difefein   fecha_ingreso
      ,d.difepldi          plan_financiacion
  FROM open.diferido d
 WHERE difenuse = nupprod
   AND difeprog = 'GCNED'
 ORDER BY difefein DESC;
nuultre              plandife.pldicodi%TYPE;
nucontaref           NUMBER(8);
BEGIN
 nuultre      := 0;
 nucontaref   := 0;
      FOR k IN cuultref(nunuse) LOOP
       nucontaref := nucontaref + 1;
       IF nucontaref = 1 THEN
        nuultre       := k.plan_financiacion;
        EXIT;
       END IF;
      END LOOP;
RETURN nuultre;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRECULULTPLANFINAN', 'ADM_PERSON');
END;
/
