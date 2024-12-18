create table OPEN.LDCBI_CARGTRAM
(
    CATRCONS       NUMBER(15)  not null,
    OPERATION      VARCHAR2(1) not null,
    PROCESS_STATUS NUMBER(3) default -1,
    CREATED_DATE   DATE      default SYSDATE
)
/

create index IDX_LDCBI_CARGTRAM on OPEN.LDCBI_CARGTRAM (PROCESS_STATUS, OPERATION);
create index IDX_LDCBI_CARGTRAM_PRST on OPEN.LDCBI_CARGTRAM (PROCESS_STATUS);

grant select, insert, update, delete on OPEN.LDCBI_CARGTRAM to INNOVACIONBI;
grant select, insert, update, delete on OPEN.LDCBI_CARGTRAM to INNOVACION;