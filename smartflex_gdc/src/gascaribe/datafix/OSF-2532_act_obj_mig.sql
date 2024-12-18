BEGIN
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'LDC_OS_INSERTFILEORDER'
                        ,'LDC_PCOMPRESSFILE'
                        ,'LDC_PLUVALCOOFER'
                        ,'LDC_PLUVALINSTVSI'
                        ,'LDC_PPROCINFOESTABLEC'
                        ,'LDC_PR_CANTLEGAITEMS'
                        ,'LDC_PR_VALIDA_ORDEN_30'
                        ,'LDC_PRABRIRACTACERRADA'
                        ,'LDC_PRACTUALIZACONDSATAB'
                        ,'LDC_PRACTUALIZAOTESDOC'
                        ,'LDC_PRBORRAMARCA'
                        ,'LDC_PRCAMBMEDIDORPREPAGO'
                        ,'LDC_PRCARGRECL'
                        ,'LDC_PRCCOBUNIFITEM'
                        ,'LDC_PRCDEVCAUSOTSPAG'
                        ,'LDC_PRCHANGEPLAN'
                        ,'LDC_PRCLIENTERECLAMO'
                    );
                    
    UPDATE master_personalizaciones
    SET comentario = 'CIERRE COMERCIAL'
    WHERE nombre IN (
                     'LDC_LLENADIFERIDOHILO'
                     ,'LDC_LLENADIFERIDOTEMP'
                     ,'LDC_LLENASESUCIER'
                    );

                    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/