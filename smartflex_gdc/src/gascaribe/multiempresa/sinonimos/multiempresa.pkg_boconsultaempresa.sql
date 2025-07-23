Prompt Creando sinonimos privados para sobre multiempresa.pkg_boconsultaempresa
BEGIN
    -- OSF-4010
    pkg_Utilidades.prCrearSinonimos(upper('pkg_boconsultaempresa'), upper('multiempresa'));
END;
/