Prompt Creando sinonimos privados para sobre OPEN.ge_items_documento
BEGIN
    -- OSF-4245
    pkg_Utilidades.prCrearSinonimos(upper('ge_items_documento'), upper('OPEN'));
END;
/