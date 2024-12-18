CREATE OR REPLACE PACKAGE adm_person.LDC_MatBloqAnillo
IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : LDC_MatBloqAnillo
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    12/07/2024              PAcosta         OSF-2850: Cambio de esquema ADM_PERSON     
                                            Retiro llamado al esquema open (.open)
    ****************************************************************/  

   /*****************************************************************
    PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

       UNIDAD : procesaLDCMBA
       DESCRIPCION    : Contiene la logica para el procesamiento de la forma LDCMBA
       AUTOR          : Cesar Figueroa
       FECHA          : 16/02/2017
     ******************************************************************/
  PROCEDURE procesaLDCMBA(inuOrder_id  IN  or_order.order_id%type,
                          inuRegistro   IN  number,
                          inuTotal      IN  number,
                          onuErrorCode  OUT number,
                          osbErrorMess  OUT varchar2);


  /*****************************************************************
    PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

       UNIDAD : consultaLDCMBA
       DESCRIPCION    : Consulta las ordenes a desplegar en la forma LDCMBA
       AUTOR          : Cesar Figueroa
       FECHA          : 16/02/2017
  ******************************************************************/
  FUNCTION consultaLDCMBA RETURN constants.tyRefCursor;

  FUNCTION consultaotanillo RETURN constants.tyRefCursor;

  PROCEDURE procesaLDCASOOTVECR (inuOrder_id  IN  or_order.order_id%type,
                             inuRegistro   IN  number,
                             inuTotal      IN  number,
                             onuErrorCode  OUT number,
                             osbErrorMess  OUT varchar2);


