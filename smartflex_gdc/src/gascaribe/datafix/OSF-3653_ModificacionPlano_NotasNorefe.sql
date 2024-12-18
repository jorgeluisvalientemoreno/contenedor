column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuLote NUMBER;
  nuLoteActualizar NUMBER := 4079;
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
            TEXTO_ENVIADO = '1|NCG157913476|91|22|1|NCG|157913476|2024-11-22|00:00:00-05:00|||1|Devolución parcial de los bienes y/o no aceptación parcial del servicio||COP|1|2|||2024-11-30|2024-11-01|09:11:27-05:00|2024-11-30|09:11:27-05:00|563692.00|0.00|563692.00|0.00||0|0|563692.00||||||66407985|||||||||||||||||||||||157913476|||se aplica ncredito al concepto interes de mora por $563.692, ya que  la  factura del periodo anterior  se  envio tarde por  problemas de configuracion de correos para  facturas  el|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_NOTAS.PDF|3|https://portal.gascaribe.com/payments/coupon/
1A|NCG157913476||||||
1B|NCG157913476|||||||
2|NCG157913476|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX||||NCG|||
3|NCG157913476|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|NCG157913476||||||||||
4|NCG157913476|1|31|NIT|800007813|5|VANTI S.A E.S.P  |||||||CL 71A 5 - 38, BOGOTA(CUND)||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|notiene@correo.com|||||||||||||||
5|NCG157913476|||||||||
5A|NCG157913476|||||||||||
6|NCG157913476|1|999|156|RECARGO POR MORA NO GRAVADO SP||||1|1||94|563692.00|563692.00|false|||||||||||||||||||
6A|NCG157913476||||||||
6B|NCG157913476|||||||
6C|NCG157913476|||||||||
6D|NCG157913476|||||||||||
7|NCG157913476||||||||||||||||||||
8|NCG157913476|||||
9|NCG157913476|0|||
9|NCG157913476|1|||
9|NCG157913476|2|||
9|NCG157913476|3|||
9|NCG157913476|4|||
9|NCG157913476|5|||
9|NCG157913476|6|||
10|NCG157913476|1|156|RECARGO POR MORA NO GRAVADO SP|563,692||||UND|1|563,692||'
    where factura_electronica = 'NCG157913476';
    
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