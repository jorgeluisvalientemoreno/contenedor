column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare
    vsbsolici varchar2(15);
    vsbclasif varchar2(4);
  Begin
    -- Descontar servicio cumplido
    --
    vsbsolici := 217377867;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -29967834
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217377867
       and l.concepto = 4
       and l.CARG_X_CONEX = 74535382;
    commit;
    --
    vsbsolici := 181882394;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1177048
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 181882394
       and l.concepto = 4
       and l.CARG_X_CONEX = 4708192;
    commit;
    --
    vsbsolici := 217763132;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -1075960
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 217763132
       and l.concepto = 400;
    commit;
    --
    vsbsolici := 219132325;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -10329216
     where l.nuano =  2024
       and l.numes = 11
       and l.solicitud = 219132325
       and l.concepto = 400;
    commit;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error solicitud : ' || vsbsolici || '  clasificador : ' || vsbclasif ||'   ' || SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/