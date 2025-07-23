Prompt Creando sinonimos privados 
BEGIN
    -- OSF-3970
    pkg_Utilidades.prCrearSinonimos(upper('pkg_ldc_log_camb_fecha_max_leg'), upper('adm_person'));
END;
/