CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDATE_INCONSISTENCYCF
  After Update Of State_Inconsistency On Ld_Inconsistency_Detai_Cf
  For Each Row
Declare
  /*Trigger para validar que los registros re- numerados no sean modificador una vez el flag de envio a centrales estén en S*/
  sbmensaje     ge_message.description%Type;
  cnuerror_2741 Number := 2741;
Begin
  pkerrors.push('Trg_Afupdate_Inconsistencydc');
  If (:old.state_inconsistency != :new.state_inconsistency) Then
    If (:old.state_inconsistency = 'C') Then
      sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo';
      ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
    End If;
  End If;
  pkerrors.pop;
Exception
  When ex.controlled_error Then
    Raise ex.controlled_error;

  When Others Then
    errors.seterror;
    pkerrors.pop;
    Raise ex.controlled_error;
End TRG_AFUPDATE_INCONSISTENCYCF;
/
