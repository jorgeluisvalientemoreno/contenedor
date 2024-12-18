BEGIN
	-- OSF-3450
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN
    (   
        'LDC_TRGNOTITERMPROC',
        'LDC_TRGVALIPLESPCART',
        'LDC_TRGVALIPROCFACT',
        'LDC_TRGVALTERFIDF',
        'LDCTRG_BSS_SUCUBANC',
        'LDCTRGBUDI_OR_OUIB',
        'LDCTRGBUDI_OR_UIBM',
        'TRG_AIU_SUBSCRIBER_SMS',
        'TRG_BI_CARGTRAM',
        'LDC_TRGLEGCODAVENT', -- Ini papelera-reciclaje
        'LDC_TRGMARCAPEPROC',
        'LDC_TRGMARCAPERGECU',
        'LDC_TRGMARUSURETATT',
        'LDC_TRGMODFECHHORA',
        'LDC_TRGMODOBSSOLI',
        'LDC_TRGPRGEAUPRE',
        'LDC_TRGRCAESPCLIEN',
        'LDC_TRGSUBSIDIOS198',
        'LDC_TRGVALACERT',
        'LDC_TRGVALCAMCLNOFAC',
        'LDC_TRGVALCATEG',
        'LDC_TRGVALCOMLECT',
        'LDC_TRGVALDIR',
        'LDC_TRGVALIITEMRECU',
        'LDC_TRGVALITEMCOTI214',
        'LDC_TRGVALPAGCUDE',
        'LDC_TRGVALUSUSINMED',
        'LDC_TRGVPMELMESESU',
        'LDCTRG_INS_UPD_PR_COMP_SUSPENS',
        'LDCTRG_MO_PACK_REVISION',
        'LDCTRG_MO_PACK_SOL_FNB',
        'LDCTRGBUDI_GE_IS',
        'LDCTRGBUDI_GE_ITDO',
        'LDCTRGINSERTMATEQUI',
        'TGR_BU_VALIDA_MONTO_ACTA',
        'TGR_IA_OPERATING_UNIT',
        'TGR_LDC_CONF_ENGI_ACTI',
        'TGRAU_GE_CONTRATO',
        'TRG_ACT_ORDER_VALUE_ESTCOBUS',
        'TRG_AFTINS_CC_DEF_MOV_HIST',
        'TRG_AFTINS_TRCASESU',
        'TRG_AIUOR_ORDER_ACTIVITY',
        'TRG_AUD_OR_OPE_UNI_ITEM_BALA',
        'TRG_AUROR_OPE_UNI_ITEM_BALA',
        'TRG_BALA_MOV_VAL_DEL_SER',
        'TRG_BI_AB_SEGMENTS',
        'TRG_BI_BU_GE_CONTRATO_VPVT',
        'TRG_BI_CARGOS',
        'TRG_BI_CC_FINANCING_REQUEST' -- Fin papelera-reciclaje
    );



    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudieron actualizar los registros de ldc_pkvalida_tt_local y trg_ldc_val_confing_tt_local en master_personalizaciones, '||sqlerrm);
END;
/    