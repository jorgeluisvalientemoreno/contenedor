CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_DELETE_WF_INSTANCE( inuPackageId in number, procesado out varchar2 ) is
  instanceId varchar2(4000) := null;
  type arrVarchar is table of varchar2(4000) index by pls_integer;
  plsqls arrVarchar;
begin
  procesado := 'N' ;
  plsqls(1) := 'delete from wf_instance_trans where origin_id in ( :x ) ';
  plsqls(2) := 'delete from wf_instance_trans where target_id in ( :x ) ';
  plsqls(3) := 'delete from wf_exception_log where instance_id in ( :x ) ';
  plsqls(4) := 'delete from mo_wf_comp_interfac where activity_id in ( :x ) ';
  plsqls(5) := 'delete from mo_wf_comp_interfac where previous_activity_id in ( :x ) ';
  plsqls(6) := 'delete from mo_wf_comp_interfac where undo_activity_id in ( :x ) ';
  plsqls(7) := 'delete from mo_wf_motiv_interfac where activity_id in ( :x ) ';
  plsqls(8) := 'delete from mo_wf_motiv_interfac where previous_activity_id in ( :x ) ';
  plsqls(9) := 'delete from mo_wf_motiv_interfac where undo_activity_id in ( :x ) ';

  plsqls(10) := 'delete from mo_wf_pack_interfac where activity_id in ( :x ) ';
  plsqls(11) := 'delete from mo_wf_pack_interfac where previous_activity_id in ( :x ) ';
  plsqls(12) := 'delete from mo_wf_pack_interfac where undo_activity_id in ( :x ) ';

  plsqls(10) := 'delete from mo_wf_pack_interfac where activity_id in ( :x ) ';
  plsqls(11) := 'delete from mo_wf_pack_interfac where previous_activity_id in ( :x ) ';
  plsqls(12) := 'delete from mo_wf_pack_interfac where undo_activity_id in ( :x ) ';
  plsqls(13) := 'delete from wf_instance_equiv where instance_id in ( :x ) ';
  plsqls(14) := 'delete from wf_instance_data_map where source_id in ( ' ||
    '  select instance_attrib_id from wf_instance_attrib where instance_id in ( :x ) ) ' ;
  plsqls(15) := 'delete from wf_instance_data_map where target in ( ' ||
    '  select instance_attrib_id from wf_instance_attrib where instance_id in ( :x ) ) ' ;
  plsqls(16) := 'delete from wf_instance_attrib where instance_id in ( :x ) ';
  plsqls(17) := 'delete from wf_instance where instance_id in ( :x ) ';
  plsqls(18) := 'delete from wf_data_external where plan_id in ( :x ) ';
  plsqls(19) := 'update or_order_activity set instance_id = null where instance_id in ( :x ) ' ;
  plsqls(20) := 'delete from in_interface_history where request_number_origi in ( :x ) ' ;

  select listagg( wf.instance_id, ',' ) within group ( order by wf.instance_id ) into instanceId
  from wf_data_external wd
  inner join wf_instance wf on wf.plan_id = wd.plan_id
  where wd.package_id = inuPackageId ;

  for i in 1 .. plsqls.count loop
    execute immediate replace( plsqls(i), ':x', instanceId );
  end loop ;

  delete from ge_executor_log where executor_log_id in ( select executor_log_id from mo_executor_log_mot where package_id = inuPackageId ) ;
  delete from mo_executor_log_mot where package_id = inuPackageId ;

  commit;

  procesado := 'Y' ;
exception
  when others then
    rollback;
end ;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_DELETE_WF_INSTANCE', 'ADM_PERSON');
END;
/