END LDC_MatBloqAnillo;
/
CREATE OR REPLACE PACKAGE body adm_person.LDC_MatBloqAnillo
IS



    /*****************************************************************
      PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

      UNIDAD : procesaLDCMBA
      DESCRIPCION    : Contiene la logica para el procesamiento de la forma LDCMBA
      AUTOR          : Cesar Figueroa
      FECHA          : 16/02/2017


      Modificacion

             Autor                          Fecha                      Caso
     John Jairo Jimenez Marimon           20/Nov/2019               40 200-2575
                                          25/Mar/2021               Cambio 644
    *************************************************************************************/

    PROCEDURE procesaLDCMBA (inuOrder_id  IN  or_order.order_id%type,
                             inuRegistro   IN  number,
                             inuTotal      IN  number,
                             onuErrorCode  OUT number,
                             osbErrorMess  OUT varchar2)
    IS

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBSERVATION ge_boInstanceControl.stysbValue;

    sbActivity varchar2(2000);
    nuAddress_id number;
    nuOrderId number;
    nuOrderActivityId number;
    nuOrdenParam NUMBER;
    nmcausalsa   ge_causal.causal_id%type;
    nmcontaRedes      NUMBER;
    nmcontaVentas     NUMBER;

    --<<variables cambio 644: para el control del mensaje>>
    blAplicaCoemntarioVenta boolean;
    blAplicaCoemntarioRedes boolean;
    sbComentario            varchar2(4000);


    BEGIN
        sbOBSERVATION := ge_boInstanceControl.fsbGetFieldValue ('MO_NOTIFY_LOG_PACK', 'OBSERVATION');

        sbActivity := DALD_PARAMETER.fsbgetvalue_chain('ACTIVITY_GENERA_LDCMBA');

        IF sbActivity IS NULL THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe el parametro ACTIVITY_GENERA_LDCMBA');
        END IF;

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        if (sbOBSERVATION is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'OBSERVACION');
            raise ex.CONTROLLED_ERROR;
        end if;

        ------------------------------------------------
        -- User code
        ------------------------------------------------



        IF inuRegistro = 1 THEN

            BEGIN

             select a.address_id,o.causal_id
             INTO nuAddress_id,nmcausalsa
             from or_order_activity a,or_order o
             where a.order_id = inuOrder_id
               and a.order_id = o.order_id
              and rownum = 1;

            EXCEPTION
             when others then
               ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No fue posible obetener direccion de la primera orden');
            END;

          -- Inicio 40 200-2575
            sbActivity := null;

          --<<cambio 664>>
          blAplicaCoemntarioVenta := false;
          blAplicaCoemntarioRedes := false;

           SELECT count(1) INTO nmcontaVentas
             FROM
                (
                 SELECT to_number(column_value) causal_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSAL_NO_HAY_ANILLO',NULL),','))
                )
           WHERE causal_var = nmcausalsa;

           IF nmcontaVentas >= 1 THEN
            sbActivity := dald_parameter.fsbGetValue_Chain('ACTIV_DISENO_REDES_POLI');
            --<<cambio 644>>
            blAplicaCoemntarioVenta := true;
           END IF;

           SELECT count(1) INTO nmcontaRedes
             FROM
                (
                 SELECT to_number(column_value) causal_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CAUSAL_REUBICAR_ANILLO',NULL),','))
                )
           WHERE causal_var = nmcausalsa;

           IF nmcontaRedes >= 1 THEN
            sbActivity := dald_parameter.fsbGetValue_Chain('ACTIV_CONSTRU_REDES_POLI');
            --<<cambio 644>>
            blAplicaCoemntarioRedes := true;
           END IF;

           --<<cambio 664>>
           IF (blAplicaCoemntarioVenta) THEN
             sbComentario := '] al área de Ventas';
           END IF;
           IF (blAplicaCoemntarioRedes) THEN
             sbComentario := '] al área de Redes';
           END IF;

           -- FIN 40 200-2575

            -- Crea orden a partir de la actividad
            Or_Boorderactivities.Createactivity(to_number(sbActivity), -- GE_ITEMS.ITEMS_ID
                                                Null,   -- MO_PACKAGES.PACKAGE_ID
                                                Null, -- MO_MOTIVE.MOTIVE_ID
                                                Null, -- MO_COMPONENT.COMPONENT_ID
                                                Null, -- WF_INSTANCE.INSTANCE_ID
                                                nuAddress_id, -- AB_ADDRESS.ADDRESS_ID
                                                Null,   -- IF_NODE.ID
                                                NULL,   -- GE_SUBSCRIBER.SUBSCRIBER_ID
                                                Null,   -- SUSCRIPC.SUSCCODI
                                                Null,   -- PR_PRODUCT.PRODUCT_ID
                                                Null,   -- OR_OPERATING_SECTOR.OPERATING_SECTOR_ID
                                                Null,   -- OR_OPERATING_UNIT.OPERATING_UNIT_ID
                                                Null,   -- OR_ORDER_ACTIVITY.EXEC_ESTIMATE_DATE
                                                Null,   -- GE_PROCESS.PROCESS_ID
                                                Null,   -- OR_ORDER_ACTIVITY.COMMENT_
                                                Null,   -- BOOLEAN
                                                Null,   -- GE_PRIORITY.PRIORITY_ID
                                                nuOrderId,    -- OR_ORDER.ORDER_ID
                                                nuOrderActivityId, -- OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
                                                Null, -- PM_ORDER_TEMPLATE.ORDER_TEMPLATE_ID
                                                Ge_Boconstants.Csbno -- VARCHAR2
                                                );

             INSERT INTO or_order_comment (order_comment_id,
                                      order_comment,
                                      order_id,
                                      comment_type_id,
                                      register_date,
                                      legalize_comment,
                                      person_id)
                       values (SEQ_OR_ORDER_COMMENT.NEXTVAL,
                               sbOBSERVATION,
                               nuOrderId,
                               3,
                               to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS'),
                               'N',
                               NULL);


             UPDATE ld_parameter
             SET ld_parameter.numeric_value = nuOrderId, ld_parameter.value_chain = sbComentario
             WHERE ld_parameter.parameter_id = 'ORDEN_TEMP_LDCMBA';

            --<<comentario 664
            BEGIN

             update or_order_activity a
                set a.comment_ =  a.comment_ || '. Se creó la orden ['||nuOrderId|| sbComentario
             where a.order_id = nuOrderId
              and rownum = 1;

            EXCEPTION
             when others then
               null;
            END;


            --COMMIT;
        END IF;


        nuOrdenParam := DALD_PARAMETER.fnuGetNumeric_Value('ORDEN_TEMP_LDCMBA');
        --<<cambio 644>>
        sbComentario := DALD_PARAMETER.fsbGetValue_Chain('ORDEN_TEMP_LDCMBA');

        IF nuOrdenParam IS NULL THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe el parametro ORDEN_TEMP_LDCMBA');
        END IF;

        -- Crea relacion entre ordenes
        INSERT INTO or_related_order (ORDER_ID,
                                      RELATED_ORDER_ID,
                                      RELA_ORDER_TYPE_ID)
                                VALUES (nuOrdenParam,
                                        inuOrder_id,
                                        13);

        INSERT INTO or_order_comment (order_comment_id,
                                      order_comment,
                                      order_id,
                                      comment_type_id,
                                      register_date,
                                      legalize_comment,
                                      person_id)
                       values (SEQ_OR_ORDER_COMMENT.NEXTVAL,
                               --'Se genero orden <'||nuOrdenParam||'> al area de ingenieria para gestion de alargue',
                               'Se creó la orden ['||nuOrdenParam|| sbComentario,
                               inuOrder_id,
                               3,
                               to_date(sysdate, 'DD/MM/YYYY HH24:MI:SS'),
                               'N',
                               NULL);

        --COMMIT;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END procesaLDCMBA;




    /*****************************************************************
    PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

       UNIDAD : consultaLDCMBA
       DESCRIPCION    : Consulta las ordenes a desplegar en la forma LDCMBA
       AUTOR          : Cesar Figueroa
       FECHA          : 16/02/2017

            Autor                          Fecha                      Caso
     John Jairo Jimenez Marimon           20/Nov/2019               40 200-2575
	 John Jairo Jimenez Marimon           16/Ene/2020               40 200-2575(CORRECION)
	                                                                Se agregan los estados 0,5,7,11
	 John Jairo Jimenez Marimon           02/Abr/2020               40 200-2575(CORRECION) OSS_HT_0000040_4
	                                                                Se modifica la consulta para colocar la
																	validacion de que el producto no tenga una
                                                                    orden con actividad 4000005,100005363)
                                                                    y estados order_status_id IN(0,5,6,7) a nivel
                                                                    de columna, esto devuelve un contador que se
                                                                    valida al final del query.
    *
    *************************************************************************************************/
    FUNCTION consultaLDCMBA
    RETURN constants.tyRefCursor
    IS

       sbQuery varchar2(4000);
       sbActividades varchar2(1000);
       sbCausal varchar2(100);
       ocuCursor constants.tyRefCursor;
       sbdepa  ge_boInstanceControl.stysbValue;
       sbloca  ge_boInstanceControl.stysbValue;
       sbcausa ge_boInstanceControl.stysbValue;
       sbacticon ge_boInstanceControl.stysbValue;
    BEGIN

     -- Inicio 40 200-2575
         sbdepa := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
         sbloca := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
         sbcausa := ge_boInstanceControl.fsbGetFieldValue ('GE_CAUSAL', 'CAUSAL_ID');
         sbacticon := ge_boInstanceControl.fsbGetFieldValue ('OR_TASK_TYPE', 'TASK_TYPE_ID');
      -- Fin 40 200-2575
        sbActividades := DALD_PARAMETER.fsbgetvalue_chain('ACTIVIDADES_CONSULTA_LDCMBA');
        sbCausal := DALD_PARAMETER.fsbgetvalue_chain('CAUSAL_CONSULTA_LDCMBA');

        IF sbActividades IS NULL THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe el parametro ACTIVIDADES_CONSULTA_LDCMBA');
        END IF;

        IF sbCausal IS NULL THEN
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe el parametro CAUSAL_CONSULTA_LDCMBA');
        END IF;

