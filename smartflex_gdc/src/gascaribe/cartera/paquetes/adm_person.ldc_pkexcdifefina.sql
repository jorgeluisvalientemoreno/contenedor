CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKEXCDIFEFINA is
  /*****************************************************************



    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================*/

  nuVlrAExc number;
  nufinan number;
  nuconc  number;
  nuvalor number;

  gsbPrograma VARCHAR2(40);

  procedure prSetPrograma(sbPrograma IN VARCHAR2);

   function fsbGetPrograma return VARCHAR2;

   PROCEDURE   prInsertTmp (inuprod  in ldc_tempnego.producto%type,
                            inudife  in ldc_tempnego.diferido%type,
                            inuconc  in ldc_tempnego.concepto%type,
                            inuvalor in ldc_tempnego.valor%type);

 PROCEDURE prDeleteTmp ;

 PROCEDURE prSetFlag;

 PROCEDURE prCambiaFlag (sbflag varchar2);

end LDC_PKEXCDIFEFINA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKEXCDIFEFINA is
  /*****************************************************************


  *****************************************************************************/

    nudel  number;
    sberr varchar2(2000);





PROCEDURE prInsertTmp  (inuprod  in ldc_tempnego.producto%type,
                        inudife  in ldc_tempnego.diferido%type,
                        inuconc  in ldc_tempnego.concepto%type,
                        inuvalor in ldc_tempnego.valor%type) IS
       PRAGMA AUTONOMOUS_TRANSACTION;


 BEGIN

    begin
     insert into ldc_tempnego (producto, diferido , concepto , valor , solicitud)
                 values       (inuprod , inudife  , inuconc  , inuvalor , null);
     commit;
   exception when DUP_VAL_ON_INDEX THEN
     rollback;
   end;

 EXCEPTION
    when others then
       raise;
END prInsertTmp;

PROCEDURE prSetFlag IS
       PRAGMA AUTONOMOUS_TRANSACTION;


 BEGIN

    begin
     insert into ldc_tempnego2 (PROCESADO)
                 values       ('N');
     commit;
   exception when DUP_VAL_ON_INDEX THEN
     ROLLBACK;
   end;


 EXCEPTION
    when others then
       raise;
END prSetFlag;

PROCEDURE prCambiaFlag (sbflag varchar2) IS
       PRAGMA AUTONOMOUS_TRANSACTION;


 BEGIN

    UPDATE ldc_tempnego2
        SET PROCESADO = sbflag;

    commit;

 EXCEPTION
    when others then
       raise;
END prCambiaFlag;

PROCEDURE prDeleteTmp  IS
       PRAGMA AUTONOMOUS_TRANSACTION;


 BEGIN

    DELETE ldc_tempnego;
    commit;


 EXCEPTION
    when others then
       raise;
END prDeleteTmp;


  procedure prSetPrograma(sbPrograma IN VARCHAR2) is
  begin
    gsbPrograma := sbPrograma;
 end prSetPrograma;

   function fsbGetPrograma return VARCHAR2 is

   begin
     return gsbPrograma;
   end fsbGetPrograma;

end LDC_PKEXCDIFEFINA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKEXCDIFEFINA', 'ADM_PERSON');
END;
/
