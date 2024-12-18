column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare

 -- Cursor de solicitudes a desasociar OT legaizadas - Segunda Entrega
 Cursor CuPackages is
  select a.*
    from open.or_order_activity a, open.or_order o, open.ge_causal c
   where a.package_id in (162562702)
     and a.order_id = o.order_id
     and o.causal_id = c.causal_id
     and c.class_causal_id = 1;
     
    -- Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

    nuPersonID open.ge_person.person_id%type;
    nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    SBCOMMENT       VARCHAR2(4000) := 'CASO SOSF-1192, SE DESASOCIA ORDEN DE LA SOLICITUD ';
    nuCommentType   number:=1277;
    nuErrorCode     number;
    sbErrorMesse    varchar2(4000);
    nuacta          number;     
    nuorden         number;
    nusolicitud     number;
     
Begin
  
  For reg in CuPackages loop
    --
    nuorden     := reg.order_id;
    nusolicitud := reg.package_id;
    -- Desasociamos la orden de la solicitud
    update open.or_order_activity a
       set a.package_id = null
     where a.order_id = reg.order_id;
    --
    OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, SBCOMMENT || reg.package_id, nuErrorCode, sbErrorMesse);       
    --
    If nuErrorCode = 0 then
       commit;
    Else
       rollback;
       dbms_output.put_line('Error en Orden ' || reg.order_id || ' Error : ' || sbErrorMesse);
    End if;

  End loop;
  --
  dbms_output.put_line('Proceso termina correctamente');
  
Exception
  when no_data_found then
    rollback;
    dbms_output.put_line('No se puedo desvincular de la orden ' || nuorden || ' de la solicitud ' || nusolicitud);
End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/