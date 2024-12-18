CREATE OR REPLACE PACKAGE adm_person.ldc_eliminarexclusion as
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : ldc_eliminarexclusion
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    12/07/2024              PAcosta         OSF-2850: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    
        
    PROCEDURE process(inuOrderId     IN  or_order.order_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2);
    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  frfgetOrdenesExcluidas
    Descripcion :  Función que devuelve las órdenes excluidas de acuerdo a
                   los criterios ingresados en la forma ELEX
    Autor       : llozada
    Fecha       : 10-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-01-2014          llozada              Creación.
    **************************************************************************/
    FUNCTION frfgetOrdenesExcluidas
    RETURN constants.tyRefCursor;
END ldc_eliminarexclusion;
/
CREATE OR REPLACE PACKAGE body adm_person.ldc_eliminarexclusion AS

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  frfgetOrdenesExcluidas
    Descripcion :  Función que devuelve las órdenes excluidas de acuerdo a
                   los criterios ingresados en la forma ELEX
    Autor       : llozada
    Fecha       : 10-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-01-2014          llozada              Creación.
    **************************************************************************/
    FUNCTION frfgetOrdenesExcluidas
    RETURN constants.tyRefCursor IS

        ocuCursor               constants.tyRefCursor;
        sbSql                   varchar2(4000):= '  SELECT a.ORDER_id ORDEN,
                                                           c.subscription_id CONTRATO,
                                                           ldc_boutilities.fsbGetValorCampoTabla(''OR_ORDER_ACTIVITY'',''ORDER_ID'',''PACKAGE_ID'',a.order_id) Solicitud,
                                                           a.operating_unit_id||'' - ''||daor_operating_unit.fsbgetname(a.operating_unit_id) Unidad_Operativa,
                                                           daor_operating_unit.fnugetcontractor_id(a.operating_unit_id)||'' - ''||
                                                           dage_contratista.fsbgetdescripcion(daor_operating_unit.fnugetcontractor_id(a.operating_unit_id)) Contratista
                                                    FROM or_order_activity c, or_order a,ct_excluded_order b
                                                    WHERE ';
        nuContador              number := 0;

        sbContrato ge_boInstanceControl.stysbValue;
        sbSolicitud ge_boInstanceControl.stysbValue;
        sbTipoTrabajo ge_boInstanceControl.stysbValue;
        sbUnidadOperativa ge_boInstanceControl.stysbValue;
        sbContratista ge_boInstanceControl.stysbValue;
        sbOrden  ge_boInstanceControl.stysbValue;

BEGIN
        sbContrato := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'DEFINED_CONTRACT_ID');
        sbSolicitud := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'SUBSCRIBER_ID');
        sbTipoTrabajo := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'TASK_TYPE_ID');
        sbUnidadOperativa := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'OPERATING_UNIT_ID');
        sbContratista := ge_boInstanceControl.fsbGetFieldValue ('OR_OPERATING_UNIT', 'CONTRACTOR_ID');
        sbOrden := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');

        --ut_trace.trace('La fecha final es:['||to_date(sbCOFFEFI,'dd/mm/yyyy hh24:mi:ss')||']',2);

        if sbContrato IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND c.subscription_id = '||sbContrato;
             else
                sbSql := sbSql||' c.subscription_id = '||sbContrato;
             END if;
             nuContador := 1;
        END if;

        if sbSolicitud IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND c.package_id = '||sbSolicitud;
             else
                sbSql := sbSql||' c.package_id = '||sbSolicitud;
             END if;
             nuContador := 2;
        END if;

        if sbTipoTrabajo IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND a.task_type_id = '||sbTipoTrabajo;
             else
                sbSql := sbSql||' a.task_type_id = '||sbTipoTrabajo;
             END if;
             nuContador := 3;
        END if;

        if sbUnidadOperativa IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND a.operating_unit_id = '||sbUnidadOperativa;
             else
                sbSql := sbSql||' a.operating_unit_id = '||sbUnidadOperativa;
             END if;
             nuContador := 4;
        END if;

        if sbContratista IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND ldc_boutilities.fsbGetValorCampoTabla(''OR_OPERATING_UNIT'',
                            ''operating_unit_id'',''CONTRACTOR_ID'',a.operating_unit_id) = '||sbContratista;
             else
                sbSql := sbSql||'  ldc_boutilities.fsbGetValorCampoTabla(''OR_OPERATING_UNIT'',
                            ''operating_unit_id'',''CONTRACTOR_ID'',a.operating_unit_id) = '||sbContratista;
             END if;
             nuContador := 5;
        END if;

        if sbOrden IS not null then
             if nuContador <> 0 then
                sbSql := sbSql||' AND a.order_id = '||sbOrden;
             else
                sbSql := sbSql||' a.order_id = '||sbOrden;
             END if;
             nuContador := 5;
        END if;

        if nuContador <> 0 then
           sbSql := sbSql||' AND c.order_id = a.order_id AND a.order_id = b.order_id ';
        else
           sbSql := sbSql||' c.order_id = a.order_id AND a.order_id = b.order_id ';
        END if;

        ut_trace.trace(sbSql,2);

        open ocuCursor for sbSql;

        RETURN ocuCursor;

    EXCEPTION
         --   raise ex.CONTROLLED_ERROR;

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    end frfgetOrdenesExcluidas;

    /**************************************************************************
    Propiedad Intelectual de PETI
    Funcion     :  process
    Descripcion :  Proceso que ejecuta para cada Orden seleccionada en ELEX la
                   eliminación de la exclusión si esta se encuentra excluida.
    Autor       : llozada
    Fecha       : 10-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    10-01-2014          llozada              Creación.
    **************************************************************************/
    PROCEDURE process(inuOrderId     IN  or_order.order_id%type,
                              inuRegistro   IN  number,
                              inuTotal      IN  number,
                              onuErrorCode  OUT number,
                              osbErrorMess  OUT varchar2)
    AS
        nuClaseComentario   number := 3;
        nuOrderCommentId    Or_Order_Comment.order_comment_id%type;
        nuCodUsuario        ge_person.user_id%type;
        nuCodPersona        ge_person.person_id%type;
    BEGIN

        -- Se obtiene el usuario conectado
        nuCodUsuario := SA_BOUser.fnuGetUserId;
        ut_trace.trace('Politica LLOZADA nuCodUsuario:['||nuCodUsuario||']',2);

        -- Se obtiene la persona asociada al usuario conectado
        nuCodPersona := GE_BCPerson.fnuGetFirstPersonByUserId(nuCodUsuario);
        ut_trace.trace('Politica LLOZADA nuCodPersona:['||nuCodPersona||']',2);

        --Inserta  comentarios de la orden
        OR_BOOrderComment.AddComment
        (
             inuOrderId,
             nuClaseComentario,
             'Eliminación de la Exclusión de la Orden mediante el proceso ELEX -
                    Eliminar Exclusiones [Usuario que realizó la eliminación: '||
                    nuCodPersona||'-'||dage_person.fsbgetname_(nuCodPersona)||']',
             'N',
             nuOrderCommentId,
             sysdate
        );

        ut_trace.trace('[LLOZADA] Inserta Commentario OrderCommentId:['||nuOrderCommentId||']', 3);

        --elimina el registro asociado a inuOrderId
        dact_excluded_order.delRecord(inuOrderId);
    END process;

END ldc_eliminarexclusion;
/
PROMPT Otorgando permisos de ejecucion a LDC_ELIMINAREXCLUSION
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_ELIMINAREXCLUSION', 'ADM_PERSON');
END;
/