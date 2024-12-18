begin
  execute immediate 'create or replace synonym personalizaciones.pkg_utilidades for adm_person.pkg_utilidades';
  execute immediate 'create or replace synonym innovacion.pkg_utilidades for adm_person.pkg_utilidades';
  execute immediate 'create or replace synonym open.pkg_utilidades for adm_person.pkg_utilidades';  
end;
/