PL/SQL Developer Test script 3.0
270
-- Created on 10/04/2023 by JORGE VALIENTE 
declare 

  inuOrderId         open.or_order.order_id%type := 259881188;
  inuPackageId       open.mo_packages.package_id%type := 191430082;
    onuFinanPlanId     open.plandife.pldicodi%type;
    onuQuotasNumber    open.plandife.pldicuma%type;

  nuOrderValue open.or_order.order_value%type := 0;
  -- Producto
    cnuProductID   open.or_order_activity.product_id%type;

    -- Tipo de Actividad
    nuActivityId          open.ge_items.items_id%type;

  nuNeighborthoodId   open.ab_address.neighborthood_id%type;
    nuAdressId          open.pr_product.address_id%type;
    nuGeograpLoca       open.ab_address.geograp_location_id%type;
  nuGeograpDepto      open.ab_address.geograp_location_id%type;
  nuGeograpPais       open.ab_address.geograp_location_id%type;
    nuCategoryId        open.servsusc.sesucate%type;
    nuSubcategory       open.servsusc.sesusuca%type;
    rcRecoFinanCond     open.ldc_finan_cond%rowtype;
    CURSOR cuFinanCond(
         inuActivityId open.ge_items.items_id%type,
         isbLocation varchar2,
         inuCateId number,
         inuSucaId number,
         inuOrderValue open.or_order.order_value%type
  ) IS
    SELECT  *
    FROM    open.ldc_finan_cond
    WHERE   reco_activity = inuActivityId
            AND geo_location_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(open.LDC_BOUTILITIES.SPLITSTRINGS(isbLocation,',')))
            AND category_id = inuCateId
            AND subcategory_id = inuSucaId
      and inuOrderValue between nvl(ldc_finan_cond.min_value,0) and nvl(ldc_finan_cond.max_value, 999999999);

  /*Cursor para obtener el valor de la orden por item NC 378*/
  cursor cuCostItem is
    select nvl(c.sales_value,0)
      from open.ge_unit_cost_ite_lis c
     where c.items_id = nuActivityId;

  /* Cursor para obtener el valor de la orden  NC 878   */
  cursor cuOrderValue (inuOrderId1   open.or_order.order_id%type)is
   SELECT sum ( nvl(or_order_items.total_price, 0) ) value
   FROM open.or_order_items
   WHERE or_order_items.order_id = inuOrderId1
   AND or_order_items.out_ = 'Y';

  sbLocation            varchar2(2000);
  rcOrderActivity       open.OR_BCOrderActivities.tyrcOrderActivities;

  cnuActRecCM           constant open.ld_parameter.numeric_value%type := open.dald_parameter.fnuGetNumeric_Value('LDC_ACT_RECONE_CM',0);
  cnuActRecACO          constant open.ld_parameter.numeric_value%type := open.dald_parameter.fnuGetNumeric_Value('LDC_ACT_RECONE_ACOM',0);

---------
function fnuGetActivityId
(
  inuOrderId         in   open.or_order.order_id%type
) return number
is
 cursor cuActivityId
 is
 SELECT order_activity_id
 FROM open.or_order_activity
 WHERE  order_id = inuOrderId
        AND register_date = (SELECT min (or_order_activity.register_date)
                              FROM open.or_order_activity, open.or_order_items
                              WHERE or_order_activity.order_id = inuOrderId
                               and or_order_items.order_items_id = or_order_activity.order_item_id
                            and or_order_items.legal_item_amount <> -1
                            );
 /*select order_activity_id
  from or_order_activity
       where order_id = inuOrderId
        and rownum = 1
      order by or_order_activity.register_date asc;*/


  nuActivityId            open.or_order_activity.order_activity_id%type;
begin
  open cuActivityId;
  fetch cuActivityId into nuActivityId;
  if cuActivityId%notfound then
     nuActivityId := -1;
  end if;
  close cuActivityId;
  return nuActivityId;
end fnuGetActivityId;

    FUNCTION fnuValReconexion
    (
        inuProductId    in  open.OR_order_activity.product_id%type,
        inuPackageId    in  open.OR_order_activity.package_id%type
    )
    RETURN number
    IS

        sbItemsReconexionCM varchar2(4000) := '|'||open.dald_parameter.fsbGetValue_Chain('LDC_ITEMS_RECONEXION_CM',0)||'|';
        nuReconexionCM number;

        CURSOR cuValReconexion
        (
            nuProductId    in  open.OR_order_activity.product_id%type,
            nuPackageId    in  open.OR_order_activity.package_id%type
        )
        IS
            SELECT  count(1)
            FROM    open.OR_order_activity a,
                    open.OR_order_items b
            WHERE   a.order_id = b.order_id
            AND     a.ORDER_activity_id = b.ORDER_activity_id
            AND     a.product_id = nuProductId
            AND     a.package_id = nuPackageId
            AND     instr(sbItemsReconexionCM,'|'||b.items_id||'|') > 0
            AND     b.legal_item_amount = open.ld_boconstans.cnuonenumber;

    BEGIN

        dbms_output.put_line('Inicio Procedimiento LDC_BcFinanceOt.fnuValReconexion');
        dbms_output.put_line('Producto: '||inuProductId);
        dbms_output.put_line('Solicitud: '||inuPackageId);

        -- Si el CURSOR esta abierto, se cierra
        if cuValReconexion%isopen then
            close cuValReconexion;
        end if;

        -- Se crea un registro del CURSOR
        open cuValReconexion(inuProductId,inuPackageId);
            fetch cuValReconexion INTO nuReconexionCM;
        close cuValReconexion;

        dbms_output.put_line('Fin Procedimiento LDC_BcFinanceOt.fnuValReconexion['||nuReconexionCM||']');

        return nuReconexionCM;

    END fnuValReconexion;
