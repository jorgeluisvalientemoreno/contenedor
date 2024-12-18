CREATE OR REPLACE procedure CREATE_GRACE_PERIOD (Numinicio number, Numfinal number, inubasedato number) as

cursor cudiferidos
is
select difecodi,difefein,difefecr
from  ldc_temp_diferido_sge
WHERE difefein>difefecr
AND   basedato= inubasedato;

   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;

nugrace_period_id number:=18;
nuLogError NUMBER;
begin 


UPDATE  MIGRA.MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=270;

   pkg_constantes.COMPLEMENTO(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   PKLOG_MIGRACION.prInsLogMigra (270,270,1,'CREATE_GRACE_PERIOD',0,0,'Inicia Proceso','INICIO',nuLogError);
if inubasedato in (1,2,3) then
    nugrace_period_id:=18;
end if;

if inubasedato =4 then
    nugrace_period_id:=16;
end if;

if inubasedato=5 then
    nugrace_period_id:=19;
end if;

    for r in cudiferidos loop
    begin
        
		insert into
		CC_GRACE_PERI_DEFE
		(Grace_peri_defe_id, Grace_period_id, Deferred_id, initial_date,end_date,program,person_id)
		values(seq_cc_grace_peri_d_185489.nextval,nugrace_period_id,r.difecodi+nuComplementoDI,r.difefecr, r.difefein,161,4125);
		commit;
	EXCEPTION
       WHEN OTHERS THEN
           PKLOG_MIGRACION.prInsLogMigra (270,270,2,'CREATE_GRACE_PERIOD',0,0,'Error en diferido '||r.difecodi||' - '||SQLERRM,to_char(sqlcode),nuLogError);
	end;
    end loop;

    UPDATE  MIGRA.MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=270;
	PKLOG_MIGRACION.prInsLogMigra (270,270,3,'CREATE_GRACE_PERIOD',0,0,'Termina Proceso','FIN',nuLogError);
end; 
/
