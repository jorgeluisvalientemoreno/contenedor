CREATE OR REPLACE FUNCTION ldc_fncretorcargcontribfgcc(
                                                       nmpaconcepto concepto.conccodi%TYPE
                                                       ) RETURN NUMBER IS
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2022-03-17
    Descripcion : Obtenemos lo liquidado del concepto de contribucion 
                  para la causa cargo de facturación : 15

    Parametros Entrada
      nmpaconcepto
      nmpacauscarg

    Valor de salida
     Valor cargo contribuci?n

   HISTORIA DE MODIFICACIONES
***************************************************************************/
 nuidx        NUMBER ;
 nuvalor      cargos.cargvalo%TYPE;
 otbcargosgen pkboratingmemorymgr.tytbliqcharges;
BEGIN
 pkboratingmemorymgr.getratedchrgarray(otbcargosgen);
 ut_trace.trace('INICIO LDC_FNCRETORCARGCONTRIBFGCC',15);
 nuvalor := 0;
 nuidx := otbcargosgen.first;
 ut_trace.trace(' otbcargosgen.first : '||nuidx,15);
 LOOP
  EXIT WHEN nuidx IS NULL;
   ut_trace.trace(' otbcargosgen(nuidx).nuconcept : '||otbcargosgen(nuidx).nuconcept,15);
   ut_trace.trace(' otbcargosgen(nuidx).nuvalue : '||otbcargosgen(nuidx).nuvalue,15);
   IF nvl(otbcargosgen(nuidx).nuconcept,-1) = nmpaconcepto THEN
    nuvalor := nuvalor + nvl(otbcargosgen(nuidx).nuvalue,0);
    ut_trace.trace(' if nuvalor : '||nuvalor,15);
   END IF;
  nuidx := otbcargosgen.next(nuidx);
 END LOOP;
 ut_trace.trace(' resultado nuvalor : '||nuvalor,15);
 ut_trace.trace('FIN LDC_FNCRETORCARGCONTRIBFGCC',15);
 RETURN nuvalor ;
EXCEPTION
 WHEN OTHERS THEN
  ut_trace.trace(' error : '||sqlerrm,15);
  nuvalor := 0;
  RETURN nuvalor;
END ldc_fncretorcargcontribfgcc;
/
GRANT EXECUTE ON ldc_fncretorcargcontribfgcc TO SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE ON ldc_fncretorcargcontribfgcc TO REPORTES;
GRANT EXECUTE ON ldc_fncretorcargcontribfgcc TO RSELOPEN;