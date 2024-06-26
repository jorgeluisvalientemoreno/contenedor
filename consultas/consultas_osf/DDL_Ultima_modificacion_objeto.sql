SELECT *
  FROM SYSADM.DDL_LOG
 where OBJECT_NAME = upper('ED_CONFEXME')
   and DDL_DATE > '01/01/2021'
 order by DDL_DATE desc;
