CREATE TABLE OPEN.LDCBI_LDCI_SERIDMIT (
    SERIMMIT        NUMBER(9)   NOT NULL,
    SERIDMIT        NUMBER(9)   NOT NULL,
    SERICODI        NUMBER(9)   NOT NULL,
    OPERATION       VARCHAR2(3) NOT NULL,
    CREATED_DATE    DATE        DEFAULT SYSDATE,
    PROCESS_STATUS  NUMBER(3)   DEFAULT -1
);

-- Create/Recreate indexes
CREATE INDEX IDX_LDCBI_LDCI_SERIDMIT ON OPEN.LDCBI_LDCI_SERIDMIT (PROCESS_STATUS, CREATED_DATE);
CREATE INDEX IDX_LDCBI_LDCI_SERIDMIT_PRST ON OPEN.LDCBI_LDCI_SERIDMIT (PROCESS_STATUS);

-- Grant/Revoke object privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_LDCI_SERIDMIT TO INNOVACIONBI;
GRANT SELECT, INSERT, UPDATE, DELETE ON OPEN.LDCBI_LDCI_SERIDMIT TO INNOVACION;