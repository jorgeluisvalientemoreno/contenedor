CREATE OR REPLACE Procedure adm_person.provapatapa(sbcodipara In Varchar2,
                                        sbtipopara In Varchar2,
                                        nuvalopara Out Number,
                                        sbvalopara Out Varchar2) Is
  /************************************************************************
   PROPIEDAD INTELECTUAL DE LUDYCOM S.A
   PROCEDIMIENTO   : proVaPaTaPa
   AUTOR       : JERY ANN SILVERA DE LA RANS
   FECHA    : 01/01/2013
   DESCRIPCION  : Valida que exista un parametro en la tabla LD_GENERAL_PARAMETR.
  Parametros de Entrada
  sbCodiPara  Codigo del parametro a validar
  sbTipoPara  Tipo del parametro a validar (Numerico/String)
  Parametros de Salida
  nuValoPara  Valor del parametro en numerico.
  sbValoPara  Valor del parametro en cadena.
  Historia de Modificaciones
  Autor   Fecha     Descripcion
  14/05/2024          Paola Acosta       OSF-2674: Cambio de esquema ADM_PERSON 
  ************************************************************************/
  
  sbmensaje Varchar2(300);
  nuvalpar  ld_general_parameters.numercial_value%Type := Null;
  sbvalpar  ld_general_parameters.text_value%Type := Null;
Begin
  -- Si el codigo del parametro esta en null, error.
  If sbcodipara Is Null Then
    sbmensaje := 'No hay parametro entrado al procedimiento proVaPaTaPa';
    raise_application_error(-20080, sbmensaje);
  End If;
  -- Si el tipo del parametro esta en null, error.
  If sbtipopara Is Null Then
    sbmensaje := 'No hay tipo parametro entrado al procedimiento proVaPaTaPa';
    raise_application_error(-20080, sbmensaje);
  End If;
  -- Si el tipo del parametro es diferente a (N)umerico o (S)tring, error.
  If sbtipopara Not In ('N', 'S') Then
    sbmensaje := 'El tipo parametro entrado al procedimiento proVaPaTaPa';
    sbmensaje := sbmensaje || ' debe ser (N)umerico o (S)tring';
    raise_application_error(-20080, sbmensaje);
  End If;
  If sbtipopara = 'N' Then
    nuvalpar := pkpara.finget(upper(sbcodipara));
    If nuvalpar Is Null Then
      sbmensaje := 'El parametro ' || sbcodipara || ' no esta definido ';
      sbmensaje := sbmensaje || 'en la tabla PARAMETR';
      raise_application_error(-20080, sbmensaje);
    End If;
    nuvalopara := nuvalpar;
  End If;
  If sbtipopara = 'S' Then
    sbvalpar := pkpara.fsbget(upper(sbcodipara));
    If sbvalpar Is Null Then
      sbmensaje := 'El parametro ' || sbcodipara || ' no esta definido ';
      sbmensaje := sbmensaje || 'en la tabla PARAMETR';
      raise_application_error(-20080, sbmensaje);
    End If;
    sbvalopara := sbvalpar;
  End If;
Exception
  When Others Then
    sbmensaje := 'Existen problemas para ejecutar proVaPaTaPa con el parametro ' ||
                 sbcodipara;
    raise_application_error(-20080, sbmensaje);
End;
/
PROMPT Otorgando permisos de ejecucion a PROVAPATAPA
BEGIN
    pkg_utilidades.praplicarpermisos('PROVAPATAPA', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre PROVAPATAPA para reportes
GRANT EXECUTE ON adm_person.PROVAPATAPA TO rexereportes;
/