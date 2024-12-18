REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		insldc_parameter_ldc_conf_rege_acti_pno.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		19-01-2023
REM Descripcion	 :		Crea el parametro LDC_CONF_REGE_ACTI_PNO
REM Caso		 :		OSF-691git

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_CONF_REGE_ACTI_PNO');
        rcLdparameter.parameter_id := 'LDC_CONF_REGE_ACTI_PNO';
        rcLdparameter.description := 'Configuracion para regeneración de actividades de PNO';
        rcLdparameter.numeric_value := NULL;
        rcLdparameter.value_chain := '4000920|9851|4000948;4000840|9532|4000949;4000839|9532|4000949;4000838|9532|4000949;4000834|9532|4000949;4000840|9623|4000949;4000839|9623|4000949;4000838|9623|4000949;4000834|9623|4000949;4000840|9611|4000949;4000838|9611|4000949;4000834|9611|4000949;4000980|3757|4000949;100006595|3757|4000949;4000079|3757|4000949;4000980|3756|4000949;100006595|3756|4000949;4000079|3756|4000949;4000980|3755|4000949;100006595|3755|4000949;4000079|3755|4000949;4000839|9611|4000949;4000932|9849|4000949;4000930|9848|4000949;4000931|9682|4000949';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_CONF_REGE_ACTI_PNO');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_CONF_REGE_ACTI_PNO|'|| SQLERRM );
END;
/
