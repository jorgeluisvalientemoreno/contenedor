column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuLote NUMBER;
  nuLoteActualizar NUMBER := 9961 ;
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
				TEXTO_ENVIADO = '1|NCG160565587|91|22|1|NCG|160565587|2025-04-03|00:00:00-05:00|||1|Devolución parcial de los bienes y/o no aceptación parcial del servicio||COP|4|2|1|Instrumento no definido|2025-01-24|2025-04-01|04:04:38-05:00|2025-04-30|04:04:38-05:00|2044161.00|0.00|2044161.00|0.00||0|0|2044161.00||||||48235073|||||||||||||||||||||||160565587|||NC ya que manifiestan que hay una diferencia entre, el volumen reportado de las ventas y el volumen facturado para el periodo de diciembre del 2024 memo 25-001895|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
1A|NCG160565587||||||
1B|NCG160565587|||||||
2|NCG160565587|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NCG|||
3|NCG160565587|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|NCG160565587||||||||||
4|NCG160565587|1|31|NIT|900962591|3|COMBUSTIBLES PALMAR S.A.S. |||08|ATLANTICO|08001|BARRANQUILLA|KR 43 CL 74 - 47||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|proveedorespalmar@gmail.com|||||||||||||||
5|NCG160565587|||||||||
5A|NCG160565587|||||||||||
6|NCG160565587|1|999|200|SUMINISTRO DE GAS||||1|1||94|1207580.00|1207580.00|false|||||||||||||||||||
6A|NCG160565587||||||||
6B|NCG160565587|||||||
6C|NCG160565587|||||||||
6D|NCG160565587|||||||||||
6|NCG160565587|2|999|20|CARGO POR DISTRIBUCION||||1|1||94|409260.00|409260.00|false|||||||||||||||||||
6A|NCG160565587||||||||
6B|NCG160565587|||||||
6C|NCG160565587|||||||||
6D|NCG160565587|||||||||||
6|NCG160565587|3|999|716|COMERCIALIZACION SUMINISTRO||||1|1||94|86379.00|86379.00|false|||||||||||||||||||
6A|NCG160565587||||||||
6B|NCG160565587|||||||
6C|NCG160565587|||||||||
6D|NCG160565587|||||||||||
6|NCG160565587|4|999|204|TRANSPORTE DE GAS||||1|1||94|340942.00|340942.00|false|||||||||||||||||||
6A|NCG160565587||||||||
6B|NCG160565587|||||||
6C|NCG160565587|||||||||
6D|NCG160565587|||||||||||
7|NCG160565587||||||||||||||||||||
8|NCG160565587|||||
9|NCG160565587|0|||
9|NCG160565587|1|||
9|NCG160565587|2|||
9|NCG160565587|3|||
9|NCG160565587|4|||
9|NCG160565587|5|||
9|NCG160565587|6|||
10|NCG160565587|1|200|SUMINISTRO DE GAS|1,207,580||||UND|1|1,207,580||
10|NCG160565587|2|20|CARGO POR DISTRIBUCION|409,260||||UND|1|409,260||
10|NCG160565587|3|716|COMERCIALIZACION SUMINISTRO|86,379||||UND|1|86,379||
10|NCG160565587|4|204|TRANSPORTE DE GAS|340,942||||UND|1|340,942||'
    where factura_electronica = 'NCG160565587';

    update  PERSONALIZACIONES.lote_fact_electronica  set CANTIDAD_REGISTRO = CANTIDAD_REGISTRO - 1      
    where CODIGO_LOTE = nuLoteActualizar;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Termino proceso');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/