REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		titr_vpm_noti_susp.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :	    14-06-2023
REM Descripcion	 :		Crea o actualiza el parametro TITR_VPM_NOTI_SUSP
REM Caso		 :		OSF-1085

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN

    rcLdparameter.parameter_id := 'TITR_VPM_NOTI_SUSP';
    rcLdparameter.description := 'TIPOS DE TRABAJO EXCLUSIVOS DE NOTIFICACIONES VPM';
    rcLdparameter.numeric_value := NULL;
    rcLdparameter.value_chain := '11185,11183';
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dbms_output.put_line('Inicia creacion parametro TITR_VPM_NOTI_SUSP'); 
        dald_parameter.insrecord(rcLdparameter);
		dbms_output.put_line('Termina creacion parametro TITR_VPM_NOTI_SUSP');
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro TITR_VPM_NOTI_SUSP');    
        dald_parameter.updrecord(rcLdparameter);
		dbms_output.put_line('Termina actualizacion parametro TITR_VPM_NOTI_SUSP');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro causcarg_persca|'|| SQLERRM );
END;
/
