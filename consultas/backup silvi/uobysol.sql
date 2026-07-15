Select *
from open.ldc_order o
Where  1=1
--o.ordefere is not null
and o.order_id in (391286664);


update ldc_order  lo  set lo.asignacion = 1  where lo.order_id  = 391286664; 

select *
from or_order_activity  
where order_id in (391286664);

select *
from or_order
where order_id in (391286664);


Select a.package_type_id, s.description, t.package_type_oper_unit_id, t.operating_unit_id, u.name, t.task_type_id , t.items_id, i.description, t.procesopre, t.procesopost, t.catecodi
From open.LDC_PACKAGE_TYPE_ASSIGN  a,
     open.PS_PACKAGE_TYPE  s,
     open.LDC_PACKAGE_TYPE_OPER_UNIT  t,
     open.GE_ITEMS  i,
     open.OR_OPERATING_UNIT  u
Where a.package_type_id = s.package_type_id
and   a.package_type_assign_id = t.package_type_assign_id
and   t.items_id = i.items_id
and   t.operating_unit_id = u.operating_unit_id
and-- t.task_type_id  =  10345

  u.operating_unit_id = 5083
--and   a.package_type_id = 288
and   t.items_id in (4295328)
--and u.name Like '%DISPAPELES%'

;

declare
    nuerror ge_error_log.error_log_id%TYPE;
    sberror ge_error_log.description%TYPE;
begin
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO');
    nuerror := pkConstante.EXITO;
    LDC_BOASIGAUTO.PRASIGNACION
    (
        null
    );
    dbms_output.put_line('Finalizo sin error');
    dbms_output.put_line('Mensaje '||sberror);
exception
    when others then
        pkerrors.geterrorvar(nuerror,sberror);
        dbms_output.put_line('Error Exception '||sberror);
end;