--------------


begin
        dbms_output.put_line('Inicio LDC_BcFinanceOt.GetFinanCondbyProd');

       --Obtener actividad principal de la ot
        nuActivityId := open.daor_order_activity.fnugetactivity_id(fnuGetActivityId(inuOrderId));   --or_bolegalizeorder.prget--rcOrderActivity.nuOrderActivity;
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuActivityId=>'||nuActivityId);

        --Obtener valor de la ot a financiar
        -- Inicio NC 878
        nuOrderValue := nvl(open.daor_order.fnugetorder_value(inuOrderId),0);

        if nuOrderValue = 0 then
          open cuOrderValue(inuOrderId);
          fetch cuOrderValue into nuOrderValue;
          close cuOrderValue;
        end if;
        -- Fin NC 878

        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue);

        /*Inicio: Obtener el valor de la actividad principal NC378*/
        if nuOrderValue = 0 then
          open cuCostItem;
          fetch cuCostItem into nuOrderValue;
          close cuCostItem;
          dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue);
        end if;
        /*Fin NC378*/
        --Obtener el producto
        cnuProductID := to_number(open.ldc_boutilities.fsbgetvalorcampostabla('or_order_activity','order_id','product_id',inuOrderId,'package_id',inuPackageId));
          dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => cnuProductID=>'||cnuProductID);
          --Obener la direccion del producto
        nuAdressId    := open.dapr_product.fnugetaddress_id(cnuProductID);
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuAdressId=>'||nuAdressId);
        --Obtener el barrio
        nuNeighborthoodId := open.daab_address.fnugetneighborthood_id(nuAdressId);
        sbLocation := nuNeighborthoodId||',';
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuNeighborthoodId=>'||nuNeighborthoodId);
        --Obtener la localidad
        nuGeograpLoca := open.daab_address.fnugetgeograp_location_id(nuAdressId);
        sbLocation := sbLocation||nuGeograpLoca||',';
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpLoca =>'||nuGeograpLoca);
            --Obtener el Depto
        nuGeograpDepto := open.dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpLoca);
        sbLocation := sbLocation||nuGeograpDepto||',';
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpDepto =>'||nuGeograpDepto);
        --Obtener Pais
        --Obtener categoria y subcategoria
        nuGeograpPais := open.dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpDepto);
        sbLocation := sbLocation||nuGeograpPais;
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => nuGeograpPais =>'||nuGeograpPais);
        nuCategoryId  := open.pktblservsusc.fnugetcategory(cnuProductID);
        nuSubcategory := open.pktblservsusc.fnugetsubcategory(cnuProductID);

        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd => sbLocation => '||sbLocation);
        dbms_output.put_line('Ejecucion LDC_BcFinanceOt.GetFinanCondbyProd['||nuGeograpLoca||']['||nuCategoryId||']['||nuSubcategory||']');
        
        dbms_output.put_line('Categoria['||nuCategoryId||']');
        dbms_output.put_line('SubCategoria['||nuSubcategory||']');        

        rcRecoFinanCond := NULL;

        IF nuActivityId = cnuActRecACO AND fnuValReconexion(cnuProductID,inuPackageId) > open.ld_boconstans.cnuCero THEN
            nuActivityId := cnuActRecCM;
            -- Busca si existe un criterio que coincida con la ubicacion geografica, categoria
            --y subcategoria del producto
            OPEN cuFinanCond(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
                FETCH cuFinanCond INTO rcRecoFinanCond;
            CLOSE cuFinanCond;

            IF rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                  /* Se busca configuracion por ubicacion geografica y  Categoria*/
                  OPEN cuFinanCond(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                  FETCH cuFinanCond INTO rcRecoFinanCond;
                  CLOSE cuFinanCond;
                  IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                      /* Se busca configuracion por ubicacion geografica*/
                      OPEN cuFinanCond(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                      FETCH cuFinanCond INTO rcRecoFinanCond;
                      CLOSE cuFinanCond;
                  END IF;
            END IF;

            /* Si el registro no es nulo se asigna condiciones de Financiacion */
            dbms_output.put_line('1. IF rcRecoFinanCond.rec_finan_cond_id[' || rcRecoFinanCond.rec_finan_cond_id || '] IS NOT NULL THEN');
            IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
                onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
                onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
            END IF;

        ELSE
            /* Busca si existe un criterio que coincida con la ubicacion geografica, categoria
            y subcategoria del producto */
            OPEN cuFinanCond(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
                FETCH cuFinanCond INTO rcRecoFinanCond;
            CLOSE cuFinanCond;

            IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                  /* Se busca configuracion por ubicacion geografica y  Categoria*/
                  OPEN cuFinanCond(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                  FETCH cuFinanCond INTO rcRecoFinanCond;
                  CLOSE cuFinanCond;
                  IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                      /* Se busca configuracion por ubicacion geografica*/
                      OPEN cuFinanCond(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                      FETCH cuFinanCond INTO rcRecoFinanCond;
                      CLOSE cuFinanCond;
                  END IF;
            END IF;

            /* Si el registro no es nulo se asigna condiciones de Financiacion */
            dbms_output.put_line('2. IF rcRecoFinanCond.rec_finan_cond_id[' || rcRecoFinanCond.rec_finan_cond_id || '] IS NOT NULL THEN');
            IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
                onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
                onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
            END IF;

        END IF;


        dbms_output.put_line('    onuFinanPlanId: ' || onuFinanPlanId);
        dbms_output.put_line('    onuQuotasNumber: ' || onuQuotasNumber);

        dbms_output.put_line('Fin LDC_BcFinanceOt.GetFinanCondbyProd');
  
end;
0
0
