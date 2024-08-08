DECLARE

  isbObjeto  VARCHAR2(4000) := upper('LDC_EXCEP_COBRO_FACT');
  isbEsquema VARCHAR2(4000) := upper('open');

  CURSOR cuGetPermisos IS
    SELECT 'REVOKE  ' || PRIVILEGE || ' ON ' || TABLE_NAME || ' FROM ' ||
           GRANTEE cadena_sql
      FROM dba_tab_privs
     WHERE TABLE_NAME = UPPER(isbObjeto)
       AND GRANTEE = UPPER(isbEsquema);

  cursor cuGetSinonimos is
    select 'DROP SYNONYM ' || B.OWNER || '.' || B.OBJECT_NAME cadena_sql
      from dba_objects b
     where b.OBJECT_NAME = isbObjeto
       and B.OWNER not in (isbEsquema, 'GISPETI', 'INNOVACION')
     order by B.OBJECT_NAME;

  --sbExecuta varchar2(1) := 'S';
  sbExecuta varchar2(1) := 'N';
  --N No se ejecutar
  --S Si se ejecuta

BEGIN

  --/*Eliminar permisos
  FOR reg IN cuGetPermisos LOOP
    if sbExecuta = 'N' then
       dbms_output.put_line('execute immediate ' || reg.cadena_sql);
    else    
      execute immediate reg.cadena_sql;
      dbms_output.put_line('Se ejecuta ' || reg.cadena_sql);
    end if;
  END LOOP;
  --*/

  --/*Eliminar Sinonimos
  FOR reg IN cuGetSinonimos LOOP
    if sbExecuta = 'N' then
      dbms_output.put_line('execute immediate ' || reg.cadena_sql);
    else
      begin
        execute immediate reg.cadena_sql;
        dbms_output.put_line('Se ejecuta ' || reg.cadena_sql);
      exception
        when others then
          dbms_output.put_line('No se ejecuta ' || reg.cadena_sql ||
                               ' - Error: ' || sqlerrm);
      end;
    end if;
  END LOOP;
  --*/

END;
/*

declare
  isbObjeto varchar2(4000);
begin

  --isbObjeto := upper('ed_confexme');
  --isbObjeto := upper('ed_formato');
  --isbObjeto := upper('ge_boinstancecontrol');
  --isbObjeto := upper('id_bogeneralprinting');
  --isbObjeto := upper('pkbced_confexme');
  --isbObjeto := upper('pkbodataextractor');
  --isbObjeto := upper('pkboinsertmgr');
  --isbObjeto := upper('pktbled_confexme');
  --adm_person.pkg_utilidades.prEliminarSinonimos(isbObjeto,isbEsquema);
  begin
    adm_person.pkg_utilidades.prEliminarSinonimos(isbObjeto,
                                                  'PERSONALIZACIONES');
    dbms_output.put_line('Sinonimo del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema PERSONALIZACIONES');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

  begin
    adm_person.pkg_utilidades.prEliminarSinonimos(isbObjeto, 'ADM_PERSON');
    dbms_output.put_line('Sinonimo del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema ADM_PERSON');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

  begin
    adm_person.pkg_utilidades.prEliminarSinonimos(isbObjeto, 'INNOVACION');
    dbms_output.put_line('Sinonimo del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema INNOVACION');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

  --adm_person.pkg_utilidades.prEliminarPermisos(isbObjeto,isbEsquema);
  begin
    adm_person.pkg_utilidades.prEliminarPermisos(isbObjeto,
                                                 'PERSONALIZACIONES');
    dbms_output.put_line('Permiso del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema PERSONALIZACIONES');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

  begin
    adm_person.pkg_utilidades.prEliminarPermisos(isbObjeto, 'ADM_PERSON');
    dbms_output.put_line('Permiso del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema ADM_PERSON');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

  begin
    adm_person.pkg_utilidades.prEliminarPermisos(isbObjeto, 'INNOVACION');
    dbms_output.put_line('Permiso del objeto ' || isbObjeto ||
                         ' fue eliminado del esquema INNOVACION');
  exception
    when others then
      dbms_output.put_line('Error ' || sqlerrm);
  end;

end;
*/
