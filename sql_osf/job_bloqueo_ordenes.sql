declare
  cursor cuOrden is
    select oo.*
      from open.or_order_activity ooa, open.or_order oo
     where oo.order_id = ooa.order_id
       and oo.task_type_id = 12149
       and oo.order_status_id in (5)
       and ooa.package_id = 195263154;
  rfcuOrden       cuOrden%rowtype;
  contador        number;
  onuerrorcode    number;
  osberrormessage varchar2(4000);
begin
  contador := 1;
  for rfcuOrden in cuOrden loop
    BEGIN
      DBMS_SCHEDULER.CREATE_JOB(job_name   => 'BLOQUEO_ORDEN_' || contador,
                                job_type   => 'PLSQL_BLOCK',
                                job_action => 'DECLARE
                                               onuerrorcode numeric;
                                               osberrormessage varchar2(4000);                                               
                                               BEGIN os_lockorder(inuorderid      => ' ||
                                              rfcuOrden.order_id || ',
                                                                    inucommenttype  => 1296,
                                                                    isbcomment      => ''Bloqueo Orden'',
                                                                    idtchangedate   => sysdate,
                                                                    onuerrorcode    => onuerrorcode,
                                                                    osberrormessage => osberrormessage);
                                                            if onuerrorcode = 0 then
                                                              commit;
                                                            else
                                                              rollback;
                                                            end if; END;',
                                start_date => sysdate,
                                auto_drop  => TRUE,
                                enabled    => TRUE,
                                comments   => 'Job Bloqueo Orden ' ||
                                              rfcuOrden.order_id);
      dbms_output.put_line('Job BLOQUEO_ORDEN_' || contador);
    exception
      when others then
        dbms_output.put_line('Error: ' || sqlerrm);
    END;
    contador := contador + 1;
  end loop;
end;
