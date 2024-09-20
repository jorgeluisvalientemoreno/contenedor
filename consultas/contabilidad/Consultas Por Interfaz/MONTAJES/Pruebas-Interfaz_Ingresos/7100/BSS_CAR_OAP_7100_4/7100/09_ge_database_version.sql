  /*****************************************************************
    Propiedad intelectual de PETI (c).
  
    Unidad         : ge_database_version.sql
    Descripcion : Scripts para actualizar las plantillas xsl de la entrega 118
    Autor            :   Luis Arturo Diuza C
    Fecha            :  29/12/2014

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
insert into ge_database_version  (VERSION_ID,VERSION_NAME,INSTALL_INIT_DATE,INSTALL_END_DATE)
                          values (seq_ge_database_version.nextval,'BSS_CAR_OAP_7100_4',sysdate,sysdate);
						  
commit;						  
