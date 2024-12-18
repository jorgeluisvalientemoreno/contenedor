CREATE OR REPLACE PACKAGE adm_person.ldc_pkgprocmuctt IS
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  TYPE RgCommissionRegister IS RECORD(
    onuCommissionValue mo_gas_sale_data.TOTAL_VALUE%type,
    sbIsZone           ldc_info_predio.is_zona%type);


  PROCEDURE PROPROCESSOMCTT(   sborden   IN VARCHAR2,
                              nuCurrent   IN NUMBER,
                              nuTotal     IN NUMBER,
                              nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                              sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE);
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso para legalizacion de las ordenes seleccionada en el PB [LDC_PROCMGCTT]


      Parametros Entrada
      sborden     codigo de la orden
      nuCurrent   numero de ocurrencia
      nuTotal     total orden seleccionadas

      sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total

      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PROPROCCESAPORMULT (   sborden   IN VARCHAR2,
                                      nuCurrent   IN NUMBER,
                                      nuTotal     IN NUMBER,
                                      nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                                      sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE);
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso para aprobacion de las ordenes seleccionadas en el PB [LDCAMAM]


      Parametros Entrada
      sborden     codigo de la orden
      nuCurrent   numero de ocurrencia
      nuTotal     total orden seleccionadas

      sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total

      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION FRFGETORDEMULT Return constants.tyrefcursor;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Funcion que se encarga de retornar las ordenes no procesadas y que no hayan sido
                    aprobadas o no aporobadas del PB [LDC_PROCMGCTT]


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

     FUNCTION FRFGETORAPMULT  Return constants.tyrefcursor;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Funcion que se encarga de retornar las ordenes no procesadas del PB [LDCAMAM]
                    y que esten aprobadas o no aprobadas.


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE PROGENMULTCVTT;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso que se encargara de generar las multas a contratista de ventas

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGPROCMUCTT IS

  function FnuGetCommissionValue( inuPackageId     IN mo_packages.package_id%type,
                                  inuAddressId     IN ab_address.address_id%type,
                                  inuProductid     IN pr_product.product_id%Type,
                                  inuOperatingUnit IN or_operating_unit.operating_unit_id%type,
                                  dtAttentionDate  IN mo_packages.REQUEST_DATE%type,
                                  nuGeograpLoca    IN  ge_geogra_location.geograp_location_id%type,
                                  nuCateCodi       IN categori.catecodi%TYPE,
                                  nuContractorId   IN or_operating_unit.contractor_id%type,
                                  nuOk             OUT NUMBER,
                                  sbMensaje        OUT VARCHAR2)
    return RgCommissionRegister is

     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Funcion que devuelve valor de la multa del comando CTCVE


      Parametros Entrada
        inuPackageId      Solicitud
        inuAddressId      Direccion
        inuProductid      Producto
        inuOperatingUnit  Unidad Operativa
        dtAttentionDate   Fecha de registro
        nuGeograpLoca     Localidad
        nuCateCodi        Categoria
        nuContractorId    Contratista

      Valor de salida
       nuOk      Codigo de error 0 - Exito -1 - Error
       sbMensaje  mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    RgReturn           RgCommissionRegister;

    nuCommissionType   LDC_COMISION_PLAN.COMISION_PLAN_ID%type;
    nuCommercialPlanId LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type;
    nuMereCodi         LDC_COMISION_PLAN.MERECODI%type;
    nuSucaCodi         LDC_COMISION_PLAN.SUCACODI%type;
    nuCommissionPlanId LDC_COMISION_PLAN.COMISION_PLAN_ID%type;
    nuTotalPercent     LDC_COMI_TARIFA.PORC_TOTAL_COMI%type;
    nuInitialPercent   LDC_COMI_TARIFA.PORC_ALFINAL%type;
    nuInitialValue     LDC_COMI_TARIFA.VALOR_ALFINAL%type;
    nuFinalPercent     LDC_COMI_TARIFA.PORC_ALFINAL%type;
    nuFinalValue       LDC_COMI_TARIFA.VALOR_ALFINAL%type;
    nuPercent          ldc_info_predio.PORC_PENETRACION%type;
    nuIdPremise        ab_premise.premise_id%type;
    nuTotalValueValue  mo_gas_sale_data.TOTAL_VALUE%type;
    AXnuMereCodi       LDC_COMISION_PLAN.MERECODI%type;
    AXnuCateCodi       LDC_COMISION_PLAN.CATECODI%type;
    AXnuSucaCodi       LDC_COMISION_PLAN.SUCACODI%type;
    SW                 NUMBER;


    --Ticket 200-1132 LJLB-- Cursor para obtener plan de comision
    cursor cuPlanCommissionId(nuCommissionType   LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
                              nuCommercialPlanId LDC_COMISION_PLAN.COMMERCIAL_PLAN_ID%type,
                              sbIsZone           ldc_info_predio.is_zona%type,
                              nuMereCodi         LDC_COMISION_PLAN.MERECODI%type,
                              nuCateCodi         LDC_COMISION_PLAN.CATECODI%type,
                              nuSucaCodi         LDC_COMISION_PLAN.SUCACODI%type) is
	select nvl(COMISION_PLAN_ID, 0) PlanCommissionId
	from LDC_COMISION_PLAN
	where TIPO_COMISION_ID = nuCommissionType
	 and IS_ZONA = sbIsZone
	 and COMMERCIAL_PLAN_ID = nuCommercialPlanId
	 and NVL(MERECODI, -1) = NVL(nuMereCodi, -1)
	 and NVL(CATECODI, -1) = NVL(nuCateCodi, -1)
	 and NVL(SUCACODI, -1) = NVL(nuSucaCodi, -1);

   --Ticket 200-1132 LJLB-- Cursor para obtener los valores para aplicar en el calculo de la comision al registro
    cursor cuCommission(dtAttentionDate    mo_packages.ATTENTION_DATE%type,
                        nuCommissionPlanId LDC_COMISION_PLAN.COMISION_PLAN_ID%type,
                        nuPercent          ldc_info_predio.PORC_PENETRACION%type) is
	select nvl(PORC_TOTAL_COMI, 0) totalPercent,
		 nvl(PORC_ALINICIO, 0) initialPercent,
		 nvl(VALOR_ALINICIO, 0) initialValue,
		 nvl(PORC_ALFINAL, 0) finalPercent,
		 nvl(VALOR_ALFINAL, 0) finalValue
	from LDC_COMI_TARIFA
	where COMISION_PLAN_ID = nuCommissionPlanId
	 and dtAttentionDate between FECHA_VIG_INICIAL and FECHA_VIG_FINAL
	 and nuPercent between RANG_INI_PENETRA and RANG_FIN_PENETRA;

    --Ticket 200-1132 LJLB-- Cursor para obtener el tipo de zona y el porcentaje de cobertura en la zona
    cursor cuZonePercent(nuIdPremise ab_premise.premise_id%type) is
	select IS_ZONA sbZone, nvl(PORC_PENETRACION, 0) nuPercent
	from ldc_info_predio
	where PREMISE_ID = nuIdPremise
		and rownum = 1;

    sbCargdoso cargos.cargdoso%type;

    sbError VARCHAR2(4000);
  begin

    RgReturn.onuCommissionValue := 0;
    RgReturn.sbIsZone           := 'X';

    --Ticket 200-1132 LJLB-- Obtener id predio
    nuIdPremise := daab_address.fnugetestate_number(inuAddressId, null);
    --Ticket 200-1132 LJLB-- se valida si el predio es correcto
    if nuIdPremise is null then
      nuOk := -1;
      sbMensaje := 'No existe predio asociado a la direcciÃ³n ' || inuAddressId;
      return RgReturn;
    end if;
    --Ticket 200-1132 LJLB--Obtener zona  porcentaje de cobertura para la zona
    open cuZonePercent(nuIdPremise);
    fetch cuZonePercent into RgReturn.sbIsZone, nuPercent;
    if cuZonePercent%notfound then
      RgReturn.onuCommissionValue := 0;
      RgReturn.sbIsZone           := 'X';
      close cuZonePercent;
      return RgReturn;
    end if;
    close cuZonePercent;

   --Ticket 200-1132 LJLB-- obtenr subcategoria del producto
    nuSucaCodi := to_number(dapr_product.fnuGetSUBCATEGORY_ID(inuProductId, NULL));
    --Ticket 200-1132 LJLB -- Obtener mercado relevante
    nuMereCodi := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('fa_locamere', 'LOMRLOID', 'LOMRMECO', nuGeograpLoca));

     --Ticket 200-1132 LJLB --Obtener plan comercial
    nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive', 'PACKAGE_ID','COMMERCIAL_PLAN_ID', inuPackageId));
    --Ticket 200-1132 LJLB-- valida si el plan comercial es correcto
    if nuCommercialPlanId is null or nuCommercialPlanId = -1 then
      nuOk := -1;
      sbMensaje := 'No existe un plan comercial asociado a la solicitud de venta: ' ||inuPackageId;
      return RgReturn;
    end if;

    --Ticket 200-1132 LJLB-- Obtener tipo de comision para contratista y validar
    --Ticket 200-1132 LJLB-- Validar si se realizo la configuraci?n para el contratista
   nuCommissionType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT', 'OPERATING_UNIT_ID','TIPO_COMISION_ID',nuContractorId));
   if nuCommissionType = -1 or nuCommissionType is null then
      nuOk := -1;
      sbMensaje := 'No existe Tipo de Comision asocociado al contratista: ' ||nuContractorId;
      return RgReturn;
    else
      SW           := 0;
      AXnuMereCodi := nuMereCodi;
      AXnuCateCodi := nuCateCodi;
      AXnuSucaCodi := nuSucaCodi;
      LOOP
        BEGIN
          open cuPlanCommissionId(nuCommissionType,
                                  nuCommercialPlanId,
                                  RgReturn.sbIsZone,
                                  AXnuMereCodi,
                                  AXnuCateCodi,
                                  AXnuSucaCodi);
          fetch cuPlanCommissionId      into nuCommissionPlanId;
          IF cuPlanCommissionId%NOTFOUND THEN
              IF SW = 0 THEN
                AXnuMereCodi := nuMereCodi;
                AXnuCateCodi := nuCateCodi;
                AXnuSucaCodi := NULL;
              ELSIF SW = 1 THEN
                AXnuMereCodi := NULL;
                AXnuCateCodi := nuCateCodi;
                AXnuSucaCodi := nuSucaCodi;
              ELSIF SW = 2 THEN
                AXnuMereCodi := nuMereCodi;
                AXnuCateCodi := NULL;
                AXnuSucaCodi := NULL;
              ELSIF SW = 3 THEN
                AXnuMereCodi := NULL;
                AXnuCateCodi := nuCateCodi;
                AXnuSucaCodi := NULL;
              ELSIF SW = 4 THEN
                AXnuMereCodi := NULL;
                AXnuCateCodi := NULL;
                AXnuSucaCodi := NULL;
              END IF;
          END IF;

        END;
        close cuPlanCommissionId;
        EXIT WHEN nuCommissionPlanId > 0 OR SW = 5;
        SW := SW + 1;

      END LOOP;
      --Ticket 200-1132 LJLB-- se valida configuracion del valor de la multa
      open cuCommission(dtAttentionDate, nuCommissionPlanId, nuPercent);
      fetch cuCommission   into nuTotalPercent, nuInitialPercent,nuInitialValue, nuFinalPercent,nuFinalValue;
      close cuCommission;
      if nuTotalPercent = 0 then
           nuOk := 0;
            RgReturn.onuCommissionValue := nuInitialValue + nuFinalValue;
           return RgReturn;
      else

        sbCargdoso        := 'PP-' || inuPackageId;
        nuTotalValueValue := LDC_BCSALESCOMMISSION.LDC_FNUGETVLRVENTA(sbCargdoso);

        RgReturn.onuCommissionValue := (((nuTotalPercent / 100) * (nuFinalPercent / 100)) * nuTotalValueValue) + (((nuTotalPercent / 100) * (nuInitialPercent / 100)) * nuTotalValueValue);
        nuOk := 0;
        return RgReturn;
      end if;
    end if;

    nuOk := 0;

    return RgReturn;

