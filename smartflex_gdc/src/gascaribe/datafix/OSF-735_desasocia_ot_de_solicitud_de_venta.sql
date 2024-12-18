column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

Declare

 -- Cursor de solicitudes a desasociar OT legaizadas, segunda entrega
 Cursor CuPackages is
  select a.*
    from open.or_order_activity a, open.or_order o, open.ge_causal c
   where a.order_id in (
                          250770728, 250911859, 251494916, 252082745, 252680990, 253479767, 253984316, 254538927, 254723066, 255023355, 
                          255285085, 255850840, 256166169, 257192214, 257786392, 257786785, 258230137, 258568496, 258823672, 259149110, 
                          260201826, 260876159, 261077791, 261086707, 262446882, 262885290, 263184379, 263644248, 264137337, 264417220, 
                          264748523, 265044732, 265537305, 265828947, 266163603,
                          123686693, 183574695, 186957379, 187631924, 187946206, 188205407, 189036968, 193375806, 245635685, 248337202, 
                          248841558, 249809242, 253320702, 253707296, 254294873, 255284979, 257776768,
                          250394502, 250394937, 251352047, 251467254, 257777739
                         )
     and a.order_id = o.order_id
     and o.causal_id = c.causal_id
     /*and c.class_causal_id = 1*/;
     
    -- Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

    nuPersonID open.ge_person.person_id%type;
    nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    SBCOMMENT       VARCHAR2(4000) := 'CASO OSF-735, SE DESASOCIA ORDEN DE LA SOLICITUD ';
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