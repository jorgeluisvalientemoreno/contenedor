CREATE OR REPLACE TRIGGER ADM_PERSON.ldc_trg_upsert_LDC_PROMO_FNB
FOR update or insert ON  LDC_PROMO_FNB
COMPOUND TRIGGER
   rcPromoFNB LDC_PROMO_FNB%ROWTYPE;

   sbstring  varchar2(4000);

   nuCount number := 0;
   AFTER EACH ROW IS
    BEGIN
       ut_trace.trace('ldc_trg_upsert_LDC_PROMO_FNB -  Inicio -> AFTER EACH ROW ', 10);
       rcPromoFNB.SUBLINE_ID := :NEW.SUBLINE_ID;
       rcPromoFNB.INITIAL_DATE:= :NEW.INITIAL_DATE;
       rcPromoFNB.FINAL_DATE := :NEW.FINAL_DATE;
       ut_trace.trace('ldc_trg_upsert_LDC_PROMO_FNB -  Fin -> AFTER EACH ROW '||rcPromoFNB.SUBLINE_ID||' - '||rcPromoFNB.INITIAL_DATE||' - '||rcPromoFNB.FINAL_DATE, 10);

   END AFTER EACH ROW;

   before STATEMENT IS
     BEGIN
      ut_trace.trace('ldc_trg_upsert_LDC_PROMO_FNB -  Inicio ->  AFTER STATEMENT ', 10);
       -- Obtener configuración de la tabla de presupuesto por proveedor
       select count(*)
       into nuCount
       from LDC_PROMO_FNB
       where LDC_PROMO_FNB.SUBLINE_ID =  rcPromoFNB.SUBLINE_ID
       and (LDC_PROMO_FNB.INITIAL_DATE  between  rcPromoFNB.INITIAL_DATE and rcPromoFNB.FINAL_DATE
       or LDC_PROMO_FNB.FINAL_DATE between  rcPromoFNB.INITIAL_DATE and rcPromoFNB.FINAL_DATE);
        ut_trace.trace('ldc_trg_upsert_LDC_PROMO_FNB -  Fin ->  AFTER STATEMENT - '||nuCount, 10);

       if nuCount > 0 then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Existe solapamiento de fechas para la sublinea '||
                                            rcPromoFNB.SUBLINE_ID ||' - '|| dald_subline.fsbGetDescription(rcPromoFNB.SUBLINE_ID )  );
           raise ex.CONTROLLED_ERROR;
       end if;

       EXCEPTION
          when ex.CONTROLLED_ERROR then
              raise;
          when OTHERS then
              Errors.setError;
              raise ex.CONTROLLED_ERROR;
   END before STATEMENT;
END ldc_trg_upsert_LDC_PROMO_FNB;
/
