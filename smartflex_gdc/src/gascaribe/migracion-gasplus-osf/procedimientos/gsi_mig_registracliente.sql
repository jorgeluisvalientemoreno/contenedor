CREATE OR REPLACE PROCEDURE      "GSI_MIG_REGISTRACLIENTE" (
   ionusubscriber_id          IN OUT ge_subscriber.subscriber_id%TYPE,
   inuident_type_id           IN     ge_subscriber.ident_type_id%TYPE,
   isbidentification          IN     ge_subscriber.identification%TYPE,
   inuparent_subscriber_id    IN     ge_subscriber.parent_subscriber_id%TYPE,
   inusubscriber_type_id      IN     ge_subscriber.subscriber_type_id%TYPE,
   isbaddress                 IN     ge_subscriber.address%TYPE,
   isbphone                   IN     ge_subscriber.phone%TYPE,
   isbsubscriber_name         IN     ge_subscriber.subscriber_name%TYPE,
   isbsubs_last_name          IN     ge_subscriber.subs_last_name%TYPE,
   isbsubs_second_last_name   IN     ge_subscriber.subs_second_last_name%TYPE,
   idtdate_birth              IN     ge_subs_general_data.date_birth%TYPE DEFAULT NULL,
   idtLast_update             IN     ge_subs_general_data.last_update%type DEFAULT NULL,
   isbe_mail                  IN     ge_subscriber.e_mail%TYPE,
   isburl                     IN     ge_subscriber.url%TYPE,
   inucontactid               IN     ge_subscriber.contact_id%TYPE,
   inueconomic_activity_id    IN     ge_subscriber.economic_activity_id%TYPE,
   inumarketing_segment_id    IN     ge_subscriber.marketing_segment_id%TYPE,
   inusubs_status_id          IN     ge_subscriber.subs_status_id%TYPE,
   isbactive                  IN     ge_subscriber.active%TYPE,
   inuaddressid               IN     ge_subscriber.address_id%TYPE DEFAULT NULL,
   inutaxpayertype            IN     ge_subscriber.taxpayer_type%TYPE,
   isbdatasend                IN     ge_subscriber.data_send%TYPE,
   idtvinculate_date          IN     ge_subscriber.vinculate_date%TYPE,
   idtdoc_date_of_issue       IN     ge_subscriber.doc_date_of_issue%TYPE,
   isbdoc_place_of_issue      IN     ge_subscriber.doc_place_of_issue%TYPE,
   isbis_corporative          IN     ge_subscriber.is_corporative%TYPE,
   onuerrorcode                  OUT ge_message.message_id%TYPE,
   osberrormessage               OUT VARCHAR2)
IS
   /*
    Nombre objeto      gsi_mig_registracliente
    Proposito          Creacion de cliente tabla ge_subscriber y satelites.
    Historial
    Fecha           Modificacion        Autor
    2012-01-31      Creacion            WOSPINA: Creacion de objeto de acuerdo a la version de esquema en 7.6
    2012-11-27      Modificacion        WOSPINA: Modifiacion de objeto por cambio en esquema.
                                                 Se modifica el API, para manejar los campos: DOC_DATE_OF_ISSUE y DOC_PLACE_OF_ISSUE
    2013-04-02                          PDELAPENA: Se agrega el parametro de entrada isbis_corporative debido a el cambio de esquema
                                                   En ge_subscriber. se llena el  parametro de salida con la descripción del error de
                                                   oracle para el caso de errores no controlados osberrormessage:=SQLERRM;
   */
   rcsubscriber              dage_subscriber.styge_subscriber;
   rcsubsgeneral             dage_subs_general_data.styge_subs_general_data;
   rcsubsbussdata            dage_subs_busines_data.styge_subs_busines_data;
   --- Definicion de datos de la tabla GE_SUBSCRIBER.
   nusubscriber_id           ge_subscriber.subscriber_id%TYPE;
   nuparent_subscriber_id    ge_subscriber.parent_subscriber_id%TYPE;
   nuident_type_id           ge_subscriber.ident_type_id%TYPE;
   nusubscriber_type_id      ge_subscriber.subscriber_type_id%TYPE;
   sbidentification          ge_subscriber.identification%TYPE;
   sbsubscriber_name         ge_subscriber.subscriber_name%TYPE;
   sbsubs_last_name          ge_subscriber.subs_last_name%TYPE;
   sbe_mail                  ge_subscriber.e_mail%TYPE;
   sburl                     ge_subscriber.url%TYPE;
   sbaddress                 ge_subscriber.address%TYPE;
   sbphone                   ge_subscriber.phone%TYPE;
   sbactive                  ge_subscriber.active%TYPE;
   nueconomic_activity_id    ge_subscriber.economic_activity_id%TYPE;
   sbexoneration_document    ge_subscriber.exoneration_document%TYPE;
   nusubs_status_id          ge_subscriber.subs_status_id%TYPE;
   numarketing_segment_id    ge_subscriber.marketing_segment_id%TYPE;
   nucontact_id              ge_subscriber.contact_id%TYPE;
   sbcountry_id              ge_subscriber.country_id%TYPE;
   nuaddress_id              ge_subscriber.address_id%TYPE;
   sbdata_send               ge_subscriber.data_send%TYPE;
   dtvinculate_date          ge_subscriber.vinculate_date%TYPE;
   sbsubs_second_last_name   ge_subscriber.subs_second_last_name%TYPE;
   sbaccept_call             ge_subscriber.accept_call%TYPE;
   nutaxpayer_type           ge_subscriber.taxpayer_type%TYPE;
   nuauthorization_type      ge_subscriber.authorization_type%TYPE;
   nucollect_program_id      ge_subscriber.collect_program_id%TYPE;
   nucollect_entity_id       ge_subscriber.collect_entity_id%TYPE;
   nucategory_id             ge_subscriber.category_id%TYPE;
   dtdoc_date_of_issue       ge_subscriber.doc_date_of_issue%TYPE;
   sbdoc_place_of_issue      ge_subscriber.doc_place_of_issue%TYPE;
   sbis_corporative          ge_subscriber.is_corporative%TYPE;

   --- Definicion de datos de la tabla GE_SUBS_GENERAL_DATA.

   dtdate_birth              ge_subs_general_data.date_birth%TYPE;
   dtlast_update              ge_subs_general_data.last_update%TYPE;
