declare

  cursor cuordenes is
    select n.order_id from open.or_order n where n.order_id in (267617524);

  rfcuordenes cuordenes%rowtype;

  cursor cuordenesPNONoExiste(InuOrden number) is
    select count(1)
      from open.fm_possible_ntl n
     where n.order_id = InuOrden;

  nuCantidad  number;
  nuContrador number := 0;

  cursor cuPNOHijaPadre(InuOrdenHija number) is
    select padres.order_id as ot_padre,
           ott.TASK_TYPE_ID || ' - ' || ott.DESCRIPTION desc_tt_padre,
           oo.CREATED_DATE as fec_creacion_padre,
           oo.order_status_id as esta_OT_Padre,
           padres.related_order_id as ot_hija,
           ott2.TASK_TYPE_ID || ' - ' || ott2.DESCRIPTION desc_tt_hija,
           rela_order_type_id as realacion,
           decode((select 'PADRE_PNO'
                    from OPEN.FM_POSSIBLE_NTL pno
                   where pno.order_id = padres.order_id),
                  'PADRE_PNO',
                  'SI',
                  'NO') as esta_en_FMCAP,
           (select pno.POSSIBLE_NTL_ID
              from OPEN.FM_POSSIBLE_NTL pno
             where pno.order_id = padres.order_id) as PROYECTO_FMCAP,
           (select pno.order_id
              from OPEN.FM_POSSIBLE_NTL pno
             where pno.order_id = padres.order_id) as OT_PNO
      from open.or_related_order padres
     inner join open.or_order oo
        on (padres.ORDER_ID = oo.ORDER_ID)
     inner join open.or_order oo1
        on (padres.RELATED_ORDER_ID = oo1.ORDER_ID)
     inner join open.or_task_type ott
        on (oo.TASK_TYPE_ID = ott.TASK_TYPE_ID)
     inner join open.or_task_type ott2
        on (oo1.TASK_TYPE_ID = ott2.TASK_TYPE_ID)
     where rela_order_type_id IN (2 --> Regeneración
                                 ,
                                  13 --> Orden Relacionada
                                  )
     START WITH padres.related_order_id = InuOrdenHija --inuOrder_id
    CONNECT BY PRIOR padres.order_id = padres.related_order_id;

  rfcuPNOHijaPadre cuPNOHijaPadre%rowtype;

  OtPadreExiste number;

  NuCausalhija  number;
  NuCausalPadre number;
  sbCausalhija  open.ge_causal.description%type;
  sbCausalPadre open.ge_causal.description%type;

  cursor CuEstadoPNO(NuordenPNO number) is
    select t.status
      from OPEN.FM_POSSIBLE_NTL t
     where t.order_id = NuordenPNO;

  sbStatus OPEN.FM_POSSIBLE_NTL.STATUS%type;

  cursor cuProducto(InuOrden number) is
    select ooa.product_id
      from open.Or_Order_Activity ooa
     where ooa.order_id = InuOrden;

  nuProductoHijo  open.Or_Order_Activity.product_id%type;
  nuProductoPadre open.Or_Order_Activity.product_id%type;

  nuOrdenPadre open.or_order.order_id%type;

  cursor cuCausalOrden(inuorden number) is
    select oo.causal_id, gc.description
      from open.ge_causal gc, open.or_order oo
     where oo.order_id = inuorden
       and gc.causal_id = oo.causal_id;

begin

  dbms_output.put_line('Inicio ' || sysdate);

  dbms_output.put_line('Posicion|Orden Hija|Causal Hija|Orden Padre|Causal Padre|Existe PNO|Estado Orden Padre');

  nuOrdenPadre := 0;

  for rfcuordenes in cuordenes loop
  
    open cuordenesPNONoExiste(rfcuordenes.order_id);
    fetch cuordenesPNONoExiste
      into nuCantidad;
    close cuordenesPNONoExiste;
    if nuCantidad = 0 then
      nuContrador := nuContrador + 1;
      --dbms_output.put_line('Posicion :' || nuContrador || ' - Orden: ' || rfcuordenes.order_id);      
      open cuPNOHijaPadre(rfcuordenes.order_id);
      fetch cuPNOHijaPadre
        into rfcuPNOHijaPadre;
    
      if cuPNOHijaPadre%found then
        open cuordenesPNONoExiste(rfcuPNOHijaPadre.ot_padre);
        fetch cuordenesPNONoExiste
          into OtPadreExiste;
      
        close cuordenesPNONoExiste;
        open CuEstadoPNO(rfcuPNOHijaPadre.ot_padre);
        fetch CuEstadoPNO
          into sbStatus;
        close CuEstadoPNO;
      
        /*--Validar Prodcuto
        open cuProducto(rfcuPNOHijaPadre.ot_hija);
        fetch cuProducto into nuProductoHijo;
        close cuProducto;
        
        if nuProductoHijo = 50758249 then
           dbms_output.put_line('El prodcuto 50758249 esta asociada a la orden hija: ' || rfcuPNOHijaPadre.ot_hija);          
        end if;
        open cuProducto(rfcuPNOHijaPadre.ot_padre);
        fetch cuProducto into nuProductoPadre;
        close cuProducto;
        
        if nuProductoPadre = 50758249 then
           dbms_output.put_line('El prodcuto 50758249 esta asociada a la orden padre: ' || rfcuPNOHijaPadre.ot_padre);          
        end if;*/
      
        if OtPadreExiste = 1 --and sbStatus in ('R','P') 
         then
          open cuCausalOrden(rfcuPNOHijaPadre.ot_hija);
          fetch cuCausalOrden
            into NuCausalhija, sbCausalhija;
          close cuCausalOrden;
        
          open cuCausalOrden(rfcuPNOHijaPadre.ot_padre);
          fetch cuCausalOrden
            into NuCausalPadre, sbCausalPadre;
          close cuCausalOrden;
        
          --NuCausalhija  := open.daor_order.fnugetcausal_id(rfcuPNOHijaPadre.ot_hija,null);          
          --NuCausalPadre := open.daor_order.fnugetcausal_id(rfcuPNOHijaPadre.ot_padre,null);
          --sbCausalhija  := open.dage_causal.fsbgetdescription(NuCausalhija,null);
          --sbCausalPadre := open.dage_causal.fsbgetdescription(NuCausalPadre,null);
        
          dbms_output.put_line(' ' || nuContrador || '|' ||
                               rfcuPNOHijaPadre.ot_hija || '|' ||
                               NuCausalhija || '-' || sbCausalhija || '|' ||
                               rfcuPNOHijaPadre.ot_padre || '|' ||
                               NuCausalPadre || '-' || sbCausalPadre || '|' ||
                               OtPadreExiste || '|' || sbStatus);
        
          --dbms_output.put_line('update open.FM_POSSIBLE_NTL FPN set FPN.status= ''N'' where FPN.order_id = ' || rfcuPNOHijaPadre.ot_padre || ';');
          --dbms_output.put_line('commit;');
          --if nuOrdenPadre <> rfcuPNOHijaPadre.ot_padre then
          --dbms_output.put_line(','||rfcuPNOHijaPadre.ot_hija||','||rfcuPNOHijaPadre.ot_padre);
          --dbms_output.put_line('Orden Padre: '||rfcuPNOHijaPadre.ot_padre || ' -  Estado: ' ||sbStatus);             
          --nuOrdenPadre := rfcuPNOHijaPadre.ot_padre;
          --end if;*/
        
        end if;
      end if;
      close cuPNOHijaPadre;
    end if;
  end loop;
  dbms_output.put_line('Fin ' || sysdate);

end;
