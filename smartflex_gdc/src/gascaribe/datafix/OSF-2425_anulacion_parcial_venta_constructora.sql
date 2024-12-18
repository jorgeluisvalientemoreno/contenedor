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
        select product_id PRODUCTO, oa.order_id ORDEN, o.causal_id CAUSAL, gc.class_causal_id
          from open.or_order_activity oa, open.or_order o, open.ge_causal gc
        where oa.package_id = cnuPackage_id
          and oa.order_id = o.order_id
          and o.causal_id = gc.causal_id
          and oa.motive_id in (select motive_id
                                from open.mo_motive mo
                                where mo.package_id = oa.package_id
                                  and mo.product_id in (52641093,52641085,52641089,52641086,52641092,52641088,52641090,52641091,52641087,52641084,52641083,52641082,52641081,52641080,52641079,52641078,
          52641077,52641075,52641076,52641071,52641070,52641074,52641072,52641068,52641073,52641069,52641066,52641067,52641065,52641064,52641059,52641063,52641060,52641062,52641061,52641058,52641057,
          52641056,52641055,52641054,52641053,52641052,52641051,52641048,52641050,52641047,52641042,52641049,52641039,52641044,52641045,52641043,52641046,52641041,52641037,52641040,52641038,52641034,
          52641033,52641035,52641036,52641031,52641030,52641032,52641029,52641019,52641026,52641010,52641007,52641027,52641013,52641012,52641020,52641018,52641023,52641011,52641014,52641028,52641017,
          52641016,52641022,52641025,52641009,52641024,52641021,52641006,52641008,52641015));

      -- Cursor de Person ID para el comentario
      CURSOR cuLoadData IS
          select person_id
          from ge_person
          where person_id = 13549; -- Pablo

      -- Registro de Comentario de la orden
      rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
      nuPersonID          open.ge_person.person_id%type;

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
        If nvl(rcOrderActiv.class_causal_id,0) != 1 then
          
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
              pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 110); -- Retirado sin instalacion.
              
              /*update open.servsusc s
                set s.sesuesco = 110,         -- Retirado sin Instalacion
                    s.sesufere = sysdate
              where sesunuse = rcOrderActiv.PRODUCTO;*/

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

      dbms_output.put_line('Fin del Proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont);
      
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