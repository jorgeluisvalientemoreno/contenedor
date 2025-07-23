column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuLote NUMBER;
  nuLoteActualizar NUMBER := 6507;
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
				TEXTO_ENVIADO = '1|NCG159088806|91|22|1|NCG|159088806|2025-01-17|00:00:00-05:00|||1|Devolución parcial de los bienes y/o no aceptación parcial del servicio||COP|1|2|||2025-01-30|2025-01-01|02:01:12-05:00|2025-01-31|02:01:12-05:00|18360000.00|1836000.00|18708840.00|0.00||0|0|18708840.00||||||67344799|||||||||||||||||||||||159088806|||nota credito debido a que el valor cotizado de Red Interna es de 43.200.000 y se facturó 61.560.000 segun memorando 25-000308 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
1A|NCG159088806||||||
1B|NCG159088806|||||||
2|NCG159088806|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NCG|||
3|NCG159088806|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|NCG159088806||||||||||
4|NCG159088806|1|31|NIT|901413067|4|GRUPO INMOBILIARIO SEVILLA S.A.S. |||08|ATLANTICO|08758|SOLEDAD|CL 74 KR 7D - 22 CONRES M. DE SEVILLA||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|notiene@correo.com|||||||||||||||
5|NCG159088806|01|IVA|348840.00|false|||||
5A|NCG159088806|1836000.00|348840.00|19.00||||||||
6|NCG159088806|1|999|30|CONSTRUCCIÓN RED INTERNA||||1|1||94|18360000.00|18360000.00|false|||||||||||||||||||
6A|NCG159088806||||||||
6B|NCG159088806|||||||
6C|NCG159088806|01|IVA|348840.00|false|||||
6D|NCG159088806|1836000.00|348840.00|19.00||||||||
7|NCG159088806||||||||||||||||||||
8|NCG159088806|||||
9|NCG159088806|0|||
9|NCG159088806|1|||
9|NCG159088806|2|||
9|NCG159088806|3|||
9|NCG159088806|4|||
9|NCG159088806|5|||
9|NCG159088806|6|||
10|NCG159088806|1|30|CONSTRUCCIÓN RED INTERNA|18,360,000||||UND|1|18,360,000|348,840|'
    where factura_electronica = 'NCG159088806';

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