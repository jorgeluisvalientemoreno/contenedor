CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOUTILCANCELLATIONS IS

  /*****************************************************************
   Declaracion de variables
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOUtilCancellations
  Descripcion    : Paquete con los servicios del proceso de cancelación de venta FNB.
  Autor          :
  Fecha          : 06/07/13

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/

  -- Declaracion de Tipos de datos publicos

  FUNCTION fsbVersion RETURN VARCHAR2;

  PROCEDURE GetInteractionData
    (
        inuSubscriberId             in          ge_subscriber.subscriber_id%type,
        onuInteractionId            out         cc_attention_data.package_id%type,
        onuAddressId                out         cc_attention_data.address_id%type,
        onuReceptionType            out         cc_attention_data.reception_type_id%type,
        onuContactId                out         cc_attention_data.contact_id%type,
        onuIdentTypeContact         out         ge_subscriber.ident_type_id%type,
        onuIdentContact             out         ge_subscriber.identification%type,
        onuNameContact              out         ge_subscriber.subscriber_name%type,
        onuLastNameContact          out         ge_subscriber.subs_last_name%type
    );

END LD_BOUTILCANCELLATIONS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOUTILCANCELLATIONS IS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LD_BOUtilCancellations
  Descripcion    : Paquete con los servicios del proceso de cancelación de venta FNB.
  Autor          :
  Fecha          : 06/07/13

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/

  /* Declaracion de Tipos de datos privados */

  /* Declaracion de constantes privados */

  csbVersion CONSTANT VARCHAR2(20) := 'SAO207258';

  /* Declaracion de variables privados */

  /* Declaracion de funciones y procedimientos */

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END;

  /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GetInteractionData
    Descripcion :  Obtiene los datos de la interaccion para una solicitud

    Fecha       :  10-07-2012
    Parametros  :
        inuSubscriberId             Id del suscriptor
        onuInteractionId            Id de la interaccion
        onuAddressId                Id de la direccion de respuesta
        onuReceptionType            Id del medio de recepcion
        onuContactId                Id del contacto

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    ***************************************************************/
    PROCEDURE GetInteractionData
    (
        inuSubscriberId             in          ge_subscriber.subscriber_id%type,
        onuInteractionId            out         cc_attention_data.package_id%type,
        onuAddressId                out         cc_attention_data.address_id%type,
        onuReceptionType            out         cc_attention_data.reception_type_id%type,
        onuContactId                out         cc_attention_data.contact_id%type,
        onuIdentTypeContact         out         ge_subscriber.ident_type_id%type,
        onuIdentContact             out         ge_subscriber.identification%type,
        onuNameContact              out         ge_subscriber.subscriber_name%type,
        onuLastNameContact          out         ge_subscriber.subs_last_name%type
    )
    IS
        rcSubscriber    dage_subscriber.styGE_subscriber;
    BEGIN
    --{
        ut_trace.trace('Inicio [LD_BOUtilCancellations.GetInteractionData]', 1);

        /* Obtiene los datos de la interaccion */
        CC_BOPetitionMgr.ReturnAttentionData
        (
            inuSubscriberId,
            onuInteractionId,
            onuAddressId,
            onuReceptionType,
            onuContactId
        );

        if ( onuContactId IS not null)
        then
            rcSubscriber := dage_subscriber.frcgetrecord(onuContactId);

            onuIdentTypeContact := rcSubscriber.ident_type_id;
            onuIdentContact := rcSubscriber.identification;
            onuNameContact := rcSubscriber.subscriber_name;
            onuLastNameContact := rcSubscriber.subs_last_name;
        END if;

        ut_trace.trace('Fin [LD_BOUtilCancellations.GetInteractionData]', 1);
    --}
    EXCEPTION
    --{
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('ex.CONTROLLED_ERROR [LD_BOUtilCancellations.GetInteractionData]', 1);
    	    raise ex.CONTROLLED_ERROR;

        when OTHERS then
            Errors.SetError;
            ut_trace.trace('OTHERS [LD_BOUtilCancellations.GetInteractionData]', 1);
            raise ex.CONTROLLED_ERROR;
    --}
    END GetInteractionData;

END LD_BOUTILCANCELLATIONS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOUTILCANCELLATIONS', 'ADM_PERSON'); 
END;
/
