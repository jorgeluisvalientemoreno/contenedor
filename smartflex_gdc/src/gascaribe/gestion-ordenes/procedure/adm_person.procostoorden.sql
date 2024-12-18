CREATE OR REPLACE procedure ADM_PERSON.PROCOSTOORDEN(inucontrato  in ge_contrato.id_contrato%type,
                                                      inuOrderId   IN or_order.order_id%type,
                                                      inuitemid    IN or_order_items.items_id%TYPE,
                                                      onuOrderCost OUT number) IS

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : procostoorden
    ******************************************************************/

    cursor cuitemslegorden(nuorderid in or_order_items.order_id%TYPE, nuitemid in or_order_items.items_id%TYPE) is
      SELECT items_id, LEGAL_ITEM_AMOUNT, value
        FROM OR_order_items
       where order_id = nuorderid
         and legal_item_amount > 0
         AND items_id = nuitemid;

   cursor cuitemslegordenPadre(nuorderid in or_order_items.order_id%type,
                                nuItems   in or_order_items.items_id%type) is
      SELECT items_id
        FROM OR_order_items
       where order_id = nuorderid
        AND items_id = nuItems
         and legal_item_amount > 0;

    -- CURSOR que trae la orden padre
    CURSOR cuOrdenSinAjuste(nuorderid in or_order_items.order_id%type) IS
      SELECT related_order_id
        FROM or_related_order
       where order_id = nuorderid
         AND rela_order_type_id = 9;

    nucontract     ge_contrato.id_contrato%type;
    nucontrato     ge_contrato.id_contrato%type;
    nuCantidad     OR_order_items.LEGAL_ITEM_AMOUNT%type;
    dtfecha        date;
    onupricelistid number;
    onuvalue       number;

    --NC 795
    -- CURSOR que trae los items de la orden de ajuste
    cursor cuordenajustes(nuorderid in or_order.order_id%type) is
      SELECT Order_Id, LEGAL_ITEM_AMOUNT, out_, value, items_id
        FROM OR_order_items
       where order_id =
             (select oro.related_order_id
                from or_related_order oro
               where oro.rela_order_type_id =
                     dald_parameter.fnuGetNumeric_Value('COD_ORDEN_AJUSTE',
                                                        null)
                 and oro.related_order_id = nuorderid)
         AND items_id = inuitemid
         and legal_item_amount > 0
         and out_ in (ge_boconstants.csbYES, ge_boconstants.csbNO);

    nuY           number;
    nuN           number;
    nuOrdenAjuste number := 0;
    nuOrden       number;
    nuItem        NUMBER;
    --FIN NC795

    --<<NC 1776
    cursor cuitemnovedadpos(nuitem ge_items.items_id%type) is
      select 'X'
        from ct_item_novelty
       where items_id = nuitem
         and liquidation_sign = 1;

    cursor cuitemslegordennov(nuorderid in or_order_items.order_id%type) is
      select activity_id, value_reference
        from or_order_activity
       where order_id = nuorderid;

    sbliquida varchar2(2);
    nuitemnov ge_items.items_id%type;
    -->>

  BEGIN
    --valida si es contratista de recaudos
 --   ldc_acta.provalidacontratistarecaudo(inucontrato);

    if cuItemsLegOrden%isopen then
      close cuItemsLegOrden;
    end if;

    open cuOrdenSinAjuste(inuOrderId);
    fetch cuOrdenSinAjuste
      INTO nuOrdenAjuste;
    close cuOrdenSinAjuste;

    --Valida si la orden que llega es de Ajuste
    nuOrden := inuOrderId;
    nuItem :=  inuitemid;
    --Valida si la orden que llega es de Ajuste
    if nuOrdenAjuste IS null OR nuOrdenAjuste = 0 then
      nuOrdenAjuste := 0;
    END if;

    ut_trace.trace('-- Paso 1. nuOrden '||nuOrden, 1);
    ut_trace.trace('-- Paso 1.1 nuOrden '||nuOrdenAjuste, 1);

    nuContract := inucontrato;

    ut_trace.trace('-- Paso 2. nuContract '||nuContract, 1);

    -- Adiciona el atributo de la entidad a la instancia
--    ge_boinstancecontrol.addattribute(CT_BOConstants.fsbgetContractorInstanceName,
--                                      null,
--                                      'GE_CONTRATO',
--                                      'ID_CONTRATO',
--                                      to_char(nuContract));

    ut_trace.trace('-- Paso 2.1 sube a la instancia ', 1);

    -- si creo la instancia, podra obtener el costo
--    if (ge_boinstancecontrol.fblacckeyinstancestack(ct_boconstants.fsbgetcontractorinstancename,
--                                                    nucontrato)) then

--      if (ldc_acta.isContratistaRecaudos = 'S') then
        --obtiene la fecha con que se debe buscar el costo en la lista de costos
      --  ldc_acta.PROFECHALISTACOSTO(dtfecha, nuOrden);
        ut_trace.trace('-- Paso 3. dtfecha -->' || dtfecha, 1);
