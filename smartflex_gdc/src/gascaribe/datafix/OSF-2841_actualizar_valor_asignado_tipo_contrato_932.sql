column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  nuerror NUMBER;
  sberror VARCHAR2(4000);

  CURSOR cuValorAsignado(inuContratoDefinido number) IS
    SELECT SUM(nvl(oo.estimated_cost, 0)) VALOR_ASIGNADO
      from open.or_order oo
     where oo.order_status_id in (5, 6, 7)
       and oo.defined_contract_id = inuContratoDefinido;

  nuValorAsignado open.ge_contrato.valor_asignado%type;

  cursor cuContratos is
    select gc.*
      from open.ge_contrato gc
     where gc.id_tipo_contrato = 932
       and gc.status = 'AB';

  rfContratos cuContratos%rowtype;

begin

  dbms_output.put_line('Inicia OSF-2841');

  BEGIN
  
    dbms_output.put_line('CONTRATO|VALOR_ASIGNADO_ANTERIOR|VALOR_ASIGNADO_NUEVO|');
  
    for rfContratos in cuContratos loop
    
      open cuValorAsignado(rfContratos.id_contrato);
      fetch cuValorAsignado
        into nuValorAsignado;
      close cuValorAsignado;
    
      --/*
      update ge_contrato
         set valor_asignado = nuValorAsignado
       where id_contrato = rfContratos.id_contrato
         and id_tipo_contrato = rfContratos.id_tipo_contrato
         and status = 'AB';
      
      commit;
      --*/
    
      dbms_output.put_line(rfContratos.id_contrato || '|' ||
                           rfContratos.valor_asignado || '|' ||
                           nuValorAsignado || '|');
    
    end loop;
  
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Error no controlado --> ' || sqlerrm);
  END;

  dbms_output.put_line('Termina OSF-2841');

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/