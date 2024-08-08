-- Created on 29/08/2023 by JORGE VALIENTE 
declare

  sbCadenaFinal varchar2(4000);

  -- Local variables here
  cursor cuDATAPNO is
    select ooa.subscription_id Contrato,
           ooa.product_id Producto,
           oo.order_id OT_Inicio_PNO,
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
       and to_char(oo.created_date, 'YYYY') = 2017
          --and rownum <= 1
       and oo.order_status_id = 8
    --and oo.order_id = 118712741
    ;

  rfcuDATAPNO cuDATAPNO%rowtype;

  procedure prDATARelacionada(InuOrden    In number,
                              Cantidad    in number,
                              sbCadenaIn  in varchar2,
                              sbCadenaOut out varchar2) is
  
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
               where gc.causal_id = oo.causal_id) Causal_Legalizacion_Hija
        from open.or_order oo, open.or_related_order oro
       where oro.order_id = InuOrden
         and oo.order_id = oro.related_order_id;
  
    rfcuDATARelacionada cuDATARelacionada%rowtype;
  
    nuCantidad number;
  
    sbchar varchar2(4000);
  
  begin
  
    for rfcuDATARelacionada in cuDATARelacionada loop
    
      sbCadenaOut := sbCadenaIn || 'Hija_' || Cantidad || '|' ||
                     rfcuDATARelacionada.Orden_Hija || '|' ||
                     rfcuDATARelacionada.Tipo_Trabajo_Hija || '|' ||
                     rfcuDATARelacionada.Estado_Orden_Hija || '|' ||
                     rfcuDATARelacionada.Causal_Legalizacion_Hija || '|';
    
      --ut_trace.trace(sbCadenaOut, 1);
    
      if cuDATARelacionada%found then
        if rfcuDATARelacionada.Causal_Legalizacion_Hija is not null then
          nuCantidad := Cantidad + 1;
          prDATARelacionada(rfcuDATARelacionada.Orden_Hija,
                            nuCantidad,
                            sbCadenaOut,
                            sbchar);
        end if;
      end if;
    end loop;
  
  end prDATARelacionada;

begin

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  -- Test statements here
  ut_trace.trace('Tipo|Contrato|Producto|OT_PNO|Tipo_Trabajo|Estado_Orden|Causal_Legalizacion',
                 1);
  for rfcuDATAPNO in cuDATAPNO loop
    sbCadenaFinal := null;
    prDATARelacionada(rfcuDATAPNO.OT_Inicio_PNO, 1, null, sbCadenaFinal);
    ut_trace.trace('Padre' || '|' || nvl(rfcuDATAPNO.Contrato, 0) || '|' ||
                   nvl(rfcuDATAPNO.Producto, 0) || '|' ||
                   rfcuDATAPNO.OT_Inicio_PNO || '|' ||
                   rfcuDATAPNO.Tipo_Trabajo || '|' ||
                   rfcuDATAPNO.Estado_Orden || '|' ||
                   rfcuDATAPNO.Causal_Legalizacion || '|' || sbCadenaFinal,
                   1);
  
  end loop;

end;
