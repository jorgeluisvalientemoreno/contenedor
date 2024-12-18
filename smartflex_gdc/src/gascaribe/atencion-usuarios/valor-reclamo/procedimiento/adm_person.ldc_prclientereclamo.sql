CREATE OR REPLACE PROCEDURE adm_person.ldc_prclientereclamo( inuident_type_id     IN NUMBER,
                                                             isbidentification    IN VARCHAR2,
                                                             isbsubscriber_name   IN VARCHAR2,
                                                             isbsubs_last_name    IN VARCHAR2,
                                                             isbphone             IN VARCHAR2,
                                                             isbe_mail            IN VARCHAR2,
                                                             inudireccioncontrato IN NUMBER,
                                                             onuerrorcode         OUT NUMBER,
                                                             osberrormessage      OUT VARCHAR2) 
AS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).
    
    Unidad         : LDC_PRCLIENTERECLAMO
    Descripcion    : Proceso para creacion del nuevo cliente que solicita un reclamo de un contrato
    
    Autor          : Jorge Valiente
    Fecha          : 20/04/2022
    Jira           : 96
    
    Parametros             Descripci?n
    ============           ===================
    inuident_type_id       Tipo de identificacion
    isbidentification      Codigo identificacion
    isbsubscriber_name     Nombre
    isbsubs_last_name      Apellido
    isbphone               Telefono
    isbe_mail              Correo
    inuDireccionContrato   Direccion
    onuerrorcode           Codigo error
    osberrormessage        Descriipcion Error
    
    Historia de Modificaciones
    Fecha            Autor                    Modificaci?n
    =========      =========                ====================
    17/04/2024      PAcosta                 OSF-2532: Se crea el objeto en el esquema adm_person
    ******************************************************************/
    
    ionusubscriber_id NUMBER(15);

BEGIN
    --Registrar el nuevo cliente
    BEGIN
        os_customerregister(ionusubscriber_id, --Codigo del cliente en OSF
                            inuident_type_id, --Tipo Identificacion
                            isbidentification, --Codigo Identificacion
                            NULL, --inuparent_subscriber_id
                            1, --inusubscriber_type_id
                            NULL, --isbaddress
                            isbphone, --Telefono
                            isbsubscriber_name, --Nombre comepleto
                            isbsubs_last_name, --Apellido completo
                            isbe_mail, --Correo
                            NULL, --isburl
                            NULL, --isbcontact_phone
                            NULL, --isbcontact_address
                            NULL, ----isbcontact_name
                            NULL, --inucontact_ident_type
                            NULL, --isbcontact_ident
                            NULL, --inumarketing_segment_id
                            NULL, --inusubs_status_id
                            NULL, --isbsex
                            NULL, --idtbirthdate
                            onuerrorcode,
                            osberrormessage);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            onuerrorcode    := -1;
            osberrormessage := 'Error al utilizar el Servicio de OPEN os_customerregister';
    END;

    /*
    Onuerrorcode    := -1;
    Osberrormessage := 'Error al utilizar el Servicio de OPEN os_customerregister';
    */

    --/*
    IF onuerrorcode = 0 THEN
        COMMIT;
        --Actualizar el direccion del cliente con la direccion del contrato
        UPDATE ge_subscriber G
        SET G.address_id = inudireccioncontrato
        WHERE G.subscriber_id = ionusubscriber_id;
        COMMIT;
        onuerrorcode    := 0;
        osberrormessage := 'Cliente Creado.';
    ELSE
        onuerrorcode    := onuerrorcode;
        osberrormessage := 'Error creando Cliente [' || osberrormessage || ']';
    END IF;
    --*/
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        onuerrorcode    := -1;
        osberrormessage := ' Error: ' || sqlerrm;  
END ldc_prclientereclamo;
/
PROMPT Otorgando permisos de ejecucion a ldc_prclientereclamo
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PRCLIENTERECLAMO','ADM_PERSON');
END;
/