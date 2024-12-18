CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROINSERTAESTAPROGv2(
																v_ano in NUMBER
															   ,v_mes in NUMBER
															   ,v_proceso in VARCHAR2
															   ,v_estado in VARCHAR2
															   ,v_sesion in NUMBER
															   ,v_usuario_conectado in VARCHAR2
															   ,vrowid out VARCHAR2
															   ) IS
 PRAGMA AUTONOMOUS_TRANSACTION;
/**************************************************************************
  Autor       : dsaltarin
  Fecha       : 27/09/2021
  Descripcion : Se modifica el proceso LDC_PROINSERTAESTAPROG para devuelva el rowid.

  Parametros Entrada
    nuano A?o
    numes Mes
    v_proceso proceso
    v_estado estado
    v_sesion sesion
    v_usuario_conectado usuario conectado

  Valor de salida
   vrowid rowid

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION


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
                              )
    returning rowid into vrowid;
 COMMIT;

END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROINSERTAESTAPROGv2', 'ADM_PERSON');
END;
/
