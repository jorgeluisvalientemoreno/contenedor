BEGIN

    dbms_output.put_line('Actualizando registros en master_personalizaciones');
    
    UPDATE MASTER_PERSONALIZACIONES
    SET COMENTARIO = 'BORRADO'
    WHERE NOMBRE IN
    (
        upper('pr_2812'),
        upper('pr_2837'),
        upper('prdatafix635'),
        upper('prdatafix635_h1'),
        upper('prdatafix635_h10'),
        upper('prdatafix635_h2'),
        upper('prdatafix635_h3'),
        upper('prdatafix635_h4'),
        upper('prdatafix635_h5'),
        upper('prdatafix635_h6'),
        upper('prdatafix635_h7'),
        upper('prdatafix635_h8'),
        upper('prdatafix635_h9'),
        upper('prexeupdatebrujula'),
        upper('prupdatebrujula'),
        upper('so_gd_sao456560_p01_e01'),
        upper('so_gd_sao457493_p01_e01'),
        upper('so_gd_sao460769_p01_e01'),
        upper('so_gd_sao460769_p02_e01'),
        upper('so_gd_sao464794_p01_e02'),
        upper('so_gd_sao464794_p01_e03'),
        upper('so_gd_sao464794_p01_e04'),
        upper('so_gd_sao464794_p01_e05'),
        upper('so_gd_sao464794_p01_e06'),
        upper('so_gd_sao469244_p01_e01'),
        upper('so_gd_sao469837_p01_e01'),
        upper('so_gd_sao472531_p01_e01'),
        upper('so_gd_sao472531_p01_e02'),
        upper('so_gd_sao474383_p01_e02'),
        upper('so_gd_sao474383_p01_e03'),
        upper('so_gd_sao475308_p01_e01'),
        upper('so_gd_sao478465_p01_e01'),
        upper('so_gd_sao479674_p01_e01'),
        upper('so_gd_sao479674_p01_e02'),
        upper('so_gd_sao484879_p01_e01'),
        upper('so_gd_sao485226_p01_e01'),
        upper('so_gd_sao487346_p01_e01'),
        upper('so_gd_sao488936_p01_e01'),
        upper('so_gd_sao496277_p01_e01'),
        upper('so_gd_sao505535_p01_e01'),
        upper('so_gd_sao512497_p01_e01'),
        upper('so_gd_sao547566_p01_e01'),
        upper('so_gdc_sao547566_p01_e03'),
        upper('so_gdc_sao548565_p01_e01'),
        upper('tmp_cambiar_instancia_negativo'),
        upper('tmp_practdiferido'),
        upper('trunc_ld_quota_by_subsc_temp'),
        upper('truncate_table_ldcbi')
    );
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/