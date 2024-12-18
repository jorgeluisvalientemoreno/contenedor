CREATE OR REPLACE PROCEDURE      PERICOSEMGR (NUMINICIO NUMBER,NUMFINAL NUMBER,pbd number) is
 /*******************************************************************
 PROGRAMA            :    PERICOSEMGR
 FECHA            :    16/05/2014
 AUTOR            :
 DESCRIPCION        :    LLena la tabla de perifact de OSF basado en los
                        perifact extraidos y acorde a la homologacion de
                        ciclos
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   maxnumber           number:=0;
   vfecha_ini          DATE;
   vfecha_fin          DATE;
   Vprograma           Varchar2 (100);
   verror              VARCHAR2 (2000);
   vcont               NUMBER;
   vcontIns            NUMBER;
   pe number;
    nuErrorCode       NUMBER;
   vcontLec            NUMBER;
   SBERRORMESSAGE    VARCHAR2 (4000);
   nuSecuencia        number;
   sbsql varchar2(800);
   blPeriodoValido     boolean:= FALSE;



    CURSOR cuperiodos
    is
    SELECT pefahomo PEFAHOMO,prfechaAnteriorperi(pafccicl, pafcano,pafcmes) pecsfeci, pafcfein pecsfecf,c.ciclhomo PECSCICO
    FROM
    migra.ldc_temp_planfaca_sge a, ldc_TEMP_perifact_sge b, ldc_mig_ciclo c, ldc_mig_perifact d
    WHERE b.pefacicl= a.pafccicl
    AND  b.pefaano= a.pafcano
    AND  b.pefames= a.pafcmes
    AND  d.codipefa =b.pefacodi
    AND  d.codicicl =b.pefacicl
     AND  d.codiano =b.pefaano
    AND  d.codimes= b.pefames
    AND  c.codicicl=a.pafccicl
    AND a.basedato=b.basedato
    AND c.database=a.basedato
    AND d.database =a.basedato
    AND a.basedato= pbd;



BEGIN
    update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=3695 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
    COMMIT;
    -- Borra log del proceso
    COMMIT;
    vprograma := 'perifactmigr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    -- LLENA LA TABLA DE LDC_MIG_PERIFACT
    -- Extraer Datos y cargarlos
    --nuContador := 2; --Se inicia en 2 porque el codigo 1 es un registro comodin
    for r in cuperiodos
    loop
        BEGIN
        if  r.pecsfeci IS not null
        then

            INSERT INTO pericose
            (pecscons,pecsfeci,pecsfecf,pecsproc,pecsuser, pecsterm,pecsprog,pecscico,pecsflav, pecsfeai,pecsfeaf)
            VALUES
            (r.pefahomo,trunc(r.pecsfeci),trunc(r.pecsfecf)+23.9998/24,'S','MIGARCION','MIGARCION','MIGARCION',r.pecscico ,'S',trunc(r.pecsfeci),trunc(r.pecsfecf)+23.9998/24 );
        else
            INSERT INTO pericose
            (pecscons,pecsfeci,pecsfecf,pecsproc,pecsuser, pecsterm,pecsprog,pecscico,pecsflav, pecsfeai,pecsfeaf)
            VALUES
            (r.pefahomo,trunc(r.pecsfecf-28),trunc(r.pecsfecf)+23.9998/24 ,'S','MIGARCION','MIGARCION','MIGARCION',r.pecscico ,'S',(r.pecsfecf-28),trunc(r.pecsfecf)+23.9998/24 );
        END if;

        commit;
        
       EXCEPTION
           when others then
           rollback;
       END;
    END LOOP;
        -- Borrar tablas     tbl_datos.

   -- Actualizar Secuencia.
   execute immediate 'drop sequence OPEN.SQ_PERICOSE_PECSCONS';
   SELECT max(PECSCONS) + 1 INTO maxnumber FROM PERICOSE;
   execute immediate '
      CREATE SEQUENCE OPEN.SQ_PERICOSE_PECSCONS
      START WITH '||maxnumber||'
      MAXVALUE 9999999999999999999999999999
      MINVALUE 1
      NOCYCLE
      CACHE 20
      ORDER';

   UPDATE migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=3695 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   COMMIT;

  END PERICOSEMGR; 
/
