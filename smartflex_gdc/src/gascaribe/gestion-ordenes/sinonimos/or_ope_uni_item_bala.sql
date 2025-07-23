Prompt Creando sinonimos privados para sobre OPEN.or_ope_uni_item_bala
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('or_ope_uni_item_bala'), upper('OPEN'));
END;
/