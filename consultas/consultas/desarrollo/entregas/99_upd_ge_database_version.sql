/*****************************************************************
Propiedad intelectual de PETI (c).

Unidad          :   ge_database_version.sql
Descripcion     :   Scripts para actualizar la versión de la entrega

******************************************************************/
update  ge_database_version
set     INSTALL_END_DATE = SYSDATE
WHERE   VERSION_NAME = 'OSS_REVSEG_DSS_0000819_1'
  and   INSTALL_END_DATE is null;
/
commit
/
