CREATE OR REPLACE PROCEDURE fix_carg_polizs AS

    CURSOR cuPolizas
    IS
        SELECT *
        FROM ld_policy, diferido
        WHERE difecodi = deferred_policy_id
        AND DIFECUPA = 0;
        
    CURSOR cuCargos(nuNuse number, nuDif number)
    IS
        SELECT /*+ idnex(c  IX_CARGOS04 ) */ cargcuco
        FROM (SELECT c.cargcuco
              FROM cargos c
             WHERE c.cargnuse = nuNuse
             AND  REGEXP_INSTR(c.cargdoso, '(\W|^)' || nuDif || '(\W|$)') > 0
             ORDER BY c.cargfecr DESC)
        WHERE rownum = 1;
        
    rgCargo      cuCargos%rowtype;
    
    nuLogError number;

BEGIN

    for rgPoliza in cuPolizas loop
        BEGIN

            rgCargo.cargcuco := null;
            open cuCargos(rgPoliza.PRODUCT_ID,rgPoliza.DEFERRED_POLICY_ID);
            fetch cuCargos INTO rgCargo;
            close cuCargos;

            if rgCargo.cargcuco IS null then

                UPDATE cargos
                    SET cargdoso = 'DF-'||rgPoliza.DEFERRED_POLICY_ID
                    WHERE cargnuse = rgPoliza.PRODUCT_ID
                    AND (cargdoso = 'DIF-REN' OR cargdoso = 'DIF-LIB')
                    AND cargfecr = (SELECT max(c.cargfecr)
                                    FROM open.cargos c
                                    WHERE c.cargnuse = rgPoliza.PRODUCT_ID
                                    AND (c.cargdoso = 'DIF-REN' OR c.cargdoso = 'DIF-LIB'));

                commit;
            END if;
            
        EXCEPTION
            WHEN OTHERS THEN
            --dbms_output.put_Line('Excepcion final '||sqlerrm);
            PKLOG_MIGRACION.prInsLogMigra (1070,1070,2,'fix_carg_polizs',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
    END loop;

EXCEPTION
    WHEN OTHERS THEN
    --dbms_output.put_Line('Excepcion final '||sqlerrm);
    PKLOG_MIGRACION.prInsLogMigra (1070,1070,2,'fix_carg_polizs',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END;
/
