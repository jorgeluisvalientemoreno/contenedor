column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuLote NUMBER;
BEGIN
 
  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into lote_fact_electronica
         select  nuLote CODIGO_LOTE ,
                 PERIODO_FACTURACION ,
                 ANIO ,
                 MES ,
                 CICLO ,
                 5 CANTIDAD_REGISTRO ,
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
        where CODIGO_LOTE = 1979 ;

    update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
    TEXTO_ENVIADO = '1|NDG156479301|92|32|1|NDG|156479301|2024-10-03|00:00:00-05:00|||4|Otros||COP|1|2|||2024-09-19|2024-10-01|08:10:48-05:00|2024-10-31|08:10:48-05:00|259714.00|0.00|259714.00|0.00||0|0|259714.00||||||17189071|||||||||||||||||||||||156479301|||Se reliquida consumo delos meses de abril. mayo, junio, julio y agosto/24 al modificar la presión a 4PSI según la ot de reliquidación No. 340203427|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
                1A|NDG156479301||||||
                1B|NDG156479301|||||||
                2|NDG156479301|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NDG|||
                3|NDG156479301|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
                3A|NDG156479301||||||||||
                4|NDG156479301|1|31|NIT|900169751|4|AVANCE URBANO Y CONSTRUCCIONES |||47|MAGDALENA|47001|SANTA MARTA (MAG)|KR 32 CL 29A - 500 LOCAL 45||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos||||||||||||||||
                5|NDG156479301|||||||||
                5A|NDG156479301|||||||||||
                6|NDG156479301|1|999|31|CONSUMO||||1|1||94|259714.00|259714.00||||||||||||||||||||
                6A|NDG156479301||||||||
                6B|NDG156479301|||||||
                6C|NDG156479301|||||||||
                6D|NDG156479301|||||||||||
                7|NDG156479301||||||||||||||||||||
                8|NDG156479301|||||
                9|NDG156479301|0|||
                9|NDG156479301|1|||
                9|NDG156479301|2|||
                9|NDG156479301|3|||
                9|NDG156479301|4|||
                9|NDG156479301|5|||
                9|NDG156479301|6|||
                10|NDG156479301|1|31|CONSUMO|259714||||UND|1|259714||'
 where factura_electronica = 'NDG156479301';
 
 update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
            TEXTO_ENVIADO = '1|NDG156479304|92|32|1|NDG|156479304|2024-10-03|00:00:00-05:00|||4|Otros||COP|1|2|||2024-09-19|2024-10-01|08:10:47-05:00|2024-10-31|08:10:47-05:00|273462.00|0.00|273462.00|0.00||0|0|273462.00||||||17189071|||||||||||||||||||||||156479304|||Se reliquida consumo delos meses de abril. mayo, junio, julio y agosto/24 al modificar la presión a 4PSI según la ot de reliquidación No. 340203427|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
        1A|NDG156479304||||||
        1B|NDG156479304|||||||
        2|NDG156479304|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NDG|||
        3|NDG156479304|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
        3A|NDG156479304||||||||||
        4|NDG156479304|1|31|NIT|900169751|4|AVANCE URBANO Y CONSTRUCCIONES |||47|MAGDALENA|47001|SANTA MARTA (MAG)|KR 32 CL 29A - 500 LOCAL 45||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos||||||||||||||||
        5|NDG156479304|||||||||
        5A|NDG156479304|||||||||||
        6|NDG156479304|1|999|31|CONSUMO||||1|1||94|273462.00|273462.00||||||||||||||||||||
        6A|NDG156479304||||||||
        6B|NDG156479304|||||||
        6C|NDG156479304|||||||||
        6D|NDG156479304|||||||||||
        7|NDG156479304||||||||||||||||||||
        8|NDG156479304|||||
        9|NDG156479304|0|||
        9|NDG156479304|1|||
        9|NDG156479304|2|||
        9|NDG156479304|3|||
        9|NDG156479304|4|||
        9|NDG156479304|5|||
        9|NDG156479304|6|||
        10|NDG156479304|1|31|CONSUMO|273462||||UND|1|273462||'
    where factura_electronica = 'NDG156479304';
    
    update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
            TEXTO_ENVIADO = '1|NDG156479300|92|32|1|NDG|156479300|2024-10-03|00:00:00-05:00|||4|Otros||COP|1|2|||2024-09-19|2024-10-01|08:10:48-05:00|2024-10-31|08:10:48-05:00|255240.00|0.00|255240.00|0.00||0|0|255240.00||||||17189071|||||||||||||||||||||||156479300|||Se reliquida consumo delos meses de abril. mayo, junio, julio y agosto/24 al modificar la presión a 4PSI según la ot de reliquidación No. 340203427|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
                    1A|NDG156479300||||||
                    1B|NDG156479300|||||||
                    2|NDG156479300|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NDG|||
                    3|NDG156479300|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
                    3A|NDG156479300||||||||||
                    4|NDG156479300|1|31|NIT|900169751|4|AVANCE URBANO Y CONSTRUCCIONES |||47|MAGDALENA|47001|SANTA MARTA (MAG)|KR 32 CL 29A - 500 LOCAL 45||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos||||||||||||||||
                    5|NDG156479300|||||||||
                    5A|NDG156479300|||||||||||
                    6|NDG156479300|1|999|31|CONSUMO||||1|1||94|255240.00|255240.00||||||||||||||||||||
                    6A|NDG156479300||||||||
                    6B|NDG156479300|||||||
                    6C|NDG156479300|||||||||
                    6D|NDG156479300|||||||||||
                    7|NDG156479300||||||||||||||||||||
                    8|NDG156479300|||||
                    9|NDG156479300|0|||
                    9|NDG156479300|1|||
                    9|NDG156479300|2|||
                    9|NDG156479300|3|||
                    9|NDG156479300|4|||
                    9|NDG156479300|5|||
                    9|NDG156479300|6|||
                    10|NDG156479300|1|31|CONSUMO|255240||||UND|1|255240||'
    where factura_electronica = 'NDG156479300';
    
    update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
            TEXTO_ENVIADO = '1|NDG156479302|92|32|1|NDG|156479302|2024-10-03|00:00:00-05:00|||4|Otros||COP|1|2|||2024-09-19|2024-10-01|08:10:48-05:00|2024-10-31|08:10:48-05:00|280780.00|0.00|280780.00|0.00||0|0|280780.00||||||17189071|||||||||||||||||||||||156479302|||Se reliquida consumo delos meses de abril. mayo, junio, julio y agosto/24 al modificar la presión a 4PSI según la ot de reliquidación No. 340203427|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
                1A|NDG156479302||||||
                1B|NDG156479302|||||||
                2|NDG156479302|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NDG|||
                3|NDG156479302|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
                3A|NDG156479302||||||||||
                4|NDG156479302|1|31|NIT|900169751|4|AVANCE URBANO Y CONSTRUCCIONES |||47|MAGDALENA|47001|SANTA MARTA (MAG)|KR 32 CL 29A - 500 LOCAL 45||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos||||||||||||||||
                5|NDG156479302|||||||||
                5A|NDG156479302|||||||||||
                6|NDG156479302|1|999|31|CONSUMO||||1|1||94|280780.00|280780.00||||||||||||||||||||
                6A|NDG156479302||||||||
                6B|NDG156479302|||||||
                6C|NDG156479302|||||||||
                6D|NDG156479302|||||||||||
                7|NDG156479302||||||||||||||||||||
                8|NDG156479302|||||
                9|NDG156479302|0|||
                9|NDG156479302|1|||
                9|NDG156479302|2|||
                9|NDG156479302|3|||
                9|NDG156479302|4|||
                9|NDG156479302|5|||
                9|NDG156479302|6|||
                10|NDG156479302|1|31|CONSUMO|280780||||UND|1|280780||'
    where factura_electronica = 'NDG156479302';
    
    update  OPEN.factura_elect_general set CODIGO_LOTE = nuLote,
            TEXTO_ENVIADO = '1|NDG156479303|92|32|1|NDG|156479303|2024-10-03|00:00:00-05:00|||4|Otros||COP|1|2|||2024-09-19|2024-10-01|08:10:48-05:00|2024-10-31|08:10:48-05:00|252484.00|0.00|252484.00|0.00||0|0|252484.00||||||17189071|||||||||||||||||||||||156479303|||Se reliquida consumo delos meses de abril. mayo, junio, julio y agosto/24 al modificar la presión a 4PSI según la ot de reliquidación No. 340203427|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
            1A|NDG156479303||||||
            1B|NDG156479303|||||||
            2|NDG156479303|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NDG|||
            3|NDG156479303|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
            3A|NDG156479303||||||||||
            4|NDG156479303|1|31|NIT|900169751|4|AVANCE URBANO Y CONSTRUCCIONES |||47|MAGDALENA|47001|SANTA MARTA (MAG)|KR 32 CL 29A - 500 LOCAL 45||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos||||||||||||||||
            5|NDG156479303|||||||||
            5A|NDG156479303|||||||||||
            6|NDG156479303|1|999|31|CONSUMO||||1|1||94|252484.00|252484.00||||||||||||||||||||
            6A|NDG156479303||||||||
            6B|NDG156479303|||||||
            6C|NDG156479303|||||||||
            6D|NDG156479303|||||||||||
            7|NDG156479303||||||||||||||||||||
            8|NDG156479303|||||
            9|NDG156479303|0|||
            9|NDG156479303|1|||
            9|NDG156479303|2|||
            9|NDG156479303|3|||
            9|NDG156479303|4|||
            9|NDG156479303|5|||
            9|NDG156479303|6|||
            10|NDG156479303|1|31|CONSUMO|252484||||UND|1|252484||'
    where factura_electronica = 'NDG156479303';
    
    update  PERSONALIZACIONES.lote_fact_electronica  set CANTIDAD_REGISTRO = 2      
    where CODIGO_LOTE = 1979;
     
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Termino proceso');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/