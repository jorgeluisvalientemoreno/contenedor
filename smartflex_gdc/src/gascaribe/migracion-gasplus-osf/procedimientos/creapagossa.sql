CREATE OR REPLACE procedure      CREAPAGOSSA (NUMINICIO number, numFinal number,inubasedato number)
As

cursor cusa
is
select /*+ index(cargos IX_CARG_CODO) */ *
from cargos
where cargsign='SA'
and cargcodo<>0
and exists (select /*+ index(pagos PK_PAGOS) */ 1 from pagos where pagocupo=cargcodo);

    nuLogError NUMBER;
    NUTOTALREGS NUMBER := 0;
    NUERRORES NUMBER := 0;
    NUCONECTION NUMBER :=0;
    vfecha_ini             DATE;
    vfecha_fin             DATE;
    vprograma              VARCHAR2 (100);
    vcont                  NUMBER := 0;
    vcontLec               NUMBER := 0;
    vcontIns               NUMBER := 0;
    Verror                 Varchar2 (4000);

begin
    VPROGRAMA := 'CREAPAGOSSA';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.PRINSLOGMIGRA (3800,3800,1,VPROGRAMA,0,0,'Inicia Proceso','INICIO',NULOGERROR);
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3800;
    commit;

    for r in cuSa
    loop

       begin

        insert /*+ APPEND*/ into cargos values (r.cargcuco,r.cargnuse,145,r.cargcaca,'PA',r.cargpefa,r.cargvalo,'PAGOCREADO',r.cargcodo,r.cargusua,'P',r.cargunid,r.cargfecr,161,r.cargcoll,r.cargpeco,r.cargtico,r.cargvabl,r.cargtaco);
        commit;

       exception
       when others then
        rollback;
       end;

    end loop;

     PKLOG_MIGRACION.PRINSLOGMIGRA ( 3800,3800,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
        UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=3800;
    commit;

       EXCEPTION
     WHEN OTHERS THEN
        BEGIN

           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 3800,3800,2,vprograma||vcontIns,0,0,' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

        END;
    
end; 
/
