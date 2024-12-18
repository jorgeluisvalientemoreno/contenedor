CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOQUOTATRANSFER IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LD_BOQUOTATRANSFER
    Descripcion    :    Paquete que contiene la lógica de negocio del proceso
                        traslado de cupo.
    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/09/2013

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    --------        ----------          --------------
    31-07-2014      KCienfuegos.NC1016     Se modifica el método <<availableQuota>>
    02-07-2014      KCienfuegos.NC485      Se modifica el método <<validationsTrasferQuota>>
    06-12-2013      hjgomez.SAO226367      Se modifica <<validationsTrasferQuota>>
    02/10/2013      LDiuza.SAO218144       Se modifica el metodo <GetConsSalebyOrder>
    12/09/2013      mmeusburgger.SAO212252 Se agrega el metodo
                                            - <<GetConsSalebyOrder>>
    10/09/2013      JCarmona.SAO211751     Creación.
    ******************************************************************/

    --------------------------------------------
    -- Tipos y Estructuras de Datos
    --------------------------------------------
    subtype styIndex         IS VARCHAR2(50);

    /*****************************************************************
    Unidad   :      tyrcQuotaTransfer
    Descripcion	:   Información de Transferencia de Cupo.

    Historia de Modificaciones
    Fecha	    IDEntrega
    =========== ================================================================
    10-09-2010  JCarmona.SAO211751     Creación
    ******************************************************************/
    type tyrcQuotaTransfer is record
    (
        nuOrigSubcripId        suscripc.susccodi%type,         -- Contrato Origen
        nuDestSubscripId       suscripc.susccodi%type,         -- Contrato Destino
        dtTransferDate         date,                           -- Fecha de Traslado
        dtFinalDate            date,                           -- Final de Vigencia
        nuTrasnferValue        number,                         -- Valor Trasladado
        sbObservation          ld_quota_transfer.request_observation%type
    );

    type tytbQuotaTransfer is table of tyrcQuotaTransfer INDEX BY styIndex;

    TYPE tyrcSubcription IS RECORD(
    susccodi       suscripc.susccodi%type,
    SUSCCBANC      suscripc.SUSCBANC%type,
    SUSCCBANC_DESC varchar2(200),
    SUSCSUBA       suscripc.SUSCSUBA%type,
    SUSCTCBA       suscripc.SUSCTCBA%type,
    SUSCTCBA_DESC  varchar2(200),
    SUSCBAPA       suscripc.SUSCBAPA%type,
    SUSCBAPA_DESC  varchar2(200),
    SUSCSBBP       suscripc.SUSCSBBP%type,
    SUSCTCBP       suscripc.SUSCTCBP%type,
    SUSCTCBP_DESC  varchar2(200),
    SUSCCUBP       suscripc.SUSCCUBP%type,
    SUSCCUCO       suscripc.SUSCCUCO%type,
    SUSCCECO       suscripc.SUSCCECO%type,
    SUSCCEMD       suscripc.SUSCCEMD%type,
    SUSCCEMD_DESC  varchar2(200),
    SUSCCEMF       suscripc.SUSCCEMF%type,
    SUSCCEMF_DESC  varchar2(200),
    SUSCCICL       suscripc.SUSCCICL%type,
    SUSCCICL_DESC  varchar2(200),
    SUSCCLIE       suscripc.SUSCCLIE%type,
    SUSCCLIE_DESC  varchar2(200),
    SUSCDECO       suscripc.SUSCDECO%type,
    SUSCDETA       suscripc.SUSCDETA%type,
    SUSCEFCE       suscripc.SUSCEFCE%type,
    SUSCENCO       suscripc.SUSCENCO%type,
    SUSCENCO_DESC  varchar2(200),
    SUSCTDCO       suscripc.SUSCTDCO%type,
    SUSCTDCO_DESC  varchar2(200),
    SUSCIDDI       suscripc.SUSCIDDI%type,
    SUSCIDDI_DESC  varchar2(200),
    SUSCIDTT       suscripc.SUSCIDTT%type,
    SUSCMAIL       suscripc.SUSCMAIL%type,
    SUSCNUPR       suscripc.SUSCNUPR%type,
    SUSCPRCA       suscripc.SUSCPRCA%type,
    SUSCPRCA_DESC  varchar2(200),
    SUSCSAFA       suscripc.SUSCSAFA%type,
    SUSCSIST       suscripc.SUSCSIST%type,
    SUSCSIST_DESC  varchar2(200),
    SUSCTIMO       suscripc.SUSCTIMO%type,
    SUSCTIMO_DESC  varchar2(200),
    SUSCTISU       suscripc.SUSCTISU%type,
    SUSCTISU_DESC  varchar2(200),
    SUSCTTPA       suscripc.SUSCTTPA%type,
    SUSCTTPA_DESC  varchar2(200),
    SUSCVETC       suscripc.SUSCVETC%type);

    ----------------------------------------------------------------------------

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fsbVersion
    Descripcion :   Obtiene la versión del paquete.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   RegisterStatusChange
    Descripcion :   Procedimiento para el registro de las trasnferencias de cupo.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    inuOrder                    Identificador de la orden.
    inuStatus                   Estado de la orden 3 - Aprobado.
    isbRequestObservation       Observación de la Solicitud.
    isbReviewObservation        Observación de la Revisión.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    PROCEDURE RegisterStatusChange
    (
        inuPackageId            ld_quota_transfer.package_id%type,
        inuStatus             ld_quota_transfer.status%type,
        isbRequestObservation ld_quota_transfer.request_observation%type,
        isbReviewObservation  ld_quota_transfer.review_observation%type
    );

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : validationsTrasferQuota
    Descripción    : Validaciones al momento de realizar un traslado de cupo

    Autor          : emontenegro
    Fecha          : 26/08/2013

    Parámetros       Descripción
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificación
    =========        =========             ====================
    26/08/2013       emontenegro.SAO211738    Creación
    ******************************************************************/

    PROCEDURE validationsTrasferQuota(inuSuscripcAct   in suscripc.susccodi%type,
                                      inuQuotaTransfer in ld_quota_transfer.trasnfer_value%type,
                                      inuSuscripCode   in suscripc.susccodi%type,
                                      inuIdentType     in ge_subscriber.ident_type_id%type,
                                      isbIdentification  in ge_subscriber.identification%type,
                                      isbListSuscrip   in varchar2);

    PROCEDURE AttendApprovalTransferQuote(inuOrderId NUMBER,
                                        iblExito   BOOLEAN,
                                        osbFlag    out VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : RegisterTransferQuota
    Descripcion    : Procedimiento para el registro de las trasnferencias de cupo.

    Autor          : Evens Herard Gorut
    Fecha          : 17/10/2012

    Parametros              Descripcion
    ============         ===================
    inuDestinySubscripId:   Identificaci?n del contrato que recibir? el cupo.
    inuOriginSubcripId:     Identificaci?n del contrato de donde se tomara el cupo.
    idtTransferDate:        Fecha de traslado de cupo.
    inuTrasnferValue:       Valor transferido.
    idtFinalDate:           Fecha final de vigencia.
    inuPackegeId:           Paquete.

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE RegisterTransferQuota(inuPackTransId       mo_packages.package_id%type,
                                  inuDestinySubscripId NUMBER,
                                  inuOriginSubcripId   NUMBER,
                                  idtTransferDate      DATE,
                                  inuTrasnferValue     NUMBER,
                                  idtFinalDate         DATE,
                                  inuOrder             in out NUMBER,
                                  isbObservation       ld_quota_transfer.request_observation%type default null);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : getTransferData
    Descripción    : Obtiene los datos para realizar una transferencia de cupo.

    Autor          : Eduar Ramos Barragan
    Fecha          : 20/11/2012

    Parametros              Descripción
    ============         ===================


    Historia de Modificaciónes
    Fecha             Autor               Modificación
    =========       =========             ====================
    31/08/2013      JCarmona.SAO214298    Se modifica para que obtenga el cupo disponible
                                        dado el contrato y lo almacena en onuQuota.
    ******************************************************************/
    PROCEDURE getTransferData(inusubscription in suscripc.susccodi%type,
                            onuId           out number,
                            osbName         out varchar2,
                            onuQuota        out number);

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : availableQuota
    Descripción    : Obtiene el saldo disponible del cupo de un contrato

    Autor          : gavargas
    Fecha          : 16/08/2013

    Parámetros       Descripción
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                 Modificación
    =========        =========             ====================
    16/08/2013       gavargas.SAO211900    Creación
    ******************************************************************/

    FUNCTION availableQuota(inuSuscripc   in suscripc.susccodi%type)
    RETURN Number;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   registerQuotaTransfer
    Descripcion :   Procedimiento para el registro de las trasnferencias de cupo.
                    Crea una orden por cada contrato origen (que ceden cupo) y
                    realiza el registro en la entidad ld_quota_transfer.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    inuPackTransId                  Identificador de la solicitud de venta.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    PROCEDURE registerQuotaTransfer
    (
        inuPackTransId    in      mo_packages.package_id%type
    );

    /*****************************************************************
    Unidad   : ClearCache
    Descripcion	: Elimina el cache.

    Parámetros			Descripción
    ============  	    ===================

    Autor       :  Jorge Alejandro Carmona Duque    SAO211751
    Fecha       :  10-09-2013

    Historia de Modificaciones
    Fecha	    IDEntrega
    =========== ================================================================
    ******************************************************************/
    PROCEDURE ClearCache;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   addDataTransferQuota
    Descripcion :   Se llena la tabla con cada contrato que cede cupo.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    inuPackTransId                  Identificador de la solicitud de venta.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    PROCEDURE addDataTransferQuota
    (
        inuOrigSubcripId        suscripc.susccodi%type,         -- Contrato Origen
        inuDestSubscripId       suscripc.susccodi%type,         -- Contrato Destino
        idtTransferDate         date,                           -- Fecha de Traslado
        idtFinalDate            date,                           -- Final de Vigencia
        inuTrasnferValue        number,                         -- Valor Trasladado
        isbObservation          ld_quota_transfer.request_observation%type default null
    );

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   GetConsSalebyOrder
    Descripcion :   Retorna el Consecutivo de una venta
    Autor       :   Mahicol meusburgger
    Fecha       :   12-09-2013
    Parametros  :
        inuPackageId:    Identificador de financiacion no bancaria
        onuConsSale:     Consecutivo de la venta

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    12-09-2013  mmeusburgger.SAO212252     Creación.
    ***************************************************************************/
    PROCEDURE GetConsSalebyOrder
    (
        inuPackageId    in  mo_packages.package_id%type,
        osbConsSale     out ld_non_ba_fi_requ.digital_prom_note_cons%type
    );

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : fnuCountOrderTranfer
      Descripcion    : retorna la cantidad de ordenes generadas para aprovar traslado de cupo
      Autor          : hvera
      Fecha          : 13/09/2013

      Parametros              Descripcion
      ============         ===================
      inupackage           Código de la solicitud

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========       =========           ====================
    ******************************************************************/
    function fnuCountOrderTranfer(inupackage IN mo_packages.package_id%TYPE)
    return number;

END LD_BOQUOTATRANSFER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOQUOTATRANSFER IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LD_BOQUOTATRANSFER
    Descripcion    :    Paquete que contiene la lógica de negocio del proceso
                        traslado de cupo.
    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/09/2013

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    --------        ----------          --------------
    06-12-2013      hjgomez.SAO226367   Se modifica <<validationsTrasferQuota>>
    10/09/2013      JCarmona.SAO211751  Creación.
    ******************************************************************/

    -- Declaración de variables y tipos globales privados del paquete
    csbVERSION          constant varchar2(20) := 'SAO226367';

    tbQuotaTransfer     tytbQuotaTransfer;

    ----------------------------------------------------------------------------
	-- Definicion de metodos privados del paquete
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    ----------------------------------------------------------------------------
    PROCEDURE ClearCache
    IS
    BEGIN
        tbQuotaTransfer.delete;
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;



    PROCEDURE AllocateTotalQuota(InuSubscription SUSCRIPC.susccodi%TYPE,
                                onuAvailableQuota OUT NUMBER)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        ld_bononbankfinancing.AllocateTotalQuota(InuSubscription, OnuAvailableQuota);
        onuAvailableQuota := onuAvailableQuota - ld_bononbankfinancing.fnuGetUsedQuote(InuSubscription);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ROLLBACK;
            raise ex.CONTROLLED_ERROR;
        when others then
            ROLLBACK;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AllocateTotalQuota;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   RegisterStatusChange
    Descripcion :   Procedimiento para el registro de las trasnferencias de cupo.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    inuOrder                    Identificador de la orden.
    inuStatus                   Estado de la orden 3 - Aprobado.
    isbRequestObservation       Observación de la Solicitud.
    isbReviewObservation        Observación de la Revisión.

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO221355      Se modifica para que concatene las observaciones de
                                        Revisión, Aprobación y Rechazo al momento de hacer
                                        el registro.
    21-10-2013  AEcheverry              Se modifica par realizar El proceso por solicitud y no por orden
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    PROCEDURE RegisterStatusChange
    (
        inuPackageId            ld_quota_transfer.package_id%type,
        inuStatus             ld_quota_transfer.status%type,
        isbRequestObservation ld_quota_transfer.request_observation%type,
        isbReviewObservation  ld_quota_transfer.review_observation%type
    )
    IS

        tbOrder                     dald_quota_transfer.tytbLD_quota_transfer;
        styLdQuoHistori             Dald_Quota_Historic.styLD_quota_historic;
        nuIndex                     number;
        nuPerson                    ge_person.person_id%type;
        nuCausal                    ge_causal.causal_id%type;

        cnuFLOW_ACTION              constant number :=8181;
        nuErrorCode                 ge_error_log.error_log_id%type;
        sbErrorMessage              ge_error_log.description%type;
        nuCountOrderAct             number;
        nuTransfer_Quota_FNB_Type   or_order_activity.activity_id%type;

        nuAvailableQuota number;
        nuSubscription  suscripc.susccodi%type;
    BEGIN
        ut_trace.Trace('Inicio LD_BOQUOTATRANSFER.RegisterStatusChange['||inuPackageId||' - '||inuStatus||']',1);

        dald_quota_transfer.getRecords('ld_quota_transfer.package_id = ' ||
                                       inuPackageId,
                                       tbOrder);

        nuPerson := GE_BOPersonal.fnuGetPersonId;
        --Revisar
        If (inuStatus = 1) then

          nuIndex := tbOrder.first;

          while nuIndex is not null loop
            ut_trace.trace('Order Status : '||tbOrder(nuIndex).status,2);
            if (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'Esta orden ya fue aprobada o rechazada');

            elsif (tbOrder(nuIndex).status = 1) then
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'Esta orden ya fue revisada');
            else

              tbOrder(nuIndex).status := inuStatus;
              tbOrder(nuIndex).review_user := nuPerson;
              tbOrder(nuIndex).review_date := sysdate;
              tbOrder(nuIndex).request_observation := isbRequestObservation;
              tbOrder(nuIndex).review_observation := isbReviewObservation;
              dald_quota_transfer.updRecord(tbOrder(nuIndex));

            end if;

            nuIndex := tbOrder.next(nuIndex);
          end loop;
        --Rechazar
        elsif (inuStatus = 2) then

          nuCausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_FAIL_CAUSA');

          if nuCausal is not null then

            nuIndex := tbOrder.first;

            while nuIndex is not null loop
               ut_trace.trace('Order Status : '||tbOrder(nuIndex).status,2);
              if (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
                ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                 'Esta orden ya fue aprobada o rechazada');
              else

                tbOrder(nuIndex).status := inuStatus;
                tbOrder(nuIndex).reject_user := nuPerson;
                tbOrder(nuIndex).reject_date := sysdate;
                tbOrder(nuIndex).approved := 'N';
                tbOrder(nuIndex).request_observation := isbRequestObservation;
                tbOrder(nuIndex).review_observation := tbOrder(nuIndex).review_observation || ' - ' || isbReviewObservation;

                dald_quota_transfer.updRecord(tbOrder(nuIndex));
                ld_bopackagefnb.legalizeOrder(tbOrder(nuIndex).order_id, nuCausal);

                /* Se obtiene el valor de    parametro de tipo de actividad Transferencia de cupo FNB */
                nuTransfer_Quota_FNB_Type := DALD_PARAMETER.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE'); --4000825 en BB

              end if;

              nuIndex := tbOrder.next(nuIndex);
            end loop;

            if (inuPackageId IS not null) then
                Ld_BoflowFNBPack.procvalidateFlowmove( cnuFLOW_ACTION , inuPackageId, nuErrorCode, sbErrorMessage );

                if (nuErrorCode <> 0) then
                    ge_boerrors.seterrorcodeargument(nuErrorCode, sbErrorMessage);
                end if;
            END if;

          else

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Por favor configuere el parametro TRASNFER_FAIL_CAUSA');

          end if;
        --Aprobación
        elsif (inuStatus = 3) then

          nuCausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_SUCC_CAUSAL');

          if nuCausal is not null then

            nuIndex := tbOrder.first;

            while nuIndex is not null loop
              ut_trace.trace('Order Status : '||tbOrder(nuIndex).status,2);
              if(tbOrder(nuIndex).status = 0) then
                 ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                 'La orden no se ha revisado');
              elsif (tbOrder(nuIndex).status = 2 or tbOrder(nuIndex).status = 3) then
                ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                 'Esta orden ya fue aprobada o rechazada');
              else

                nuSubscription := tbOrder(nuIndex).DESTINY_SUBSCRIP_ID;

                -- calculo del cupo
                AllocateTotalQuota(nuSubscription,nuAvailableQuota);

				if nuAvailableQuota < tbOrder(nuIndex).TRASNFER_VALUE then
				    ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                                 'El cupo del contrato que cede es insuficiente');
				else

	                tbOrder(nuIndex).status := inuStatus;
	                tbOrder(nuIndex).approved_user := nuPerson;
	                tbOrder(nuIndex).approved_date := sysdate;
	                tbOrder(nuIndex).approved := 'Y';
	                tbOrder(nuIndex).request_observation := isbRequestObservation;
	                tbOrder(nuIndex).review_observation := tbOrder(nuIndex).review_observation|| ' - '||isbReviewObservation;

	                dald_quota_transfer.updRecord(tbOrder(nuIndex));
	                ld_bopackagefnb.legalizeOrder(tbOrder(nuIndex).order_id, nuCausal);
	                /**/
	                  --Si la trasferencia de cupo es aprobada, se registra en el historial de cupo
	                  --Se registra en el historico de la persona que cedió el cupo
	                  styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
	                                                                                           'SEQ_LD_QUOTA_HISTORIC');
	                  styLdQuoHistori.assigned_quote    := tbOrder(nuIndex).trasnfer_value;--  inuTrasnferValue;
	                  styLdQuoHistori.register_date     := SYSDATE;
	                  styLdQuoHistori.result            := 'Y';
	                  styLdQuoHistori.subscription_id   := tbOrder(nuIndex).destiny_subscrip_id; --inuOriginSubcripId;
	                  styLdQuoHistori.observation       :=
	                  'Se ha realizado una transferencia de cupo al contrato ['||tbOrder(nuIndex).origin_subscrip_id||'],
	                  por valor de : $'||tbOrder(nuIndex).trasnfer_value||', el dia '||trunc(sysdate);

	                  Dald_Quota_Historic.insRecord(styLdQuoHistori);
	                  --Se registra en el historico, la persona a la cual se le hizo el traslado de cupo
	                  styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
	                                                                                           'SEQ_LD_QUOTA_HISTORIC');
	                  styLdQuoHistori.assigned_quote    := tbOrder(nuIndex).trasnfer_value;
	                  styLdQuoHistori.register_date     := SYSDATE;
	                  styLdQuoHistori.result            := 'Y';
	                  styLdQuoHistori.subscription_id   := tbOrder(nuIndex).origin_subscrip_id;
	                  styLdQuoHistori.observation       :=
	                  'Se ha recibido una transferencia de cupo del contrato ['||tbOrder(nuIndex).destiny_subscrip_id||'],
	                  por valor de : $'||tbOrder(nuIndex).trasnfer_value||', el dia '||trunc(sysdate);

	                  Dald_Quota_Historic.insRecord(styLdQuoHistori);
	                  ------------------------------------------------------------------------


	                ut_trace.Trace('Identificador de la Solicitud: '||inuPackageId,1);

				END if;
              end if;
              nuIndex := tbOrder.next(nuIndex);
            end loop;

            if (inuPackageId IS not null) then
                /* Se obtiene el valor del parametro de tipo de actividad Transferencia de cupo FNB */
                nuTransfer_Quota_FNB_Type := DALD_PARAMETER.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE'); --4000825 en BB
                /* Se obtiene la cantidad de órdenes pendientes de aprobación */
                nuCountOrderAct := LD_BCQUOTATRANSFER.fnuCountOrderAct(inuPackageId, nuTransfer_Quota_FNB_Type);

                ut_trace.Trace('nuCountOrderAct: '||nuCountOrderAct,1);
                /* Valida si debe empujar el flujo o si hay mas ordenes por procesar*/
                if (nuCountOrderAct = 0) then
                    ut_trace.Trace('No existen órdenes pendientes por aprobar, se reenvía el flujo ',1);
                    Ld_BoflowFNBPack.procvalidateFlowmove( cnuFLOW_ACTION , inuPackageId, nuErrorCode, sbErrorMessage );

                    if (nuErrorCode <> 0) then
                        ge_boerrors.seterrorcodeargument(nuErrorCode, sbErrorMessage);
                    end if;
                END if;
            END if;

          else

            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Por favor configure el parámetro TRASNFER_FAIL_CAUSA');

          end if;

        end if;

        ut_trace.Trace('Fin LD_BOQUOTATRANSFER.RegisterStatusChange',1);
    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        rollback;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      rollback;
      RAISE ex.CONTROLLED_ERROR;
    END RegisterStatusChange;

    ----------------------------------------------------------------------------
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : validationsTrasferQuota
    Descripción    : Validaciones al momento de realizar un traslado de cupo

                    Se validara que el monto máximo trasladado no supere hasta N
                    (Parámetro definido en LD_PARAMETER)  veces del cupo aprobado
                    para el contrato sobre el cual se realiza la financiación.

                    Se validara que por lo menos uno de los clientes que cede
                    el cupo sea el codeudor

    Autor          : emontenegro
    Fecha          : 26/08/2013

    Parámetros       Descripción
    ============     ===================

    Historia de Modificaciones
    Fecha            Autor                      Modificación
    =========        =========                  ====================
    02-07-2014       KCienfuegos.NC485          Se agrega nvl a la variable nuOldQuota
    06-12-2013       hjgomez.SAO226367          Se obtiene el cupo trasladado previamente
    26/08/2013       emontenegro.SAO211738      Creación
    ******************************************************************/

    PROCEDURE validationsTrasferQuota(inuSuscripcAct   in suscripc.susccodi%type,
                                      inuQuotaTransfer in ld_quota_transfer.trasnfer_value%type,
                                      inuSuscripCode   in suscripc.susccodi%type,
                                      inuIdentType     in ge_subscriber.ident_type_id%type,
                                      isbIdentification  in ge_subscriber.identification%type,
                                      isbListSuscrip   in varchar2) IS


     nuParameter ld_parameter.numeric_value%type;
     nuQuota     ld_quota_by_subsc.quota_value%type;
     nuTotalTranfer ld_quota_transfer.trasnfer_value%type;
     nuValid    number;
     nuOldQuota number;

     rfCursor constants.tyrefcursor;
     type tytbSubscription is table of pktblsuscripc.tytbSuscripc;
     rcSubcription tyrcSubcription;

   BEGIN

   /*Obtiene parámetro para calcular el monto máximo de traslado*/
   nuParameter:= dald_parameter.fnuGetNumeric_Value('MAX_QUOTA_VALUE_TRANSF');

   /*obtiene el cupo asignado al suscriptor*/
   nuQuota:= ld_bcnonbankfinancing.FnuGetQuotaAssigned(inuSuscripcAct);

   /*Total de cupo aprovado previamente */
   nuOldQuota :=LD_BCQUOTATRANSFER.fnuTotalTransferedBySusc(inuSuscripcAct);

   /*Se calcula el monto máximo de traslado de acuerdo al parámetro*/
   nuTotalTranfer:= (nuQuota * nuParameter)-nvl(nuOldQuota,0);

   /*Se valida si el monto maximo de traslado es mayor al cupo aprobado*/
   if(inuQuotaTransfer > nuTotalTranfer) then

   ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El cupo a trasladar supera el monto máximo de traslado.');
   else

    if(inuSuscripCode IS not null)then

   /*Valida que el contrato del codeudor este dentro de la lista de contratos que ceden cupo*/
     SELECT regexp_instr(isbListSuscrip,'(^|,)'||to_char(inuSuscripCode)||'(,|$)') INTO nuValid  FROM dual;

     if(nuValid= 0) then
       ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Ninguno de los clientes que ceden cupo es el codeudor');
     END if;
    else

        /*Obtiene los contratos asociados al cliente*/
        cc_bosubscription.getsubscription(null,
                                      null,
                                      inuIdentType,
                                      isbIdentification,
                                      null,
                                      null,
                                      null,
                                      rfCursor);
        nuValid:=0;

      loop
      fetch rfCursor
        into rcSubcription;
      exit when(rfCursor%notFound);

         if(rcSubcription.susccodi=inuSuscripCode)then
           nuValid:=nuValid+1;
         END if;

      end loop;
      close rfCursor;

      if(nuValid=0)then
       ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'Ninguno de los clientes que ceden cupo es el codeudor');
      END if;

    END if;
   END if;



   EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
   END validationsTrasferQuota;

   -----------------------------------------------------------------------------

   /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : AttendApprovalTransferQuote
  Descripción    : Procedimiento para la aprovaci?n de las trasnferencias de cupo FNB.

  Autor          : Evens Herard Gorut
  Fecha          : 19/10/2012

  Parametros              Descripción
  ============         ===================
  inuOrderId           Identificaci?n de la orden.
  iblExito             Se?ala si se legaliza con fallo o con ?xito.

  Historia de Modificaciónes
  Fecha             Autor             Modificación
  =========       =========           ====================
  23-08-2013     emontenegro         Se modifica para que obtenga el person_id
                                     de la unidad operativa para la legalización
                                     de la orden.
  ******************************************************************/
  PROCEDURE AttendApprovalTransferQuote(inuOrderId NUMBER,
                                        iblExito   BOOLEAN,
                                        osbFlag    out VARCHAR2) is
    -- Local variables
    --sbCadena                   varchar2(400);
    nuQuota_Transfer_Id        Ld_Quota_Transfer.Quota_Transfer_Id%type;
    nuTransfer_Quota_Authoriza number;
    --Variables de salida
    nuErrorCode    ge_error_log.error_log_id%type;
    sbErrorMessage ge_error_log.description%type;
    ---Variable tipo registro
    styLdQuoTranfer DALD_quota_transfer.styLD_quota_transfer;
    --Variable que guarda la causal
    nuCausal ge_causal.causal_id%type;
    nuPersonId number;

  BEGIN

    ut_trace.trace('Inicio LD_BOQUOTATRANSFER.AttendApprovalTransferQuote',
                   10);

    /*Obtengo el transfer_id a partir de la Order_id, para poder actualizar el registro*/
    SELECT Quota_Transfer_Id
      into nuQuota_Transfer_Id
      FROM LD_Quota_Transfer
     WHERE order_id = inuOrderId;

    /*Obtiene el parametro de Unidad Operativa y asigno valores*/
    nuTransfer_Quota_Authoriza := DALD_PARAMETER.fsbGetValue_Chain('TRANSFER_QUOTA_AUTHORIZA');
    /*Obtiene el person_id de la unidad operativa*/
    nuPersonId:= LD_BOUtilFlow.fnuGetPersonToLegal(nuTransfer_Quota_Authoriza);

    if (iblExito) then
      nuCausal := or_boconstants.cnuSuccesCausal;
      osbFlag  := 'Orden legalizada exitosa';
    else
      nuCausal := or_boconstants.cnuFailCausal;
      osbFlag  := 'Orden Legalizada con fallo';
    end if;

    /*Legaliza la orden con fallo o ?xito*/
    os_legalizeorderallactivities(inuorderid        => inuOrderId,
                                  inucausalid       => nuCausal,
                                  inupersonid       => nuPersonId,
                                  idtexeinitialdate => sysdate,
                                  idtexefinaldate   => sysdate,
                                  isbcomment        => 'Orden legalizada para aprobación de transferiencia de cupo FNB',
                                  idtChangeDate     => null,
                                  onuerrorcode      => nuErrorCode,
                                  osberrormessage   => sbErrorMessage);

    /*Actualiza el registro de la tabla LD_quota_transfer y actualiza el estado del registro*/
    if (iblExito) then
      styLdQuoTranfer.approved := ld_boconstans.csbYesFlag;
      DALD_quota_transfer.updApproved(inuQuota_Transfer_Id => nuQuota_Transfer_Id,
                                      isbApproved$         => styLdQuoTranfer.approved);
    else
      styLdQuoTranfer.approved := ld_boconstans.csbNOFlag;
      DALD_quota_transfer.updApproved(inuQuota_Transfer_Id => nuQuota_Transfer_Id,
                                      isbApproved$         => styLdQuoTranfer.approved);
    end if;

    ut_trace.trace('Finaliza LD_BOQUOTATRANSFER.AttendApprovalTransferQuote',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END AttendApprovalTransferQuote;

    /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : RegisterTransferQuota
  Descripción    : Procedimiento para el registro de las trasnferencias de cupo.

  Autor          : Evens Herard Gorut
  Fecha          : 17/10/2012

  Parametros              Descripción
  ============         ===================
  inuDestinySubscripId:   Identificaci?n del contrato que recibir? el cupo.
  inuOriginSubcripId:     Identificaci?n del contrato de donde se tomara el cupo.
  idtTransferDate:        Fecha de traslado de cupo.
  inuTrasnferValue:       Valor transferido.
  idtFinalDate:           Fecha final de vigencia.
  inuPackegeId:           Paquete.

    Historia de Modificaciónes
    Fecha       Autor                   Modificación
    =========== ======================= ========================================================
    9-17-2013   lfernandez.SAO203070    Se le envía a RegisterTransferQuota la
                                        solicitud
    10/Jul/2013 Evelio Sanjuanelo       Se adiciona el parámetro del stado al momento de
                                        registrar una trasferencia de cupo, ya que este
                                        al momento de crear el registro se estaba guardando
                                        en nulo y no como registrada.
  ******************************************************************/
  PROCEDURE RegisterTransferQuota
  (
    inuPackTransId          in  mo_packages.package_id%type,
    inuDestinySubscripId    in  NUMBER,
    inuOriginSubcripId      in  NUMBER,
    idtTransferDate         in  DATE,
    inuTrasnferValue        in  NUMBER,
    idtFinalDate            in  DATE,
    inuOrder                in out NUMBER,
    isbObservation          in  ld_quota_transfer.request_observation%type default null
  )
  IS
    -- Declaración de variables Parametros
    sbTransfer_Quota_Auto      Varchar2(1);
    nuTransfer_Quota_FNB_Type  GE_Activity.Activity_Id%type;
    nuTransfer_Quota_Authoriza number;
    -- Local variables
    --sbCadena varchar2(3200);
    nuError number;
    sbError varchar2(2000);
    --
    --nuOperativeUnit number;
    ---Variables para obtener los valores de or_boorderactivities.createactivity
    nuorderactivityid OR_ORDER_ACTIVITY.ACTIVITY_ID%type;
    ---Variable tipo registro
    --styLdQuoTranfer DALD_quota_transfer.styLD_quota_transfer;
    rcOrder      daor_order.styor_order;
    styLdQuoHistori Dald_Quota_Historic.styLD_quota_historic;
  BEGIN
    ut_trace.trace('Inicio LD_BOQUOTATRANSFER.RegisterTransferQuota',
                   10);

    /*Obtiene el valor del par?metro que se?ala si es necesaria la aprobaci?n
    del traslado de cupo.*/
    sbTransfer_Quota_Auto := DALD_PARAMETER.fsbGetValue_Chain('TRANSFER_QUOTA_AUTO');

    /*En caso de no ser necesario atiende inmediatamente la solicitud.*/
    IF (sbTransfer_Quota_Auto = ld_boconstans.csbYesFlag) THEN
      /*Registro los detalles de la trasferencia en la entidad LD_quota_transfer
      con aprovación automatica*/
      LD_BCNONBANKFINANCING.RegisterTransferQuota( inuDestinySubscripId,
                                                   inuOriginSubcripId,
                                                   idtTransferDate,
                                                   inuTrasnferValue,
                                                   idtFinalDate,
                                                   sbTransfer_Quota_Auto,
                                                   null,
                                                   isbObservation,
                                                   3,
                                                   inuPackTransId );

              --Si la trasferencia de cupo es aprobada, se registra en el historial de cupo
              --Se registra en el historico de la persona que cedió el cupo
              styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                       'SEQ_LD_QUOTA_HISTORIC');
              styLdQuoHistori.assigned_quote    := inuTrasnferValue;--  inuTrasnferValue;
              styLdQuoHistori.register_date     := SYSDATE;
              styLdQuoHistori.result            := 'Y';
              styLdQuoHistori.subscription_id   := inuDestinySubscripId;
              styLdQuoHistori.observation       :=
              'Se ha realizado una transferencia de cupo al contrato ['||inuOriginSubcripId||'],
              por valor de : $'||inuTrasnferValue||', el dia '||trunc(sysdate);

              Dald_Quota_Historic.insRecord(styLdQuoHistori);
              --Se registra en el historico, la persona a la cual se le hizo el traslado de cupo
              styLdQuoHistori.quota_historic_id := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_HISTORIC',
                                                                                       'SEQ_LD_QUOTA_HISTORIC');
              styLdQuoHistori.assigned_quote    := inuTrasnferValue;
              styLdQuoHistori.register_date     := SYSDATE;
              styLdQuoHistori.result            := 'Y';
              styLdQuoHistori.subscription_id   := inuOriginSubcripId;
              styLdQuoHistori.observation       :=
              'Se ha recibido una transferencia de cupo del contrato ['||inuDestinySubscripId||'],
              por valor de : $'||inuTrasnferValue||', el dia '||trunc(sysdate);

              Dald_Quota_Historic.insRecord(styLdQuoHistori);
              ------------------------------------------------------------------------
            /**/
    --,0,''Registrada'',1,''Revisada'',2,''Rechazada'',3,''Aprobada'')';
    ELSE
      /*Obtengo el valor del parametro de tipo de actividad Transferencia de cupo FNB
      que ha sido creado en SmartFlex ORCOR*/
      nuTransfer_Quota_FNB_Type := DALD_PARAMETER.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE'); --4000825 en BB

        inuOrder := null;

      /*Genera una orden de traslado de cupo*/
      or_boorderactivities.createactivity(inuitemsid          => nuTransfer_Quota_FNB_Type,
                                          inupackageid        => inuPackTransId, --
                                          inumotiveid         => null, --
                                          inucomponentid      => null,
                                          inuinstanceid       => null,
                                          inuaddressid        => null, --
                                          inuelementid        => null,
                                          inusubscriberid     => null, --
                                          inusubscriptionid   => inuOriginSubcripId, --
                                          inuproductid        => null, --
                                          inuopersectorid     => null,
                                          inuoperunitid       => null,
                                          idtexecestimdate    => null,
                                          inuprocessid        => null,
                                          isbcomment          => null,
                                          iblprocessorder     => false,
                                          inupriorityid       => null,
                                          ionuorderid         => inuOrder,
                                          ionuorderactivityid => nuorderactivityid,
                                          inuordertemplateid  => null,
                                          isbcompensate       => null,
                                          inuconsecutive      => null,
                                          inurouteid          => null,
                                          inurouteconsecutive => null,
                                          inulegalizetrytimes => null,
                                          isbtagname          => null,
                                          iblisacttogroup     => false,
                                          inurefvalue         => null);

      /*Obtiene el usuario conectado*/
      /*Obtiene el contratista del usuario conectado*/

      /*Registro los detalles de la trasferencia en la entidad LD_quota_transfer
      sin aprovación*/
      LD_BCNONBANKFINANCING.RegisterTransferQuota( inuDestinySubscripId,
                                                   inuOriginSubcripId,
                                                   idtTransferDate,
                                                   inuTrasnferValue,
                                                   idtFinalDate,
                                                   ld_boconstans.csbNOFlag,
                                                   inuOrder,
                                                   isbObservation,
                                                   0,
                                                   inuPackTransId );

      /*Obtiene el parametro de Unidad Operativa*/
      nuTransfer_Quota_Authoriza := DALD_PARAMETER.fnuGetNumeric_Value('UNID_TRAB_FNB');


        /*Se asigna la orden a la unidad operativa asociada al tipo de poliza*/

            rcOrder := Daor_Order.Frcgetrecord(inuOrder);

            OR_boProcessOrder.updBasicData(rcOrder,
                                           rcOrder.operating_sector_id,
                                           null);
          IF nuTransfer_Quota_Authoriza IS NOT NULL AND rcOrder.order_status_id <> 5 THEN
            or_boprocessorder.assign(rcOrder,
                                     nuTransfer_Quota_Authoriza,
                                     sysdate, --dtArrangedHour,
                                     false, --true,
                                     TRUE);

            ELSE
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'NO ESTA CONFIGURADA LA UNIDAD OPERATIVA FNB (PARAMETRO: UNID_TRAB_FNB), VERIFIQUE');
         end if;

    END IF;

    ut_trace.trace('Finaliza LD_BOQUOTATRANSFER.RegisterTransferQuota',
                   10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END RegisterTransferQuota;

    ----------------------------------------------------------------------------
    FUNCTION availableQuota(inuSuscripc   in suscripc.susccodi%type)
    RETURN Number
    IS
        nuAssignedQuote number := 0;
        nuUsedQuote     number := 0;
        nuAvalibleQuote number := 0;
        nuTransfProcess number := 0;
    BEGIN
        ut_trace.trace('Inicio LD_BOQUOTATRANSFER.availableQuota '||inuSuscripc, 10);

        if pktblsuscripc.fblExist(inuSuscripc) THEN
          ld_bononbankfinancing.AllocateTotalQuota(inuSuscripc,
                                                   nuAssignedQuote);
          nuUsedQuote := ld_bononbankfinancing.fnuGetUsedQuote(inuSuscripc);

          /*Obtiene el valor de las transferencias de cupo que están en proceso*/
          nuTransfProcess := ld_bononbankfinancing.fnuGetTransfValueInProcess(inuSuscripc);
          IF (nuAssignedQuote >= nuUsedQuote) THEN
            nuAvalibleQuote := nuAssignedQuote - nuUsedQuote - nvl(nuTransfProcess,0);
          ELSE
            nuAvalibleQuote := 0;
          END IF;
        END IF;
        ut_trace.trace('Fin LD_BOQUOTATRANSFER.availableQuota', 10);
        RETURN nuAvalibleQuote;

    Exception
        when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;

    END availableQuota;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : getTransferData
  Descripción    : Obtiene los datos para realizar una transferencia de cupo.

  Autor          : Eduar Ramos Barragan
  Fecha          : 20/11/2012

  Parametros              Descripción
  ============         ===================


  Historia de Modificaciónes
  Fecha             Autor               Modificación
  =========       =========             ====================
  31/08/2013      JCarmona.SAO214298    Se modifica para que obtenga el cupo disponible
                                        dado el contrato y lo almacena en onuQuota.
  ******************************************************************/
  PROCEDURE getTransferData(inusubscription in suscripc.susccodi%type,
                            onuId           out number,
                            osbName         out varchar2,
                            onuQuota        out number) IS

    nuSubscriber number;
    tbProducts dapr_product.tytbPR_product;
    nuIndex number;
    blExist boolean;

  begin

    if (pktblsuscripc.fblExist(inusubscription)) then

      onuId := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LD_QUOTA_TRANSFER',
                                                   'SEQ_LD_QUOTA_TRANSFER');

      -- AllocateQuota(inusubscription, onuQuota);

      /* SAO214298: Se obtiene el cupo disponible del contrato*/
      onuQuota := availableQuota(inusubscription);

      nuSubscriber := pktblsuscripc.fnuGetSuscclie(inusubscription);

      osbName := dage_subscriber.fsbGetSubscriber_Name(nuSubscriber) || ' ' ||
                 dage_subscriber.fsbGetSubs_Last_Name(nuSubscriber);
    else

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato no existe ');

    end if;

    /*Se obtienen los productos*/
    tbProducts:=pr_bcproduct.ftbProdsBySubscId(inusubscription);

    if(tbProducts.count>0)then

    nuIndex:= tbProducts.first;

    while nuIndex IS not null loop
     /*Valida si tiene una orden de suspensión en proceso*/
     blExist:= pkSuspConnServiceMgr.fblExistOrder( -1, -1, tbProducts(nuindex).product_id, 'D' );

     if(blExist)then
       ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El contrato tiene una orden de suspensión en proceso ');

     END if;

     nuIndex:= tbProducts.next(nuIndex);

    END loop;

    END if;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END getTransferData;

    ----------------------------------------------------------------------------

    PROCEDURE addDataTransferQuota
    (
        inuOrigSubcripId        suscripc.susccodi%type,         -- Contrato Origen
        inuDestSubscripId       suscripc.susccodi%type,         -- Contrato Destino
        idtTransferDate         date,                           -- Fecha de Traslado
        idtFinalDate            date,                           -- Final de Vigencia
        inuTrasnferValue        number,                         -- Valor Trasladado
        isbObservation          ld_quota_transfer.request_observation%type default null
    )
    IS
        rcDataTransfer          tyrcQuotaTransfer;
    BEGIN

        UT_Trace.Trace('Inicio LD_BOQUOTATRANSFER.addDataTransferQuota',1);

        rcDataTransfer.nuOrigSubcripId := inuOrigSubcripId;
        rcDataTransfer.nuDestSubscripId := inuDestSubscripId;
        rcDataTransfer.dtTransferDate := idtTransferDate;
        rcDataTransfer.dtFinalDate := idtFinalDate;
        rcDataTransfer.nuTrasnferValue := inuTrasnferValue;
        rcDataTransfer.sbObservation := isbObservation;

        tbQuotaTransfer(tbQuotaTransfer.count + 1) := rcDataTransfer;

        UT_Trace.Trace('FIN LD_BOQUOTATRANSFER.addDataTransferQuota',1);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
          RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
    END addDataTransferQuota;

    ----------------------------------------------------------------------------

    PROCEDURE registerQuotaTransfer
    (
        inuPackTransId    in      mo_packages.package_id%type
    )
    IS
        nuIdx                       BINARY_INTEGER;
        nuTransfer_Quota_FNB_Type   GE_Activity.Activity_Id%type;
        nuOrder                     or_order.order_id%type;

    BEGIN

        UT_Trace.Trace('Inicio LD_BOQUOTATRANSFER.registerQuotaTransfer['||inuPackTransId||']',1);

        /* Se valida si existen registros en la tabla */
        IF (tbQuotaTransfer.count > 0) THEN
            -- Procesa los registros
            nuIdx := tbQuotaTransfer.first;
            WHILE (nuIdx IS NOT NULL) LOOP
                nuOrder := null;
                /* Se crean las ordenes por cada contrato que está cediendo cupo */
                RegisterTransferQuota
                (
                    inuPackTransId,
                    tbQuotaTransfer(nuIdx).nuDestSubscripId,    --inuDestinySubscripId NUMBER,
                    tbQuotaTransfer(nuIdx).nuOrigSubcripId,     --inuOriginSubcripId   NUMBER,
                    tbQuotaTransfer(nuIdx).dtTransferDate,      --idtTransferDate      DATE,
                    tbQuotaTransfer(nuIdx).nuTrasnferValue,     --inuTrasnferValue     NUMBER,
                    tbQuotaTransfer(nuIdx).dtFinalDate,         --idtFinalDate         DATE,
                    nuOrder,                                    --inuOrder             in out NUMBER,
                    tbQuotaTransfer(nuIdx).sbObservation        --isbObservation
                );

                nuIdx := tbQuotaTransfer.NEXT(nuIdx);
            END LOOP;
        END IF;

        UT_Trace.Trace('FIN LD_BOQUOTATRANSFER.registerQuotaTransfer',1);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
          RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
    END registerQuotaTransfer;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   GetConsSalebyOrder
    Descripcion :   Retorna el Consecutivo de una venta
    Autor       :   Mahicol meusburgger
    Fecha       :   12-09-2013
    Parametros  :
        inuPackageId:    Identificador de financiacion no bancaria
        onuConsSale:     Consecutivo de la venta

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    02/10/2013  LDiuza.SAO218144           Se cambia el codigo de la orden por
                                           el codigo de la solicitud como parametro
                                           de entrada usado como filtro.
    12-09-2013  mmeusburgger.SAO212252     Creación.
    ***************************************************************************/
    PROCEDURE GetConsSalebyOrder
    (
        inuPackageId    in  mo_packages.package_id%type,
        osbConsSale     out ld_non_ba_fi_requ.digital_prom_note_cons%type
    )
    IS
    BEGIN
        ut_trace.trace('[INICIO]LD_BOQUOTATRANSFER.GetConsSalebyOrder',1);

        --Obtiene el Consecutivo de la Venta
         LD_BCQUOTATRANSFER.GetConsSalebyOrder(inuPackageId,osbConsSale);

        ut_trace.trace('[FINAL]LD_BOQUOTATRANSFER.GetConsSalebyOrder',1);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
    END GetConsSalebyOrder;

  function fnuCountOrderTranfer(inupackage IN mo_packages.package_id%TYPE)
    return number IS

    nucausal        ld_parameter.numeric_value%type;
    nusucccausal    ld_parameter.numeric_value%type;
    nuactivityTrasn ld_parameter.numeric_value%type;
    tbDataOrder     LD_BCQUOTATRANSFER.tytbOrderData;
  BEGIN

    UT_Trace.Trace('Inicio LD_BOQUOTATRANSFER.fnuCountOrderTranfer',2);

    nuactivityTrasn := dald_parameter.fnuGetNumeric_Value('TRANSFER_QUOTA_FNB_ACTIVI_TYPE');

    nucausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_FAIL_CAUSA');

    nusucccausal := dald_parameter.fnuGetNumeric_Value('TRASNFER_SUCC_CAUSAL');

    tbDataOrder := LD_BCQUOTATRANSFER.ftbDataOrderAct(inupackage, nuactivityTrasn);

    UT_Trace.Trace('Fin LD_BOQUOTATRANSFER.fnuCountOrderTranfer ' || tbDataOrder.count,2);
    return tbDataOrder.count;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END fnuCountOrderTranfer;

END LD_BOQUOTATRANSFER;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOQUOTATRANSFER', 'ADM_PERSON');
END;
/
