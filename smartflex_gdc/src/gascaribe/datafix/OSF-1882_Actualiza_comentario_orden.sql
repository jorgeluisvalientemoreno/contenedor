column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1882');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

Declare

	sborder_comment OR_ORDER_COMMENT.order_comment%type := 'HACER REVISION DE INSTALACION. VERIFICAR GASODOMESTICOS INSTLADOS. FUNCIONAMIENTO ESTADO DEL MEDIDOR. REVISAR ACOMETIDA REALIZANDO APIQUE. // / VERIFICAR INSTALACIONES INTERNA, VERIFICAR PRESION DE SUMINISTRO// VERIFICAR CON CÁMARA ENDOSCÓPICA DE SER NECESARIO, TOMAR EVIDENCIAS FOTOGRÁFICAS DEL CASO, SUSPENDER SERVICIO POR SEGURIDAD SI NO PERMITEN REVISIÓN, VERIFICAR GASODOMÉSTICOS VS CAPACIDAD DEL MEDIDOR, VERIFICAR FUNCIONAMIENTO. VERIFICAR SELLOS Y TAPONES DE SEGURIDAD DEL MEDIDOR, VALIDAR TODO, PROCEDER SEGÚN EL CASO. // FUNCIONA HOTEL AMERICAN GOLF Y RESTAURANTE PONTE VEDRA,';

begin
  dbms_output.put_line('Inicia OSF-1882');
  
  UPDATE OR_ORDER_ACTIVITY
  SET comment_ = sborder_comment
  WHERE ORDER_ACTIVITY_ID = 284467395;
  
  UPDATE OR_ORDER_COMMENT
  SET order_comment = sborder_comment
  WHERE ORDER_COMMENT_ID = 537937928;  
  
  dbms_output.put_line('Termina OSF-1882');
  
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/