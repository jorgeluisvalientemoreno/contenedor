column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update open.or_order o
   set o.order_status_id = 8
 where o.order_id in (261202255,261202258,261202260)
   and o.order_status_id = 12;
  commit;
  /* inserta cambio de estado de las OT */
  insert into OPEN.or_order_stat_change (ORDER_STAT_CHANGE_ID,
                                       ACTION_ID,
                                       INITIAL_STATUS_ID,
                                       FINAL_STATUS_ID,
                                       ORDER_ID,
                                       STAT_CHG_DATE,
                                       USER_ID,
                                       TERMINAL,
                                       execution_date,
                                       range_description,
                                       programing_class_id ,
                                       initial_oper_unit_id,
                                       final_oper_unit_id,
                                       COMMENT_TYPE_ID,
                                       CAUSAL_ID)
                               values (or_bosequences.fnuNextOr_Order_Stat_Change,
                                       113,
                                       12,
                                       8,
                                       261202255,
                                       sysdate,
                                       user,
                                       nvl(userenv('TERMINAL'),'know'),
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null);

 insert into OPEN.or_order_stat_change (ORDER_STAT_CHANGE_ID,
                                       ACTION_ID,
                                       INITIAL_STATUS_ID,
                                       FINAL_STATUS_ID,
                                       ORDER_ID,
                                       STAT_CHG_DATE,
                                       USER_ID,
                                       TERMINAL,
                                       execution_date,
                                       range_description,
                                       programing_class_id ,
                                       initial_oper_unit_id,
                                       final_oper_unit_id,
                                       COMMENT_TYPE_ID,
                                       CAUSAL_ID)
                               values (or_bosequences.fnuNextOr_Order_Stat_Change,
                                       113,
                                       12,
                                       8,
                                       261202258,
                                       sysdate,
                                       user,
                                       nvl(userenv('TERMINAL'),'know'),
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null);

insert into OPEN.or_order_stat_change (ORDER_STAT_CHANGE_ID,
                                       ACTION_ID,
                                       INITIAL_STATUS_ID,
                                       FINAL_STATUS_ID,
                                       ORDER_ID,
                                       STAT_CHG_DATE,
                                       USER_ID,
                                       TERMINAL,
                                       execution_date,
                                       range_description,
                                       programing_class_id ,
                                       initial_oper_unit_id,
                                       final_oper_unit_id,
                                       COMMENT_TYPE_ID,
                                       CAUSAL_ID)
                               values (or_bosequences.fnuNextOr_Order_Stat_Change,
                                       113,
                                       12,
                                       8,
                                       261202260,
                                       sysdate,
                                       user,
                                       nvl(userenv('TERMINAL'),'know'),
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null,
                                       null);
commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/