CREATE OR REPLACE procedure mig_crea_indices_cargos is
begin
execute immediate 'drop index IX_CARGOS010';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS010 ON OPEN.CARGOS (CARGDOSO) LOGGING
TABLESPACE TSI_CARGOS PCTFREE    5 INITRANS   2 MAXTRANS   255
STORAGE    (             INITIAL          16K             NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL';
execute immediate 'drop index ix_carg_codo';
execute immediate 'CREATE INDEX OPEN.IX_CARG_CODO ON OPEN.CARGOS
(CARGCODO, CARGSIGN)
LOGGING
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
NOPARALLEL';
execute immediate 'drop index ix_carg_cuco_conc';
execute immediate 'CREATE INDEX OPEN.IX_CARG_CUCO_CONC ON OPEN.CARGOS
(CARGCUCO, CARGCONC, CARGSIGN)
LOGGING
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
NOPARALLEL';
execute immediate 'drop index IX_CARG_NUSE_CUCO_CONC';
execute immediate 'CREATE INDEX OPEN.IX_CARG_NUSE_CUCO_CONC ON OPEN.CARGOS
(CARGNUSE, CARGCUCO, CARGCONC)
LOGGING
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
NOPARALLEL';
execute immediate 'drop index IX_CARGOS01';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS01 ON OPEN.CARGOS
(CARGSIGN)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos02';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS02 ON OPEN.CARGOS
(CARGCUCO)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos03';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS03 ON OPEN.CARGOS
(CARGCONC)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos04';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS04 ON OPEN.CARGOS
(CARGNUSE)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos05';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS05 ON OPEN.CARGOS
(CARGCACA)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos06';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS06 ON OPEN.CARGOS
(CARGPEFA)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos07';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS07 ON OPEN.CARGOS
(CARGPROG)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
execute immediate 'drop index ix_cargos08';
execute immediate 'CREATE INDEX OPEN.IX_CARGOS08 ON OPEN.CARGOS
(CARGUSUA)
LOGGING
TABLESPACE TSI_BASICA
PCTFREE    0
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
NOPARALLEL';
end;
/
