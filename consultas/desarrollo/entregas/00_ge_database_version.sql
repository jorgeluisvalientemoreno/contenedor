INSERT INTO ge_database_version
    (VERSION_ID,
     VERSION_NAME,
     INSTALL_INIT_DATE)
VALUES
    (seq_ge_database_version.nextval,
     'OSS_HT_0000796_V3',
     SYSDATE)
/
commit
/
