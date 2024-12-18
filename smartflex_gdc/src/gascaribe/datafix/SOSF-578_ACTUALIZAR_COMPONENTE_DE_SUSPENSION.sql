column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cupoblacion is
    select *
      from (select /*+ index (ps IDX_PR_PROD_SUSPENSION_01)*/
             ps.PROD_SUSPENSION_ID PROD_SUSPENSION_ID,
             ps.PRODUCT_ID         PRODUCT_ID,
             ps.SUSPENSION_TYPE_ID SUSPENSION_TYPE_ID,
             ps.REGISTER_DATE      REGISTER_DATE,
             ps.APLICATION_DATE    APLICATION_DATE,
             ps.INACTIVE_DATE      INACTIVE_DATE,
             ps.ACTIVE             ACTIVE,
             ps.CONNECTION_CODE    CONNECTION_CODE,
             cmsssesu              CMSSSESU,
             cmssidco              CMSSIDCO,
             cmssescm              cmssescm,
             pc.COMP_SUSPENSION_ID COMP_SUSPENSION_ID,
             pc.COMPONENT_ID       COMPONENT_ID,
             pc.SUSPENSION_TYPE_ID SUSPENSION_TYPE_ID_0,
             pc.REGISTER_DATE      REGISTER_DATE_1,
             pc.APLICATION_DATE    APLICATION_DATE_2,
             pc.INACTIVE_DATE      INACTIVE_DATE_3,
             pc.ACTIVE             ACTIVE_4
              from open.pr_prod_suspension ps
             inner join open.compsesu
                on ps.product_id = cmsssesu
             inner join open.pr_comp_suspension pc
                on cmssidco = pc.component_id
               and pc.suspension_type_id <> ps.suspension_type_id
               and pc.aplication_date between ps.aplication_date and
                   (ps.aplication_date + 1 / (60 * 60 * 24))
             where ps.suspension_type_id = 2
               and ps.aplication_date >= '01/01/2021'
               and ps.product_id in (6068042,
                                     1101442,
                                     6622597,
                                     50071189,
                                     50780587,
                                     50999123,
                                     51336357,
                                     50523642,
                                     51183381,
                                     6095364,
                                     1139764,
                                     6532281,
                                     17252481,
                                     50289711)) sub1
     order by 2 asc;

  rfcupoblacion cupoblacion%rowtype;

  nuIntentoProducto number := 0;

begin

  --Actiualziaicon del tipo de suspension a 2 en los componentes de suspension definidos a una lista de productos suspendidos.
  for rfcupoblacion in cupoblacion loop
  
    if rfcupoblacion.PRODUCT_ID in (6095364, 50999123, 1139764) then
    
      begin
        update open.pr_comp_suspension pc
           set pc.suspension_type_id = 2,
               pc.inactive_date      = rfcupoblacion.INACTIVE_DATE,
               pc.active             = 'N'
         where COMP_SUSPENSION_ID = rfcupoblacion.COMP_SUSPENSION_ID;
        dbms_output.put_line('Actualizacion del tipo de suspension ' ||
                             rfcupoblacion.SUSPENSION_TYPE_ID_0 ||
                             ' a 2, Fecha inactividad a ' ||
                             rfcupoblacion.INACTIVE_DATE || ' y Activo ' ||
                             rfcupoblacion.ACTIVE_4 ||
                             ' a N en el componente de suspesion [' ||
                             rfcupoblacion.COMP_SUSPENSION_ID ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID || ' - Ok.');
        commit;
        --rollback;
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizar el tipo de suspension ' ||
                               rfcupoblacion.SUSPENSION_TYPE_ID_0 ||
                               ' a 2, Fecha inactividad a ' ||
                               rfcupoblacion.INACTIVE_DATE || ' y Activo ' ||
                               rfcupoblacion.ACTIVE_4 ||
                               ' a N en el componente de suspesion [' ||
                               rfcupoblacion.COMP_SUSPENSION_ID ||
                               '] asociado al Producto: ' ||
                               rfcupoblacion.PRODUCT_ID);
      end;
    
      --ajustar los productos 6095364,50999123,1139764 para que queden componentes del servicio en estado 5
      begin
        update open.compsesu pc
           set pc.cmssescm = 5
         where pc.CMSSIDCO = rfcupoblacion.CMSSIDCO;
        dbms_output.put_line('Actualizacion del estado ' ||
                             rfcupoblacion.cmssescm ||
                             ' a 5 del componente en compsesu [' ||
                             rfcupoblacion.CMSSIDCO ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID || ' - Ok.');
        commit;
        --rollback;
      
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizacion del estado ' ||
                               rfcupoblacion.cmssescm ||
                               ' a 5 del componente [' ||
                               rfcupoblacion.CMSSIDCO ||
                               '] asociado al Producto: ' ||
                               rfcupoblacion.PRODUCT_ID);
      end;

      --ajustar los productos 6095364,50999123,1139764 para que queden componentes del producto en estado 5
      begin
        update open.pr_component pc
           set pc.component_status_id = 5
         where pc.component_id = rfcupoblacion.CMSSIDCO;
        dbms_output.put_line('Actualizacion del estado a 5 del componente en pr_component [' ||
                             rfcupoblacion.CMSSIDCO ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID || ' - Ok.');
        commit;
        --rollback;
      
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizacion del estado a 5 del componente en pr_component [' ||
                             rfcupoblacion.CMSSIDCO ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID);
      end;
          
      --ajustar los productos 6095364,50999123,1139764 para que queden con estado técnico 1, sin última actividad de suspensión en pr_product.
      begin
        if nuIntentoProducto <> rfcupoblacion.PRODUCT_ID then
          update open.pr_product pc
             set pc.product_status_id = 1, pc.suspen_ord_act_id = null
           where pc.product_id = rfcupoblacion.PRODUCT_ID;
          dbms_output.put_line('Actualizacion del estado a 1 y sin ultima actividad de suspension asociado a al Producto ' ||
                               rfcupoblacion.PRODUCT_ID || ' - Ok.');
          commit;
          --rollback;
        end if;
        nuIntentoProducto := rfcupoblacion.PRODUCT_ID;
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizar del estado a 1 y sin ultima actividad de suspension asociado a al Producto ' ||
                               rfcupoblacion.PRODUCT_ID);
      end;
    
    else
    
      begin
        update open.pr_comp_suspension pc
           set pc.suspension_type_id = 2
         where COMP_SUSPENSION_ID = rfcupoblacion.COMP_SUSPENSION_ID;
        dbms_output.put_line('Actualizacion del tipo de suspension ' ||
                             rfcupoblacion.SUSPENSION_TYPE_ID_0 ||
                             ' a 2 en el componente de suspesion [' ||
                             rfcupoblacion.COMP_SUSPENSION_ID ||
                             '] asociado al Producto: ' ||
                             rfcupoblacion.PRODUCT_ID || ' - Ok.');
        commit;
        --rollback;
      exception
        when others then
          rollback;
          dbms_output.put_line('No se permitio actualizar el tipo de suspension ' ||
                               rfcupoblacion.SUSPENSION_TYPE_ID_0 ||
                               ' a 2 en el componente de suspesion [' ||
                               rfcupoblacion.COMP_SUSPENSION_ID ||
                               '] asociado al Producto: ' ||
                               rfcupoblacion.PRODUCT_ID || '');
      end;
    end if;
  
  end loop;

end;  
/




select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/