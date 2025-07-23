column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
   onuError      NUMBER;
   osbError      VARCHAR2(4000);
   sesion  number;
   nuIdReporte   	NUMBER;
   nuLote  number;
   nuLoteActualizar number := 5395;
begin
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);

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

    update factura_elect_general set CODIGO_LOTE = nuLote,
            TEXTO_ENVIADO = '1|GCFS531719|01|09|1|GCFS|531719|2024-12-20|00:00:00-05:00||||||COP|3|2|||2025-02-02|2024-12-01|03:12:46-05:00|2024-12-31|11:01:59-05:00|176050599.00|6211217.00|177230730.00|0.00||0|0|177230730.00||||||67555333|||||||||||||||||||||||2143544566||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||ARTE_FACTURA_OTROS_SERVICIOS.PDF|2|https://portal.gascaribe.com/payments/coupon/
1A|GCFS531719||||||
1B|GCFS531719|||||||
2|GCFS531719|NO|||OPEN SYSTEMS COLOMBIA S.A.S|9004017146|OPEN|OPEN SMARTFLEX|18764075091087|1|30000000|GCFS|2024-07-15|2024-07-15|2026-07-14
3|GCFS531719|1|31|NIT|890101691|2|GASES DEL CARIBE S A EMPRESA DE SERVICIOS PUBLICOS GASCARIBE S A E S P|GASES DEL CARIBE S.A. E.S.P.|4418|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|08|ATLANTICO|08001|BARRANQUILLA|CR 59 59 166|080001|CO|COLOMBIA|RESPONSABLE DE IVA|O-13;O-15|01|IVA|correo@gascaribe.com||3306000|3306000||||||||||
3A|GCFS531719||||||||||
4|GCFS531719|1|31|NIT|901127259|5|ALURACK SAS |||08|ATLANTICO|08433|MALAMBO|PARQ IND PIMSA MALAMBO BODEGA 6||CO|COLOMBIA|No Aplica|R-99-PN|ZZ|Otros tributos|notiene@correo.com|||||||||||||||
5|GCFS531719|01|IVA|1180131.00|false|||||
5A|GCFS531719|6211217.00|1180131.00|19.00||||||||
6|GCFS531719|1|999|674|CERTIFICACIÓN INSTALAC PREVIA||||1|1||94|1302375.00|1302375.00|false|||||||||||||||||||
6A|GCFS531719||||||||
6B|GCFS531719|||||||
6C|GCFS531719|01|IVA|247451.00|false|||||
6D|GCFS531719|1302375.00|247451.00|19.00||||||||
6|GCFS531719|2|999|291|RED INTERNA INDUSTRIAL|Contrato de servicios AIU por concepto de: RED INTERNA INDUSTRIAL|||1|1||94|75269055.00|75269055.00|false|||||||||||||||||||
6A|GCFS531719||||||||
6B|GCFS531719|||||||
6C|GCFS531719|01|IVA|932680.00|false|||||
6D|GCFS531719|4908842.00|932680.00|19.00||||||||
6|GCFS531719|3|999|19|CARGO POR CONEXIÓN||||1|1||94|99479169.00|99479169.00|false|||||||||||||||||||
6A|GCFS531719||||||||
6B|GCFS531719|||||||
6C|GCFS531719|||||||||
6D|GCFS531719|||||||||||
7|GCFS531719||||||||||||||||||||
8|GCFS531719|||||
9|GCFS531719|0|||
9|GCFS531719|1|||
9|GCFS531719|2|||
9|GCFS531719|3|||
9|GCFS531719|4|||
9|GCFS531719|5|||
9|GCFS531719|6|||
10|GCFS531719|1|674|CERTIFICACIÓN INSTALAC PREVIA|1,302,375||||UND|1|1,302,375|247,451|
10|GCFS531719|2|291|RED INTERNA INDUSTRIAL|75,269,055||||UND|1|75,269,055|932,680|
10|GCFS531719|3|19|CARGO POR CONEXIÓN|99,479,169||||UND|1|99,479,169||'
	where  factura_electronica = 'GCFS531719';

    update  PERSONALIZACIONES.lote_fact_electronica  set CANTIDAD_REGISTRO = CANTIDAD_REGISTRO - 1      
    where CODIGO_LOTE = nuLoteActualizar;
	
	update cargos set cargvabl =170870048
	where cargcodo = 158656327 and cargcuco = 3073819954 and cargconc = 991;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE(' osbError '||osbError);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/