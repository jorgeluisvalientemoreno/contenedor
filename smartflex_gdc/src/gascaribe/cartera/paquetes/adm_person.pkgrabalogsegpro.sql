CREATE OR REPLACE PACKAGE adm_person.pkGrabaLogSegPro AS

/******************************************************

  Unidad         : pkGrabaLogSegPro
  Descripcion    : Paquete para grabar log de seguimiento a ciertos procesos en los que
                   se requiera validar que parte causa la demora de los mismos
  Autor          : F.Castro
  Fecha          : 27/02/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================
  11/07/2024    PAcosta                 OSF-2893: Cambio de esquema ADM_PERSON 

  ******************************************************************/

  -----------------------------------------
  -- Variables de paquete
  -----------------------------------------
     sbActiLog    varchar2(1);
     nuconsec     number;
     nusesion     LDC_LOG_SEG_PROC.SESION%type;
     sbUsua       LDC_LOG_SEG_PROC.USUARIO%type;
     sbProg       LDC_LOG_SEG_PROC.PROGRAMA%type;
     sbTerm       LDC_LOG_SEG_PROC.TERMINAL%type;

  -----------------------------------------
  -- Procesos de procedimientos y funciones
  -----------------------------------------

  procedure pro_GraLogSegPro (isbobse in LDC_LOG_SEG_PROC.OBSERVACION%type);


END pkGrabaLogSegPro;
/
CREATE OR REPLACE package body adm_person.pkGrabaLogSegPro AS
  /******************************************************

  Unidad         : pkGrabaLogSegPro
  Descripcion    : Paquete para grabar log de seguimiento a ciertos procesos en los que
                   se requiera validar que parte causa la demora de los mismos
  Autor          : F.Castro
  Fecha          : 27/02/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================


  ******************************************************************/


  procedure pro_GraLogSegPro (isbobse in LDC_LOG_SEG_PROC.OBSERVACION%type) is

  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    if nvl(sbActiLog,'N') = 'N' then
      return;
    end if;

    nuconsec := nvl(nuconsec,0) + 1;

    insert into LDC_LOG_SEG_PROC
      (sesion,
       consec,
       usuario,
       fecha,
       programa,
       terminal,
       observacion)
    values
      (nusesion,
       nuconsec,
       sbUsua,
       sysdate,
       sbProg,
       sbTerm,
       isbobse);
    commit;
 EXCEPTION
  when OTHERS then
    null;
 END pro_GraLogSegPro;


END pkGrabaLogSegPro;
/
PROMPT Otorgando permisos de ejecucion a PKGRABALOGSEGPRO
BEGIN
    pkg_utilidades.praplicarpermisos('PKGRABALOGSEGPRO', 'ADM_PERSON');
END;
/