--  Inicio 40 200-2575 Se agregan los campos departamento y localidad en el where
----
        sbQuery := 'SELECT "Orden"
                    ,"Solicitud"
                    ,"Manzana catastral"
                    ,"Departamento"
                    ,"Localidad"
                    ,"Causal"
                    ,"Contrato"
                    ,"Producto"
                    ,"Direccion"
                    ,"Tipo de trabajo"
                    ,"Fecha creacion"
                    ,"Fecha legalizacion"
                    ,"Unidad operativa"
                FROM(
                     SELECT or_order.order_id "Orden",
                            or_order_activity.package_id "Solicitud",
                            (SELECT block_id FROM ab_premise s WHERE s.premise_id = ab_address.estate_number) "Manzana catastral",
                            dage_geogra_location.fsbgetdescription (dage_geogra_location.fnugetgeo_loca_father_id (daab_address.fnugetgeograp_location_id (or_order.external_address_id, NULL), NULL), NULL) "Departamento",
                            dage_geogra_location.fsbgetdescription (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null) "Localidad",
                            or_order.causal_id||'' - ''||dage_causal.fsbgetdescription(or_order.causal_id) "Causal",
                            pr_product.subscription_id "Contrato",
                            pr_product.product_id "Producto",
                            ab_address.address "Direccion",
                            or_order.task_type_id||'' - ''|| daor_task_type.fsbgetdescription(or_order.task_type_id) "Tipo de trabajo",
                            or_order.created_date "Fecha creacion",
                            or_order.legalization_date "Fecha legalizacion",
                            or_order.operating_unit_id||'' - ''|| daor_operating_unit.fsbgetname(or_order.operating_unit_id) "Unidad operativa",
/*Inicio OSS_HT_0000040_4*/ (SELECT COUNT(1)
                               FROM or_order_activity b,or_order e
                              WHERE b.activity_id IN(4000005,100005363)
                                AND e.order_status_id IN(0,5,6,7)
                                AND b.order_id = e.order_id
                                AND pr_product.product_id = b.product_id
/*Fin OSS_HT_0000040_4*/    ) salida
                       FROM or_order_activity,
                            or_order,
                            pr_product,
                            ab_address,
                            ge_geogra_location
                      WHERE or_order_activity.activity_id = '||to_number(sbacticon)||'
                        AND ge_geogra_location.geo_loca_father_id = '||to_number(sbdepa)||'
                        AND ge_geogra_location.geograp_location_id = '||to_number(sbloca)||'
                        AND or_order.causal_id = '||to_number(sbcausa)||'
                        AND or_order.order_status_id = 8
                        AND or_order.order_id = or_order_activity.order_id
                        AND ab_address.address_id = or_order.external_address_id
                        AND pr_product.product_id = or_order_activity.product_id
                        AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
/*OSS_HT_0000040_4*/    ) WHERE salida = 0';

        /*sbQuery := 'select or_order.order_id "Orden",
                    or_order_activity.package_id "Solicitud",
                    (SELECT block_id FROM ab_premise s WHERE s.premise_id = ab_address.estate_number) manzana_catastral,
                           dage_geogra_location.fsbgetdescription (dage_geogra_location.fnugetgeo_loca_father_id (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null), null) "Departamento",
                           dage_geogra_location.fsbgetdescription (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null) "Localidad",
                           or_order.causal_id||'' - ''||dage_causal.fsbgetdescription(or_order.causal_id) "Causal",
                           pr_product.subscription_id "Contrato",
                           pr_product.product_id "Producto",
                           ab_address.address "Direccion",
                           or_order.task_type_id||'' - ''|| daor_task_type.fsbgetdescription(or_order.task_type_id) "Tipo de trabajo",
                           or_order.created_date "Fecha creacion",
                           or_order.legalization_date "Fecha legalizacion",
                           or_order.operating_unit_id||'' - ''|| daor_operating_unit.fsbgetname(or_order.operating_unit_id) "Unidad operativa"
                    from or_order_activity,
                         or_order,
                         --or_related_order,
                         pr_product,
                         ab_address,
                         ge_geogra_location
                    where or_order_activity.activity_id = ('||to_number(sbacticon)||')
                      and ge_geogra_location.geo_loca_father_id = '||to_number(sbdepa)||'
                      and ge_geogra_location.geograp_location_id = '||to_number(sbloca)||'
                      and or_order.causal_id IN ('||to_number(sbcausa)||')
                      and daor_order.fnugetorder_status_id(or_related_order.related_order_id) in(0,5,7,11)
                      and or_order.order_status_id = 8
                      and or_order.order_id = or_order_activity.order_id
                      and or_related_order.order_id = or_order.order_id
                      and ab_address.address_id = or_order.external_address_id
                      and pr_product.product_id = or_order_activity.product_id
                      and ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
                      and NOT EXISTS (select 1
                                        from or_related_order
                                       where or_related_order.related_order_id = or_order.order_id
                                         and or_related_order.rela_order_type_id = 13)
                    order by
                    dage_geogra_location.fsbgetdescription (dage_geogra_location.fnugetgeo_loca_father_id (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null), null),
                    dage_geogra_location.fsbgetdescription (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null),
                    ab_address.address';*/


        open ocuCursor for sbQuery;

        RETURN ocuCursor;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END consultaLDCMBA;

