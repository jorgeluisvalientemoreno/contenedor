CREATE OR REPLACE PROCEDURE borra_espacios_dir
is

CURSOR cuvacio
is
SELECT * FROM ab_address WHERE address_parsed like ' %';

 Verror                 Varchar2 (4000);
    Sbdocumento            Varchar2(30) := Null;
    nuDocumento            number(15);
    nuLog                  number;
    nuIndex                numbeR;
    nuestate_number        NUMBER;
    nuProceso   number := 6500;
    nuLogError number;
    nuLogErrorPro number;

BEGIN

    PKLOG_MIGRACION.prInsLogMigra (6601,6601,1,'Borra_Espacios_dir',0,0,'Inicia Proceso','INICIO',nuLogError);

    for r in cuvacio
    loop

        UPDATE ab_address SET address= ltrim(r.address), address_parsed=ltrim(r.address_parsed) WHERE address_id =r.address_id;
        commit;
    END loop;

    PKLOG_MIGRACION.prInsLogMigra (6601,6601,2,'Borra_Espacios_dir',0,0,'Finaliza Proceso','FIN',nuLogError);
END;
/
