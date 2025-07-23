Prompt Creando sinonimos privados para sobre OPEN.GE_ITEM_CLASSIF
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('GE_ITEM_CLASSIF'), upper('OPEN'));
END;
/