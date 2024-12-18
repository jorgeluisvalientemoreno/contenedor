CREATE OR REPLACE PROCEDURE FIX_CARGDOSO (numinicio number,numfinal number,pbd number)
IS

nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   
CURSOR cudiferidos
is
SELECT  /*+ parallel index( a ldc_temp_diferido_pk_sge) */   
        A.DIFECODI+nuComplementoDI        DIFECODI,
        a.DIFENUSE+nuComplementoPR        DIFENUSE
        FROM LDC_TEMP_DIFERIDO_SGE a, diferido b
     WHERE A.BASEDATO = pbd
        AND A.DIFESUSC >= NUMINICIO
        AND A.DIFESUSC <  NUMFINAL
        AND b.difecodi=A.DIFECODI+nuComplementoDI;
        
ndiferido number;
nuLogError NUMBER;
van number;
BEGIN
     PKLOG_MIGRACION.prInsLogMigra (282,282,1,'FIX_CARGDOSO',0,0,'Inicia Proceso','INICIO',nuLogError);

     if pbd in (2,3) then
        UPDATE migr_rango_procesos set raprfeIN=sysdate,raprterm='P' where raprcodi=282 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;  
        commit;

        pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
        van:=0;

        for r in cudiferidos loop
            ndiferido:=r.difecodi-nuComplementoDI;

            update /*+ INDEX (CARGOS IX_CARGOS010)*/ cargos
                   set cargdoso='DF-'||r.difecodi
                   where cargdoso='DF-'||ndiferido AND CARGNUSE=R.DIFENUSE;

            UPDATE /*+ INDEX (CARGOS IX_CARGOS010)*/ CARGOS SET CARGDOSO='ID-'||r.difecodi
                   where cargdoso='ID-'||ndiferido AND CARGNUSE=R.DIFENUSE;

            van:=van+1;
            if van=1000 then
               commit;
               van:=0;
            end if;
        END loop;
     end if;
     
     PKLOG_MIGRACION.prInsLogMigra (282,282,3,'FIX_CARGDOSO',0,0,'Fin Proceso','FIN',nuLogError);
     UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=282 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;  
END; 
/
