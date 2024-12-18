CREATE OR REPLACE TRIGGER SYSADM.AFTER_LOGON_TRIGGER
/**************************************************************************************
 .   Autor           : Gabriel Garcia Trujillo - Administrador de Base de Datos GDO   .
 .   Descripcion     : Trigger para Bloquear la ejecucion de Aplicativos restringidos .
 .                     en el Sistema por parte de Usuarios NO autorizados.            .
 .   Fecha Creacion  : 10-04-2014                                                     .
 .   Variables       :                                                                .
 **************************************************************************************
 .   MODIFICACIONES                                                                   .
 **************************************************************************************
 .   QUIEN             CUANDO            QUE                                          .
 **************************************************************************************
 .   Revision Historica                                                               .
 .   Version 1.5                                                                      .
 **************************************************************************************/

  AFTER LOGON ON DATABASE
DECLARE
  --VARIABLES
  V_MENSAJE   VARCHAR2(100);

  --EXCEPCIONES
  E_NOLOGIN   EXCEPTION;
BEGIN
  --VERIFICAMOS EL MENSAGE RESULTADO DEL QUERY Y LANZAMOS EL ERROR
  V_MENSAJE := FUNC_AFTER_LOGON_TRIGGER;
  IF V_MENSAJE != 'OK' THEN
    RAISE E_NOLOGIN;
  END IF;
EXCEPTION
  WHEN E_NOLOGIN THEN
    RAISE_APPLICATION_ERROR(-20000, FUNC_AFTER_LOGON_TRIGGER);
  WHEN NO_DATA_FOUND THEN
    raise;
  WHEN OTHERS THEN
    raise;
END;
/
