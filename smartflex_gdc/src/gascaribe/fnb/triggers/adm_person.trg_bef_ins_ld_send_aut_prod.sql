CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BEF_INS_LD_SEND_AUT_PROD
  BEFORE insert OR UPDATE on ld_send_authorized
  for each row

BEGIN
    DECLARE
        sbError         ge_error_log.description%TYPE; -- Error
        nuconta         NUMBER(4);
        sbidentificacod ge_subscriber.identification%TYPE;
        nupackdeudor    mo_packages.package_id%TYPE;
        nupackcodeudor  mo_packages.package_id%TYPE;
    BEGIN
      IF :new.sample_id IS NULL THEN
       :new.sample_id := -1;
      END IF;
      IF :new.product_id IS NOT NULL THEN
       SELECT COUNT(1) INTO nuconta
         FROM servsusc s
        WHERE s.sesunuse = :new.product_id
          AND s.sesuserv = :new.type_product_id;
       IF nuconta = 0 THEN
         sbError := 'El producto : '||to_char(:new.product_id)||' no pertenece al tipo de producto : '||to_char(:new.type_product_id);
         RAISE ex.Controlled_Error;
       END IF;
       /*SELECT COUNT(1) INTO nuconta
         FROM servsusc s,suscripc g,ge_subscriber c
        WHERE s.sesunuse       = :new.product_id
          AND c.identification = :new.identification
          AND s.sesususc       = g.susccodi
          AND g.suscclie       = c.subscriber_id;
       IF nuconta = 0 THEN
        BEGIN
         SELECT c.identification INTO sbidentificacod
           FROM servsusc s,suscripc g,ge_subscriber c
          WHERE s.sesunuse       = :new.product_id
            AND s.sesususc       = g.susccodi
            AND g.suscclie       = c.subscriber_id;
        EXCEPTION
         WHEN no_data_found THEN
          sbidentificacod := NULL;
        END;
        IF sbidentificacod IS NULL THEN
         sbError := 'El producto : '||to_char(:new.product_id)||' no tiene identificacion registrada';
         RAISE ex.Controlled_Error;
        END IF;
        BEGIN
         SELECT lf.package_id INTO nupackdeudor
           FROM ld_promissory lf
          WHERE lf.identification = :new.identification;
        EXCEPTION
         WHEN no_data_found THEN
          sbError := 'El producto con identificacion : '||:new.identification||' no esta registro como Deudor o Codeudor.';
          RAISE ex.Controlled_Error;
        END;
        BEGIN
         SELECT lf.package_id INTO nupackcodeudor
           FROM ld_promissory lf
          WHERE lf.identification = sbidentificacod;
        EXCEPTION
         WHEN no_data_found THEN
          sbError := 'El producto con identificacion : '||sbidentificacod||' no esta registro como Deudor o Codeudor.';
          RAISE ex.Controlled_Error;
        END;
        IF nupackdeudor <> nupackcodeudor THEN
         sbError := 'El producto : '||to_char(:new.product_id)||' no esta asociado a la identificacion : '||:new.identification||' DEUDOR - CODEUDOR';
         RAISE ex.Controlled_Error;
        END IF;
       END IF;*/
      END IF;
    EXCEPTION
        WHEN ex.Controlled_Error THEN
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
            RAISE;

        WHEN OTHERS THEN
            sbError := 'TERMINO CON ERROR NO CONTROLADO  TRG_BEF_INS_LD_SEND_AUT_PROD' || SQLERRM;
            ut_trace.trace(sbError);
            dbms_output.put_line(sbError);
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
    END;
END TRG_BEF_INS_LD_SEND_AUT_PROD;
/
