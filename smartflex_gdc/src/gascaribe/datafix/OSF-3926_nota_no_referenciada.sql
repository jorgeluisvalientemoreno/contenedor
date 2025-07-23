DECLARE
  nuLote NUMBER;
  nuLoteActualizar NUMBER := 7063;
BEGIN

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into lote_fact_electronica
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
        from PERSONALIZACIONES.lote_fact_electronica        
        where CODIGO_LOTE = nuLoteActualizar ;


    update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
				TEXTO_ENVIADO = '1|NCG159353132|91|22|1|NCG|159353132|2025-01-30|00:00:00-05:00|||1|Devolución parcial de los bienes y/o no aceptación parcial del servicio||COP|1|2|||2025-01-23|2025-01-01|10:01:32-05:00|2025-01-31|10:01:32-05:00|622386.00|0.00|622386.00|0.00||0|0|622386.00||||||67573087|||||||||||||||||||||||159353132|||Se ajustan 213 mts3 cr en el mes de Dic por cobro promedio, según ot 352120528, lectura encontrada 778 el 27-01-25, se factura hasta 750 el 28-12-24|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
1A|NCG159353132||||||
1B|NCG159353132|||||||
2|NCG159353132|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NCG|||
3|NCG159353132|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|NCG159353132||||||||||
4|NCG159353132|1|31|NIT|901486868|1|MAKING INDUSTRY S.A.S. |||08|ATLANTICO|08001|BARRANQUILLA|CL 42 KR 51 - 10 BO||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|notiene@correo.com|||||||||||||||
5|NCG159353132|||||||||
5A|NCG159353132|||||||||||
6|NCG159353132|1|999|31|CONSUMO||||1|1||94|622386.00|622386.00|false|||||||||||||||||||
6A|NCG159353132||||||||
6B|NCG159353132|||||||
6C|NCG159353132|||||||||
6D|NCG159353132|||||||||||
7|NCG159353132||||||||||||||||||||
8|NCG159353132|||||
9|NCG159353132|0|||
9|NCG159353132|1|||
9|NCG159353132|2|||
9|NCG159353132|3|||
9|NCG159353132|4|||
9|NCG159353132|5|||
9|NCG159353132|6|||
10|NCG159353132|1|31|CONSUMO|622,386||||UND|1|622,386||'
    where factura_electronica = 'NCG159353132';

    update  PERSONALIZACIONES.lote_fact_electronica  set CANTIDAD_REGISTRO = CANTIDAD_REGISTRO - 1      
    where CODIGO_LOTE = nuLoteActualizar;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Termino proceso');
END;
/