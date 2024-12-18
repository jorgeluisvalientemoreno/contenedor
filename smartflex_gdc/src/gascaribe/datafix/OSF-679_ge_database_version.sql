declare

  cursor cuge_database_version is
    select count(1)
      from open.ge_database_version a
     where a.version_name = 'CRM_JV_OSF-679';

  nuCantidad number;

begin

  open cuge_database_version;
  fetch cuge_database_version
    into nuCantidad;
  close cuge_database_version;

  if nvl(nuCantidad, 0) = 0 then
    insert into ge_database_version
      (VERSION_ID, VERSION_NAME, INSTALL_INIT_DATE, INSTALL_END_DATE)
    values
      (seq_ge_database_version.nextval, 'CRM_JV_OSF-679', sysdate, sysdate);
    COMMIT;
  
    dbms_output.put_line('Se regitra entrega CRM_JV_OSF-679');
  
  else
    update ge_database_version
       set INSTALL_END_DATE = sysdate
     where version_name = 'CRM_JV_OSF-679';
    COMMIT;
    dbms_output.put_line('Se actualiza fecha final (INSTALL_END_DATE) de registro de la entrega CRM_JV_OSF-679');
  end if;
exception
  when others then
    rollback;
    dbms_output.put_line('No se registro o actualizo DATA de la entrega CRM_JV_OSF-679');
  
end;
/
