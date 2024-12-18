column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuOrdenActuCausal is
    SELECT od.order_id, od.causal_id, rownum nurownum
      FROM or_order od
     WHERE od.order_id in (340167495);

  PROCEDURE pActuCausalOrden(inuOrden  or_order.order_id%TYPE,
                             inuCausal or_order.causal_id%TYPE,
                             inuRownum NUMBER) IS
    rcOrderComment daor_order_comment.styor_order_comment;
  
    sbComment    or_order_comment.order_comment%TYPE := 'Se actualiza la causal a 9595 – SOLICITUD ATENDIDA por OSF-3716';
    nuCommTypeId or_order_comment.comment_type_id%TYPE := 83;
  
  BEGIN
  
    IF (inuCausal NOT IN (9595)) THEN
    
      UPDATE or_order SET causal_id = 9595 WHERE order_id = inuOrden;
    
      rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
      rcOrderComment.order_comment    := sbComment;
      rcOrderComment.order_id         := inuOrden;
      rcOrderComment.comment_type_id  := nuCommTypeId;
      rcOrderComment.register_date    := ut_date.fdtSysdate;
      rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
      rcOrderComment.person_id        := ge_boPersonal.fnuGetPersonId;
    
      daor_order_comment.insRecord(rcOrderComment);
    
      dbms_output.put_line('Causal orden ' || inuOrden ||
                           ' actualizada Ok.');
    
      commit;
    
    ELSE
    
      dbms_output.put_line('No se actualiza Orden |' || inuOrden ||
                           '|causal actual|' || inuCausal);
    
    END IF;
  
  exception
    when others then
      dbms_output.put_line('ERROR:  orden|' || inuOrden || '|' || SQLERRM);
      rollback;
    
  END pActuCausalOrden;

BEGIN

  FOR reg IN cuOrdenActuCausal LOOP
    pActuCausalOrden(reg.order_id, reg.causal_id, reg.nurownum);
  END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/