CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LD_EXTRA_QUOTA
  AFTER INSERT or update or delete ON LD_EXTRA_QUOTA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

/************************************************************************
PROPIEDAD INTELECTUAL DE GDC
PROCEDIMIENTO        : LDC_TRG_LD_EXTRA_QUOTA
AUTOR                : Sebastian Tapias
DESCRIPCION          : Realiza acciones en la tabla LDC_EXTRA_QUOTA_ADIC
                       a medida que se realizan cambios en LD_EXTRA_QUOTA
************************************************************************/

DECLARE

  ------------------
  -- Variables -->
  ------------------

  inuConseId NUMBER;

  ------------------
  -- Cursores -->
  ------------------

  CURSOR cuexquad(inu NUMBER) IS
    SELECT l.conse_id FROM ldc_extra_quota_adic l WHERE l.conse_id = inu;

BEGIN

  ------------------
  -- Logica -->
  ------------------

  -- Cuando esta insertando.
  IF INSERTING THEN

    INSERT INTO ldc_extra_quota_adic
      (conse_id,
       supplier_id,
       category_id,
       subcategory_id,
       geograp_location_id,
       sale_chanel_id,
       quota_option,
       value,
       line_id,
       subline_id,
       initial_date,
       final_date,
       observation)
    VALUES
      (:new.extra_quota_id,
       :new.supplier_id,
       :new.category_id,
       :new.subcategory_id,
       :new.geograp_location_id,
       :new.sale_chanel_id,
       :new.quota_option,
       :new.value,
       :new.line_id,
       :new.subline_id,
       :new.initial_date,
       :new.final_date,
       :new.observation);

    -- Cuando esta actualizando
  ELSIF UPDATING THEN

    --Consultamos si el registro existe en nuestra tabla.
    OPEN cuexquad(:old.extra_quota_id);
    FETCH cuexquad
      INTO inuConseId;
    CLOSE cuexquad;

    --Si ya existe actualizamos
    IF (inuConseId IS NOT NULL) THEN
      --Actualizamos
      UPDATE LDC_EXTRA_QUOTA_ADIC
         SET supplier_id         = :new.supplier_id,
             category_id         = :new.category_id,
             subcategory_id      = :new.subcategory_id,
             geograp_location_id = :new.geograp_location_id,
             sale_chanel_id      = :new.sale_chanel_id,
             quota_option        = :new.quota_option,
             value               = :new.value,
             line_id             = :new.line_id,
             subline_id          = :new.subline_id,
             initial_date        = :new.initial_date,
             final_date          = :new.final_date,
             observation         = :new.observation
       WHERE conse_id = :old.extra_quota_id;
      --Si no existe, lo creamos como uno nuevo.
    ELSE

      INSERT INTO ldc_extra_quota_adic
        (conse_id,
         supplier_id,
         category_id,
         subcategory_id,
         geograp_location_id,
         sale_chanel_id,
         quota_option,
         value,
         line_id,
         subline_id,
         initial_date,
         final_date,
         observation)
      VALUES
        (:old.extra_quota_id,
         :new.supplier_id,
         :new.category_id,
         :new.subcategory_id,
         :new.geograp_location_id,
         :new.sale_chanel_id,
         :new.quota_option,
         :new.value,
         :new.line_id,
         :new.subline_id,
         :new.initial_date,
         :new.final_date,
         :new.observation);

    END IF;
    --Cuando este borrando.
  ELSIF DELETING THEN

    DELETE FROM ldc_extra_quota_adic WHERE conse_id = :old.extra_quota_id;

  END IF;

EXCEPTION
  WHEN OTHERS THEN
    errors.seterror(2741, 'Error en el Trigger: LDC_TRG_LD_EXTRA_QUOTA');
    RAISE;
END;
/
