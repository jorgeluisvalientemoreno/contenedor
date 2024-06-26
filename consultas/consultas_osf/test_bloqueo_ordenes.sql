declare

  cursor cuOrden is
    select oo.*
      from open.or_order_activity ooa, open.or_order oo
     where oo.order_id = ooa.order_id
       and oo.task_type_id = 12149
       and oo.order_status_id in (5)
       and ooa.package_id = 195263154;

  rfcuOrden cuOrden%rowtype;

  contador number;

  onuerrorcode    number;
  osberrormessage varchar2(4000);

begin
  /*ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);*/
  contador := 1;
  for rfcuOrden in cuOrden loop
    --dbms_output.put_line(contador || ' - Orden: ' || rfcuOrden.order_id);
    --contador := contador + 1;
    BEGIN
      DBMS_SCHEDULER.CREATE_JOB(job_name   => 'BLOQUEO_ORDEN_' || contador,
                                job_type   => 'PLSQL_BLOCK',
                                job_action => 'BEGIN os_lockorder(inuorderid      => ' ||
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
                                start_date => sysdate+1,
                                auto_drop  => TRUE,
                                enabled    => TRUE,
                                comments   => 'Job Bloqueo Orden ' ||
                                              rfcuOrden.order_id);
    
      dbms_output.put_line('Job BLOQUEO_ORDEN_' || contador);
    
    exception
      when others then
        dbms_output.put_line('Error: ' || sqlerrm);
    END;
  
  /*os_lockorder(inuorderid      => rfcuOrden.order_id,
                       inucommenttype  => 1296,
                       isbcomment      => 'Bloqueo Orden',
                       idtchangedate   => sysdate,
                       onuerrorcode    => onuerrorcode,
                       osberrormessage => osberrormessage);
          if onuerrorcode = 0 then
            dbms_output.put_line('************************* ' || contador ||
                                 ' - Orden: ' || rfcuOrden.order_id ||
                                 ' bloqueada Ok.');
            commit;
          else
            dbms_output.put_line('************************* Error: ' ||
                                 onuerrorcode || ' - ' || osberrormessage);
            rollback;
          end if;*/
  
  end loop;

  --commit;
end;
