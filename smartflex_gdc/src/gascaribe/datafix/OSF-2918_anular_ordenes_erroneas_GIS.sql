column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cuListadoOrden is
    select 328666227 orden from dual union all
    select 328666162 orden from dual union all
    select 329264529 orden from dual union all
    select 329013410 orden from dual union all
    select 328900486 orden from dual union all
    select 328900483 orden from dual union all
    select 328900481 orden from dual union all
    select 328900479 orden from dual union all
    select 328900476 orden from dual union all
    select 328900473 orden from dual union all
    select 328900394 orden from dual union all
    select 328900392 orden from dual union all
    select 329677197 orden from dual union all
    select 328369604 orden from dual union all
    select 328368383 orden from dual union all
    select 328497121 orden from dual union all
    select 328497108 orden from dual union all
    select 327863875 orden from dual union all
    select 329025656 orden from dual union all
    select 329468619 orden from dual union all
    select 326799133 orden from dual union all
    select 326799151 orden from dual union all
    select 326799756 orden from dual;

  rfcuListadoOrden cuListadoOrden%rowtype;

  --cursor para DATA de orden 
  cursor cuDataOrden(inuOrden number) is
    select o.order_id ORDEN, o.order_status_id estado
      from open.or_order o
     where o.order_id = inuOrden;

  rfcuDataOrden cuDataOrden%rowtype;

  SBCOMMENT     VARCHAR2(4000) := 'SE ANULA ORDEN ERRONEA CREADA POR GIS CASO OSF-2918';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

BEGIN
  
  --Recorrer Lsitado de ordenes
  for rfcuListadoOrden in cuListadoOrden loop

    --Recorrer DATA de orden 
    for rfcuDataOrden in cuDataOrden(rfcuListadoOrden.Orden) loop
      if rfcuDataOrden.estado = 0 then
        BEGIN
          -- Anulamos la OT
          or_boanullorder.anullorderwithoutval(rfcuDataOrden.ORDEN,SYSDATE);
          
          --/*-- Adicionamos comentario a la OT
          OS_ADDORDERCOMMENT(rfcuDataOrden.ORDEN,
                             nuCommentType,
                             SBCOMMENT,
                             nuErrorCode,
                             sbErrorMesse);
          --*/
          
          If nuErrorCode = 0 then
            commit;
            dbms_output.put_line('Orden ' ||
                                 rfcuDataOrden.ORDEN || ' anulada Ok.' ||
                                 sbErrorMesse);
          Else
            rollback;
            dbms_output.put_line('Error en Orden ' ||
                                 rfcuDataOrden.ORDEN || ' Error : ' ||
                                 sbErrorMesse);
          End if;
          --
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Error en Orden ' ||
                                 rfcuDataOrden.ORDEN || ' Error : ' ||
                                 SQLERRM);
        END;
        --  
      else
            dbms_output.put_line('La Orden ' ||
                                 rfcuDataOrden.ORDEN || ' no se anula debido a que su estado no es 0 sino ' || rfcuDataOrden.estado);
      end if;
    end loop;
  end loop;
  
END;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/