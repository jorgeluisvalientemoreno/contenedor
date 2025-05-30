CREATE TABLE OPEN.LDCBI_PAGARE (
    PAGACODI       NUMBER(15)  NOT NULL,
    OPERATION      VARCHAR2(1) NOT NULL,
    PROCESS_STATUS NUMBER(3) DEFAULT -1,
    CREATED_DATE   DATE      DEFAULT SYSDATE
);
-- Create/Recreate indexes

CREATE INDEX OPEN.IDX_LDCBI_PAGARE ON OPEN.LDCBI_PAGARE (PROCESS_STATUS, CREATED_DATE) TABLESPACE TSI_DEFAULT;
CREATE INDEX OPEN.IDX_PAGARE ON OPEN.LDCBI_PAGARE (PROCESS_STATUS) TABLESPACE TSI_DEFAULT;

-- Grant/Revoke object privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PAGARE TO INNOVACIONBI;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PAGARE TO INNOVACION;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PAGARE TO DATAOPS;
