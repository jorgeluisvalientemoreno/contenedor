declare

cursor cuPNOINFO is
select 1184605 as CONTRATO, 1184605 as PRODUCTO, '19/01/2023' as FECHA_DETECCION from dual
union all select 2167095 as CONTRATO, 2067095 as PRODUCTO, '31/01/2023' as FECHA_DETECCION from dual
union all select 6133077 as CONTRATO, 6133077 as PRODUCTO, '02/01/2023' as FECHA_DETECCION from dual
union all select 48191839 as CONTRATO, 50563696 as PRODUCTO, '31/01/2023' as FECHA_DETECCION from dual
union all select 48003019 as CONTRATO, 50002978 as PRODUCTO, '19/01/2023' as FECHA_DETECCION from dual
union all select 48072051 as CONTRATO, 50085964 as PRODUCTO, '18/01/2023' as FECHA_DETECCION from dual
union all select 17151674 as CONTRATO, 17090027 as PRODUCTO, '10/01/2023' as FECHA_DETECCION from dual
union all select 12002467 as CONTRATO, 12002467 as PRODUCTO, '17/01/2023' as FECHA_DETECCION from dual
union all select 67301200 as CONTRATO, 52460041 as PRODUCTO, '11/01/2023' as FECHA_DETECCION from dual
union all select 17150628 as CONTRATO, 17087165 as PRODUCTO, '31/01/2023' as FECHA_DETECCION from dual
union all select 17211996 as CONTRATO, 17212649 as PRODUCTO, '05/01/2023' as FECHA_DETECCION from dual
union all select 1089886 as CONTRATO, 1089886 as PRODUCTO, '23/02/2023' as FECHA_DETECCION from dual
union all select 14208893 as CONTRATO, 14508893 as PRODUCTO, '20/02/2023' as FECHA_DETECCION from dual
union all select 6223797 as CONTRATO, 6524595 as PRODUCTO, '28/02/2023' as FECHA_DETECCION from dual
union all select 2181149 as CONTRATO, 2081149 as PRODUCTO, '22/03/2023' as FECHA_DETECCION from dual
union all select 66276195 as CONTRATO, 6629984 as PRODUCTO, '24/03/2023' as FECHA_DETECCION from dual
union all select 17103489 as CONTRATO, 17004172 as PRODUCTO, '20/04/2023' as FECHA_DETECCION from dual
union all select 17121938 as CONTRATO, 17024112 as PRODUCTO, '17/05/2023' as FECHA_DETECCION from dual
union all select 17118856 as CONTRATO, 17020571 as PRODUCTO, '20/05/2023' as FECHA_DETECCION from dual
union all select 66791988 as CONTRATO, 51686144 as PRODUCTO, '12/05/2023' as FECHA_DETECCION from dual
union all select 6110009 as CONTRATO, 6110009 as PRODUCTO, '29/03/2023' as FECHA_DETECCION from dual
union all select 6133871 as CONTRATO, 6133871 as PRODUCTO, '29/03/2023' as FECHA_DETECCION from dual
union all select 1040846 as CONTRATO, 1040846 as PRODUCTO, '15/04/2023' as FECHA_DETECCION from dual
union all select 67200944 as CONTRATO, 52314403 as PRODUCTO, '04/03/2023' as FECHA_DETECCION from dual
union all select 67226685 as CONTRATO, 52354563 as PRODUCTO, '14/06/2023' as FECHA_DETECCION from dual
union all select 17150378 as CONTRATO, 17086281 as PRODUCTO, '14/06/2023' as FECHA_DETECCION from dual
union all select 17125023 as CONTRATO, 17027728 as PRODUCTO, '20/06/2023' as FECHA_DETECCION from dual
union all select 1083459 as CONTRATO, 1083459 as PRODUCTO, '27/03/2023' as FECHA_DETECCION from dual
union all select 48095960 as CONTRATO, 50112171 as PRODUCTO, '24/04/2023' as FECHA_DETECCION from dual
union all select 17222632 as CONTRATO, 17248519 as PRODUCTO, '28/06/2023' as FECHA_DETECCION from dual
union all select 1117003 as CONTRATO, 1117003 as PRODUCTO, '05/07/2023' as FECHA_DETECCION from dual
union all select 2173265 as CONTRATO, 2073265 as PRODUCTO, '04/05/2023' as FECHA_DETECCION from dual
union all select 1144189 as CONTRATO, 1144189 as PRODUCTO, '13/07/2023' as FECHA_DETECCION from dual
union all select 1034860 as CONTRATO, 1034860 as PRODUCTO, '12/07/2023' as FECHA_DETECCION from dual
union all select 17111530 as CONTRATO, 17012480 as PRODUCTO, '07/07/2023' as FECHA_DETECCION from dual
union all select 20200683 as CONTRATO, 20500683 as PRODUCTO, '14/07/2023' as FECHA_DETECCION from dual
union all select 66707659 as CONTRATO, 51570191 as PRODUCTO, '12/07/2023' as FECHA_DETECCION from dual
union all select 17103154 as CONTRATO, 17003837 as PRODUCTO, '10/07/2023' as FECHA_DETECCION from dual;

  rfcuPNOINFO cuPNOINFO%rowtype;

  cursor cuPNODATA(nuContrtao number, nuProducto number) is
    select --rownum Orden, 
     oo.order_id Orden,
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
     oo.operating_unit_id || ' - ' ||
     (select h.name
        from open.or_operating_unit h
       where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
     oo.created_date Creacion_Orden,
     oo.execution_final_date Fecha_Ejecucion_Final,
     oo.legalization_date Legalizacion_Orden,
     ooa.comment_ Comentario_Orden,
     ooa.package_id Solicitud,
     ooa.instance_id,
     (select a2.user_id || ' ' ||
             (select p.name_
                from open.ge_person p
               where p.user_id = (select a.user_id
                                    from open.sa_user a
                                   where a.mask = a2.user_id))
        from open.or_order_stat_change a2
       where a2.order_id = oo.order_id
         and (a2.initial_status_id = 0 and a2.final_status_id = 0)
         and rownum = 1) Usuario_Crea,
     (select a2.user_id || ' ' ||
             (select p.name_
                from open.ge_person p
               where p.user_id = (select a.user_id
                                    from open.sa_user a
                                   where a.mask = a2.user_id))
        from open.or_order_stat_change a2
       where a2.order_id = oo.order_id
         and a2.final_status_id = 7
         and rownum = 1) Usuario_Ejecuta,
     (select a2.user_id || ' ' ||
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
     where a3.product_id = ooa.product_id
       and oo.order_id = a3.order_id)*/
     decode((select count(1)
              from open.fm_possible_ntl a3
             where oo.order_id = a3.order_id),
            0,
            'NO',
            'SI') Registro_PNO,
     /*(select oro.related_order_id
      from open.or_related_order oro
     where (oro.order_id = oo.order_id \*or oro.related_order_id = oo.order_id*\) \*and rownum = 1*\)*/
     (select oro.related_order_id
        from open.or_related_order oro
       where oro.order_id = oo.order_id) Orden_Ralacionada
      from open.or_order_activity ooa, open.or_order oo, open.pr_product pp
     where ooa.order_id = oo.order_id
          --and ooa.order_id = 293080419
       and pp.product_id = ooa.product_id
       and (ooa.product_id = nuProducto or ooa.subscription_id = nuContrtao)
          --and (trunc(oo.legalization_date) >= '01/03/2022'
       and trunc(oo.created_date) >= '01/01/2023'
          --and oo.task_type_id = 10784
          --and mp.cust_care_reques_num = '192735615'   
          --and mp.package_id = 194041548
          --and oo.task_type_id in (12669, 11302, 10059)
       and oo.task_type_id in (12669)
     order by ooa.subscription_id, oo.legalization_date desc;

  rfcuPNODATA cuPNODATA%rowtype;

  cursor cuOrdenRelacionada(nuOrden number) is
    select oo.*, ott.description
      from open.or_order oo
      left join open.or_task_type ott
        on ott.task_type_id = oo.task_type_id
     where oo.order_id = nuOrden;
  rfcuOrdenRelacionada cuOrdenRelacionada%rowtype;

  nuOrden number := 1;

begin
  dbms_output.put_line('Orden|FECHA DETECCION|Contrato|Producto|Orden|Estado Orden|Tipo Trabajo|Causal Legalizacion|Fecha Legalizacion|Regsitro PNO|Usuario Crea|Usuario Legaliza|Orde Relacionada|Tipo Trabajo|Fecha Creacion');

  for rfcuPNOINFO in cuPNOINFO loop
    for rfcuPNODATA in cuPNODATA(rfcuPNOINFO.contrato, rfcuPNOINFO.producto) loop
      open cuOrdenRelacionada(rfcuPNODATA.Orden_Ralacionada);
      fetch cuOrdenRelacionada
        into rfcuOrdenRelacionada;
      close cuOrdenRelacionada;
      dbms_output.put_line(nuOrden || '|' || rfcuPNOINFO.FECHA_DETECCION || '|' || rfcuPNOINFO.contrato || '|' ||
                           rfcuPNOINFO.producto || '|' ||
                           rfcuPNODATA.Orden || '|' ||
                           rfcuPNODATA.Estado_Orden || '|' ||
                           rfcuPNODATA.Tipo_Trabajo || '|' ||
                           rfcuPNODATA.Causal_Legalizacion || '|' ||
                           rfcuPNODATA.Legalizacion_Orden || '|' ||                           
                           rfcuPNODATA.Registro_PNO || '|' ||
                           rfcuPNODATA.Usuario_Crea || '|' ||
                           rfcuPNODATA.Usuario_Legaliza || '|' ||
                           rfcuPNODATA.Orden_Ralacionada || '|' ||
                           rfcuOrdenRelacionada.task_type_id || '-' ||
                           rfcuOrdenRelacionada.description || '-' ||
                           rfcuOrdenRelacionada.CREATED_DATE);
      nuOrden := nuOrden + 1;
    end loop;
  end loop;

end;
