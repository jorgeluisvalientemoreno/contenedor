column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
  /*
      OSF-2425: Se solicita la anulación de la solicitud de venta constructora 192616580, motivos de solicitud, de ordenes de trabajo (Anuladas), 
                retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación), 
                retiro de componentes de producto (18-Retirado sin instalación), actualización fecha de retiro, de los 88 contratos anexos ya que 
                pertenecen a una solicitud de venta que según acuerdo con el constructor no se van a construir. La venta constructora que se modifica 
                es contrato padre 67338501 solicitud 192616580 Constructora VIVA MAYALES SAS
  */
      -- ID de la solicitud relacionada a los contratos a retirar
      cnuPackage_id   constant number := 192616580;
      -- Informacion general
      nuInfomrGen     constant open.or_order_comment.comment_type_id%type := 1277;

      -- Cursor para Anular ordenes de contratos definidos del CASO OSF-2346
      CURSOR cuOrderActiv is
        select product_id PRODUCTO, oa.order_id ORDEN, oa.task_type_id, o.causal_id CAUSAL, gc.class_causal_id, o.order_status_id
          from open.or_order_activity oa 
        inner join open.or_order o ON  oa.order_id = o.order_id
          left join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = cnuPackage_id 
          and nvl(gc.class_causal_id,0) != 1 
          and o.order_status_id not in (8,12);
          
      -- Cursor para validar que todas las OT esten anuladas o legalizadas con error
      CURSOR cuOrderActiv2 IS
        select 1 orden
          from open.or_order_activity oa 
        inner join open.or_order o ON  oa.order_id = o.order_id
          left join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = cnuPackage_id 
          and nvl(gc.class_causal_id,0) != 1 
          and o.order_status_id not in (8,12)
          and rownum = 1;

      -- Cursor de Person ID para el comentario
      CURSOR cuLoadData IS
          select person_id
          from ge_person
          where person_id = 13549; -- Pablo

      -- Registro de Comentario de la orden
      rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
      nuPersonID          open.ge_person.person_id%type;
      nuOrdenes           number(1);

      sbComment           VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-2425';
      nuCommentType       number         := 1277;

      nuErrorCode         number;
      nuCont              number;
      nuTotal             number;
      nuOrderCommentID    number;
      sbErrorMessage      varchar2(4000);
      exError             EXCEPTION;

  BEGIN

      nuCont  := 0;
      nuTotal := 0;

      -- Carga de Person ID para el comentario
      open cuLoadData;
      fetch cuLoadData into nuPersonID;
      close cuLoadData;

      -- sino existe la persona pone la default de OPEN
      IF nuPersonID is null THEN
          nuPersonID := ge_bopersonal.fnugetpersonid;
      END IF;

      dbms_output.put_line('Codigo Tipo Comentario[' || nuInfomrGen || ']');
      dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');
      dbms_output.put_line('Person ID             [' || nuPersonID || ']');

      --Recorrer ordenes del contrato de venta a constructora
      FOR rcOrderActiv in cuOrderActiv LOOP
      
        nuTotal := nuTotal + 1;      
        
        -- Si la Orden no esta legalizada con causal de exito, anula
        If nvl(rcOrderActiv.class_causal_id,0) != 1  then
          
          BEGIN
              dbms_output.put_line(chr(10)||'ANULA ORDEN: [' || rcOrderActiv.ORDEN || ']');

              -- or_boanullorder.anullorderwithoutval(rcOrderActiv.ORDEN,SYSDATE);
              -- Se reemplaza por el nuevo API para anular ordenes - GDGA 20/02/2024
              api_anullorder
              (
                  rcOrderActiv.ORDEN,
                  null,
                  null,
                  nuErrorCode,
                  sbErrorMessage
              );
              IF (nuErrorCode <> 0) THEN
                  dbms_output.put_line('Error en api_anullorder, Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                  RAISE exError;
              END IF;

              -- Arma el registro con el comentario
              rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
              rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
              rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
              rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuInfomrGen;
              rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
              rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
              rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

              -- Inserta el registro en or_order_comment
              daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

              -- Cambia el estado de la orden a Finalizada
              update open.or_order_activity
                set status = 'F'
              where order_id = rcOrderActiv.ORDEN;

              -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
              update open.pr_product
                set product_status_id = 16,  -- Retirado sin instalacion
                    suspen_ord_act_id = null,
                    retire_date = sysdate
              where product_id = rcOrderActiv.PRODUCTO;

              -- Estado de corte
              pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 95    -- Retiro para el tipo de producto 6121
                                                              -- 110 -- Retirado sin instalacion. para el tipo de producto 7014
                                      ); 

              -- componente del producto
              update open.pr_component
                set component_status_id = 18  -- Retirado sin instalacion
              where product_id = rcOrderActiv.PRODUCTO;

              update open.compsesu
                set cmssescm = 18,  --
                    cmssfere = sysdate
              where cmsssesu = rcOrderActiv.PRODUCTO;

              -- Cambia estado del motivo
              update open.mo_motive m
                set m.motive_status_id = 5 -- 
              where m.package_id = cnuPackage_id
                and m.product_id in rcOrderActiv.PRODUCTO;

              -- Componentes del motivo
              update mo_component m
                set m.motive_status_id = 26
              where m.package_id = cnuPackage_id
                and m.product_id = rcOrderActiv.PRODUCTO;

              nuCont := nuCont + 1;

              -- Asienta la transaccion
              commit;

          EXCEPTION
              WHEN exError THEN
                  rollback;
              WHEN OTHERS THEN
                  rollback;
                  dbms_output.put_line('Error Anulando Orden: '|| rcOrderActiv.ORDEN ||', SQLERRM: '|| SQLERRM );
          END;
          
        Else
          
          dbms_output.put_line('Orden: '|| rcOrderActiv.ORDEN ||' , Esta legalizada con Exito, no se puede anular.');
        
        END If;

      END LOOP;
      
      -- Anulamos la solicitud
      -- Recorrer ordenes para validar estado de estas, si hay una pendiente, no se anula la solicitud.
      open cuOrderActiv2;
      fetch cuOrderActiv2 into nuOrdenes;
      close cuOrderActiv2;
        
      If nvl(nuOrdenes, 0) = 0 Then
        Begin
          MO_BOANNULMENT.PACKAGEINTTRANSITION(cnuPackage_id,GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL', 'Y'));
          commit;
          dbms_output.put_line('Fin del Proceso. Solicitud anulada, Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont);
        EXCEPTION
            WHEN exError THEN
                rollback;
            WHEN OTHERS THEN
                rollback;
                dbms_output.put_line('Error Anulando la solicitud : ' ||', SQLERRM: '|| SQLERRM );
        END;           
      Else
        dbms_output.put_line('Hay Ordenes pendientes por Anuladar');
        End if;
      --
  EXCEPTION
      WHEN OTHERS THEN
          dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/