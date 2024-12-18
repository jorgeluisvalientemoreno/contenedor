CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_MO_MOTIVE_MARCA_PROD
AFTER INSERT ON mo_motive
FOR EACH ROW
/**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P
    trigger     :   LDC_TRG_MO_MOTIVE_MARCA_PROD
    Descripcion :   Actualiza la suspension en cambios de marca del productu.
    Autor       :   John Jairo Jimenez Marimón
    Fecha       :   21-02-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
**************************************************************************/
DECLARE
 nutiposol ps_package_type.package_type_id%TYPE;
BEGIN
 SELECT m.package_type_id INTO nutiposol
   FROM mo_packages m
  WHERE m.package_id = :new.package_id;
    IF nutiposol = dald_parameter.fnuGetNumeric_Value('TIPO_SOL_RECONEX_SIN_CERTIF') THEN
     UPDATE ldc_creatami_revper f
        SET f.solicitud = :new.package_id
      WHERE f.solicitud IS NULL
        AND f.producto = :new.product_id;
    END IF;
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_TRG_MO_MOTIVE_MARCA_PROD;
/
