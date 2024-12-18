column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cuListadoOrden is
    select 335270939 orden from dual;

  rfcuListadoOrden cuListadoOrden%rowtype;

  SBCOMMENT     VARCHAR2(4000) := 'SE ANULA ORDEN ERRONEA CREADA POR GIS CASO OSF-3556';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

BEGIN

  --Recorrer Lsitado de ordenes
  for rfcuListadoOrden in cuListadoOrden loop
    BEGIN
      -- Anulamos la OT
      or_boanullorder.anullorderwithoutval(rfcuListadoOrden.Orden, SYSDATE);
    
      --/*-- Adicionamos comentario a la OT
      OS_ADDORDERCOMMENT(rfcuListadoOrden.Orden,
                         nuCommentType,
                         SBCOMMENT,
                         nuErrorCode,
                         sbErrorMesse);
      --*/
    
      If nuErrorCode = 0 then
        commit;
        dbms_output.put_line('Orden ' || rfcuListadoOrden.Orden ||
                             ' anulada Ok.' || sbErrorMesse);
      Else
        rollback;
        dbms_output.put_line('Error en Anular la Orden ' ||
                             rfcuListadoOrden.Orden || ' Error : ' ||
                             sbErrorMesse);
      End if;
      --
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error en Orden ' || rfcuListadoOrden.Orden ||
                             ' Error : ' || SQLERRM);
    END;
    --  
  end loop;

END;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/