-- Create table
create table OPEN.LDCBI_FA_APROMOFA
(
  APMOCONS	NUMBER(15) not null,
  OPERATION      		Varchar2(3) not null,
  CREATED_DATE   		DATE default SYSDATE,
  PROCESS_STATUS 		NUMBER(3) default -1
);
-- Create/Recreate indexes
create index OPEN.IDX_LDCBI_FA_APROMOFA on OPEN.LDCBI_FA_APROMOFA (PROCESS_STATUS, CREATED_DATE);
create index OPEN.IDX_LDCBI_FA_APROMOFA_PRST on OPEN.LDCBI_FA_APROMOFA (PROCESS_STATUS);
-- Grant/Revoke object privileges
grant select, insert, update, delete on OPEN.LDCBI_FA_APROMOFA to INNOVACIONBI;
