CREATE TABLE OPEN.LDCBI_PR_TIMEOUT_COMPONENT (
    TIMEOUT_COMPONENT_ID  NUMBER(15)  NOT NULL,
    OPERATION             VARCHAR2(1) NOT NULL,
    PROCESS_STATUS        NUMBER(3) DEFAULT -1,
    CREATED_DATE          DATE      DEFAULT SYSDATE
);

-- Create/Recreate indexes
CREATE INDEX IDX_LDCBI_PR_TIMEOUT_COMPONENT ON OPEN.LDCBI_PR_TIMEOUT_COMPONENT (PROCESS_STATUS, CREATED_DATE);
CREATE INDEX IDX_PR_TIMEOUT_COMPONENT_PRST ON OPEN.LDCBI_PR_TIMEOUT_COMPONENT (PROCESS_STATUS);

-- Grant/Revoke object privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PR_TIMEOUT_COMPONENT TO INNOVACIONBI;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PR_TIMEOUT_COMPONENT TO INNOVACION;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_PR_TIMEOUT_COMPONENT TO DATAOPS;