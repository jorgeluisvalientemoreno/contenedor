-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbImprime     varchar2(4000);
  sbCadenaFinal varchar2(4000);
  nuEstadoOTout number;
  Cantidad      number;

  -- Local variables here
  cursor cuDATAPNO is
    select ooa.subscription_id Contrato,
           ooa.product_id Producto,
           oo.order_id OT_Inicio_PNO,
           fpn.package_id Solicitud,
           (select mp.motive_status_id || ' - ' || pms.description
              from open.mo_packages mp, open.ps_motive_status pms
             where mp.package_id = fpn.package_id
               and pms.motive_status_id = mp.motive_status_id) Estado_Solicitud,
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
           oo.created_date Fecha_Creacion,
           oo.legalization_date Fecha_Legalizacion,
           ooa.comment_ Coemntario
      from open.or_order_activity ooa,
           open.or_order          oo,
           open.fm_possible_ntl   fpn
     where ooa.order_id = oo.order_id
       and oo.order_id = fpn.order_id
       and fpn.status in ('R', 'P')
    --and to_char(oo.created_date, 'YYYY') = 
    --2015
    --2016
    --2017
    --2018
    --2019
    --2020
    --2021
    --2022
    --2023
    --and rownum <= 1
    --and oo.order_status_id in (12,8)
    /*and fpn.product_id in (6113403,
    17186829,
    17005932,
    2057963,
    1506424,
    17005946,
    51530890,
    51606067)*/
    --and ooa.product_id = fpn.product_id
    --and oo.order_id = 50005297
     order by fpn.order_id;

  rfcuDATAPNO cuDATAPNO%rowtype;

  cursor cuDATARelacionada1(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada1 cuDATARelacionada1%rowtype;

  cursor cuDATARelacionada2(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada2 cuDATARelacionada2%rowtype;

  cursor cuDATARelacionada3(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada3 cuDATARelacionada3%rowtype;

  cursor cuDATARelacionada4(InuOrden number) is
    select oro.related_order_id Orden_Hija,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Hija,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Hija,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija,
           oo.order_status_id Estado_orden
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada4 cuDATARelacionada4%rowtype;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  dbms_output.put_line('Contrato|Producto|OT_PNO_Padre|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion|OT_Hija1|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion|OT_Hija2|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion|OT_Hija3|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion|OT_Hija4|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  for rfcuDATAPNO in cuDATAPNO loop
    sbCadenaFinal := null;
    nuEstadoOTout := null;
    sbImprime     := null;
    Cantidad      := 1;
  
    sbCadenaFinal := nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                     nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                    --rfcuDATAPNO.Solicitud || '|' ||
                    --rfcuDATAPNO.Estado_Solicitud || '|' ||
                     rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                     rfcuDATAPNO.Tipo_Trabajo || '|' ||
                     rfcuDATAPNO.Estado_Orden || '|' ||
                     rfcuDATAPNO.Causal_Legalizacion || '|';
  
    open cuDATARelacionada1(rfcuDATAPNO.OT_Inicio_PNO);
    fetch cuDATARelacionada1
      into rfcuDATARelacionada1;
    if cuDATARelacionada1%found then
      sbCadenaFinal := sbCadenaFinal || rfcuDATARelacionada1.Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Tipo_Trabajo_Hija || '|' ||
                       rfcuDATARelacionada1.Estado_Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Causal_Legalizacion_Hija || '|';
      Cantidad      := Cantidad + 1;
      nuEstadoOTout := rfcuDATARelacionada1.Estado_orden;
      ----Inicio Hijo nivel 2
      open cuDATARelacionada2(rfcuDATARelacionada1.Orden_Hija);
      fetch cuDATARelacionada2
        into rfcuDATARelacionada2;
      if cuDATARelacionada2%found then
        sbCadenaFinal := sbCadenaFinal || rfcuDATARelacionada2.Orden_Hija || '|' ||
                         rfcuDATARelacionada2.Tipo_Trabajo_Hija || '|' ||
                         rfcuDATARelacionada2.Estado_Orden_Hija || '|' ||
                         rfcuDATARelacionada2.Causal_Legalizacion_Hija || '|';
        Cantidad      := Cantidad + 1;
        nuEstadoOTout := rfcuDATARelacionada2.Estado_orden;
        ----Inicio Hijo nivel 3
        open cuDATARelacionada3(rfcuDATARelacionada2.Orden_Hija);
        fetch cuDATARelacionada3
          into rfcuDATARelacionada3;
        if cuDATARelacionada3%found then
          sbCadenaFinal := sbCadenaFinal || rfcuDATARelacionada3.Orden_Hija || '|' ||
                           rfcuDATARelacionada3.Tipo_Trabajo_Hija || '|' ||
                           rfcuDATARelacionada3.Estado_Orden_Hija || '|' ||
                           rfcuDATARelacionada3.Causal_Legalizacion_Hija || '|';
          Cantidad      := Cantidad + 1;
          nuEstadoOTout := rfcuDATARelacionada3.Estado_orden;
          ----Inicio Hijo nivel 4
          open cuDATARelacionada4(rfcuDATARelacionada3.Orden_Hija);
          fetch cuDATARelacionada4
            into rfcuDATARelacionada4;
          if cuDATARelacionada4%found then
            sbCadenaFinal := sbCadenaFinal ||
                             rfcuDATARelacionada4.Orden_Hija || '|' ||
                             rfcuDATARelacionada4.Tipo_Trabajo_Hija || '|' ||
                             rfcuDATARelacionada4.Estado_Orden_Hija || '|' ||
                             rfcuDATARelacionada4.Causal_Legalizacion_Hija || '|';
            Cantidad      := Cantidad + 1;
            nuEstadoOTout := rfcuDATARelacionada4.Estado_orden;
          end if;
          close cuDATARelacionada4;
          ----Fin Hijo nivel 4        
        end if;
        close cuDATARelacionada3;
        ----Fin Hijo nivel 3        
      end if;
      close cuDATARelacionada2;
      ----Fin Hijo nivel 2
    end if;
    close cuDATARelacionada1;
  
    --if nuEstadoOTout = 12 or nuEstadoOTout = 8 then
      dbms_output.put_line(sbCadenaFinal);
    --end if;
  
  end loop;

end;