exception
    WHEN ex.CONTROLLED_ERROR then
      raise;
    WHEN others then
      nuOk := -1;
      sbMensaje := 'Error no Controlado en FnuGetCommissionValue ' || SQLERRM;

  end FnuGetCommissionValue;

  PROCEDURE PROPROCESSOMCTT(   sborden   IN VARCHAR2,
                              nuCurrent   IN NUMBER,
                              nuTotal     IN NUMBER,
                              nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                              sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso para legalizacion de las ordenes seleccionada en el PB [LDC_PROCMGCTT]


      Parametros Entrada
       sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total

      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
       sbTipoComentario       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-1132 LJLB-- se almacena el tipo de comentario
       sbComentario           GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-1132 LJLB-- se almacena el comentario d ela orden
       nuTipoCome             OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE; --Ticket 200-1132 LJLB-- se almacena el tipo de comentario

       onuErrorCode        number; --Ticket 200-1132 LJLB-- se almacena el codigo de error
       osbErrorMessage     varchar2(2000); --Ticket 200-1132 LJLB-- se almacena el mensaje de error

       nuItemId            ge_items.items_id%type; --Ticket 200-1132 LJLB-- se almacena actividad de novedad
       nuPersonId          ge_person.person_id%type; --Ticket 200-1132 LJLB-- se almacena el codigo de la persona que esta ejecutando el proceso

	   --Ticket 200-1132 LJLB-- se consultas ordenes a generar las multas
       CURSOR cuMultaGenerar IS
       SELECT ORMGOORI orden,
              ORMGUNID unidad,
              ORMGVAMU valor,
              ORMGAPRO aprobado
       FROM LDC_ORMUGENE O
       WHERE o.ORMGOORI = TO_NUMBER(sborden);
       --Ticket 200-1132 LJLB-- se consultas orden de novedad generada
       CURSOR cuOrdeGene IS
       SELECT ORDER_ID
       FROM or_order
       WHERE task_type_id = DALD_parameter.fnuGetNumeric_Value('LDC_TITRMUCTT')
          AND CREATED_DATE BETWEEN SYSDATE- 2/(24*60) AND SYSDATE;

      nuOrden    OR_ORDER.ORDER_ID%TYPE; --Ticket 200-1132 LJLB-- se almacena codigo de la orden generada


    BEGIN

       sbTipoComentario  := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_COMMENT', 'COMMENT_TYPE_ID'); --Ticket 200-1132 LJLB-- se obtiene valor del tipo de comentario
       sbComentario      := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_COMMENT', 'ORDER_COMMENT'); --Ticket 200-1132 LJLB-- se obtiene comentario ingresado

       nuTipoCome := TO_NUMBER(sbTipoComentario);

        nuItemId := DALD_parameter.fnuGetNumeric_Value('LDC_ACTIMUCTT'); --Ticket 200-1132 LJLB-- se obtiene actividad a generar
        --Ticket 200-1132 LJLB-- se Obteniene  persona a cargo
        nuPersonId := ge_bopersonal.fnugetpersonid;
        --Ticket 200-1132 LJLB-- se consultas registro de ordenes seleccionadas
        FOR reg IN cuMultaGenerar LOOP
          --Ticket 200-1132 LJLB-- se valida si la orden fue aprobada o no
          IF reg.aprobado = 'S' THEN
              --Ticket 200-1132 LJLB-- se crea novedad de multa al contratista
			  LDC_OS_REGISTERNEWCHARGE(reg.unidad, nuItemId, null, null, reg.valor, null, nuTipoCome, sbComentario, onuErrorCode, osbErrorMessage);

              IF (onuErrorCode <> 0) THEN
                 rollback;
                  UPDATE LDC_ORMUGENE
                        SET ORMGOBSE = 'Error generando Novedad: ' || osbErrorMessage
                 WHERE ORMGOORI = reg.orden;
              ELSE
                 OPEN cuOrdeGene;
                 FETCH cuOrdeGene INTO nuOrden;
                 IF cuOrdeGene%NOTFOUND THEN
                   nuOrden := -1;
                 END IF;
                 CLOSE cuOrdeGene;

                 UPDATE LDC_ORMUGENE
                        SET ORMGOBSE = 'Multa Generada Exitosamente',
                            ORMGFEPR = SYSDATE,
                            ORMGPROC = 'S',
                            ORMGORGE = nuOrden
                 WHERE ORMGOORI = reg.orden;
              END IF;

          ELSE
             UPDATE LDC_ORMUGENE
                        SET ORMGOBSE = 'Multa Anulado por Usuario',
                            ORMGFEPR = SYSDATE,
                            ORMGPROC = 'S'
                 WHERE ORMGOORI = reg.orden;
          END IF;
          COMMIT;

        END LOOP;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROPROCESSOMCTT;

    PROCEDURE PROPROCCESAPORMULT (   sborden   IN VARCHAR2,
                                      nuCurrent   IN NUMBER,
                                      nuTotal     IN NUMBER,
                                      nuCodError OUT GE_ERROR_LOG.MESSAGE_ID%TYPE,
                                      sbMensaje OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso para aprobacion de las ordenes seleccionadas en el PB [LDCAMAM]


      Parametros Entrada
      sbOrden     Codigo de la orden
      nuCurrent   Current
      nuTotal     Total

      Valor de salida
       nuCodError Codigo de error
       sbMensaje mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
       sbAccion      GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-1132 LJLB -- se almacena el tipo de comentario
       sbValor       GE_BOUTILITIES.STYSTATEMENTATTRIBUTE; --Ticket 200-1132 LJLB -- se almacena el tipo de comentario
       nuValor       LDC_ORMUGENE.ORMGVAMU%TYPE; --Ticket 200-1132 LJLB -- se almacena el tipo de comentario
       nuAccion      NUMBER;
       sbEstado      LDC_ORMUGENE.ORMGAPRO%TYPE;
    BEGIN
     sbAccion := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('LDC_ORMUGENE', 'ORMGTITR'); --Ticket 200-1132 LJLB -- accion a  ejecutar
     sbValor  := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('LDC_ORMUGENE', 'ORMGVAMU'); --Ticket 200-1132 LJLB -- valor de multa

     nuAccion := TO_NUMBER(sbAccion);
     --Ticket 200-1132 LJLB -- se valida si el valor es diferente a nulo
     IF sbValor IS NOT NULL THEN
         nuValor := TO_NUMBER(sbValor);
     END IF;
     --Ticket 200-1132 LJLB -- si accion es 1 aprobar
     IF nuAccion = 1 THEN
         sbEstado := 'S';
     END IF;
     --Ticket 200-1132 LJLB -- sia ccion es 2 no aprobar
     IF nuAccion = 2 THEN
        sbEstado := 'N';
     END IF;

     UPDATE LDC_ORMUGENE
        SET ORMGAPRO = sbEstado,
            ORMGVAMU = DECODE(NVL(nuValor,0),0,ORMGVAMU,nuValor ),
            ORMGFEAP = SYSDATE
    WHERE  ORMGOORI  = TO_NUMBER(sborden);

     COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END PROPROCCESAPORMULT;

    FUNCTION FRFGETORDEMULT Return constants.tyrefcursor IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Funcion que se encarga de retornar las ordenes no procesadas y que no hayan sido
                    aprobadas o no aporobadas del PB [LDC_PROCMGCTT]


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     /* Cursor referenciado con datos de la consulta */
    rfresult constants.tyrefcursor;

    /* Formato con que el PB instancia la fecha */
    sbdateformat ge_boutilities.stystatementattribute;

    sbContratista    ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena contratista
    sbUnidad         ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena unidad operativa
    sbSolicitud      ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena solicitud
    sbFechaInicial   ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena fecha inicial
    sbFechaFinal     ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena fecha final


    nuContratista     ge_contratista.id_contratista%type; --Ticket 200-1132 LJLB -- se almacena contratista
    nuUnidad          or_operating_unit.OPERATING_UNIT_ID%type; --Ticket 200-1132 LJLB -- se almacena unidad operativa
    dtFechaInicial    DATE; --Ticket 200-1132 LJLB -- se almacena fecha inicial
    dtFechaFinal      DATE;--Ticket 200-1132 LJLB -- se almacena fecha final
    nuSolicitud       mo_packages.package_id%type; --Ticket 200-1132 LJLB -- se almacena solicitud

  BEGIN


        sbContratista     := ge_boinstancecontrol.fsbgetfieldvalue('GE_CONTRATISTA','ID_CONTRATISTA'); --Ticket 200-1132 LJLB -- se obtiene contratista
        sbUnidad          := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_UNIT','OPERATING_UNIT_ID'); --Ticket 200-1132 LJLB -- se obtiene unidad operativa
        sbFechaInicial    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXEC_INITIAL_DATE'); --Ticket 200-1132 LJLB -- se obtiene fecha inicial
        sbFechaFinal      := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXECUTION_FINAL_DATE'); --Ticket 200-1132 LJLB -- se obtiene fecha final
        sbSolicitud       := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY', 'PACKAGE_ID'); --Ticket 200-1132 LJLB -- se obtiene solicitud

       IF sbSolicitud IS NOT NULL THEN
         nuSolicitud := TO_NUMBER(sbSolicitud);
       END IF;

       IF sbContratista IS NOT NULL THEN
           nuContratista := TO_NUMBER(sbContratista);
       END IF;

       IF sbUnidad IS NOT NULL THEN
           nuUnidad := TO_NUMBER(sbUnidad);
       END IF;

       IF sbFechaInicial IS NOT NULL THEN
           dtFechaInicial := TO_DATE(TO_CHAR(TO_DATE(sbFechaInicial,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
       END IF;

       IF sbFechaFinal IS NOT NULL THEN
           dtFechaFinal := TO_DATE(TO_CHAR(TO_DATE(sbFechaFinal,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');
       END IF;

	   --Ticket 200-1132 LJLB -- se crea consulta
       OPEN rfresult FOR
       SELECT /*+ ORDERED INDEX(o IDX_ORMUGENE) */
             o.ORMGOORI "Orden Origen",
            o.ORMGSORI "Solicitud Origen",
            o.ORMGUNID||'-'||u.NAME "Unidad Operativa",
            o.ORMGTITR||'-'||t.DESCRIPTION "Tipo de Trabajo",
            o.ORMGCONT ||'-'|| c.nOMBRE_CONTRATISTA "Contratista Multado",
            o.ORMGCLMU ||'-'||cm.CLMUDESC "Clase de Multa",
            o.ORMGVAMU "Valor Multa",
            o.ORMGFEGE "Fecha de GeneraciÃ³n",
            o.ORMGFEAP "Fecha de AprobaciÃ³n",
            o.ormgobse Observacion,
            DECODE(o.ORMGPROC,'N','NO','S','SI','NO') Procesado,
            DECODE(o.ORMGAPRO,'N','NO','S','SI','') Aprobado
      FROM LDC_ORMUGENE o
          JOIN or_operating_unit u ON u.OPERATING_UNIT_ID = o.ORMGUNID
          JOIN or_task_type t ON  t.task_type_id = o.ORMGTITR
          JOIN ge_contratista c ON c.id_contratista = o.ORMGCONT
          JOIN LDC_CLMUCONT cm ON cm.CLMUID = o.ORMGCLMU
      WHERE  NVL(ORMGPROC,'N') = 'N'
        AND O.ORMGAPRO IS NOT NULL
        AND O.ORMGFEGE BETWEEN NVL(dtFechaInicial,O.ORMGFEGE ) AND NVL(dtFechaFinal,O.ORMGFEGE)
        AND o.ORMGUNID = NVL(nuUnidad,o.ORMGUNID )
        AND o.ORMGCONT = NVL(nuContratista,  o.ORMGCONT)
        AND o.ORMGSORI = NVL(nuSolicitud, o.ORMGSORI);

       RETURN rfresult;

      END FRFGETORDEMULT;


     FUNCTION FRFGETORAPMULT  Return constants.tyrefcursor IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Funcion que se encarga de retornar las ordenes no procesadas del PB [LDCAMAM]
                    y que esten aprobadas o no aprobadas.


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    /* Cursor referenciado con datos de la consulta */
    rfresult constants.tyrefcursor;

    /* Formato con que el PB instancia la fecha */
    sbdateformat ge_boutilities.stystatementattribute;

    sbContratista    ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena contratista
    sbUnidad         ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena unidad operativa
    sbSolicitud      ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena solicitud
    sbFechaInicial   ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena fecha inicial
    sbFechaFinal     ge_boinstancecontrol.stysbvalue; --Ticket 200-1132 LJLB -- se almacena fecha final


    nuContratista     ge_contratista.id_contratista%type; --Ticket 200-1132 LJLB -- se almacena contratista
    nuUnidad          or_operating_unit.OPERATING_UNIT_ID%type; --Ticket 200-1132 LJLB -- se almacena unidad operativa
    dtFechaInicial    DATE; --Ticket 200-1132 LJLB -- se almacena fecha inicial
    dtFechaFinal      DATE;--Ticket 200-1132 LJLB -- se almacena fecha final
    nuSolicitud       mo_packages.package_id%type; --Ticket 200-1132 LJLB -- se almacena solicitud


  BEGIN


        sbContratista     := ge_boinstancecontrol.fsbgetfieldvalue('GE_CONTRATISTA','ID_CONTRATISTA'); --Ticket 200-1132 LJLB -- se obtiene contratista
        sbUnidad          := ge_boinstancecontrol.fsbgetfieldvalue('OR_OPERATING_UNIT','OPERATING_UNIT_ID'); --Ticket 200-1132 LJLB -- se obtiene unidad operativa
        sbFechaInicial    := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXEC_INITIAL_DATE'); --Ticket 200-1132 LJLB -- se obtiene fecha inicial
        sbFechaFinal      := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER', 'EXECUTION_FINAL_DATE'); --Ticket 200-1132 LJLB -- se obtiene fecha final
        sbSolicitud       := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER_ACTIVITY', 'PACKAGE_ID'); --Ticket 200-1132 LJLB -- se obtiene solicitud

       IF sbSolicitud IS NOT NULL THEN
         nuSolicitud := TO_NUMBER(sbSolicitud);
       END IF;

       IF sbContratista IS NOT NULL THEN
           nuContratista := TO_NUMBER(sbContratista);
       END IF;

       IF sbUnidad IS NOT NULL THEN
           nuUnidad := TO_NUMBER(sbUnidad);
       END IF;


       IF sbFechaInicial IS NOT NULL THEN
           dtFechaInicial := TO_DATE(TO_CHAR(TO_DATE(sbFechaInicial,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
       END IF;

       IF sbFechaFinal IS NOT NULL THEN
           dtFechaFinal := TO_DATE(TO_CHAR(TO_DATE(sbFechaFinal,'DD/MM/YYYY HH24:MI:SS'),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');
       END IF;

	   --Ticket 200-1132 LJLB -- se crea consulta
       OPEN rfresult FOR
       SELECT /*+ ORDERED INDEX(o IDX_ORMUGENE) */
            o.ORMGOORI "Orden Origen",
            o.ORMGSORI "Solicitud Origen",
            o.ORMGUNID||'-'||u.NAME "Unidad Operativa",
            o.ORMGTITR||'-'||t.DESCRIPTION "Tipo de Trabajo",
            o.ORMGCONT ||'-'|| c.nOMBRE_CONTRATISTA "Contratista Multado",
            o.ORMGCLMU ||'-'||cm.CLMUDESC "Clase de Multa",
            o.ORMGVAMU "Valor Multa",
            o.ORMGFEGE "Fecha de GeneraciÃ³n",
            o.ORMGFEAP "Fecha de AprobaciÃ³n",
            o.ormgobse Observacion,
            DECODE(o.ORMGPROC,'N','NO','S','SI','NO') Procesado,
            DECODE(o.ORMGAPRO,'N','NO','S','SI','') Aprobado
      FROM LDC_ORMUGENE o
          JOIN or_operating_unit u ON u.OPERATING_UNIT_ID = o.ORMGUNID
          JOIN or_task_type t ON  t.task_type_id = o.ORMGTITR
          JOIN ge_contratista c ON c.id_contratista = o.ORMGCONT
          JOIN LDC_CLMUCONT cm ON cm.CLMUID = o.ORMGCLMU
      WHERE  NVL(ORMGPROC,'N') = 'N'
        AND O.ORMGAPRO IS NULL
        AND O.ORMGFEGE BETWEEN NVL(dtFechaInicial,O.ORMGFEGE ) AND NVL(dtFechaFinal,O.ORMGFEGE)
        AND o.ORMGUNID = NVL(nuUnidad,o.ORMGUNID )
        AND o.ORMGCONT = NVL(nuContratista,  o.ORMGCONT)
        AND o.ORMGSORI = NVL(nuSolicitud, o.ORMGSORI);

       RETURN rfresult;
    END FRFGETORAPMULT;

    PROCEDURE PROGENMULTCVTT IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-28
      Ticket      : 200-1132
      Descripcion : Proceso que se encargara de generar las multas a contratista de ventas

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
      nuCateCodi          categori.CATECODI%type;
      nuOrderId           or_order.order_id%type;
      nuCausalId          ge_causal.causal_id%type;
      nuValue             LDC_TMLOCALTTRA.valor%type := 0;
      sbObservation       varchar2(200);
      nuOperatingUnit     or_order.operating_unit_id%type;
      onuErrorCode        number;
      osbErrorMessage     varchar2(2000);

      dtRegisterDate               mo_packages.REQUEST_DATE%type;
      sbAditionalAttribute         or_temp_data_values.data_value%type;
      nuPackageId                  mo_packages.package_id%type;
      nuSalesmanId                 ge_person.person_id%type;
      nuTotalValue                 number := 0;
      nuTaskTypeId                 or_task_type.task_type_id%type;
      inuPackageID                 mo_packages.package_id%type;
      nuAdressId                   pr_product.address_id%type;
      nuGeograpLoca                ab_address.geograp_location_id%type;
      nuGeograpDepto               ab_address.geograp_location_id%type;
      nuMotiveId                   mo_motive.motive_id%type;
      nuContractorId               ge_contratista.id_contratista%type;

      RgCommission                RgCommissionRegister;
      nuOk  NUMBER;
      sbError VARCHAR2(4000);
      nuValor                       NUMBER;

     --Ticket 200-1132 LJLB -- se consulta de ordenes con causal de incumplimiento
     CURSOR cuOrdeCausal IS
     SELECT /*+ ORDERED INDEX(d IDX_CMTTACCA) */D.CMTTTITR,
          D.CMTTACTI,
          o.order_id orden,
          o.causal_id causal,
          o.operating_unit_id unidad_operativa,
          a.PACKAGE_ID solicitud,
          a.motive_id motivo,
          s.ADDRESS_ID direccion,
          a.SUBSCRIPTION_ID contrato,
          a.PRODUCT_ID producto,
          s.request_date fecha_atencion,
          s.POS_OPER_UNIT_ID unidad_solicitud,
          u.CONTRACTOR_ID contratista,
          D.CMTTMULT multi
    FROM LDC_COMCTT d, or_order o, or_order_activity a, mo_packages s, or_operating_unit u
    WHERE D.CMTTTITR = o.task_type_id
        AND d.CMTTACTI = a.activity_id
        AND d.CMTTCAIN = o.causal_id
        AND a.order_id = o.order_id
        AND s.package_id = a.package_id
        AND u.OPERATING_UNIT_ID = s.POS_OPER_UNIT_ID
        AND o.order_status_id = 8
        AND u.ES_EXTERNA = 'Y'
        AND instr(','||DALD_PARAMETER.fsbGetValue_Chain('ID_SOLIC_VENTA_GAS_CONST', NULL)||',', ','||S.PACKAGE_TYPE_ID||',') > 0
        AND NOT EXISTS (SELECT 1 FROM LDC_ORMUGENE WHERE ORMGSORI = s.package_id AND ORMGOORI = o.order_id);

	   --Ticket 200-1132 LJLB -- se consulta de ordenes que pasan el tiempo estipulado
      CURSOR cuOrdeTiempo IS
      SELECT /*+ INDEX(d IDX_CMTTACTI2) */  D.CMTTTITR,
                D.CMTTACTI,
                o.order_id orden,
                o.causal_id causal,
                o.operating_unit_id unidad_operativa,
                a.PACKAGE_ID solicitud,
                a.motive_id motivo,
                s.ADDRESS_ID direccion,
                a.SUBSCRIPTION_ID contrato,
                a.PRODUCT_ID producto,
                s.request_date fecha_atencion,
                u.CONTRACTOR_ID contratista,
                u.OPER_UNIT_CLASSIF_ID clasificacion,
                DECODE(D.CMTTMULT,0,D.CMTTVAFI, D.CMTTMULT * D.CMTTVAFI)  valor
          FROM LDC_COMCTT d, or_order o, or_order_activity a, mo_packages s, or_operating_unit u
          WHERE D.CMTTTITR = o.task_type_id
            AND d.CMTTACTI = a.activity_id
            AND o.LEGALIZATION_DATE >= TO_DATE(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FECHA_INI_EXECUTE_JOB')||' 00:00:00','DD/MM/YYYY HH24:MI:SS')
            AND ROUND((s.ATTENTION_DATE - o.ASSIGNED_DATE ),0) > d.CMTTTIED
            AND d.CMTTFLVV = 'S'
            AND a.order_id = o.order_id
            AND s.package_id = a.package_id
            AND u.OPERATING_UNIT_ID = o.operating_unit_id
            AND o.order_status_id = 8
            AND s.MOTIVE_STATUS_ID = 14
            AND u.ES_EXTERNA = 'Y'
            AND NOT EXISTS (SELECT 1 FROM LDC_ORMUGENE WHERE ORMGSORI = s.package_id AND ORMGOORI = o.order_id);

     --Ticket 200-1132 LJLB-- se consulta la unidad de clasificacion despachante 15 del contratista
     CURSOR cuBuscarUnidadVenta( nuContratista or_operating_unit.CONTRACTOR_ID%type) IS
     SELECT operating_unit_id
     FROM or_operating_unit u
     WHERE u.CONTRACTOR_ID = nuContratista
        AND U.OPER_UNIT_CLASSIF_ID = 15;

      nuConta NUMBER := 0;       --Ticket 200-1132 LJLB-- se almacena cantidad de registros procesados
      nusession NUMBER;         --Ticket 200-1132 LJLB-- se almacena la session conectada
      sbuser    VARCHAR2(4000); --Ticket 200-1132 LJLB-- se almacena el usuario conectado
      nuAno    NUMBER; --Ticket 200-1132 LJLB-- se almacena el año
      nuMes    NUMBER; --Ticket 200-1132 LJLB-- se almacena el mes

      nuUnidad_Operativa  or_operating_unit.operating_unit_id%type; --Ticket 200-1132 LJLB-- se almacena unidad operativa

    BEGIN

      pkerrors.Push('PROGENMULTCVTT');

      nuAno := TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')); --Ticket 200-1132 LJLB-- se consulta el aÃ±o actual
      nuMes := TO_NUMBER(TO_CHAR(SYSDATE,'MM'));   --Ticket 200-1132 LJLB-- se consulta el mes actual

      --Ticket 200-1132 LJLB -- se consulta session y usuario conectado
      SELECT USERENV('SESSIONID'),
        USER
      INTO nusession,
        sbuser
      FROM dual;

      ldc_proinsertaestaprog(nuAno,nuMes,'PROGENMULTCVTT','En ejecucion..',nusession,sbuser);


      nuTaskTypeId := DALD_parameter.fnuGetNumeric_Value('LDC_TITRMUCTT');

      FOR reg IN   cuOrdeCausal LOOP
         --Ticket 200-1132 LJLB-- Obtener la localidad
        nuGeograpLoca := daab_address.fnugetgeograp_location_id(reg.direccion, null);
         --Ticket 200-1132 LJLB--Obtener el Depto
        nuGeograpDepto := dage_geogra_location.fnugetgeo_loca_father_id(nuGeograpLoca, null);
         --Ticket 200-1132 LJLB--Obtener la categoria del motivo
        nuCateCodi := damo_motive.fnugetcategory_id(reg.motivo);

        nuContractorId := reg.contratista;

        IF nuContractorId is null or nuContractorId = -1 THEN

          ldc_prolenalogerror(reg.solicitud,1,'Error : La unidad operativa ' || reg.unidad_solicitud ||' No esta asociado a un Contratista', 'PROGENMULTCVTT');

        ELSE
           --Ticket 200-1132 LJLB-- obtener el valor de la multa de acuerdo a la configuraciÃ³n realizada
          RgCommission := FnuGetCommissionValue( reg.solicitud,
                                                  reg.direccion,
                                                  reg.producto,
                                                  reg.unidad_solicitud,
                                                  reg.fecha_atencion,
                                                  nuGeograpLoca,
                                                  nuCateCodi,
                                                  nuContractorId,
                                                  nuOk,
                                                  sbError
                                                  );


          IF nuOk = 0 THEN

            IF reg.multi  > 0 THEN
              nuValor := RgCommission.onuCommissionValue * reg.multi;
            ELSE
              nuValor := RgCommission.onuCommissionValue;
            END IF;

          if nuValor > 0 then

              INSERT INTO LDC_ORMUGENE
                                      ( ORMGOORI,
                                        ORMGSORI,
                                        ORMGUNID,
                                        ORMGTITR,
                                        ORMGCLMU,
                                        ORMGFEGE,
                                        ORMGCONT,
                                        ORMGVAMU,
                                        ORMGOBSE,
                                        ORMGPROC
                                      )
                      VALUES
                            ( reg.orden,
                              reg.solicitud,
                              reg.unidad_solicitud,
                               nuTaskTypeId,
                              2,
                              SYSDATE,
                              nuContractorId,
                              nuValor,
                              'GENERADO AUTOMATICAMENTE POR JOB',
                              'N'
                            );
                nuConta := nuConta + 1;

          end if;

          IF nuConta = 1000 THEN
             COMMIT;
             nuConta := 0;
          END IF;

        ELSE
           ldc_prolenalogerror(reg.solicitud,1,'Error : '||sbError, 'PROGENMULTCVTT');

        END IF;
      END IF;

      END LOOP;
      COMMIT;

      nuConta := 0;
      FOR reg IN   cuOrdeTiempo LOOP

        --Ticket 200-1132 LJLB-- se valida si la unidad es diferente a despachante 15
        IF REG.clasificacion <> 15 THEN
          OPEN cuBuscarUnidadVenta(reg.contratista);
          FETCH cuBuscarUnidadVenta INTO nuUnidad_Operativa;
          IF cuBuscarUnidadVenta%NOTFOUND THEN
             nuUnidad_Operativa := -1;
          END IF;
          CLOSE cuBuscarUnidadVenta;
        ELSE
           nuUnidad_Operativa := reg.unidad_operativa;
        END IF;
        nuContractorId := reg.contratista;

        IF nuContractorId is null or nuContractorId = -1 OR NVL(nuUnidad_Operativa,-1) = -1 THEN
          ldc_prolenalogerror(reg.solicitud,1,'Error : La unidad operativa ' || nuUnidad_Operativa ||' No esta asociado a un Contratista', 'PROGENMULTCVTT');
        ELSE
          IF reg.valor > 0 then

              INSERT INTO LDC_ORMUGENE
                                      ( ORMGOORI,
                                        ORMGSORI,
                                        ORMGUNID,
                                        ORMGTITR,
                                        ORMGCLMU,
                                        ORMGFEGE,
                                        ORMGCONT,
                                        ORMGVAMU,
                                        ORMGOBSE,
                                        ORMGPROC
                                      )
                      VALUES
                            ( reg.orden,
                              reg.solicitud,
                              nuUnidad_Operativa,
                              nuTaskTypeId,
                              1,
                              SYSDATE,
                              nuContractorId,
                              reg.valor,
                              'GENERADO AUTOMATICAMENTE POR JOB',
                              'N'
                            );
                nuConta := nuConta + 1;

          END IF;

          IF nuConta = 1000 THEN
             COMMIT;
             nuConta := 0;
          END IF;
       END IF;

     END LOOP;
     COMMIT;

      ldc_proactualizaestaprog(nusession,'ok','PROGENMULTCVTT',osbErrorMessage);
      pkErrors.Pop;
  EXCEPTION
     WHEN ex.CONTROLLED_ERROR THEN
        rollback;
        osbErrorMessage := Sqlerrm;
         ldc_proactualizaestaprog(nusession,'Error '||osbErrorMessage, 'PROGENMULTCVTT','Error');
        raise;
      WHEN others then
         rollback;
        raise ex.CONTROLLED_ERROR;

    END PROGENMULTCVTT;
END LDC_PKGPROCMUCTT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGPROCMUCTT
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGPROCMUCTT', 'ADM_PERSON'); 
END;
/ 

