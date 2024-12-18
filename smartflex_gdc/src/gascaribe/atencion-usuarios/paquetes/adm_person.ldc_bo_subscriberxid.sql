CREATE OR REPLACE PACKAGE adm_person.LDC_BO_SUBSCRIBERXID AS

    /**************************************************************************
    Propiedad intelectual de Gases de Occidente.

    Nombre del Paquete: LDC_BO_SUBSCRIBERXID
    Descripcion : PACKAGE para consultar clientes por el id.

    Autor       : Emiro Leyva Hernandez.
    Fecha       : 08 enero del 2014

    Historia de Modificaciones
      Fecha             Autor                Modificación
    =========         =========          ====================
    23/07/2024         PAcosta           OSF-2952: Cambio de esquema ADM_PERSON
    08-01-2014         Emirol            Creación.

   **************************************************************************/

    -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;

    PROCEDURE LDC_LlenarAtributosSubscriber(iosbSubscriber  in out     Ge_BoUtilities.styStatement);

    PROCEDURE obtSubscriberXID( isbSubscriber      in VARCHAR2, ocuDataCursor out constants.tyRefCursor);

	PROCEDURE obtSubscriber( inuSubscriberid       in  ge_subscriber.subscriber_id%type,
                             ocuDataCursor         out constants.tyRefCursor);
END LDC_BO_SUBSCRIBERXID;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BO_SUBSCRIBERXID AS
  /**************************************************************************
   Propiedad intelectual de Gases de Occidente.

    Nombre del Paquete: LDC_BO_SUBSCRIBERXID
    Descripcion : PACKAGE para consultar clientes por el id.

    Autor       : Emiro Leyva Hernandez.
    Fecha       : 08 enero del 2014

    Historia de Modificaciones
      Fecha             Autor                Modificación
    =========         =========          ====================
    08-01-2014         Emirol            Creación.

   **************************************************************************/


    --------------------------------------------
    -- Variables PRIVADAS DEL PAQUETE
    --------------------------------------------

    ---------------------------------------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    ---------------------------------------------------------------------------
    CSBVERSION                   CONSTANT        VARCHAR2(40)  := 'ELH_01';

   /*
       Versionammiento del Pkg */
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
      return CSBVERSION;
    END FSBVERSION;

 /**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  LDC_LlenarAtributosSubscriber
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 8-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificación
    =========           =========          ====================
    08-01-2014          emirol               Creación.
  **************************************************************************/
  PROCEDURE LDC_LlenarAtributosSubscriber
    (
        iosbSubscriber  in out     Ge_BoUtilities.styStatement
    )
    IS

    BEGIN

        if iosbSubscriber IS not null then
            return;
        END if;

        -- Se Adicional los atributos a desplegar
        GE_BOUtilities.AddAttribute ('GE_SUBSCRIBER.SUBSCRIBER_ID','SUBSCRIBER_ID',iosbSubscriber);
        GE_BOUtilities.AddAttribute ('GE_SUBSCRIBER.IDENTIFICATION','IDENTIFICATION',iosbSubscriber);
        GE_BOUtilities.AddAttribute ('GE_SUBSCRIBER.SUBSCRIBER_NAME','SUBSCRIBER_NAME',iosbSubscriber);
        GE_BOUtilities.AddAttribute ('GE_SUBSCRIBER.SUBS_LAST_NAME','SUBS_LAST_NAME',iosbSubscriber);

        GE_BOUtilities.AddAttribute (':parent_id','parent_id',iosbSubscriber);

        ut_trace.trace(iosbSubscriber,40);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END LDC_LlenarAtributosSubscriber;

    PROCEDURE obtSubscriberXID
    (
        isbSubscriber       in VARCHAR2,
        ocuDataCursor       out constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        nuSubscriber            ge_subscriber.subscriber_id%type;
        sbSubscriber            Ge_BoUtilities.styStatement;
        --======================================================================

    BEGIN

        LDC_LlenarAtributosSubscriber(sbSubscriber);

        nuSubscriber := to_number(isbSubscriber);

        sbSql :=  ' SELECT ' || sbSubscriber   ||chr(10)||
                  ' FROM    GE_SUBSCRIBER '                   ||chr(10)||
                  ' WHERE   GE_SUBSCRIBER.subscriber_id = :nuSubscriber';

        ut_trace.trace(sbSql,40);

         open ocuDataCursor for sbSql using cc_boBossUtil.cnuNULL, nuSubscriber;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtSubscriberXID;

	/**************************************************************************
    Propiedad Intelectual de PETI
    Procedimiento     :  obtSubscriber
    Descripcion :
    Autor       : Emiro Leyva
    Fecha       : 08-01-2014

    Historia de Modificaciones
      Fecha               Autor                Modificación
    =========           =========          ====================
    08-01-2014          emirol               Creación.
  **************************************************************************/
    PROCEDURE obtSubscriber
    (
        inuSubscriberid     in      ge_subscriber.subscriber_id%type,
        ocuDataCursor       out     constants.tyRefCursor
    )
    IS
        sbSql                   varchar2(32767);
        sbSubscriber           Ge_BoUtilities.styStatement;

        nuSubscriber           ge_subscriber.subscriber_id%type;
        sbUserId                varchar2(16);
        --======================================================================

    BEGIN

        nuSubscriber    := nvl(inuSubscriberid, CC_BOConstants.cnuAPPLICATIONNULL );

        LDC_LlenarAtributosSubscriber(sbSubscriber);

        sbSql := ' SELECT '|| sbSubscriber ||chr(10)||
                 ' FROM GE_SUBSCRIBER '||chr(10)||
                 ' WHERE ';

        --CRITERIOS PARA EL IDENTIFICADOR DEL SUBSCRIBER
        IF nuSubscriber != CC_BOConstants.cnuAPPLICATIONNULL then
            sbSql := sbSql ||' subscriber_id = :nuSubscriber'||chr(10);
        ELSE
            sbSql := sbSql ||chr(39)|| nuSubscriber ||chr(39)||' = :nuSubscriber'||chr(10);
        END IF;

            --Usuario de la sesión
            sbUserId := to_char(sa_bouser.fnuGetUserId(ut_session.getUSER));

         ut_trace.trace(sbSql,40);

        open ocuDataCursor for sbSql using      cc_boBossUtil.cnuNULL,
                                                nuSubscriber;



    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtSubscriber;
END  LDC_BO_SUBSCRIBERXID;
/
PROMPT Otorgando permisos de ejecucion a LDC_BO_SUBSCRIBERXID
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BO_SUBSCRIBERXID', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_BO_SUBSCRIBERXID para reportes
GRANT EXECUTE ON adm_person.LDC_BO_SUBSCRIBERXID TO rexereportes;
/
