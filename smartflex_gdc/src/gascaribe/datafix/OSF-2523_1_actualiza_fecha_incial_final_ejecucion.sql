column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  
  --/*
  cursor cuOrden is
  select 318976696 orden, '18/03/2024 10:26:42' fecha_inicial_ejecucion, '18/03/2024 11:28:11' fecha_final_ejecucion from dual union 
  select 319146615 orden, '19/03/2024 08:59:10' fecha_inicial_ejecucion, '19/03/2024 09:33:17' fecha_final_ejecucion from dual union 
  select 319149762 orden, '19/03/2024 10:12:28' fecha_inicial_ejecucion, '19/03/2024 10:47:56' fecha_final_ejecucion from dual union 
  select 319151905 orden, '19/03/2024 12:52:57' fecha_inicial_ejecucion, '19/03/2024 13:02:38' fecha_final_ejecucion from dual union 
  select 319152418 orden, '19/03/2024 13:39:48' fecha_inicial_ejecucion, '19/03/2024 13:59:07' fecha_final_ejecucion from dual union 
  select 319175323 orden, '19/03/2024 15:09:39' fecha_inicial_ejecucion, '19/03/2024 15:20:52' fecha_final_ejecucion from dual union 
  select 319175485 orden, '19/03/2024 15:21:19' fecha_inicial_ejecucion, '19/03/2024 15:27:44' fecha_final_ejecucion from dual union 
  select 319179749 orden, '19/03/2024 13:27:50' fecha_inicial_ejecucion, '19/03/2024 13:42:54' fecha_final_ejecucion from dual union 
  select 319204932 orden, '20/03/2024 10:57:34' fecha_inicial_ejecucion, '20/03/2024 11:32:06' fecha_final_ejecucion from dual union 
  select 319304738 orden, '21/03/2024 17:29:42' fecha_inicial_ejecucion, '21/03/2024 17:31:51' fecha_final_ejecucion from dual union 
  select 319460581 orden, '22/03/2024 12:53:15' fecha_inicial_ejecucion, '22/03/2024 13:00:55' fecha_final_ejecucion from dual union 
  select 319507268 orden, '22/03/2024 15:21:01' fecha_inicial_ejecucion, '22/03/2024 15:28:49' fecha_final_ejecucion from dual union 
  select 319596996 orden, '23/03/2024 09:18:00' fecha_inicial_ejecucion, '23/03/2024 09:31:30' fecha_final_ejecucion from dual union 
  select 319600007 orden, '23/03/2024 10:50:23' fecha_inicial_ejecucion, '23/03/2024 11:40:33' fecha_final_ejecucion from dual union 
  select 319600982 orden, '23/03/2024 11:51:22' fecha_inicial_ejecucion, '23/03/2024 12:24:46' fecha_final_ejecucion from dual union 
  select 319621713 orden, '23/03/2024 16:11:18' fecha_inicial_ejecucion, '23/03/2024 17:21:00' fecha_final_ejecucion from dual union 
  select 319705718 orden, '25/03/2024 11:17:28' fecha_inicial_ejecucion, '25/03/2024 11:31:40' fecha_final_ejecucion from dual union 
  select 319706319 orden, '25/03/2024 12:56:18' fecha_inicial_ejecucion, '25/03/2024 13:44:35' fecha_final_ejecucion from dual union 
  select 319777653 orden, '26/03/2024 10:28:19' fecha_inicial_ejecucion, '26/03/2024 10:58:54' fecha_final_ejecucion from dual union 
  select 319783558 orden, '26/03/2024 08:42:04' fecha_inicial_ejecucion, '26/03/2024 11:15:30' fecha_final_ejecucion from dual union 
  select 319823037 orden, '26/03/2024 14:39:46' fecha_inicial_ejecucion, '26/03/2024 15:10:55' fecha_final_ejecucion from dual union 
  select 319827946 orden, '26/03/2024 14:24:58' fecha_inicial_ejecucion, '26/03/2024 16:45:18' fecha_final_ejecucion from dual union 
  select 319948624 orden, '27/03/2024 12:56:06' fecha_inicial_ejecucion, '27/03/2024 13:41:22' fecha_final_ejecucion from dual;
  --*/

  cursor cuOrdenLegalizada(nuOrden number) is
    select count(1)
      from open.or_order oo
     where oo.order_id = nuOrden
       and oo.order_status_id = 8;

  nuOrdenLegalizada number;

BEGIN
  for rfcuOrden in cuOrden loop
    begin
    
      open cuOrdenLegalizada(rfcuOrden.orden);
      fetch cuOrdenLegalizada
        into nuOrdenLegalizada;
      close cuOrdenLegalizada;
    
      if nuOrdenLegalizada = 0 then
      
        UPDATE LDC_OTLEGALIZAR
           SET EXEC_INITIAL_DATE    = TO_DATE(rfcuOrden.fecha_inicial_ejecucion,
                                              'DD-MM-YYYY HH24:MI:SS'),
               EXEC_FINAL_DATE = TO_DATE(rfcuOrden.fecha_final_ejecucion,
                                              'DD-MM-YYYY HH24:MI:SS')
         WHERE ORDER_ID = rfcuOrden.orden;
        COMMIT;
        
        dbms_output.put_line('Orden ' || rfcuOrden.orden ||
                             ' actualizar fecha incial ejecucion con ' ||
                             rfcuOrden.fecha_inicial_ejecucion ||
                             ' y fecha final ejecucion con ' ||
                             rfcuOrden.fecha_final_ejecucion);

      else
        dbms_output.put_line('Orden ' || rfcuOrden.orden ||
                             ' legalizada');
      end if;

    exception
      when others then
        rollback;
        dbms_output.put_line('Orden ' || rfcuOrden.orden || ' - Error: ' || sqlerrm);
    end;
  end loop;

END;

/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/