--      end if;

      --valida si es orden de novedad
      if (ct_bonovelty.fsbisnoveltyorder(nuorden) = 'N') then
        ut_trace.trace('-- Paso 4. No es Novedad -->', 1);
        onuordercost := 0;
        for rtitemslegorden in cuitemslegorden(nuorden, nuItem) loop
          ut_trace.trace('-- Paso 4.1 rtitemslegorden -->' ||
                         rtitemslegorden.items_id,
                         1);

        --  if (ldc_acta.isContratistaRecaudos = 'S') then
            nuCantidad := rtitemslegorden.LEGAL_ITEM_AMOUNT;
--            ge_bocertcontratista.obtenervaloritemlista(nuOrden,
--                                                       rtitemslegorden.items_id,
--                                                       'PRICE',
--                                                       onupricelistid,
--                                                       onuvalue,
--                                                       dtfecha);
            onuvalue := onuvalue * nucantidad;
        --  elsif (ldc_acta.iscontratistarecaudos = 'N') then
            onuvalue := rtitemslegorden.value;
        --  end if;
          onuordercost := onuvalue + onuordercost;
        end loop;
        ut_trace.trace('-- Paso 4.2 onuordercost -->' || onuordercost, 1);
        --NC 795
        --Busqueda de ordenes de ajustes con su valor total
        nuY := 0;
        nuN := 0;

        ut_trace.trace('-- Paso 4.3. AJUSTE ', 1);

        for rtordenajuste in cuordenajustes(nuOrdenAjuste) loop

        --  if (ldc_acta.isContratistaRecaudos = 'S') then
            --obtiene la fecha con que se debe buscar el costo en la lista de costos
       --     ldc_acta.PROFECHALISTACOSTO(dtfecha, rtordenajuste.order_id);
       --   end if;

--          if (ldc_acta.isContratistaRecaudos = 'S') then
--              nucantidad := rtordenajuste.legal_item_amount;
--              ge_bocertcontratista.obtenervaloritemlista(rtordenajuste.order_id,
--                                                         rtordenajuste.items_id,
--                                                         'PRICE',
--                                                         onupricelistid,
--                                                         onuvalue,
--                                                         dtfecha);
--            end if;

          ut_trace.trace('-- Paso 5. nuOrden '||nuOrden||', rtordenajuste.items_id: '||rtordenajuste.items_id, 1);

          for rtitemslegorden in cuitemslegordenPadre(nuorden,rtordenajuste.items_id) loop
            onuvalue := 0;
            nuY      := 0;
            nuN      := 0;

            if rtordenajuste.items_id = rtitemslegorden.items_id then
              --if rtordenajuste.out_ is not null then
              if rtordenajuste.out_ = ge_boconstants.csbyes then
             --   if (ldc_acta.iscontratistarecaudos = 'S') then
              --    onuvalue := onuvalue * nucantidad;
              --  elsif (ldc_acta.iscontratistarecaudos = 'N') then
                  onuvalue := rtordenajuste.value;
             --   end if;
                nuy := nuy + onuvalue;
              else
              --  if (ldc_acta.iscontratistarecaudos = 'S') then
               --   onuvalue := onuvalue * nucantidad;
               -- elsif (ldc_acta.iscontratistarecaudos = 'N') then
                  onuvalue := rtordenajuste.value;
              --  end if;
                nun := nun + onuvalue;
              end if;
            end if;
          end loop;
          onuOrderCost := onuOrderCost + nuY - nuN;
        end loop;
        ut_trace.trace('-- Paso 6. onuOrderCost '||onuOrderCost, 1);
        --Fin Busqueda de ordenes de ajustes con su valor total
        --Fin NC 795
      else
        --Se trata de una orden de Novedad
        onuordercost := 0;
        --obtener el item de or_order_activity

        ut_trace.trace('ORDEN NOVEDAD -->' || nuorden, 1);
        DBMS_OUTPUT.put_line('ORDEN NOVEDAD -->' || nuorden);

        for rtitemslegordennov in cuitemslegordennov(nuorden) loop
          nuitemnov := rtitemslegordennov.activity_id;

          ut_trace.trace('VALOR NOVEDAD -->' || nuitemnov, 1);
          DBMS_OUTPUT.put_line('VALOR NOVEDAD -->' || nuitemnov);

          ut_trace.trace('ITEM NOVEDAD -->' || nuitemnov, 1);
          DBMS_OUTPUT.put_line('ITEM NOVEDAD -->' || nuitemnov);

          --valida si se trata de un item de novedad positivo
          sbliquida := null;
          if cuitemnovedadpos%isopen then
            close cuitemnovedadpos;
          end if;
          open cuitemnovedadpos(nuitemnov); --(inuorderid);
          fetch cuitemnovedadpos
            into sbLiquida;
          close cuitemnovedadpos;

          --si item de novedad con signo positivo
          if (sbLiquida = 'X') then
            onuvalue := rtitemslegordennov.value_reference;
            if (onuvalue is null) then
              onuvalue := 0;
            end if;
            onuordercost := onuvalue + onuordercost;
          end if;
        end loop;
      end if;

    --END if;

    --ut_trace.trace('-- Paso 12. Final onuOrderCost -->' || onuOrderCost, 10);
    --ut_trace.trace('Fin [llozada] ldc_procostoorden', 10);


  END procostoorden;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PROCOSTOORDEN', 'ADM_PERSON');
END;
/