Rol:
create role ROLE_PERSONALIZACIONES IDENTIFIED BY 123456789; -- Cambiar contraseña si se va a aplicar en prod
-- Crear rol ROLE_PERSONALIZACIONES_<APLICACION>
create role ROLE_PERSONALIZACIONES_LEGO;
-- Otorgar permisos de <APLICACION> al rol ROLE_PERSONALIZACIONES_<APLICACION>
-- Otorgar permisos de LEGO al rol ROLE_PERSONALIZACIONES_LEGO.
grant execute on "OPEN".LDC_PKGESTIONORDENES TO ROLE_PERSONALIZACIONES_LEGO;
-- Otorgar el rol ROLE_PERSONALIZACIONES_<APLICACION> al rol ROLE_PERSONALIZACIONES
GRANT ROLE_PERSONALIZACIONES_LEGO TO ROLE_PERSONALIZACIONES;
Usuario:
-- Importante: NO OTORGAR NINGÚN ROL AL USUARIO PROXYPERSON
create user PROXYPERSON identified by Gases321; -- Cambiar contraseña si se va a aplicar en prod
grant create session to PROXYPERSON;
-- Otorgar CONNECT THROUGH a cada usuario que se requiera
alter user diasal grant connect through PROXYPERSON;
-- Otorgar rol ROLE_PERSONALIZACIONES a cada usuario del sistema
grant ROLE_PERSONALIZACIONES to diasal;