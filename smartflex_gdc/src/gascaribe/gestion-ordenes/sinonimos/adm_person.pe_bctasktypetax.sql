Prompt Creando sinonimos privados para ADM_PERSON.PE_BCTaskTypeTax
BEGIN
    pkg_Utilidades.prCrearSinonimos(upper('PE_BCTaskTypeTax'), 'ADM_PERSON');
END;
/