
  CREATE OR REPLACE PROCEDURE "OPEN"."AJUSTES_DE_CARGOS_CONSUMOS" (INI NUMBER,FIN NUMBER)
AS

CURSOR cucargos
is
SELECT rowid,cargpefa,cargdoso
FROM cargos
WHERE cargdoso like 'AJ-%' AND cargconc=31
AND CARGNUSE>=INI AND CARGNUSE<FIN;

CURSOR cuperifact(nuperifact number)
IS
  SELECT pefaano, pefames,pefacicl
  FROM perifact
  WHERE pefacodi=nuperifact;

CURSOR cupefacodianterior(nupefaano number,nupefames number,nupefacicl number)
IS
  SELECT pefacodi
  FROM perifact
  WHERE pefames=nupefames
  AND   pefaano=nupefaano
  AND   pefacicl=nupefacicl;

 nupefaano number;
 nupefames number;
 nupefacicl number;
 sbmesanterior varchar2(2000);
 numesanterior number;
 nupefacodianterior number;
 nuanoanterior number;
 nuLogError NUMBER;
BEGIN

PKLOG_MIGRACION.prInsLogMigra (6511,6511,1,'AJUSTES_DE_CARGOS_CONSUMOS',0,0,'Inicia Proceso','INICIO',nuLogError);

    for r in  cucargos
    loop

            open  cuperifact(r.cargpefa);
            fetch  cuperifact INTO nupefaano, nupefames,nupefacicl;
            close  cuperifact;

            sbmesanterior:= ut_string.fsbsubstr(r.cargdoso,ut_string.fsbinstr(r.cargdoso,':',1,1)+1,ut_string.fnulength( r.cargdoso));

            begin
                  numesanterior:= to_number(sbmesanterior);

                  if   numesanterior>nupefames then
                        nuanoanterior:= nupefaano-1;
                  else
                        nuanoanterior:= nupefaano;
                  END if;

                  open   cupefacodianterior(nuanoanterior,numesanterior,nupefacicl);
                  fetch  cupefacodianterior INTO nupefacodianterior;
                  close  cupefacodianterior;

                  if nupefacodianterior is not null then
                       UPDATE cargos SET cargpeco= nupefacodianterior WHERE cargos.rowid=r.rowid;
                       commit;
                  end if;

            exception
                when others then
                  PKLOG_MIGRACION.prInsLogMigra (6511,6511,2,'AJUSTES_DE_CARGOS_CONSUMOS',0,0,'Mes Anterior ['||numesanterior||'] Error: '||SQLERRM,to_char(sqlcode),nuLogError);
            end;


    END loop;

PKLOG_MIGRACION.prInsLogMigra (6511,6511,1,'AJUSTES_DE_CARGOS_CONSUMOS',0,0,'Finaliza Proceso','INICIO',nuLogError);

END;
/
