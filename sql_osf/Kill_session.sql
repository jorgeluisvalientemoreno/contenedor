BEGIN
  FOR r IN (select sid, serial#
              from v$session
             where username = 'OPEN'
               and module = 'EXECUTOR_PROCESS') LOOP
    dbms_output.put_line('EXECUTE IMMEDIATE ''alter system kill session ''''' ||
                         r.sid || ',' || r.serial# || ''''''';');
  END LOOP;
END;
/
