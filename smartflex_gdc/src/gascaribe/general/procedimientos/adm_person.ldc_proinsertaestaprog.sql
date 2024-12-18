CREATE OR REPLACE PROCEDURE adm_person.ldc_proinsertaestaprog(
                                                    v_ano NUMBER
                                                   ,v_mes NUMBER
                                                   ,v_proceso VARCHAR2
                                                   ,v_estado VARCHAR2
                                                   ,v_sesion NUMBER
                                                   ,v_usuario_conectado VARCHAR2
                                                   ) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-21-12
  Descripcion : Registramos estado inicial del proceso

  Parametros Entrada
    nuano Año
    numes Mes
    v_proceso proceso
    v_estado estado
    v_sesion sesion
    v_usuario_conectado usuario conectado

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
 21/11/2013     JJJM        Consulta factor de correción
 21/11/2013     JJJM        Cursor ajustes
 16/05/2024     Adrianavg   OSF-2675: Se migra del esquema OPEN al esquema ADM_PERSON
***************************************************************************/
BEGIN
 INSERT INTO ldc_osf_estaproc
                             (
                               ano
                              ,mes
                              ,proceso
                              ,estado
                              ,fecha_inicial_ejec
                              ,sesion
                              ,usuario_conectado
                              )
                        VALUES(
                               v_ano
                              ,v_mes
                              ,v_proceso
                              ,v_estado
                              ,SYSDATE
                              ,v_sesion
                              ,v_usuario_conectado
                              );
 COMMIT;
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PROINSERTAESTAPROG
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROINSERTAESTAPROG', 'ADM_PERSON'); 
END;
/

