CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRFINANORDRP IS
/**************************************************************************
  Proceso     : LDC_PRFINANORDRP
  Autor       : Horbath
  Fecha       : 2021-11-19
  Ticket      : 876
  Descripcion : plugin para financiar ordenes de rp

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
 ***************************************************************************/
 -- Actividad de Orden
    rcSalesFinanCond    DACC_Sales_Financ_Cond.styCC_Sales_Financ_Cond;
    nuInterestPerc      cc_Sales_Financ_Cond.interest_percent%type;
    rcFinanPlan         plandife%rowtype;
    onuFinanPlanId      plandife.pldicodi%type;
      onuQuotasNumber     plandife.pldicuma%type;
    nuQuotasNumber     plandife.pldicuma%type;

    nuOrderId or_order.order_id%type;
    inuPackageID mo_packages.package_id%type;
    onuFinanId diferido.difecodi%type;
    nuCount number := 0;
    nuPackageTypeId ps_package_type.package_type_id%type;

    --Cursor para validar si la orden que se esta legalizando tiene una orden de apoyo para condiciones de financiacion asociada
    cursor cuIsFinanced(
           inuOrderId or_order.order_id%type
    ) is
    select count(*)
     from or_order_activity
     where order_id = inuOrderId
     and or_order_activity.activity_id = DALD_PARAMETER.fnugetnumeric_value('ID_ACT_ACTUALIZA_COND_FINANC');


    nuControl number := 0;

    nuCausalId ge_causal.causal_id%type;
    nuCausalClassId ge_class_causal.class_causal_id%type;
    nuProducto NUMBER;

    sbAplicaCaso872 VARCHAR2(1) := 'N';
    sbFechaFinal DATE := DALDC_PARAREPE.fsbGetPARAVAST('LDC_FECHFINPROM',NULL);
	  sbFechaInicial DATE := DALDC_PARAREPE.fsbGetPARAVAST('LDC_FECHINIPROM',NULL);

	  dtFechaFinal DATE;
	  dtFechaInicial DATE;

	  nuPlanEspecial NUMBER := DALDC_PARAREPE.fnuGetPAREVANU('LDC_CODPLFIPROM',NULL);
 --   sbEstrato VARCHAR2(400) := DALDC_PARAREPE.fsbGetPARAVAST('LDC_ESTRAPGRP',NULL);
    sbCategoria VARCHAR2(40) := DALDC_PARAREPE.fsbGetPARAVAST('LDC_CATEAPLPROM',NULL);

	  nuEdadIni  NUMBER :=  DALDC_PARAREPE.fnuGetPAREVANU('LDC_EDADRPINI',NULL);
    nuEdadFin  NUMBER :=  DALDC_PARAREPE.fnuGetPAREVANU('LDC_EDADRPFIN',NULL);

	  nuaplicaPlan NUMBER := 0;
	  nuaplicadesc  NUMBER := 0;
    nuExisteEst NUMBER;
    sbexiste VARCHAR2(1);
    nuperiGracia NUMBER;
    nuDias NUMBER;
    nuConcRepe NUMBER := DALDC_PARAREPE.fnuGetPAREVANU('CONC_REVISION_PERIODICA',NULL);
	  sbExisVali VARCHAR2(1);


    sbcertificado   open.ldc_certificados_oia.certificado%TYPE;
    nucodatributo   open.ge_attributes.attribute_id%TYPE;
    sbnombreatrib   open.ge_attributes.name_attribute%TYPE;

    nuproductid     open.pr_product.product_id%TYPE;
    nuunitoper      open.or_order.operating_unit_id%TYPE;
    sbmensa         VARCHAR2(1000);
    nugrupoatrib    open.ld_parameter.numeric_value%TYPE;
    nuresultadoins  open.ldc_certificados_oia.resultado_inspeccion%TYPE;
    nuExiste        number;

    --Se valida que el producto pertenezca a una categoaria para el proceso
    CURSOR cuValiCategoria IS
    SELECT sesucate, sesusuca
    FROM servsusc
    WHERE sesunuse = nuProducto
     AND sesucate in ( SELECT to_number(regexp_substr(sbCategoria,'[^,]+', 1, LEVEL)) AS categoria
                        FROM dual
                        CONNECT BY regexp_substr(sbCategoria, '[^,]+', 1, LEVEL) IS NOT NULL);

    regCategoria cuValiCategoria%rowtype;

    --se valida plazo maximo
    CURSOR cuValidaPlazoMaximo IS
    SELECT 'X'
    FROM LDC_PLAZOS_CERT
    WHERE ID_PRODUCTO = nuProducto
     AND PLAZO_MAXIMO BETWEEN SYSDATE   AND dtFechaFinal;

	  --se valida plazo maximo
    CURSOR cuValidaPlazoMaximoante IS
    SELECT trunc(LAST_DAY(PLAZO_MAXIMO)) - TRUNC(SYSDATE) dias
    FROM LDC_PLAZOS_CERTANT
    WHERE ID_PRODUCTO = nuProducto ;

    	  --se valida plazo maximo
    CURSOR cuValidaPlazoMaximoActu IS
    SELECT trunc(LAST_DAY(PLAZO_MAXIMO)) - TRUNC(SYSDATE) dias
    FROM LDC_PLAZOS_CERT
    WHERE ID_PRODUCTO = nuProducto ;

     --se obtiene periodo de gracia
    CURSOR cuGetPeriogracia IS
    SELECT PLDIPEGR
    FROM plandife
    WHERE PLDICODI = nuPlanEspecial;

    nuTotalPrecio NUMBER := 0;
    --se obtiene el precio de la orden
    CURSOR cugetPrecioOrden IS
    SELECT TOTAL_PRICE, ORDER_ITEMS_ID
     FROM OPEN.OR_ORDER_ITEMS
     WHERE ORDER_ID = nuOrderId
      AND TOTAL_PRICE > 0;

   dtFechaPago DATE := SYSDATE;

   nuCodAtriNucu  NUMBER := DALDC_PARAREPE.fnuGetPAREVANU('LDC_CODATRNUCU', NULL);--se almacena codigo del atributo de numero de cuotas
   sbNombAtriNucu VARCHAR2(4000) := DALDC_PARAREPE.fsbGetPARAVAST('LDC_NOMBATRNUCU', NULL);--se almacena nombre del atributo numero de cuotas
   nuNumeCuota NUMBER;--se almacena numero de cuotas
   nuEdadRp NUMBER;

     --se valida si fecha de ejecucion esta dentro del rango de promocion
    CURSOR cugetValidaFechProm IS
    SELECT 'X'
     FROM OPEN.OR_ORDER o
     WHERE ORDER_ID = nuOrderId
      AND EXECUTION_FINAL_DATE between dtFechaInicial and dtFechaFinal;


--Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
 CURSOR cuProducto(nucuorden NUMBER) is
  SELECT product_id, operating_unit_id
    FROM open.or_order_activity
   WHERE order_id = nucuorden
     AND rownum   = 1;

  CURSOR CUEXISTE(NUVALOR OR_ORDER.CAUSAL_ID%TYPE) IS
        SELECT count(1) cantidad
          FROM DUAL
         WHERE NUVALOR IN
               (select to_number(column_value)
                  from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('RESULTADO_INSPECCION_OIA',
                                                                                           NULL),
                                                          ',')));

	FUNCTION  FNUGETEDADRP
	(
		inuProduct_id  LDC_PLAZOS_CERT.id_producto%type
	)
	RETURN NUMBER
	IS

		nuMesesRevision number := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MESES_VALIDEZ_CERT');
		nuEdadProd      number; --(4);  Aranda 7303

		CURSOR cuEdad(producto_id LDC_PLAZOS_CERT.id_producto%type,nuMesesCert number)
		IS
			select nuMesesCert - months_between(trunc(to_date(plazo_maximo),'MONTH'),trunc(sysdate,'MONTH'))
			from LDC_PLAZOS_CERTANT
			where id_producto = producto_id;
	BEGIN

		OPEN cuEdad(inuProduct_id,nuMesesRevision);
		FETCH cuEdad INTO nuEdadProd;
		CLOSE cuEdad;

		IF nuEdadProd IS NOT NULL THEN
			RETURN nuEdadProd;
		ELSE
			RETURN null;
		END IF;

	EXCEPTION
		when ex.CONTROLLED_ERROR then
			raise ex.CONTROLLED_ERROR;
		when others then
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
	END FNUGETEDADRP;

     Procedure GetFinanCondbyProd
    (
      inuOrderId         in   or_order.order_id%type,
      inuPackageId       in   mo_packages.package_id%type,
      inuOpcion          in number,
      onuFinanPlanId     out  plandife.pldicodi%type,
      onuQuotasNumber    out  plandife.pldicuma%type
    )
    is
     nuOrderValue or_order.order_value%type := 0;
     -- Producto
    cnuProductID   or_order_activity.product_id%type;

    -- Tipo de Actividad
    nuActivityId          ge_items.items_id%type;

    nuNeighborthoodId   ab_address.neighborthood_id%type;
    nuAdressId          pr_product.address_id%type;
    nuGeograpLoca       ab_address.geograp_location_id%type;
    nuGeograpDepto      ab_address.geograp_location_id%type;
    nuGeograpPais       ab_address.geograp_location_id%type;
    nuCategoryId        servsusc.sesucate%type;
    nuSubcategory       servsusc.sesusuca%type;
    rcRecoFinanCond     ldc_finan_cond%rowtype;


    CURSOR cuFinanCondPlanEspe(
         inuActivityId ge_items.items_id%type,
         isbLocation varchar2,
         inuCateId number,
         inuSucaId number,
         inuOrderValue or_order.order_value%type
  ) IS
    SELECT  *
    FROM    ldc_finan_cond
    WHERE   reco_activity = inuActivityId
	  AND geo_location_id in (SELECT TO_NUMBER(COLUMN_VALUE)
							FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(isbLocation,',')))
	  AND category_id = inuCateId
	  AND subcategory_id = inuSucaId
      and inuOrderValue between nvl(ldc_finan_cond.min_value,0) and nvl(ldc_finan_cond.max_value, 999999999)
      and FINAN_PLAN_ID = nuPlanEspecial;

      CURSOR cuFinanCond(
         inuActivityId ge_items.items_id%type,
         isbLocation varchar2,
         inuCateId number,
         inuSucaId number,
         inuOrderValue or_order.order_value%type
  ) IS
    SELECT  *
    FROM    ldc_finan_cond
    WHERE   reco_activity = inuActivityId
            AND geo_location_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(isbLocation,',')))
            AND category_id = inuCateId
            AND subcategory_id = inuSucaId
      and inuOrderValue between nvl(ldc_finan_cond.min_value,0) and nvl(ldc_finan_cond.max_value, 999999999)
      and FINAN_PLAN_ID <> nuPlanEspecial;

  /*Cursor para obtener el valor de la orden por item NC 378*/
  cursor cuCostItem is
    select nvl(c.sales_value,0)
      from open.ge_unit_cost_ite_lis c
     where c.items_id = nuActivityId;

  /* Cursor para obtener el valor de la orden  NC 878   */
  cursor cuOrderValue (inuOrderId1   or_order.order_id%type)is
   SELECT sum ( nvl(or_order_items.total_price, 0) ) value
   FROM or_order_items
   WHERE or_order_items.order_id = inuOrderId1
   AND or_order_items.out_ = 'Y';

  sbLocation            varchar2(2000);
  rcOrderActivity       OR_BCOrderActivities.tyrcOrderActivities;

  cnuActRecCM           constant ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_ACT_RECONE_CM',0);
  cnuActRecACO          constant ld_parameter.numeric_value%type := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_ACT_RECONE_ACOM',0);


