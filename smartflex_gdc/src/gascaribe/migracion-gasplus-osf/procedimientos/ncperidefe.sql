CREATE OR REPLACE procedure ncperidefe
is

    CURSOR cuperidefe
    IS
        SELECT decode(a.basedato,1,a.difecodi,2,a.difecodi+10000000) difecodi, decode(a.basedato,1,a.difenuse,2,a.difenuse+1000000) difenuse,difesusc,difefech,difefecr, difenudo, difeinte,difenucu,difevacu,difecupa,difesape, difedepa,difeloca,basedato
        FROM LDC_TEMP_DIFERIDO_PG a;
        /*WHERE not exists ( SELECT  1
                  FROM cc_grace_peri_defe
                  WHERE deferred_id = decode(basedato,1,difecodi,2,difecodi+10000000)
                  AND Grace_period_id = 3
                  ); */
                  
    CURSOR cuServicio(nuNuse number)
    IS
        SELECT *
        FROM servsusc
        WHERE sesunuse = nuNuse;
        
    rgServicio    cuServicio%rowtype;
    
    CURSOR cuPeriodo(nuCicl number)
    IS
        SELECT *
        FROM perifact
        WHERE pefaano = 2014
        AND pefames = 2
        AND pefacicl = nuCicl;

    rgPeriodo    cuPeriodo%rowtype;
    
    CURSOR cuPeriodoGracia(nuDiferido number)
    IS
        SELECT *
        FROM CC_GRACE_PERI_DEFE
        WHERE deferred_id = nuDiferido
        AND Grace_period_id = 3
        AND program = -1
        AND person_id = 4104;
        
    rgPeriodoGracia  cuPeriodoGracia%rowtype;

    nuLogError number;
    dtFecha    date;

begin

    for r in cuperidefe loop
      BEGIN

          open cuServicio(r.difenuse);
          fetch cuServicio INTO rgServicio;
          close cuServicio;
          
          open cuPeriodo(rgServicio.SESUCICL);
          fetch cuPeriodo INTO rgPeriodo;
          close cuPeriodo;

          rgPeriodoGracia.Grace_peri_defe_id := null;
          
          open cuPeriodoGracia(r.difecodi);
          fetch cuPeriodoGracia INTO rgPeriodoGracia;
          close cuPeriodoGracia;
          
          dtFecha := rgPeriodo.PEFAFFMO;

          -- Si la fecha es menor, se deja la fecha del diferido
          if rgPeriodo.PEFAFFMO < r.difefech then
              dtFecha := r.difefech;
          END if;


          if rgPeriodoGracia.Grace_peri_defe_id IS null then
              insert into
                CC_GRACE_PERI_DEFE
                (Grace_peri_defe_id, Grace_period_id, Deferred_id, initial_date,end_date,program,person_id)
                values(seq_cc_grace_peri_d_185489.nextval,3,r.difecodi,r.difefecr, dtFecha, -1,4104);
                commit;
          else
              UPDATE CC_GRACE_PERI_DEFE
                SET end_date = dtFecha
              WHERE Grace_peri_defe_id = rgPeriodoGracia.Grace_peri_defe_id;
              commit;
          
          END if;
             -- commit;
      EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            --PKLOG_MIGRACION.prInsLogMigra (1090,1090,2,'CREA TABLA',0,0,'Error: diferido: '||r.difecodi||' BD: '||r.basedato||sqlerrm,to_char(sqlcode),nuLogError);
      END;
    end loop;

    commit;

exception
when others then
rollback;

end;
/
