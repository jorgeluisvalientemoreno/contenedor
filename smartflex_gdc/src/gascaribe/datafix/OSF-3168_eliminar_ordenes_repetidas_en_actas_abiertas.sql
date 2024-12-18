column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuActaOrdenRepetida is
    select 229635 acta
      from dual
    union all
    select 229771 acta
      from dual
    union all
    select 229832 acta
      from dual
    union all
    select 229870 acta
      from dual
    union all
    select 229890 acta
      from dual;

  rfActaOrdenRepetida cuActaOrdenRepetida%rowtype;

  cursor cuActa(inuActaAbierta number) is
    select coc.certificate_id Acta_Abierta,
           coc.order_id       Orden_Repetida,
           c2.certificate_id  Acta_Cerrada,
           a2.estado
      from open.ge_acta ga
     inner join OPEN.CT_ORDER_CERTIFICA coc
        on ga.id_acta = coc.certificate_id
     inner join open.ct_order_certifica c2
        on c2.order_id = coc.order_id
       and c2.certificate_id != coc.certificate_id
     inner join open.ge_acta a2
        on a2.id_acta = c2.certificate_id
     where ga.estado = 'A'
       and ga.id_acta = inuActaAbierta
     order by 1, 2;

  rfActa cuActa%rowtype;

begin
  for rfActaOrdenRepetida in cuActaOrdenRepetida loop
  
    for rfActa in cuActa(rfActaOrdenRepetida.acta) loop
    
      begin
      
        --/*
        delete OPEN.CT_ORDER_CERTIFICA coc
         where coc.order_id = rfActa.Orden_Repetida
           and coc.certificate_id = rfActa.Acta_abierta;
      
        delete OPEN.ge_detalle_acta gda
         where gda.id_orden = rfActa.Orden_Repetida
           and gda.id_acta = rfActa.Acta_abierta;
        --*/
      
        commit;
      
        dbms_output.put_line('Se elimino orden: ' || rfActa.Orden_Repetida ||
                             ' repetida del acta abierta: ' ||
                             rfActa.Acta_abierta);
      
      exception
        when others then
          rollback;
          dbms_output.put_line('Error al eliminar orden: ' ||
                               rfActa.Orden_Repetida ||
                               ' relacionada del acta abierta: ' ||
                               rfActa.Acta_abierta || ' - Error: ' ||
                               sqlerrm);
      end;
    
    end loop;
  end loop;
end;
/



select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/