BEGIN
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN
    (   
        upper('ldc_ab_boaddressparser'),
        upper('ldc_bomaterialrequest'),
        upper('ldc_bonotificaciones'),
        upper('ldc_pe_bcgestlist'),
        upper('ldc_pk_rep_ven'),
        upper('ldc_pktariconsfact'),
        upper('ldc_pkvalidasuspcone'),
        upper('ldc_uildc_fifcast'),
        upper('ldc_valida_order_redes'),
        upper('pe_bceconomicactivity'),
        upper('pe_bctasktypetax'),
        upper('pe_botasktypetax'),
        upper('pkg_ldc_items_audit'),
        upper('pkg_ldc_ordenes_ofert_red'),
        upper('pkld_fa_bcdescprpago'),
        upper('pkld_fa_bcdiscountapplication'),
        upper('pkld_fa_bclogprocdescref'),
        upper('pkld_fa_bcodedetadesc'),
        upper('pkld_fa_boregistrardescuento'),
        upper('pkld_fa_bsapplicationpddn'),
        upper('pkld_fa_concrefe'),
        upper('pkld_fa_critrefe'),
        upper('pkld_fa_ubgerefe'),
        upper('pkld_fa_validarcontrato')
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/    