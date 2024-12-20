column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  -- Nombre de este metodo
  nuOrden open.or_order.order_id%TYPE;

  nuOrdenPNO open.or_order.order_id%TYPE;

  CURSOR cuOTRelacion is
    with base as
     (select oo.order_id Orden_Padre,
             ooa.subscription_id Contrato,
             ooa.product_id Producto,
             ooa.activity_id || ' - ' ||
             (select gi.description
                from open.ge_items gi
               where gi.items_id = ooa.activity_id) Actividad,
             oo.task_type_id || ' - ' ||
             (select a.description
                from open.or_task_type a
               where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
             oo.order_status_id || ' - ' ||
             (select oos.description
                from open.or_order_status oos
               where oos.order_status_id = oo.order_status_id) Estado_Orden,
             oo.causal_id || ' - ' ||
             (select gc.description
                from open.ge_causal gc
               where gc.causal_id = oo.causal_id) Causal_Legalizacion,
             (select x.class_causal_id || ' - ' || x.description
                from open.ge_class_causal x
               where x.class_causal_id =
                     (select y.class_causal_id
                        from open.ge_causal y
                       where y.causal_id = oo.causal_id)) Clasificacion_Causal,
             oo.created_date Creacion_Orden,
             oo.execution_final_date Fecha_Ejecucion_Final,
             oo.legalization_date Legalizacion_Orden,
             ooa.comment_ Comentario_Orden,
             (select a2.user_id || ' - ' ||
                     (select p.name_
                        from open.ge_person p
                       where p.user_id = (select a.user_id
                                            from open.sa_user a
                                           where a.mask = a2.user_id))
                from open.or_order_stat_change a2
               where a2.order_id = oo.order_id
                 and (a2.initial_status_id = 0 and a2.final_status_id = 0)
                 and rownum = 1) Usuario_Crea,
             (select a2.user_id || ' - ' ||
                     (select p.name_
                        from open.ge_person p
                       where p.user_id = (select a.user_id
                                            from open.sa_user a
                                           where a.mask = a2.user_id))
                from open.or_order_stat_change a2
               where a2.order_id = oo.order_id
                 and a2.final_status_id = 8
                 and rownum = 1) Usuario_Legaliza,
             /*(select a3.order_id || ' - Fecha Registro en PNO: ' ||
                   a3.register_date
              from open.fm_possible_ntl a3
             where oo.order_id = a3.order_id)*/
             decode((select count(1)
                      from open.fm_possible_ntl a3
                     where oo.order_id = a3.order_id),
                    0,
                    'NO',
                    'SI') Registro_PNO,
             (select oro.related_order_id
                from open.or_related_order oro
               where oro.order_id = oo.order_id) Orden_Ralacionada,
             ooa.address_id codigo_direccon
        from open.or_order_activity ooa, open.or_order oo
       where ooa.order_id = oo.order_id
         and oo.task_type_id = 12669
         and oo.causal_id in (3812, 3815)
         and oo.order_status_id = 8
         and (select count(1)
                from open.or_related_order oro
               where oro.order_id = oo.order_id
                 and (select count(1)
                        from open.or_order oo1
                       where oo1.task_type_id = 10059
                         and oro.related_order_id = oo1.order_id) = 1) = 0
         and (select count(1)
                from open.ct_item_novelty cin
               where cin.items_id = ooa.activity_id) = 0)
    select base.Orden_Padre,
           ooa.order_id Orden_Hija
      from base
      left join open.or_order_activity ooa
        on ooa.address_id = base.codigo_direccon
       and trunc(ooa.register_date) = trunc(base.Legalizacion_Orden)
       and ooa.task_type_id = 10059
      left join open.or_order oo
        on oo.order_id = ooa.order_id
       and oo.task_type_id = 10059
       and trunc(oo.created_date) = trunc(base.Legalizacion_Orden)
     order by base.contrato, base.Legalizacion_Orden desc;
     
  rfcuOTRelacion cuOTRelacion%ROWTYPE;

  CURSOR cuRelacion(  inuOrdenPNO    open.or_order_activity.order_id%TYPE,
                      inuOrden    open.or_order_activity.order_id%TYPE) IS
    SELECT *
      FROM open.or_related_order oro
     WHERE oro.order_id = inuOrdenPNO
       AND oro.related_order_id = inuOrden;

  rfcuRelacion cuRelacion%ROWTYPE;

  onuErrorCode number;
  osbErrorMessage varchar2(4000);

BEGIN

  for rfcuOTRelacion IN cuOTRelacion LOOP

    nuOrdenPNO := rfcuOTRelacion.Orden_Padre;
    nuOrden := rfcuOTRelacion.Orden_Hija;
    
  
    OPEN cuRelacion(nuOrdenPNO, nuOrden);
    FETCH cuRelacion
      INTO rfcuRelacion;
    CLOSE cuRelacion;

    IF rfcuRelacion.related_order_id IS NULL and nuOrden is not null THEN

      begin
        api_related_order(nuOrdenPNO,nuOrden,onuErrorCode,osbErrorMessage);        
        commit;      
        dbms_output.put_line('Orden Padre: ' || nuOrdenPNO || ' relacionada la Orden Hija: ' || nuOrden);        
      exception
        when others then
          dbms_output.put_line('Error ' || onuErrorCode || ' - ' || osbErrorMessage);
          ROLLBACK;
      end;
    
    END IF;    
  
  END LOOP;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error ' || SQLERRM);
    ROLLBACK;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/