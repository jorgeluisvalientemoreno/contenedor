column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  -- Comentario de orden 
  -- Registro de Comentario de la orden
  rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

  nuPersonID open.ge_person.person_id%type;
  nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

  SBCOMMENT     VARCHAR2(4000) := 'CAMBIO DE CAUSAL CON DIFERENTE CLASIFICACION CASO OSF-3096';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
  nuacta        number;
  nuorden       number;
  nusolicitud   number;

BEGIN

  UPDATE or_order oo SET oo.causal_id = 8001 WHERE oo.order_id = 329467519;

  UPDATE or_order_items ooi
     SET ooi.legal_item_amount = 0
   WHERE ooi.order_id = 329467519;

  OS_ADDORDERCOMMENT(329467519,
                     nuCommentType,
                     SBCOMMENT,
                     nuErrorCode,
                     sbErrorMesse);

  If nuErrorCode = 0 then
    commit;
    dbms_output.put_line('Se actualizo causal de la orden 329467519');
  Else
    rollback;
    dbms_output.put_line('Error actualizando la causal de la orden 329467519 - ' ||
                         sqlerrm || ' - ' || sbErrorMesse);
  End if;

exception
  when others then
    rollback;
    dbms_output.put_line('Error actualizando la causal de la orden 329467519 - ' ||
                         sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/