FUNCTION consultaotanillo

 /*****************************************************************
    PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

       UNIDAD : consultaotanillo
       DESCRIPCION    : Consulta las ordenes a desplegar en la forma LDCASOOTVECR
       AUTOR          : John Jairo Jimenez Marimon
       FECHA          : 25/11/2017

    ******************************************************************/
    RETURN constants.tyRefCursor
    IS

       sbQuery varchar2(4000);
       sbActividades varchar2(1000);
       sbCausal varchar2(100);
       ocuCursor constants.tyRefCursor;
       sbdepa  ge_boInstanceControl.stysbValue;
       sbloca  ge_boInstanceControl.stysbValue;
       sbcausa ge_boInstanceControl.stysbValue;
       sbacticon ge_boInstanceControl.stysbValue;
       sbordenes ge_boInstanceControl.stysbValue;
       nmconta NUMBER;
       sbvalores VARCHAR2(1000);
       nmid_actividad or_order_activity.activity_id%type;
    BEGIN

         sbdepa := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEO_LOCA_FATHER_ID');
         sbloca := ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID');
         sbordenes := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');

         BEGIN
          SELECT activity_id INTO nmid_actividad
            FROM or_order_activity a
           WHERE a.order_id = to_number(sbordenes)
             AND ROWNUM = 1;
         EXCEPTION
          WHEN OTHERS THEN
           sbordenes := NULL;
         END;

         SELECT count(1) INTO nmconta
             FROM
                (
                 SELECT to_number(column_value) actividad_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('ACTIV_DISENO_REDES_POLI',NULL),','))
                )
           WHERE actividad_var = nmid_actividad;

           IF nmconta >= 1 THEN
            sbvalores := '(
                 SELECT to_number(column_value) causal_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(''CAUSAL_NO_HAY_ANILLO'',NULL),'',''))
                )';
           END IF;

           SELECT count(1) INTO nmconta
             FROM
                (
                 SELECT to_number(column_value) actividad_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('ACTIV_CONSTRU_REDES_POLI',NULL),','))
                )
           WHERE actividad_var = nmid_actividad;



           IF nmconta >= 1 THEN
             sbvalores := '(
                 SELECT to_number(column_value) causal_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(''CAUSAL_REUBICAR_ANILLO'',NULL),'',''))
                )';
           END IF;

           sbactividades := '(
                 SELECT to_number(column_value) causal_var
                   FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(''ACTIV_CONSULTA_DIS_REU_ANI'',NULL),'',''))
                )';

        sbQuery := 'select or_order.order_id "Orden",
                    or_order_activity.package_id "Solicitud",
                    (SELECT block_id FROM ab_premise s WHERE s.premise_id = ab_address.estate_number) manzana_catastral,
                           dage_geogra_location.fsbgetdescription (dage_geogra_location.fnugetgeo_loca_father_id (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null), null) "Departamento",
                           dage_geogra_location.fsbgetdescription (daab_address.fnugetgeograp_location_id (or_order.external_address_id, null), null) "Localidad",
                           or_order.causal_id||'' - ''||dage_causal.fsbgetdescription(or_order.causal_id) "Causal",
                           pr_product.subscription_id "Contrato",
                           pr_product.product_id "Producto",
                           ab_address.address "Direccion",
                           or_order.task_type_id||'' - ''|| daor_task_type.fsbgetdescription(or_order.task_type_id) "Tipo de trabajo",
                           or_order.created_date "Fecha creacion",
                           or_order.legalization_date "Fecha legalizacion",
                           or_order.operating_unit_id||'' - ''|| daor_operating_unit.fsbgetname(or_order.operating_unit_id) "Unidad operativa"
                    from or_order_activity,
                         or_order,
                         pr_product,
                         ab_address,
                         ge_geogra_location
                    where or_order_activity.activity_id IN ('||trim(sbactividades)||')
                      and ge_geogra_location.geograp_location_id = '||to_number(sbloca)||'
                      and or_order.causal_id IN ('||trim(sbvalores)||')
                      and or_order.order_status_id = 8
                      and or_order.order_id = or_order_activity.order_id
                      and ab_address.address_id = or_order.external_address_id
                      and pr_product.product_id = or_order_activity.product_id
                      and ab_address.geograp_location_id = ge_geogra_location.geograp_location_id
                      and NOT EXISTS (select 1
                                        from or_related_order
                                       where or_related_order.related_order_id = or_order.order_id
                                         and or_related_order.rela_order_type_id = 13)';

        open ocuCursor for sbQuery;

        RETURN ocuCursor;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END consultaotanillo;

