CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_BI_REQUEST_DATE
  BEFORE INSERT ON mo_packages
    REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  
BEGIN

        IF :new.package_type_id in (308, 59) THEN
            :new.request_date := sysdate;
        END IF;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
END;
/