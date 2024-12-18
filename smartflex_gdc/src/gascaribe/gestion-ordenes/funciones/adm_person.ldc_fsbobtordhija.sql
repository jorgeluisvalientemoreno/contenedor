CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBOBTORDHIJA" (inuacti Number)
  Return Varchar2 Is
  /*****************************************************************
  Propiedad intelectual de Gases de occidente.

  Nombre del Paquete: ldc_fsbobtordhija
  Descripción: Descripción de la funcionalidad que realiza este paquete.

  Autor  : Sandra Lemus.
  Fecha  : 04/03/2015 -  No Tiquete 140179

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.        Modificación
  -----------  -------------------    -------------------------------------

  ******************************************************************/

  sborgen Varchar2(2000);

  Cursor cucursor Is
    Select t.task_type_id || '-' || t.description sbvalor
      From or_order_activity o, or_task_type t
     Where o.origin_activity_id = inuacti
       And t.task_type_id = o.task_type_id;

Begin

  For regcursor In cucursor Loop

    If sborgen Is Not Null Then
      sborgen := sborgen || '; ' || regcursor.sbvalor;
    Else
      sborgen := regcursor.sbvalor;
    End If;

  End Loop;

  If sborgen Is Null Then
    sborgen := '-';
  End If;
  Return sborgen;
Exception
  When Others Then
    Return Null;
End ldc_fsbobtordhija;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBOBTORDHIJA', 'ADM_PERSON');
END;
/
