DECLARE

    --tab CUSTOMER CNCRM
    CURSOR cuSa_Tab IS
    SELECT
        COUNT(1)
    FROM sa_tab st
    WHERE st.tab_id = 345143;
    

    nucantidad NUMBER;
	
BEGIN

    --tab PRODUCT CNCRM
    OPEN cuSa_Tab;
    FETCH cuSa_Tab INTO nucantidad;
    CLOSE cuSa_Tab;
    
    IF nucantidad = 0 THEN
        INSERT INTO sa_tab (
            tab_id,
            tab_name,
            process_name,
            aplica_executable,
            parent_tab,
            type,
            sequence,
            additional_attributes,
            condition
        ) VALUES (
            345143,
            'PRODUCT',
            'P_SOLICITUD_MARCACION_A_CLIENTE_ESTACIONAL_100311',
            'CNCRM',
            NULL,
            NULL,
            0,
            NULL,
            NULL
        );

        dbms_output.put_line('Registro P_SOLICITUD_MARCACION_A_CLIENTE_ESTACIONAL_100311 en SA_TAB PRODUCT Ok.');
        COMMIT;
    ELSE       
        dbms_output.put_line('El id 345143 ya esta siendo usado en la tabla SA_TAB');        
    END IF;    

END;
/

COMMIT;
/