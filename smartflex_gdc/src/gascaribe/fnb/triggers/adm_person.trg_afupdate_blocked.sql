CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDATE_BLOCKED
  After Update Of Type_Identification, Number_Identification, Number_Obligation, Branch, Mora_Age, Credit_Line, Value_Balance, Value_Mora, Termination_Date, Deadline, Blocked_Id, Blocked_Master_Id, Novelty_Date, New_Novelty, Credit_Type, Novelty, Action_Id, New_Novelty_Date, Payment_Method, Status On Ld_Blocked_Detail
  For Each Row
Declare
  /*Trigger para validar que los registros re- numerados no sean modificador una vez el flag de envio a centrales estén en S*/
  Sbmensaje     Ge_Message.Description%Type;
  Cnuerror_2741 Number := 2741;
Begin
  Pkerrors.Push('Trg_Afupdate_Blocked');
  If (:New.Status = 'S') Then
    Sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo';
    Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
  End If;
  Pkerrors.Pop;
Exception
  When Ex.Controlled_Error Then
    Raise Ex.Controlled_Error;

  When Others Then
    Errors.Seterror;
    Pkerrors.Pop;
    Raise Ex.Controlled_Error;
End TRG_AFUPDATE_BLOCKED;
/
