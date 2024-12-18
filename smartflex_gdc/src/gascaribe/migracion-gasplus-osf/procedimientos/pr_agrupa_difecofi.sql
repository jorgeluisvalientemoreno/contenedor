CREATE OR REPLACE procedure PR_AGRUPA_DIFECOFI(NUMINICIO number, NUMFINAL number,inubasedato number) is

cursor cuNuse is
select distinct difenuse
from diferido;

cursor cuDiferido (nuNuse in diferido.difenuse%type) is
select distinct difenuse, difepldi, difemeca, difetain,
       difeusua, difeprog, trunc(difefein,'HH') difefein
from diferido
where difenuse = nuNuse;

nudifecofi number;
nuLogError NUMBER;

begin
  
  -- Actualiza el programa de diferido de re financiacion
  update diferido
  set difeprog = 'GCNED'
  where difeprog = 'FFDC';
  
  commit;

 UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=279;
    commit;
	PKLOG_MIGRACION.prInsLogMigra (279,279,1,'PR_AGRUPA_DIFECOFI',0,0,'Inicia Proceso','INICIO',nuLogError);
  for rtNuse in cuNuse loop
  
      for rtDife in cuDiferido (rtNuse.difenuse) loop
      
          nudifecofi := sq_deferred_difecofi.nextval; 
          
          
          update diferido
          set difecofi = nudifecofi
          where difenuse = rtDife.difenuse
          and   difepldi = rtDife.difepldi 
          and   difemeca = rtDife.difemeca 
          and   difetain = rtDife.difetain
          and   difeusua = rtDife.difeusua
          and   difeprog = rtDife.difeprog
          and   trunc(difefein,'HH') = rtDife.difefein;
          
          commit;
      
      end loop;
   end loop;

 UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=279;
    commit;
   PKLOG_MIGRACION.prInsLogMigra (279,279,3,'PR_AGRUPA_DIFECOFI',0,0,'Termina Proceso','FIN',nuLogError);
end PR_AGRUPA_DIFECOFI; 
/
