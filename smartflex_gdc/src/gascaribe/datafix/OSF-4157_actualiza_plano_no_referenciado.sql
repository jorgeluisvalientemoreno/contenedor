DECLARE
  nuLote NUMBER;
  nuLoteActualizar NUMBER := 9706 ;
BEGIN

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into personalizaciones.lote_fact_electronica
         select  nuLote CODIGO_LOTE ,
                 PERIODO_FACTURACION ,
                 ANIO ,
                 MES ,
                 CICLO ,
                 1 CANTIDAD_REGISTRO ,
                 CANTIDAD_HILOS ,
                 HILOS_PROCESADO ,
                 HILOS_FALLIDO ,
                 INTENTOS ,
                 FLAG_TERMINADO ,
                SYSDATE FECHA_INICIO ,
                SYSDATE FECHA_FIN ,
                null FECHA_INICIO_PROC ,
                null FECHA_FIN_PROC,
                TIPO_DOCUMENTO
        from personalizaciones.lote_fact_electronica        
        where CODIGO_LOTE = nuLoteActualizar ;


    update  personalizaciones.factura_elect_general set CODIGO_LOTE = nuLote,
				TEXTO_ENVIADO = '1|NCG160376932|91|22|1|NCG|160376932|2025-03-28|00:00:00-05:00|||1|Devolución parcial de los bienes y/o no aceptación parcial del servicio||COP|1|2|||2025-03-31|2025-03-01|03:03:37-05:00|2025-03-31|03:03:37-05:00|471437.00|0.00|471437.00|0.00||0|0|471437.00||||||67100838|||||||||||||||||||||||160376932|||NC por IPAT Transporte, dado que, en comunicación recibida de parte de este, nos solicita liquidar este concepto a través de factura por razones tributarias. memo 25-001789|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
1A|NCG160376932||||||
1B|NCG160376932|||||||
2|NCG160376932|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NCG|||
3|NCG160376932|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|NCG160376932||||||||||
4|NCG160376932|1|31|NIT|800021308|5|DRUMMOND LTD. COLOMBIA |||08|ATLANTICO|08001|BARRANQUILLA|KR 54 CL 59 - 144 ZN DRUMMOND||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|FACTURACION@DRUMMONDLTD.COM|||||||||||||||
5|NCG160376932|||||||||
5A|NCG160376932|||||||||||
6|NCG160376932|1|999|1072|IPAT TRANSPORTE||||1|1||94|471437.00|471437.00|false|||||||||||||||||||
6A|NCG160376932||||||||
6B|NCG160376932|||||||
6C|NCG160376932|||||||||
6D|NCG160376932|||||||||||
7|NCG160376932||||||||||||||||||||
8|NCG160376932|||||
9|NCG160376932|0|||
9|NCG160376932|1|||
9|NCG160376932|2|||
9|NCG160376932|3|||
9|NCG160376932|4|||
9|NCG160376932|5|||
9|NCG160376932|6|||
10|NCG160376932|1|1072|IPAT TRANSPORTE|471,437||||UND|1|471,437||'
    where factura_electronica = 'NCG160376932';

    update  PERSONALIZACIONES.lote_fact_electronica  set CANTIDAD_REGISTRO = CANTIDAD_REGISTRO - 1      
    where CODIGO_LOTE = nuLoteActualizar;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Termino proceso');
END;
/