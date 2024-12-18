begin
insert into ge_database_version
  (VERSION_ID, VERSION_NAME, INSTALL_INIT_DATE, INSTALL_END_DATE)
values
  (seq_ge_database_version.nextval, 'ENTREGA EJEMPLO OSF-0', sysdate, sysdate);
end;
/