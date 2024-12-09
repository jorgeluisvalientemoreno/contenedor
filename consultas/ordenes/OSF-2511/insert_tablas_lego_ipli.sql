declare
  task_type_id number;
  agente_id number;
  initial_date date;
  final_date date;
  ex_techni_not_exist exception;
  ex_order_not_exist exception;
  ex_null_dates exception;
  nuorden number:=335794064;
  onuerrorcode number;
  osberrormessage varchar2(4000);
begin
  begin
    select task_type_id 
    into task_type_id
    from open.or_order
    where order_id = nuorden;
  exception
    when no_data_found then 
      raise ex_order_not_exist;
  end;
    initial_date := sysdate-2;   --null
    final_date := sysdate-1;    --null
 
  insert into open.ldc_otlegalizar (
    order_id,
    causal_id,
    order_comment,
    exec_initial_date,
    exec_final_date,
    legalizado,
    fecha_registro,
    task_type_id
  ) values (
    nuorden,
    9589,
    'OSF_3357',
    initial_date,
    final_date,
    'N',
    sysdate,
    task_type_id
  );
  begin
    
    agente_id:=72;
  exception
    when no_data_found then 
      raise ex_techni_not_exist;
  end;
  insert into open.ldc_anexolegaliza (
    order_id,
    agente_id,
    tecnico_unidad
  ) values (
    nuorden,
    agente_id,
    38963
  );
  commit;
exception
  
  when others then
      "OPEN".errors.seterror;
      "OPEN".errors.geterror(onuerrorcode, osberrormessage);
      dbms_output.put_line (osberrormessage);
      rollback;
end;
