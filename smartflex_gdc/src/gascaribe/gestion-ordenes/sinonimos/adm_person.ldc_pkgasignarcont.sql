Prompt Creando sinonimos privados para sobre ADM_PERSON.LDC_PKGASIGNARCONT
BEGIN
    -- OSF-4042
    pkg_Utilidades.prCrearSinonimos(upper('LDC_PKGASIGNARCONT'), upper('ADM_PERSON'));
END;
/