CREATE OR REPLACE procedure CREA_INDEX(inuindexname varchar2) as
  JobNo   user_jobs.job%TYPE;
  WHAT    VARCHAR2(1000);
  dtFecha date;
begin
  update migra.trackpostcargos
     set estado = 'P'
   where indexname = inuindexname;

  if (inuindexname = 'IX_CARGOS010') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
            (CARGDOSO)
         nologging
         TABLESPACE TSI_CARGOS
         PCTFREE    5
         INITRANS   2
         MAXTRANS   255
         STORAGE    ( INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT )
          parallel';
    EXECUTE IMMEDIATE WHAT;
  
  end if;

  if (inuindexname = 'IX_CARG_CODO') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
         (CARGCODO, CARGSIGN)
          nologging
          TABLESPACE TSI_CARGOS
          PCTFREE    10
          INITRANS   2
          MAXTRANS   255
          STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
          parallel';
    execute immediate WHAT;
  end if;

  if (inuindexname = 'IX_CARG_CUCO_CONC') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGCUCO, CARGCONC, CARGSIGN)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARG_NUSE_CUCO_CONC') then
    WHAT := '
  CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGNUSE, CARGCUCO, CARGCONC)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS01') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGSIGN)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS02') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGCUCO)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS03') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGCONC)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS04') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGNUSE)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS05') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGCACA)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS06') then
    WHAT := 'CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
  (CARGPEFA)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS07') then
    WHAT := ' CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
 (CARGPROG)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  if (inuindexname = 'IX_CARGOS08') then
    WHAT := '
  CREATE INDEX OPEN.' || inuindexname || ' ON OPEN.CARGOS
(CARGUSUA)
nologging
TABLESPACE TSI_CARGOS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
parallel';
  
    EXECUTE IMMEDIATE WHAT;
  end if;

  --------------------------------------------------
  if (inuindexname = 'IX_CONSSESU06') then
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU06 ON OPEN.CONSSESU (TRUNC("COSSFERE"), COSSSESU) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT )PARALLEL';
    execute immediate WHAT;
  end if;

  if (inuindexname = 'IX_CONSSESU01') then
    WHAT := ' CREATE INDEX OPEN.IX_CONSSESU01 ON OPEN.CONSSESU (COSSPEFA) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    10 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K             NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  end if;
  if (inuindexname = 'IX_CONSSESU03') then
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU03 ON OPEN.CONSSESU(COSSSESU, COSSPECS, COSSTCON, COSSMECC)LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    5 INITRANS   2MAXTRANS   255STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  END IF;

  if (inuindexname = 'IX_CONSSESU04') then
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU04 ON OPEN.CONSSESU(COSSPECS, COSSCAVC) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    5 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K             NEXT             8K             MINEXTENTS       1             MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  END IF;

  if (inuindexname = 'IX_CONSSESU05') then
    WHAT := ' CREATE INDEX OPEN.IX_CONSSESU05 ON OPEN.CONSSESU (COSSCONS) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    5 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K             NEXT             8K             MINEXTENTS       1             MAXEXTENTS       UNLIMITED             PCTINCREASE      0             FREELISTS        1             FREELIST GROUPS  1             BUFFER_POOL      DEFAULT           ) PARALLEL';
    execute immediate WHAT;
  END IF;

  if (inuindexname = 'IX_COSS_ELME') then
  
    WHAT := 'CREATE INDEX OPEN.IX_COSS_ELME ON OPEN.CONSSESU (COSSELME, COSSMECC, COSSTCON, COSSPEFA) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    10 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  END IF;

  if (inuindexname = 'IX_COSS_SESU') then
  
    WHAT := 'CREATE INDEX OPEN.IX_COSS_SESU ON OPEN.CONSSESU (COSSSESU, COSSMECC, COSSTCON, COSSPEFA)LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    10INITRANS   2MAXTRANS   255STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_COSS_SESU_PEFA') then
    WHAT := 'CREATE INDEX OPEN.IX_COSS_SESU_PEFA ON OPEN.CONSSESU (COSSSESU, COSSPEFA) LOGGING TABLESPACE TSI_CONS_LECT PCTFREE    10 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K            NEXT             8K             MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU13') then
    WHAT := ' CREATE INDEX OPEN.IX_CONSSESU13 ON OPEN.CONSSESU (COSSFCCO) LOGGING TABLESPACE TSI_BASICA PCTFREE    5 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1           FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU02') then
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU02 ON OPEN.CONSSESU (COSSPECS, COSSSESU, COSSTCON, COSSMECC)LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU07') then
  
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU07 ON OPEN.CONSSESU (COSSCAVC) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU08') then
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU08 ON OPEN.CONSSESU(COSSFUNC) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K             NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  END IF;

  if (inuindexname = 'IX_CONSSESU09') then
  
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU09 ON OPEN.CONSSESU (COSSSESU) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU10') then
  
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU10 ON OPEN.CONSSESU (COSSELME) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (             INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           )PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU11') then
  
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU11 ON OPEN.CONSSESU (COSSMECC) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           ) PARALLEL';
    execute immediate WHAT;
  
  END IF;

  if (inuindexname = 'IX_CONSSESU12') then
  
    WHAT := 'CREATE INDEX OPEN.IX_CONSSESU12 ON OPEN.CONSSESU (COSSTCON) LOGGING TABLESPACE TSI_BASICA PCTFREE    0 INITRANS   2 MAXTRANS   255 STORAGE    (            INITIAL          16K            NEXT             8K            MINEXTENTS       1            MAXEXTENTS       UNLIMITED            PCTINCREASE      0            FREELISTS        1            FREELIST GROUPS  1            BUFFER_POOL      DEFAULT           ) PARALLEL';
    execute immediate WHAT;
  
  END IF;
  --------------------------------------------

  update migra.trackpostcargos
     set estado = 'T'
   where indexname = inuindexname;

  update migra.trackpostconsesu
     set estado = 'T'
   where indexname = inuindexname;
  commit;

end; 
/
