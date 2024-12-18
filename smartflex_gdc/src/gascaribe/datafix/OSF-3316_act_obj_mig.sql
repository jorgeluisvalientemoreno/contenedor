BEGIN
	-- OSF-3316
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN
    (   
        upper('ldc_botraslado_pago')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro de ldc_botraslado_pago en master_personalizaciones, '||sqlerrm);
END;
/    