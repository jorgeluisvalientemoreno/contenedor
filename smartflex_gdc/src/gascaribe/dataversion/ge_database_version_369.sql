insert into ge_database_version  (VERSION_ID,VERSION_NAME,INSTALL_INIT_DATE,INSTALL_END_DATE)
                          values (seq_ge_database_version.nextval,'OSS_JV_OSF-369_2',sysdate,sysdate);
COMMIT;
/