column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  sbComment          or_order_comment.order_comment%TYPE := 'Se actualiza al fecha del campo FECHA MAXIMA PARA LEGALIZACION a la fecha 29/06/2023 con el CASO OSF-1295';
  nuCommTypeId       or_order_comment.comment_type_id%TYPE := 1277;
  nuErrorCode        number;
  sbErrorMesse       varchar2(4000);
  inuOrden           number := 245466048;
  dtfechamaxlegantes DATE;
  nuEstado           number(2);
  nutipotrab         or_task_type.task_type_id%TYPE;
  sbobservacion      or_log_order_action.error_message%TYPE;

BEGIN

  UPDATE or_order
     SET MAX_DATE_TO_LEGALIZE = to_date('29/06/2023', 'DD/MM/YYYY')
   WHERE order_id = inuOrden;

  SELECT o.max_date_to_legalize, o.task_type_id, o.order_status_id
    INTO dtfechamaxlegantes, nutipotrab, nuEstado
    FROM open.or_order o
   WHERE o.order_id = inuOrden;

  sbobservacion := 'MAX_DATE_TO_LEGALIZE -' || sbComment;

  INSERT INTO ldc_log_camb_fecha_max_leg
  VALUES
    (inuOrden,
     NULL,
     nutipotrab,
     dtfechamaxlegantes,
     to_date('29/06/2023', 'DD/MM/YYYY'),
     SYSDATE,
     USER,
     sbobservacion);

  commit;
  dbms_output.put_line('Se actualiza OK orden: ' || inuOrden);

exception
  when others then
    dbms_output.put_line('Error actualiza orden: ' || inuOrden || ' : ' ||
                         sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/