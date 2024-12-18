BEGIN
	-- OSF-3162
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO PERSONALIZACIONES'
    WHERE  nombre IN
    (   
        upper('ldc_pkvalida_tt_local'),
		upper('trg_ldc_val_confing_tt_local')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudieron actualizar los registros de ldc_pkvalida_tt_local y trg_ldc_val_confing_tt_local en master_personalizaciones, '||sqlerrm);
END;
/    