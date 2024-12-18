CREATE OR REPLACE trigger ADM_PERSON.LDC_TRG_COMENTARIO
  before insert or update on mo_comment
  REFERENCING OLD AS OLD NEW AS NEW
  for each row
  /*****************************************************************
    Propiedad intelectual de Gases del Caribe (c).

    Unidad         : LDC_TRG_COMENTARIO
    Descripcion    : Este trigger fue generado para asignar al comentario
                     el usuario logeado y el area organizacional de este
    Autor          : Caren Berdejo
    Fecha          : 05/01/2017

    Historia de Modificaciones
      Fecha                Autor             Modificacion
    =========            =========         ====================
    18-04-2017           KCienfuegos       CA200-1206: Se modifica el trigger para
                                           que tenga en cuenta las solicitudes de deposito.
  ******************************************************************/
Declare
  persona             mo_comment.person_id%Type;
  area_organizacional mo_comment.organizat_area_id%Type;
  tipo_solicitud      mo_packages.package_type_id%Type;
  nuAreaPadre         ge_organizat_area.organizat_area_id%TYPE := dald_parameter.fnuGetNumeric_Value('AREA_ORG_SAC_PADRE',0);
  nombre_entrega      Varchar2(200);
Begin
  ut_trace.trace('inicio trigger LDC_TRG_COMENTARIO', 10);
  nombre_entrega := 'CRM_SAC_CBB_200921_2';

  If fblaplicaentrega(nombre_entrega) Then
    ut_trace.trace('nombre_entrega ' || nombre_entrega, 10);
    persona := open.ge_bopersonal.fnugetpersonid;
    ut_trace.trace('persona ' || persona, 10);
    area_organizacional := open.dage_person.fnugetorganizat_area_id(persona);
    ut_trace.trace('area_organizacional ' || area_organizacional, 10);

    Begin
      Select package_type_id
        Into tipo_solicitud
        From mo_packages
       Where package_id = :new.package_id;
    Exception
      When no_data_found Then
        tipo_solicitud := Null;
      When Others Then
        tipo_solicitud := Null;
    End;
    ut_trace.trace('tipo_solicitud ' || tipo_solicitud, 10);
    If tipo_solicitud Is Not Null Then
      If tipo_solicitud = dald_parameter.fnugetnumeric_value('COD_PACK_TYPE_DEVSALFAVOR',0)
         OR tipo_solicitud = dald_parameter.fnugetnumeric_value('TIPO_SOL_DEV_DEP',0) Then

        :new.person_id := persona;
        ut_trace.trace(':new.person_id  ' || persona, 10);
        :new.organizat_area_id := nuAreaPadre;
        ut_trace.trace(':new.organizat_area_id ' || area_organizacional,
                       10);
      End If;
    End If;
  End If;
  ut_trace.trace('fin trigger LDC_TRG_COMENTARIO', 10);
End ldc_trg_comentario;
/
