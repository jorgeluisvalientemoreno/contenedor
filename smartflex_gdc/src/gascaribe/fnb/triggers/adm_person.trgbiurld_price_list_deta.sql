CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_PRICE_LIST_DETA BEFORE INSERT OR UPDATE ON LD_PRICE_LIST_DETA
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger      : trgbiurLD_PRICE_LIST_DETA
Descripcion  : Trigger para registro de historico.
Autor        : AdoAcu
Fecha        : 07/03/2013

Historia de Modificaciones
Fecha        IDEntrega           Modificacion

**************************************************************/
DECLARE
  sbNotifSends VARCHAR2(1000);
  sbLogNotif   VARCHAR2(1000);
  nuEntityid   ge_entity.entity_id%TYPE;
  nuErrorCode  NUMBER;
  sbErrorText  VARCHAR2(100);
BEGIN

  IF UPDATING THEN
    IF :new.price_aproved <> :old.price_aproved THEN

      insert into ld_price_list_dehi
        (PRICE_LIST_DEHI_ID,
         PRICE_LIST_ID,
         ARTICLE_ID,
         PRICE,
         PRICE_APROVED,
         SALE_CHANEL_ID,
         GEOGRAP_LOCATION_ID,
         VERSION,
         REGISTER_DATE)
      values
        (:new.price_list_deta_id,
         :new.price_list_id,
         :new.article_id,
         :new.price,
         :new.price_aproved,
         :new.sale_chanel_id,
         :new.geograp_location_id,
         :new.version,
         sysdate);

    END IF;
  END IF;
  IF INSERTING THEN

    insert into ld_price_list_dehi
      (PRICE_LIST_DEHI_ID,
       PRICE_LIST_ID,
       ARTICLE_ID,
       PRICE,
       PRICE_APROVED,
       SALE_CHANEL_ID,
       GEOGRAP_LOCATION_ID,
       VERSION,
       REGISTER_DATE)
    values
      (:new.price_list_deta_id,
       :new.price_list_id,
       :new.article_id,
       :new.price,
       :new.price_aproved,
       :new.sale_chanel_id,
       :new.geograp_location_id,
       :new.version,
       sysdate);

  END IF;

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_PRICE_LIST_DETA;
/
