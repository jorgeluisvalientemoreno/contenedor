CREATE OR REPLACE TRIGGER SYSADM.LOGOFF_AUDIT_TRIGGER BEFORE LOGOFF ON DATABASE
  BEGIN
    IF ( USER = 'ROBEBR' OR USER ='SYSADM') THEN
      -- ***************************************************
      -- Actualiza la 真ltima acci真n ejecutada
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET LAST_ACTION =
        (SELECT ACTION
        FROM V$SESSION
        WHERE SYS_CONTEXT('USERENV','SESSIONID') = AUDSID
        )
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
      --***************************************************
      -- Actualiza el 真ltimo programa utilizado
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET LAST_PROGRAM =
        (SELECT PROGRAM
        FROM V$SESSION
        WHERE SYS_CONTEXT('USERENV','SESSIONID') = AUDSID
        )
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
      -- ***************************************************
      -- Actualiza el 真ltimo modulo utilizado
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET LAST_MODULE =
        (SELECT MODULE
        FROM V$SESSION
        WHERE SYS_CONTEXT('USERENV','SESSIONID') = AUDSID
        )
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
      -- ***************************************************
      -- Actualiza la fecha de logoff
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET LOGOFF_DAY                           = SYSDATE
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
      -- ***************************************************
      -- Actualiza la hora de logoff
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET LOGOFF_TIME                          = TO_CHAR(SYSDATE, 'HH24:MI:SS')
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
      -- ***************************************************
      -- Calcula la duracion de la conexion en minutos
      -- ***************************************************
      UPDATE AUDIT_LOGON
      SET ELAPSED_MINUTES                      = ROUND((LOGOFF_DAY - LOGON_DAY)*1440)
      WHERE SYS_CONTEXT('USERENV','SESSIONID') = SESSION_ID;
    ELSE
      NULL;
    END IF;
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    NULL;
  END;
/
