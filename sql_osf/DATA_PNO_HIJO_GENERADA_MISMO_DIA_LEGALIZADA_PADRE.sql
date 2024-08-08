-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbImprime     varchar2(4000);
  sbCadenaFinal varchar2(4000);
  sbCadenaPadre varchar2(4000);
  nuEstadoOTout number;
  Cantidad      number;

  -- Local variables here
  cursor cuDATAPNO is
    select ooa.subscription_id Contrato,
           ooa.product_id Producto,
           oo.order_id OT_Inicio_PNO,
           ooa.address_id codigo_direccon,
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
           decode(fpn.comment_,
                  'GENERADO POR ACTIVDAD DE PNO POR CASO OSF-1426',
                  'S',
                  'N') Datafix,
           oo.order_status_id EstadoPNO,
           fpn.possible_ntl_id Proyecto,
           fpn.status Estado_Proyecto
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
    --   and fpn.product_id in (50364094)
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
           oo.order_status_id Estado_orden,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'S' Relacionada
      from open.or_order oo, open.or_related_order oro
     where oro.order_id = InuOrden
       and oo.order_id = oro.related_order_id;

  rfcuDATARelacionada1 cuDATARelacionada1%rowtype;

  cursor cuOTCreadaSinRelacaionar1(nuDireccion         number,
                                   dtFechaLegalizacion date,
                                   OT_Inicio_PNO       number) is
    select oo.order_id Orden_No_Hija,
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
           oo.created_date Fecha_Creacion_Hija,
           oo.legalization_date Fecha_Legalizacion_Hija,
           'N' Relacionada
      from open.or_order_activity ooa, open.or_order oo
     where oo.order_id = ooa.order_id
       and ooa.address_id = nuDireccion
       and oo.task_type_id in (12673, 10312, 10059, 12669)
       and trunc(ooa.register_date) = trunc(dtFechaLegalizacion)
       and oo.order_id not in (OT_Inicio_PNO);

  rfcuOTCreadaSinRelacaionar1 cuOTCreadaSinRelacaionar1%rowtype;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  for rfcuDATAPNO in cuDATAPNO loop
  
    sbCadenaFinal := null;
    sbCadenaPadre := null;
    nuEstadoOTout := null;
    sbImprime     := null;
    Cantidad      := 1;
  
    sbCadenaPadre :=  --'Padre' || '|' || 
     nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                     nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                     rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                     rfcuDATAPNO.Fecha_Creacion || '|' ||
                     rfcuDATAPNO.Fecha_Legalizacion || '|' ||
                     rfcuDATAPNO.Datafix || '|' || rfcuDATAPNO.Tipo_Trabajo || '|' ||
                     rfcuDATAPNO.Estado_Orden || '|' ||
                     rfcuDATAPNO.Causal_Legalizacion || '|';
  
    nuEstadoOTout := rfcuDATAPNO.EstadoPNO;
  
    open cuDATARelacionada1(rfcuDATAPNO.OT_Inicio_PNO);
    fetch cuDATARelacionada1
      into rfcuDATARelacionada1;
    if cuDATARelacionada1%found then
      sbCadenaFinal :=  --'Hija_' || Cantidad || '|' ||
       rfcuDATARelacionada1.Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Tipo_Trabajo_Hija || '|' ||
                       rfcuDATARelacionada1.Estado_Orden_Hija || '|' ||
                       rfcuDATARelacionada1.Causal_Legalizacion_Hija || '|' ||
                       rfcuDATARelacionada1.Fecha_Legalizacion_Hija || '|' ||
                       rfcuDATARelacionada1.Relacionada || '|';
      Cantidad      := Cantidad + 1;
      nuEstadoOTout := rfcuDATARelacionada1.Estado_orden;
    end if;
  
    close cuDATARelacionada1;
  
    if sbCadenaFinal is null then
      open cuOTCreadaSinRelacaionar1(rfcuDATAPNO.codigo_direccon,
                                     rfcuDATAPNO.Fecha_Legalizacion,
                                     rfcuDATAPNO.OT_Inicio_PNO);
      fetch cuOTCreadaSinRelacaionar1
        into rfcuOTCreadaSinRelacaionar1;
      if cuOTCreadaSinRelacaionar1%found then
        sbCadenaFinal :=  --'No_Hija' || '|' ||
         rfcuOTCreadaSinRelacaionar1.Orden_No_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Tipo_Trabajo_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Estado_Orden_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Causal_Legalizacion_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Fecha_Creacion_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Fecha_Legalizacion_Hija || '|' ||
                         rfcuOTCreadaSinRelacaionar1.Relacionada || '|';
        dbms_output.put_line(sbCadenaPadre || sbCadenaFinal);
      end if;
      close cuOTCreadaSinRelacaionar1;
    end if;
  
  end loop;

end;
