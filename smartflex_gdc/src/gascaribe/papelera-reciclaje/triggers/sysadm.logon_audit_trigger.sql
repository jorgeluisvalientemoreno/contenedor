CREATE OR REPLACE TRIGGER SYSADM.LOGON_AUDIT_TRIGGER AFTER LOGON ON DATABASE
  BEGIN
    IF ( USER = 'ROBEBR' OR USER ='SYSADM') THEN
      INSERT
      INTO AUDIT_LOGON VALUES
        (
          USER,
          SYS_CONTEXT('USERENV','OS_USER'),
          SYS_CONTEXT('USERENV','HOST'),
          NULL,
          NULL,
          NULL,
          SYSDATE,
          TO_CHAR(SYSDATE, 'HH24:MI:SS'),
          NULL,
          NULL,
          NULL,
          SYS_CONTEXT('USERENV','SESSIONID')
        );
    ELSE
      NULL;
    END IF;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  END;
  
/
