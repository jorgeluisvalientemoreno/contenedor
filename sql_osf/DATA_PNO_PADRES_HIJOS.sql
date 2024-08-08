-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbImprime     varchar2(4000);
  sbCadenaFinal varchar2(4000);
  nuEstadoOTout number;

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
             where gc.causal_id = oo.causal_id) Causal_Legalizacion
      from open.or_order_activity ooa,
           open.or_order          oo,
           open.fm_possible_ntl   fpn
     where ooa.order_id = oo.order_id
       and oo.order_id = fpn.order_id
       and fpn.status in ('R', 'P')
       and to_char(oo.created_date, 'YYYY') = 2015
          --2016
          --2017
          --2018
          --2019
          --2020
          --2021
          --2022
          --2023
          --and rownum <= 1
       and oo.order_status_id = 8
       and fpn.product_id not in
           (1087687, 1082027, 17017510, 17092466, 1136488)
    --and oo.order_id = 50005297
     order by fpn.product_id;

  rfcuDATAPNO cuDATAPNO%rowtype;

  procedure prDATARelacionada(InuOrden     In number,
                              Cantidad     in number,
                              sbCadenaIn   in varchar2,
                              sbCadenaOut  out varchar2,
                              sbImprimeOut out varchar2) is
  
    cursor cuDATARelacionada is
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
  
    rfcuDATARelacionada cuDATARelacionada%rowtype;
  
    nuCantidad number;
  
    sbchar varchar2(4000);
  
    nuEstadoOT number;
  
  begin
    sbCadenaOut := sbCadenaIn;
    for rfcuDATARelacionada in cuDATARelacionada loop
    
      sbchar      := sbCadenaIn || 'Hija_' || Cantidad || '|' ||
                     rfcuDATARelacionada.Orden_Hija || '|' ||
                     rfcuDATARelacionada.Tipo_Trabajo_Hija || '|' ||
                     rfcuDATARelacionada.Estado_Orden_Hija || '|' ||
                     rfcuDATARelacionada.Causal_Legalizacion_Hija || '|';
      sbCadenaOut := sbchar;
      nuEstadoOT  := rfcuDATARelacionada.Estado_orden;
      if nuEstadoOt in (12, 8) then
        sbImprimeOut := 'S';
      else
        sbImprimeOut := 'N';
      end if;
      nuEstadoOTOut := nuEstadoOT;
      nuCantidad    := Cantidad + 1;
      prDATARelacionada(rfcuDATARelacionada.Orden_Hija,
                        nuCantidad,
                        sbchar,
                        sbCadenaOut,
                        sbImprimeOut);
    end loop;
  end prDATARelacionada;

begin

  -- Test statements here
  --dbms_output.put_line('Tipo|Contrato|Producto|Solicitud|Estado_Solicitud|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion');
  for rfcuDATAPNO in cuDATAPNO loop
    sbCadenaFinal := null;
    nuEstadoOTout := null;
    sbImprime     := null;
    prDATARelacionada(rfcuDATAPNO.OT_Inicio_PNO,
                      1,
                      null,
                      sbCadenaFinal,
                      sbImprime);
    dbms_output.put_line('Imprime: ' || sbImprime || ' - Cadena: ' || sbCadenaFinal);
    --if sbImprimeOut = 'S' then
  /*dbms_output.put_line('Padre' || '|' || nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                             nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                             rfcuDATAPNO.Solicitud || '|' ||
                             rfcuDATAPNO.Estado_Solicitud || '|' ||
                             rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                             rfcuDATAPNO.Tipo_Trabajo || '|' ||
                             rfcuDATAPNO.Estado_Orden || '|' ||
                             rfcuDATAPNO.Causal_Legalizacion || '|' ||
                             sbCadenaFinal);*/
  --end if;
  
  end loop;

end;
