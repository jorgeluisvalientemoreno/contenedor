-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbImprime         varchar2(4000);
  sbCadenaFinal     varchar2(4000);
  nuEstadoOTout     number;
  Cantidad          number;
  nuOTPadrePNO      number;
  nuTipoTrabajoHijo number;
  nuExisteOTHija    number := 0;

  -- Local variables here
  cursor cuDATAPNO is
    select ooa.subscription_id Contrato,
           ooa.product_id      Producto,
           oo.order_id         OT_Inicio_PNO,
           /*fpn.package_id Solicitud,
           (select mp.motive_status_id || ' - ' || pms.description
              from open.mo_packages mp, open.ps_motive_status pms
             where mp.package_id = fpn.package_id
               and pms.motive_status_id = mp.motive_status_id) Estado_Solicitud,*/
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
    /*and fpn.product_id in (17010641,
    6604904,
    6077686,
    6639244,
    14521656,
    14507421,
    6587036,
    6516571,
    50953717,
    52336691,
    6514319,
    24000223)*/
    --and oo.order_id = 50005297
     order by fpn.order_id;

  rfcuDATAPNO cuDATAPNO%rowtype;

  cursor cuDATARelacionada(InuOrden number) is
    select oro.order_id Orden_Padre,
           oo.task_type_id || ' - ' ||
           (select a.description
              from open.or_task_type a
             where a.task_type_id = oo.task_type_id) Tipo_Trabajo_Padre,
           oo.order_status_id || ' - ' ||
           (select oos.description
              from open.or_order_status oos
             where oos.order_status_id = oo.order_status_id) Estado_Orden_Padre,
           oo.causal_id || ' - ' ||
           (select gc.description
              from open.ge_causal gc
             where gc.causal_id = oo.causal_id) Causal_Legalizacion_Padre,
           oo.order_status_id Estado_orden,
           oo.task_type_id tipo_trabajo_hijo
      from open.or_order oo, open.or_related_order oro
     where oro.related_order_id = InuOrden
       and oo.order_id = oro.order_id;

  rfcuDATARelacionada cuDATARelacionada%rowtype;

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
           oo.order_status_id Estado_orden,
           oo.task_type_id tipo_trabajo_hijo
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
           oo.order_status_id Estado_orden,
           oo.task_type_id tipo_trabajo_hijo
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
           oo.order_status_id Estado_orden,
           oo.task_type_id tipo_trabajo_hijo
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
           oo.order_status_id Estado_orden,
           oo.task_type_id tipo_trabajo_hijo
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada4 cuDATARelacionada4%rowtype;

  cursor cuOrdenHija(InuOrdenHija number) is
    select count(1)
      from open.or_related_order oro
     where oro.related_order_id = InuOrdenHija;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  sbCadenaFinal := 'Contrato|Producto|Orden_Padre_Proyecto|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion|Orden_Padre_Relaciona|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion';
  --dbms_output.put_line(sbCadenaFinal);
  for rfcuDATAPNO in cuDATAPNO loop
    sbCadenaFinal := null;
    nuEstadoOTout := null;
    sbImprime     := null;
    Cantidad      := 1;
    nuOTPadrePNO  := rfcuDATAPNO.OT_Inicio_PNO;
    sbCadenaFinal := nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                     nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                     rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                     rfcuDATAPNO.Tipo_Trabajo || '|' ||
                     rfcuDATAPNO.Estado_Orden || '|' ||
                     rfcuDATAPNO.Causal_Legalizacion;
  
    ----Inicio Orden Padre Relacioanda
    open cuDATARelacionada(rfcuDATAPNO.OT_Inicio_PNO);
    fetch cuDATARelacionada
      into rfcuDATARelacionada;
    if cuDATARelacionada%found then
      sbCadenaFinal := sbCadenaFinal || '|' ||
                       rfcuDATARelacionada.Orden_Padre || '|' ||
                       rfcuDATARelacionada.Tipo_Trabajo_Padre || '|' ||
                       rfcuDATARelacionada.Estado_Orden_Padre || '|' ||
                       rfcuDATARelacionada.Causal_Legalizacion_Padre || '|';
      --dbms_output.put_line(sbCadenaFinal);
      --dbms_output.put_line('delete from open.or_related_order oro where oro.related_order_id = ' || rfcuDATAPNO.OT_Inicio_PNO);
      dbms_output.put_line('Eliminar relacion de orden padre ' || rfcuDATARelacionada.Orden_Padre || ' con orden hija ' || rfcuDATAPNO.OT_Inicio_PNO);
      --else
      --  sbCadenaFinal := sbCadenaFinal || '|' || '|' || '|' || '|' || '|';
    end if;
    close cuDATARelacionada;
    ----Fin Orden Padre Relacioanda
  
  /*open cuDATARelacionada1(rfcuDATAPNO.OT_Inicio_PNO);
            fetch cuDATARelacionada1
              into rfcuDATARelacionada1;
            if cuDATARelacionada1%found then
              sbCadenaFinal     := sbCadenaFinal || 'Hija_' || Cantidad || '|' ||
                                   rfcuDATARelacionada1.Orden_Hija || '|' ||
                                   rfcuDATARelacionada1.Tipo_Trabajo_Hija || '|' ||
                                   rfcuDATARelacionada1.Estado_Orden_Hija || '|' ||
                                   rfcuDATARelacionada1.Causal_Legalizacion_Hija || '|';
              Cantidad          := Cantidad + 1;
              nuEstadoOTout     := rfcuDATARelacionada1.Estado_orden;
              nuTipoTrabajoHijo := rfcuDATARelacionada1.tipo_trabajo_hijo;
              ----Inicio Hijo nivel 2
              open cuDATARelacionada2(rfcuDATARelacionada1.Orden_Hija);
              fetch cuDATARelacionada2
                into rfcuDATARelacionada2;
              if cuDATARelacionada2%found then
                sbCadenaFinal     := sbCadenaFinal || 'Hija_' || Cantidad || '|' ||
                                     rfcuDATARelacionada2.Orden_Hija || '|' ||
                                     rfcuDATARelacionada2.Tipo_Trabajo_Hija || '|' ||
                                     rfcuDATARelacionada2.Estado_Orden_Hija || '|' ||
                                     rfcuDATARelacionada2.Causal_Legalizacion_Hija || '|';
                Cantidad          := Cantidad + 1;
                nuEstadoOTout     := rfcuDATARelacionada2.Estado_orden;
                nuTipoTrabajoHijo := rfcuDATARelacionada2.tipo_trabajo_hijo;
                ----Inicio Hijo nivel 3
                open cuDATARelacionada3(rfcuDATARelacionada2.Orden_Hija);
                fetch cuDATARelacionada3
                  into rfcuDATARelacionada3;
                if cuDATARelacionada3%found then
                  sbCadenaFinal     := sbCadenaFinal || 'Hija_' || Cantidad || '|' ||
                                       rfcuDATARelacionada3.Orden_Hija || '|' ||
                                       rfcuDATARelacionada3.Tipo_Trabajo_Hija || '|' ||
                                       rfcuDATARelacionada3.Estado_Orden_Hija || '|' ||
                                       rfcuDATARelacionada3.Causal_Legalizacion_Hija || '|';
                  Cantidad          := Cantidad + 1;
                  nuEstadoOTout     := rfcuDATARelacionada3.Estado_orden;
                  nuTipoTrabajoHijo := rfcuDATARelacionada3.tipo_trabajo_hijo;
                  ----Inicio Hijo nivel 4
                  open cuDATARelacionada4(rfcuDATARelacionada3.Orden_Hija);
                  fetch cuDATARelacionada4
                    into rfcuDATARelacionada4;
                  if cuDATARelacionada4%found then
                    sbCadenaFinal     := sbCadenaFinal || 'Hija_' || Cantidad || '|' ||
                                         rfcuDATARelacionada4.Orden_Hija || '|' ||
                                         rfcuDATARelacionada4.Tipo_Trabajo_Hija || '|' ||
                                         rfcuDATARelacionada4.Estado_Orden_Hija || '|' ||
                                         rfcuDATARelacionada4.Causal_Legalizacion_Hija || '|';
                    Cantidad          := Cantidad + 1;
                    nuEstadoOTout     := rfcuDATARelacionada4.Estado_orden;
                    nuTipoTrabajoHijo := rfcuDATARelacionada4.tipo_trabajo_hijo;
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
            close cuDATARelacionada1;*/
  
  --dbms_output.put_line(sbCadenaFinal);
  
  --dbms_output.put_line('delete from open.or_related_order oro where oro.related_order_id = ' || nuOTPadrePNO);
  
  /*if nuTipoTrabajoHijo = 10312 then
                  nuExisteOTHija := 0;
                  open cuOrdenHija(nuOTPadrePNO);
                  fetch cuOrdenHija
                    into nuExisteOTHija;
                  close cuOrdenHija;
                  if nuExisteOTHija = 1 then        
                    dbms_output.put_line('delete from open.or_related_order oro where oro.related_order_id = ' ||
                                         nuOTPadrePNO);
                  end if;
                end if;*/
  
  end loop;

end;