PROCEDURE procesaLDCASOOTVECR (inuOrder_id  IN  or_order.order_id%type,
                             inuRegistro   IN  number,
                             inuTotal      IN  number,
                             onuErrorCode  OUT number,
                             osbErrorMess  OUT varchar2)
    IS
  /*****************************************************************
      PROPIEDAD INTELECTUAL DE EFIGAS/GDC (C).

      UNIDAD : procesaLDCASOOTVECR
      DESCRIPCION    : Contiene la logica para el procesamiento de la forma LDCASOOTVECR
      AUTOR          : John Jairo Jimenez Marimon
      FECHA          : 25/11/2019

    *************************************************************************************/

    cnuNULL_ATTRIBUTE constant number := 2126;

    sbOBSERVATION ge_boInstanceControl.stysbValue;

    sbActivity varchar2(2000);
    nuAddress_id number;
    nuOrderId number;
    nuOrderActivityId number;
    nuOrdenParam NUMBER;
    nmcausalsa   ge_causal.causal_id%type;
    nmconta      NUMBER;
    nmordenasocia or_order.order_id%type;

    BEGIN
        nmordenasocia := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');


        -- Crea relacion entre ordenes
        INSERT INTO or_related_order (ORDER_ID,
                                      RELATED_ORDER_ID,
                                      RELA_ORDER_TYPE_ID)
                                VALUES (nmordenasocia,
                                        inuOrder_id,
                                        13);


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END procesaLDCASOOTVECR;

END LDC_MatBloqAnillo;
/
PROMPT Otorgando permisos de ejecucion a LDC_MATBLOQANILLO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_MATBLOQANILLO', 'ADM_PERSON');
END;
/