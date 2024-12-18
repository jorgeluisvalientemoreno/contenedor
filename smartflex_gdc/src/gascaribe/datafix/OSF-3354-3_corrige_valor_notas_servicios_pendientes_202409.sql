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
    -- Septiembre - Eliminar notas ajustadas en contabilidad
    -- Corrige movimiento
    --
    vsbsolici := 183000986;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -8435609
     where l.nuano = 2024
       and l.numes in (8)
       and l.solicitud = 183000986
       and l.concepto = 400;
    commit; 
    --
    vsbsolici := 185280342;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = (l.carg_x_conex + l.cert_previa) * -1
     where l.nuano = 2024
       and l.numes in (8)
       and l.solicitud = 185280342
       and l.concepto in (4,400);
    commit; 
    --
    vsbsolici := 125600223;
    vsbclasif := '';   
    update open.ldc_osf_serv_pendiente l
       set l.ingreso_report = -345525000
     where l.nuano = 2024
       and l.numes in (8)
       and l.solicitud = 125600223
       and l.concepto in (19);
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