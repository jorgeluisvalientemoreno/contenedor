CREATE OR REPLACE PROCEDURE adm_person.ldc_prgenerecocmrp IS
  /**************************************************************************
  Autor       : OLSOFTWARE
  Fecha       : 2021-01-25
  Proceso     : LDC_PRGENERECOCMRP
  Ticket      : 547
  Descripcion : plugin que se encargue de generar solicitud de reconexi�n de rp

  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  25/11/2021   DANVAL      CA 833_1 : La orden instanciada se validara en OR_REQU_DATA_VALUE para ver si posee el dato adicional definido en el par�metro DATOADICION_UNIDADOPER si existe se registrar� en la tabla LDC_ORDENTRAMITERP
  28/02/2022   JORVAL      GLPI 949: Agrega comentario de la solciitud asociada a la orden legalizada a la nueva solicitud generada
  16/05/2024   Adrianavg   OSF-2675: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  --CA 833_1
  sbDatoAdicional   open.ldc_pararepe.paravast%type := open.DALDC_PARAREPE.fsbGetPARAVAST('DATOADICION_UNIDADOPER',
                                                                                          NULL);
  nuCodDatoAdicic   open.ldc_pararepe.parevanu%type := open.DALDC_PARAREPE.fnuGetPAREVANU('COD_DATOADICION_UNIDADOPER',
                                                                                          NULL);

  sbTipoTrabFalloRP open.ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('TIPOTRABAJO_FALLORP',
                                                                                     NULL);
  sbCausalFalloRP   open.ldc_pararepe.paravast%type := DALDC_PARAREPE.FSBGETPARAVAST('CAUSAL_FALLORP',
                                                                                     NULL);
  nuTipoTrabFalloRP number;
  nuCausalFalloRP   number;

  nuCausal          number;
  NUUNITOPERADDDATA number;
  sbValorPRCDA      varchar2(2000);
  sbAplica833       varchar2(1);
  nuExisteOU        number;
  --
  numedRecRp       open.ldc_pararepe.parevanu%type := DALDC_PARAREPE.FNUGETPAREVANU('LDC_MEDIRECERP',
                                                                                    null);
  sbTiTrPortal     open.ldc_pararepe.paravast%type := open.DALDC_PARAREPE.fsbGetPARAVAST('LDC_TIPOTRABPORTAL',
                                                                                         NULL);
  nuestadoProducto open.pr_product.product_status_id%type;
  nuEstacort       open.servsusc.sesuesco%type;
  sbEstadoFina     open.servsusc.sesuesfn%type;
  nuTitrOt         open.or_order.task_type_id%type;
  nuSoliOt         open.mo_packages.package_id%type;
  nuPackageId      number;
  nuMotiveId       number;
  numarca          number;
  nuOrderId        number;
  nuProducto       number;
  ONUERRORCODE     number := null;
  OSBERRORMESSAGE  varchar2(4000);

  --se consulta cargos de certificacion
  CURSOR cuGetProducto IS
    SELECT oa.product_id,
           p.product_status_id,
           sesuesfn,
           sesuesco,
           oa.package_id
      FROM or_order_activity oa, pr_product p, servsusc
     WHERE oa.order_id = nuOrderId
       and oa.product_id = p.product_id
       and oa.product_id = sesunuse;

  -- datos para generar xml
  CURSOR cudatosXml IS
    select di.ADDRESS_PARSED,
           di.ADDRESS_ID,
           di.GEOGRAP_LOCATION_ID,
           pr.CATEGORY_ID,
           pr.SUBCATEGORY_ID,
           pr.SUBSCRIPTION_ID,
           sc.SUSCCLIE SUBSCRIBER_ID,
           pr.product_id
      from pr_product pr, SUSCRIPC sc, ab_address di
     where pr.ADDRESS_ID = di.ADDRESS_ID
       and pr.SUBSCRIPTION_ID = sc.SUSCCODI
       and pr.product_id = nuproducto;

  regProducto cudatosXml%rowtype;
  sbComment   varchar2(4000);
  sbComment1  varchar2(4000);
  sbmensa     varchar2(4000);

BEGIN

  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
  nuTitrOt  := daor_order.fnugettask_type_id(nuOrderId, null);
  if instr(sbTiTrPortal, nuTitrOt || ',') > 0 then
    numedRecRp := DALDC_PARAREPE.FNUGETPAREVANU('LDC_MEDIRECERP', null);
  else
    numedRecRp := 10;
  end if;

  --se obtiene producto
  OPEN cuGetProducto;
  FETCH cuGetProducto
    INTO nuProducto, nuestadoProducto, sbEstadoFina, nuEstacort, nuSoliOt;
  IF cuGetProducto%NOTFOUND THEN
    ERRORS.SETERROR(2741,
                    'Orden de trabajo [' || nuOrderId ||
                    '] no tiene informacion de producto.');
    RAISE ex.controlled_error;
  END IF;
  CLOSE cuGetProducto;

  begin
    insert into ldc_ordenes_rp
      (product_id, order_id, package_id)
    values
      (nuProducto, nuOrderId, nuSoliOt);
  exception
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  end;

  -- Consultamos que marca tiene el producto
  numarca   := ldc_fncretornamarcaprod(nuProducto);

  --CAMBIO 949
  --Obtener comentario de la solicitude asociada a la orden legalizada.
  begin
    select mp.comment_ into sbComment1
      from open.mo_packages mp
     where mp.package_id = nuSoliOt;

  exception
    when others then
      sbComment1 := null;
  end;
  ---------------------

  sbComment := SUBSTR('Solicitud generada por proceso LDC_PRGENESOLSACRP, legalizacion de la orden [' ||
               nuOrderId || '] ' || sbComment1,0,1999);
  open cudatosXml;
  fetch cudatosXml
    into regProducto;
  close cudatosXml;

  IF nvl(numarca, 101) = ldcfncretornamarcarevprp THEN
    ldc_pkgeneraTramiteRp.prGenera100237(numedRecRp,
                                         sbComment,
                                         regProducto.SUBSCRIBER_ID,
                                         regProducto.PRODUCT_ID,
                                         regProducto.SUBSCRIPTION_ID,
                                         regProducto.ADDRESS_PARSED,
                                         regProducto.ADDRESS_ID,
                                         regProducto.GEOGRAP_LOCATION_ID,
                                         regProducto.CATEGORY_ID,
                                         regProducto.SUBCATEGORY_ID,
                                         nuPackageId,
                                         nuMotiveId,
                                         ONUERRORCODE,
                                         OSBERRORMESSAGE);

  elsif (nuMarca in (ldcfncretornamarcarepprp, ldcfncretornamarcadefcri)) then
    ldc_pkgeneraTramiteRp.prGenera100294(numedRecRp,
                                         sbComment,
                                         regProducto.SUBSCRIBER_ID,
                                         regProducto.PRODUCT_ID,
                                         regProducto.SUBSCRIPTION_ID,
                                         regProducto.ADDRESS_PARSED,
                                         regProducto.ADDRESS_ID,
                                         regProducto.GEOGRAP_LOCATION_ID,
                                         regProducto.CATEGORY_ID,
                                         regProducto.SUBCATEGORY_ID,
                                         nuPackageId,
                                         nuMotiveId,
                                         ONUERRORCODE,
                                         OSBERRORMESSAGE);
  elsif (nuMarca = ldcfncretornamarcacerprp) then
    ldc_pkgeneraTramiteRp.prGenera100295(numedRecRp,
                                         sbComment,
                                         regProducto.SUBSCRIBER_ID,
                                         regProducto.PRODUCT_ID,
                                         regProducto.SUBSCRIPTION_ID,
                                         regProducto.ADDRESS_PARSED,
                                         regProducto.ADDRESS_ID,
                                         regProducto.GEOGRAP_LOCATION_ID,
                                         regProducto.CATEGORY_ID,
                                         regProducto.SUBCATEGORY_ID,
                                         nuPackageId,
                                         nuMotiveId,
                                         ONUERRORCODE,
                                         OSBERRORMESSAGE);

  end if;
  if ONUERRORCODE <> 0 then
    ldc_pkgrepegelerecoysusp.proRegistraLogLegOrdRecoSusp('LDC_PRGENERECOCMRP',
                                                          SYSDATE,
                                                          nuOrderId,
                                                          null,
                                                          'Error al generar proceso de Rp [' ||
                                                          OSBERRORMESSAGE || ']',
                                                          USER);
    ERRORS.SETERROR(2741,
                    'Error al generar proceso de Rp [' || OSBERRORMESSAGE || ']');
    RAISE ex.controlled_error;
  else
    --CA 833_1
      IF FBLAPLICAENTREGAXCASO('0000833') THEN

        sbAplica833:='S';
        /*Si el Tipo de Trabajo est� definido en el  Par�metro TIPOTRABAJO_OPERARP y la causal es de �xito*/
        nuExisteOU := 0;
        sbValorPRCDA := open.ldc_boordenes.fsbDatoAdicTmpOrden(nuOrderId,nuCodDatoAdicic,TRIM(sbDatoAdicional));
        if sbValorPRCDA is not null then
           nuUnitOperAdddata := to_number(sbValorPRCDA);
           if daor_operating_unit.fblexist(nuUnitOperAdddata ) then
              nuExisteOU :=1;
           else
              nuExisteOU :=0;
              sbmensa := 'Proceso termino con errores : La Unidad Operativa [' ||
                         NUUNITOPERADDDATA ||
                         '] registrada en el Dato Adicional [' ||
                         sbDatoAdicional || '] no existe';
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                               sbmensa);
              RAISE ex.controlled_error;
           end if;
        end if;
        select count(1)
          into nuTipoTrabFalloRP
          from dual
         where nuTitrOt in
               (SELECT to_number(column_value)
                  FROM TABLE(open.ldc_boutilities.splitstrings(sbTipoTrabFalloRP,
                                                               ',')));
        nuCausal := Daor_order.fnugetCausal_id(nuOrderId, null);
        select count(1)
          into nuCausalFalloRP
          from dual
         where nuCausal in
               (SELECT to_number(column_value)
                  FROM TABLE(open.ldc_boutilities.splitstrings(sbCausalFalloRP,
                                                               ',')));
        nuCausal := Daor_order.fnugetCausal_id(nuOrderId, null);
        select count(1)
          into nuCausalFalloRP
          from dual
         where nuCausal in
               (SELECT to_number(column_value)
                  FROM TABLE(open.ldc_boutilities.splitstrings(sbCausalFalloRP,
                                                               ',')));
         if nuTipoTrabFalloRP > 0 and nuCausalFalloRP > 0 and NUUNITOPERADDDATA is not null then
            nuCausal := daor_order.fnugetcausal_id(nuOrderId, null);
            insert into LDC_ORDENTRAMITERP
              (ORDEN, TIPOTRABAJO, CAUSAL, SOLICITUD, UNIDADOPERA)
            values
              (nuOrderId, nuTitrOt, nuCausal, nuPackageId, NUUNITOPERADDDATA);
         end if;
      else
       sbAplica833 :='N';
      end if;
    --
  end if;

  begin
    delete ldc_ordenes_rp
     where product_id = nuProducto
       and order_id = nuOrderId
       and nvl(package_id, 0) = nvl(nuSoliOt, 0);
  exception
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
  end;
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when OTHERS then
    errors.seterror;
    raise ex.CONTROLLED_ERROR;
END LDC_PRGENERECOCMRP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PRGENERECOCMRP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRGENERECOCMRP', 'ADM_PERSON'); 
END;
/
