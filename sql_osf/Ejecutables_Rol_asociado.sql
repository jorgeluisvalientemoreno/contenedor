select EX.EXECUTABLE_ID,
       EX.NAME,
       EX.DESCRIPTION,
       EX.LAST_DATE_EXECUTED,
       EX.TIMES_EXECUTED,
       x.role_id,
       X.DESCRIPTION DESC_ROL
  from open.sa_executable ex
  left join open.sa_role_executables rex
    on rex.executable_id = ex.executable_id
  left join open.sa_role x
    on rex.role_id = x.role_id
 /*where ex.name in ('RPSUI',
                   'LDC_PROCCARTCONCCIERRE',
                   'IENCO',
                   'DLRUSEX',
                   'CTCAN',
                   'RUTEROSCRM',
                   'LDCAC',
                   'LDCPA',
                   'LDCIREVCLACARTRO',
                   'LDCCT',
                   'ERARP',
                   'LDCPAA',
                   'LDRPLAM',
                   'LDC_LDRBTAF',
                   'LDCIPROVINGRERO',
                   'LDRIRBRI')*/

 order by EX.NAME, X.DESCRIPTION;
