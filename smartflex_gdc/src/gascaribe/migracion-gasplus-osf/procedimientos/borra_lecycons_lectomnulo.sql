CREATE OR REPLACE PROCEDURE        "BORRA_LECYCONS_LECTOMNULO"
is
cursor cuconsesu
is
SELECT cosssesu,cosspefa
FROM   conssesu, (SELECT leemsesu,leempefa,leemcmss FROM lectelme a WHERE a.leemleto is null)
WHERE  cosssesu= leemsesu
AND    cosspefa=leempefa
AND    cosscmss =leemcmss
AND    cosscoca =0 ;

nuLogError NUMBER;
begin
	PKLOG_MIGRACION.prInsLogMigra (266,266,1,'BORRA_LECYCONS_LECTOMNULO',0,0,'Inicia Proceso','INICIO',nuLogError);
    for r in cuconsesu
    loop
        delete from conssesu where cosssesu=r.cosssesu and  cosspefa = r.cosspefa;
        delete from lectelme where leemsesu=r.cosssesu and  leempefa = r.cosspefa ;
        commit;
    end Loop;
	PKLOG_MIGRACION.prInsLogMigra (266,266,3,'BORRA_LECYCONS_LECTOMNULO',0,0,'Termina Proceso','FIN',nuLogError);

END Borra_LecyCons_lectomnulo;
/