begin
        UT_Trace.Trace('Inicio GetFinanCondbyProd',5);

   --Obtener actividad principal de la ot
    nuActivityId := daor_order_activity.fnugetactivity_id( LDC_BcFinanceOt.fnuGetActivityId(inuOrderId));   --or_bolegalizeorder.prget--rcOrderActivity.nuOrderActivity;
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuActivityId=>'||nuActivityId, 10);

    --Obtener valor de la ot a financiar
    -- Inicio NC 878
    nuOrderValue := nvl(daor_order.fnugetorder_value(inuOrderId),0);

    if nuOrderValue = 0 then
      open cuOrderValue(inuOrderId);
      fetch cuOrderValue into nuOrderValue;
      close cuOrderValue;
    end if;
    -- Fin NC 878

    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue, 10);

    /*Inicio: Obtener el valor de la actividad principal NC378*/
    if nuOrderValue = 0 then
      open cuCostItem;
      fetch cuCostItem into nuOrderValue;
      close cuCostItem;
      ut_trace.trace('Ejecucion GetFinanCondbyProd => nuOrderValue=>'||nuOrderValue, 10);
    end if;
    /*Fin NC378*/
    --Obtener el producto
    cnuProductID := to_number(ldc_boutilities.fsbgetvalorcampostabla('or_order_activity','order_id','product_id',inuOrderId,'package_id',inuPackageId));
      ut_trace.trace('Ejecucion GetFinanCondbyProd => cnuProductID=>'||cnuProductID, 10);
      --Obener la direccion del producto
    nuAdressId    := dapr_product.fnugetaddress_id(cnuProductID);
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuAdressId=>'||nuAdressId, 10);
    --Obtener el barrio
    nuNeighborthoodId := daab_address.fnugetneighborthood_id(nuAdressId);
    sbLocation := nuNeighborthoodId||',';
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuNeighborthoodId=>'||nuNeighborthoodId, 10);
    --Obtener la localidad
    nuGeograpLoca := daab_address.fnugetgeograp_location_id(nuAdressId);
    sbLocation := sbLocation||nuGeograpLoca||',';
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuGeograpLoca =>'||nuGeograpLoca, 10);
        --Obtener el Depto
    nuGeograpDepto := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpLoca);
    sbLocation := sbLocation||nuGeograpDepto||',';
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuGeograpDepto =>'||nuGeograpDepto, 10);
    --Obtener Pais
    --Obtener categoria y subcategoria
    nuGeograpPais := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpDepto);
    sbLocation := sbLocation||nuGeograpPais;
    ut_trace.trace('Ejecucion GetFinanCondbyProd => nuGeograpPais =>'||nuGeograpPais, 10);
    nuCategoryId  := pktblservsusc.fnugetcategory(cnuProductID);
    nuSubcategory := pktblservsusc.fnugetsubcategory(cnuProductID);

    UT_Trace.Trace('Ejecucion GetFinanCondbyProd => sbLocation => '||sbLocation,5);
    UT_Trace.Trace('Ejecucion GetFinanCondbyProd['||nuGeograpLoca||']['||nuCategoryId||']['||nuSubcategory||']',5);

    rcRecoFinanCond := NULL;

    IF nuActivityId = cnuActRecACO AND LDC_BcFinanceOt.fnuValReconexion(cnuProductID,inuPackageId) > ld_boconstans.cnuCero THEN
        nuActivityId := cnuActRecCM;
        -- Busca si existe un criterio que coincida con la ubicacion geografica, categoria
        --y subcategoria del producto
        if inuOpcion = 0 then
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

        else
          OPEN cuFinanCondPlanEspe(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
              FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
          CLOSE cuFinanCondPlanEspe;

          IF rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                /* Se busca configuracion por ubicacion geografica y  Categoria*/
                OPEN cuFinanCondPlanEspe(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
                CLOSE cuFinanCondPlanEspe;
                IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                    /* Se busca configuracion por ubicacion geografica*/
                    OPEN cuFinanCondPlanEspe(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                    FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
                    CLOSE cuFinanCondPlanEspe;
                END IF;
          END IF;

        end if;

        /* Si el registro no es nulo se asigna condiciones de Financiacion */
        IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
            onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
            onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
        END IF;


    ELSE
        /* Busca si existe un criterio que coincida con la ubicacion geografica, categoria
        y subcategoria del producto */
        if inuOpcion = 0 then
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
        else
            OPEN cuFinanCondPlanEspe(nuActivityId,sbLocation,nuCategoryId,nuSubcategory, nuOrderValue);
            FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
            CLOSE cuFinanCondPlanEspe;

            IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                  /* Se busca configuracion por ubicacion geografica y  Categoria*/
                  OPEN cuFinanCondPlanEspe(nuActivityId, sbLocation,nuCategoryId,-1,nuOrderValue);
                  FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
                  CLOSE cuFinanCondPlanEspe;
                  IF  rcRecoFinanCond.rec_finan_cond_id IS NULL THEN
                      /* Se busca configuracion por ubicacion geografica*/
                      OPEN cuFinanCondPlanEspe(nuActivityId, sbLocation,-1,-1,nuOrderValue);
                      FETCH cuFinanCondPlanEspe INTO rcRecoFinanCond;
                      CLOSE cuFinanCondPlanEspe;
                  END IF;
            END IF;
        end if;

        /* Si el registro no es nulo se asigna condiciones de Financiacion */
        IF rcRecoFinanCond.rec_finan_cond_id IS NOT NULL THEN
            onuFinanPlanId  :=  rcRecoFinanCond.finan_plan_id;
            onuQuotasNumber :=  rcRecoFinanCond.quotas_number;
        END IF;

    END IF;

    UT_Trace.Trace('Fin GetFinanCondbyProd',5);
    EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
 end GetFinanCondbyProd;
begin

  ut_trace.trace('Inicio LDC_PRFINANORDRP', 10);
  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
  ut_trace.trace('Ejecucion LDC_PRFINANORDRP => nuOrderId=>'||nuOrderId, 10);
  --Obtener causal de legalizacion
  nuCausalId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla ('or_order','order_id','causal_id',nuOrderId));
  ut_trace.trace('Ejecucion LDC_PRFINANORDRP => nuCausalId=>'||nuCausalId, 10);
  --Obtener tipo de causal
  nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
  ut_trace.trace('Ejecucion LDC_PRFINANORDRP => nuCausalClassId=>'||nuCausalClassId, 10);

   -- Obtenemos el producto asociado a la orden de trabajo
  OPEN cuproducto(nuOrderId);
   FETCH cuProducto INTO nuproductid,nuunitoper;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuOrderId);
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
         RAISE ex.controlled_error;
      END IF;
   CLOSE cuproducto;

  IF FBLAPLICAENTREGAXCASO('0000872') THEN
     sbAplicaCaso872 := 'S';
  END IF;
  --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
  if nuCausalClassId = 1 then
      --Obtener identificador de la solicitud
      inuPackageID := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order_activity','order_id','package_id',nuOrderId));
      ut_trace.trace('Ejecucion LDC_PRFINANORDRP => inuPackageID=>'||inuPackageID, 10);
      if inuPackageID is null or inuPackageID = -1 then
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No existe una solicitud asociada a la orden '||nuOrderId);
                raise ex.CONTROLLED_ERROR;
      end if;
      --Obtener tipo de paquete
      nuPackageTypeId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages','package_id','package_type_id',inuPackageID));
      ut_trace.trace('Ejecucion LDC_PRFINANORDRP => nuPackageTypeId=>'||nuPackageTypeId, 10);
      if nuPackageTypeId is null or nuPackageTypeId = -1 then
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No existe un tipo de solicitud asociado a la solicitud '||inuPackageID);
                raise ex.CONTROLLED_ERROR;
      end if;
	    --se consulta numero de cuota
	    nuNumeCuota := ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,nuCodAtriNucu,TRIM(sbNombAtriNucu));

      IF sbAplicaCaso872 = 'S' AND sbFechaInicial IS NOT NULL AND sbFechaFinal IS NOT NULL THEN
          nuProducto := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order_activity','order_id','product_id',nuOrderId));

		  dtFechaFinal := TO_DATE(sbFechaFinal,'DD/MM/YYYY HH24:MI:SS');
		  dtFechaInicial := TO_DATE(sbFechaInicial,'DD/MM/YYYY HH24:MI:SS');

		  OPEN cugetValidaFechProm;
		  FETCH cugetValidaFechProm INTO sbExisVali;
		  CLOSE cugetValidaFechProm;

		  IF sbExisVali is not null THEN
			  OPEN cuValiCategoria;
			  FETCH cuValiCategoria into regCategoria;
			  IF cuValiCategoria%FOUND THEN
				 nuaplicaPlan := 1;
			  END IF;
			  CLOSE cuValiCategoria;
        ---Se valida el resultado de inspeccion
        -- Obtenemos el valor del certificado del dato adicional
         nucodatributo := open.dald_parameter.fnuGetNumeric_Value('COD_DATO_ADICIONAL_VAL_CERTI',NULL);
         IF nucodatributo IS NULL THEN
           sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro COD_DATO_ADICIONAL_VAL_CERTI, codigo dato adicional del certificado.';
           ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
           RAISE ex.controlled_error;
         END IF;
         sbnombreatrib := open.dald_parameter.fsbGetValue_Chain('NOMBRE_ATRI_VAL_CERTI');
         IF sbnombreatrib IS NULL THEN
           sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro NOMBRE_ATRI_VAL_CERTI, nombre dato adicional del certificado.';
           ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
           RAISE ex.controlled_error;
         END IF;
         nugrupoatrib := open.dald_parameter.fnuGetNumeric_Value('COD_GRUPO_DATO_ADIC_VAL_CERTI',NULL);
         IF nugrupoatrib IS NULL THEN
           sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro COD_GRUPO_DATO_ADIC_VAL_CERTI, grupo del dato adicional del certificado.';
           ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
           RAISE ex.controlled_error;
         END IF;
         sbcertificado := open.ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,nucodatributo,TRIM(sbnombreatrib));
         -- Consultamos existencia del certificado
         nuresultadoins  := NULL;
         BEGIN
          SELECT resultado_inspeccion INTO nuresultadoins
            FROM(
                 SELECT c.resultado_inspeccion
                  -- se agrega la tabla de configuracion de oia de certificacion
                   FROM open.ldc_certificados_oia c , open.LDCCTROIACCTRL l
                  WHERE TRIM(c.certificado) = TRIM(sbcertificado)
                    --se agrega la validacion de oia de certificacion
                    AND c.id_producto       = nuproductid
                    AND c.id_organismo_oia  = l.CONTRATISTAOIA
                    AND l.CONTRALEGCERT  = nuunitoper
                  ORDER BY c.fecha_registro DESC
                )
           WHERE ROWNUM = 1;
         EXCEPTION
          WHEN no_data_found THEN
           nuresultadoins  := NULL;
         END;
        nuExiste := null;
        open CUEXISTE(nuresultadoins);
        fetch CUEXISTE into nuExiste;
        close CUEXISTE;

        ---

			  IF nuaplicaPlan > 0 THEN
        if nuExiste >= 1 then
           nuEdadRp := NVL(FNUGETEDADRP(nuProducto),0);
        else
           nuEdadRp := NVL(ldc_getedadrp(nuProducto),0);
        end if;


				IF nuEdadRp BETWEEN  nuEdadIni AND nuEdadFin THEN
				     --se valida plazo maximo
					IF nuExiste >=1 THEN
						OPEN cuValidaPlazoMaximoante;
						FETCH cuValidaPlazoMaximoante INTO nuDias;
						IF cuValidaPlazoMaximoante%NOTFOUND THEN
							nuaplicaPlan := 0;
						END IF;
						CLOSE cuValidaPlazoMaximoante;
					ELSE
						 OPEN cuValidaPlazoMaximoactu;
						  FETCH cuValidaPlazoMaximoactu INTO nuDias;
						  IF cuValidaPlazoMaximoactu%NOTFOUND THEN
							nuaplicaPlan := 0;
						  END IF;
						  CLOSE cuValidaPlazoMaximoactu;
					end if;
				ELSE
				  nuaplicaPlan := 0;
				END IF;


			  ELSE
				--se valida plazo maximo
				OPEN cuValidaPlazoMaximo;
				FETCH cuValidaPlazoMaximo INTO sbExiste;
				IF cuValidaPlazoMaximo%NOTFOUND THEN
					nuaplicaPlan := 0;
				END IF;
				CLOSE cuValidaPlazoMaximo;
			  END IF;
         END IF;
      END IF;
      --Buscar si existe configuracion en PCFO
      --Obtener el numero de cuotas de acuerdo con la
      if nuaplicaPlan = 0 THEN
        --configuracion realizada para el valor de la Ot y el plan de financiacion
        --LDC_BcFinanceOt.GetFinanCondbyProd (nuOrderId,inuPackageID,onuFinanPlanId, onuQuotasNumber);
         GetFinanCondbyProd (nuOrderId,inuPackageID, 0, onuFinanPlanId, onuQuotasNumber);
         ut_trace.trace('ingreso plan normal ', 10);

      ELSE
        ut_trace.trace('ingreso plan especial ', 10);
        --se obtiene periodo de gracias
        OPEN cuGetPeriogracia;
        FETCH cuGetPeriogracia INTO nuperiGracia;
        CLOSE cuGetPeriogracia;

        IF nuperiGracia > 0 THEN
         -- nuDias := TRUNC(dtFechaFinal) - trunc(sysdate) + 1;
          IF nuDias > 0 THEN
            update CC_GRACE_PERIOD set MIN_GRACE_DAYS = nuDias, MAX_GRACE_DAYS = nuDias
            where GRACE_PERIOD_ID = nuperiGracia;
          END IF;

          dtFechaPago := TRUNC(SYSDATE) + nuDias + 1;
        END IF;
        --se obtiene numero de cuotas
        GetFinanCondbyProd (nuOrderId,inuPackageID,1,onuFinanPlanId, onuQuotasNumber);
        --se valida si hay descuento

       END IF;

      ut_trace.trace('Ejecucion LDC_PRFINANORDRP => onuFinanPlanId - onuQuotasNumber =>'||onuFinanPlanId||' - '||onuQuotasNumber, 10);
      --Validar si existe una configuracio aplicable
      IF onuFinanPlanId IS NOT NULL AND onuQuotasNumber IS NOT NULL THEN
            --Validar si tiene OT de poyo
        open cuIsFinanced(nuOrderId);
        fetch cuIsFinanced into nuCount;
        close cuIsFinanced;
        if nuCount > 0 then
              --Obtener las n cuotas de CC_Sales_Financ_Cond
              nuQuotasNumber := DACC_Sales_Financ_Cond.Fnugetquotas_Number(inuPackageID);
              --Validar el numero de de cuotas
              if  (nuQuotasNumber > onuQuotasNumber) then
                  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                         'El numero de cuotas establecido excede el limite permitido');
                  raise ex.CONTROLLED_ERROR;
              end if;
              --Validar que
              --Obtener el plan de financiacion de la configuracion
              onuQuotasNumber := nuQuotasNumber;
              --Actualizar condiciones de financiacion
        end if;

			--se valida cuotas ingresadas
			IF nuNumeCuota IS NOT NULL THEN
        if  (nuNumeCuota > onuQuotasNumber) then
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                           'El numero de cuotas establecido excede el limite permitido');
                 raise ex.CONTROLLED_ERROR;
         end if;

			   onuQuotasNumber := nuNumeCuota;
			END IF;
            --Obtiene la informacion del plan
            rcFinanPlan := pkTblPlandife.frcGetRecord(onuFinanPlanId);
            --Obtiene el porcentaje de interes
            nuInterestPerc := fnuGetInterestRate(rcFinanPlan.plditain,SYSDATE);
            ut_trace.trace('Ejecucion LDC_PRFINANORDRP => nuInterestPerc =>'||nuInterestPerc, 10);
            --Actualiza los campos CC_SALES_FINANC_COND
            rcSalesFinanCond.package_id := inuPackageID;
            rcSalesFinanCond.financing_plan_id := onuFinanPlanId;
            rcSalesFinanCond.compute_method_id := pktblplandife.fnugetpaymentmethod(onuFinanPlanId);
            rcSalesFinanCond.interest_rate_id :=  pktblplandife.fnugetinterestratecod(onuFinanPlanId);
            rcSalesFinanCond.first_pay_date := dtFechaPago;
            rcSalesFinanCond.percent_to_finance := 100;
            rcSalesFinanCond.interest_percent := nuInterestPerc;
            rcSalesFinanCond.spread := 0;
            rcSalesFinanCond.quotas_number := onuQuotasNumber;
            rcSalesFinanCond.tax_financing_one := 'N';
            rcSalesFinanCond.value_to_finance := 0;
            rcSalesFinanCond.document_support := 'OR-'||nuOrderId;
            rcSalesFinanCond.initial_payment := 0;
            rcSalesFinanCond.average_quote_value := 0;

            --Validar si para la solicitud ya se definieron conticiones de financiacion
            if not dacc_sales_financ_cond.fblexist(inuPackageID) then
                --Inserta la informacion de las condiciones
                DACC_Sales_Financ_Cond.insrecord(rcSalesFinanCond);
            else
                --Actualizar la informacion de las condiciones
                 DACC_Sales_Financ_Cond.Updrecord(rcSalesFinanCond);
            end if;
       ELSE
        --Error
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                             'No se configuraron condiciones de financiacion para la solicitud '||inuPackageID);
            raise ex.CONTROLLED_ERROR;
       END IF;
       --Validar si el flujo del tipo de solicitud valida si se exoneraron los cobros
       if not instr(DALD_PARAMETER.fsbGetVALUE_CHAIN('ID_PKG_TYPE_RP_SI'),to_char(nuPackageTypeId)) > 0 then
            ut_trace.trace('pagarcia: entro', 10);
            --Generar una factura con los cargos a la cuenta de cobro -1 generados por la legalizacion de la orden (estos se identifican
            --porque en la tabla CARGOS, en la tabla CARGDOSO tienen el prefijo "PP" mas el numero de la solicitud), usando el metodo:
            --Donde inuPackageID es un parametro de entrada que hace referencia al numero de la solicitud padre de la orden de trabajo
            CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(inuPackageID);
            ut_trace.trace('pagarcia: Ejecucion LDC_PRFINANORDRP => onuFinanId =>'||onuFinanId, 10);
            --Realizar la financiacion de la factura mediante el metodo:
            cc_bofinancing.financingorder(inuPackageID);
            ut_trace.trace('pagarcia: Ejecucion LDC_PRFINANORDRP => onuFinanId =>'||onuFinanId, 10);
       end if;
   end if;
   ut_trace.trace('Fin LDC_PRFINANORDRP', 10);
 EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
END LDC_PRFINANORDRP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRFINANORDRP', 'ADM_PERSON');
END;
/