BEGIN
   -- Recibe Datos para GE_SUBSCRIBER
   osberrormessage := NULL;

   IF (ionusubscriber_id IS NULL)
   THEN
      nusubscriber_id := ge_bosequence.nextge_subscriber;
   END IF;

   nusubscriber_id := ionusubscriber_id;
   nuparent_subscriber_id := inuparent_subscriber_id;
   nuident_type_id := inuident_type_id;
   nusubscriber_type_id := inusubscriber_type_id;
   sbidentification := isbidentification;
   sbsubscriber_name := UPPER (isbsubscriber_name);
   sbsubs_last_name := UPPER (isbsubs_last_name);
   sbe_mail := isbe_mail;
   sburl := isburl;
   sbaddress := isbaddress;
   sbphone := isbphone;
   sbactive := NVL (isbactive, 'Y');
   nueconomic_activity_id := inueconomic_activity_id;
   sbexoneration_document := NULL;
   nusubs_status_id := NVL (inusubs_status_id, 1);
   numarketing_segment_id := inumarketing_segment_id;
   nucontact_id := inucontactid;
   sbcountry_id := NULL;
   nuaddress_id := inuaddressid;
   sbdata_send := NVL (isbdatasend, 'N');
   dtvinculate_date := idtvinculate_date;
   sbsubs_second_last_name := UPPER (isbsubs_second_last_name);
   sbaccept_call := NULL;
   nutaxpayer_type := inutaxpayertype;
   nuauthorization_type := NULL;
   nucollect_program_id := NULL;
   nucollect_entity_id := NULL;
   nucategory_id := NULL;
   dtdoc_date_of_issue := idtdoc_date_of_issue;
   sbdoc_place_of_issue := idtdoc_date_of_issue;
   sbis_corporative:= isbis_corporative;
   -- Recibe Datos para GE_SUBS_GENERAL_DATA
   dtdate_birth := idtdate_birth;
   dtlast_update:= idtLast_update;

   ---------------------------------------------------------------------------------



   --- INSERCION GE_SUBSCRIBER



   INSERT INTO ge_subscriber
        VALUES (nusubscriber_id,
                nuparent_subscriber_id,
                nuident_type_id,
                nusubscriber_type_id,
                sbidentification,
                sbsubscriber_name,
                sbsubs_last_name,
                sbe_mail,
                sburl,
                sbaddress,
                sbphone,
                sbactive,
                nueconomic_activity_id,
                sbexoneration_document,
                nusubs_status_id,
                numarketing_segment_id,
                nucontact_id,
                sbcountry_id,
                nuaddress_id,
                sbdata_send,
                dtvinculate_date,
                sbsubs_second_last_name,
                sbaccept_call,
                nutaxpayer_type,
                nuauthorization_type,
                nucollect_program_id,
                nucollect_entity_id,
                nucategory_id,
                dtdoc_date_of_issue,
                sbdoc_place_of_issue,
                sbis_corporative);

      rcSubsGeneral.SUBSCRIBER_ID := ionusubscriber_id;
      rcSubsGeneral.COMMENT_ := 'MIGRACION';
      
      IF (dtdate_birth IS NOT NULL)
      THEN
         rcSubsGeneral.DATE_BIRTH := dtdate_birth;
      END IF;
      
       IF (dtlast_update IS NOT NULL)
      THEN
         rcSubsGeneral.last_update := dtlast_update;
      END IF;

      -- Se guarda el url en la entidad de datos adicionales ge_subs_busines_data
      IF (isburl IS NOT NULL)
      THEN
         rcSubsBussData.url := isburl;
      END IF;

      dage_subs_general_data.insrecord (rcSubsGeneral);

EXCEPTION
   WHEN ex.controlled_error
   THEN
      ut_trace.trace ('Fallo Creacion de Cliente: ' || nusubscriber_id, 1);
      errors.seterror;
      errors.geterror (onuerrorcode, osberrormessage);
   WHEN OTHERS
   THEN
      ut_trace.trace ('Fallo Creacion de Cliente: ' || nusubscriber_id, 1);
      errors.seterror;
      errors.geterror (onuerrorcode, osberrormessage);
      osberrormessage:=SQLERRM;
END; 
/
