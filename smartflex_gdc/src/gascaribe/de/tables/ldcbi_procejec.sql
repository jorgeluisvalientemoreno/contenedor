CREATE TABLE OPEN.LDCBI_PROCEJEC (
    PREJIDPR       NUMBER(10)  NOT NULL,
    OPERATION      VARCHAR2(1) NOT NULL,
    PROCESS_STATUS NUMBER(3) DEFAULT -1,
    CREATED_DATE   DATE      DEFAULT SYSDATE
);

-- Create/Recreate indexes
CREATE INDEX IDX_LDCBI_PROCEJEC ON OPEN.LDCBI_PROCEJEC (PROCESS_STATUS, CREATED_DATE);
CREATE INDEX IDX_LDCBI_PROCEJEC_PRST ON OPEN.LDCBI_PROCEJEC (PROCESS_STATUS);

-- Grant/Revoke object privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PROCEJEC TO INNOVACIONBI;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PROCEJEC TO INNOVACION;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PROCEJEC TO DATAOPS;