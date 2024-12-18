CREATE OR REPLACE Trigger ADM_PERSON.TRG_BEFUPDATE_BLOCKED
  Before Update Of status, action_id, new_novelty, new_novelty_date, payment_method On Ld_Blocked_Detail
  For Each Row
Declare
  /*Trigger para validar que los registros frenados no sean modificados una vez se haya impreso el archivo de frenados*/
  Sbmensaje     Ge_Message.Description%Type;
  Cnuerror_2741 Number := 2741;
  Cnuerror_2126 Number := 2741;
  Sbmanaged     Ld_Blocked.Managed%Type;
  Nucentral     Ld_Blocked.Credit_Bureau%Type;
  Fecha         Date;

  Cursor Cublocked Is
    Select Ld.Managed, Ld.Credit_Bureau
      From Ld_Blocked Ld
     Where Ld.Blocked_Id = :Old.Blocked_Id;

Begin
  Pkerrors.Push('Trg_Befupdate_Blocked');
  Open Cublocked;
  Fetch Cublocked
    Into Sbmanaged, Nucentral;
  If (Sbmanaged = 'I') Then
    Sbmensaje := 'No se puede actualizar el registro. El archivo de frenados ya fue impreso';
    Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
  End If;
  If (Nucentral = 1) Then
    If (:New.Action_Id Is Null And
       (:New.New_Novelty Is Not Null Or :New.Payment_Method Is Not Null Or
       :New.New_Novelty_Date Is Not Null)) Then
      Sbmensaje := 'El identificador de la Acción es nulo, Usted no debería diligenciar los atributos Nueva novedad, Fecha Nueva Novedad y Forma de Pago';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
    End If;

    If (:New.Action_Id = 2) Then
      If :New.New_Novelty Is Null Then
        Sbmensaje := 'El atributo Nueva Novedad no puede ser nulo';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      If :New.New_Novelty_Date Is Null Then
        Sbmensaje := 'El atributo Fecha Nueva Novedad no puede ser nulo';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      If :New.Payment_Method Is Null Then
        Sbmensaje := 'El atributo Forma de Pago no puede ser nulo';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      Begin
        Select To_Date(To_Char(:New.New_Novelty_Date) || '01', 'yyyymmdd')
          Into Fecha
          From Dual;
      Exception
        When Others Then
          Sbmensaje := 'Valor invalido en Fecha Nueva Novedad. Este valor debe contener Año y mes valido en el formato AAAAMM.';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
      End;
      If :New.Status Is Not Null Then
        Sbmensaje := 'El atributo Estado debe ser nulo, Este atributo no pertenece al formato de la Central de Riesgo.';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;
    Else
      If :New.New_Novelty Is Not Null Then
        Sbmensaje := 'El atributo Nueva Novedad debe ser nulo, no es obligatorio para este identificador de Acción.';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      If :New.New_Novelty_Date Is Not Null Then
        Sbmensaje := 'El atributo Fecha Nueva Novedad debe ser nulo, no es obligatorio para este identificador de Acción.';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      If :New.Payment_Method Is Not Null Then
        Sbmensaje := 'El atributo Forma de Pago debe ser nulo, no es obligatorio para este identificador de Acción.';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

      If :New.Status Is Not Null Then
        Sbmensaje := 'El atributo Estado debe ser nulo, Este atributo no deberían ser diligenciados porque no pertenecen al formato de Frenados de la Central de Riesgo que esta gestionando..';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
      End If;

    End If;
  Else
    If :New.Status Is Null Then
      Sbmensaje := 'El atributo Estado no puede ser nulo';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
    End If;

    If (:New.Payment_Method Is Not Null Or :New.New_Novelty_Date Is Not Null Or
       :New.New_Novelty Is Not Null Or :New.Status Is Not Null Or :New.Action_Id Is Not Null ) Then
      Sbmensaje := 'Los atributos Forma de Pago, Fecha Nueva Novedad, Nueva Novedad e Indicador de la Acción no deberían ser diligenciados porque no pertenecen al formato de Frenados de la Central de Riesgo que esta gestionando.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2126, Sbmensaje);
    End If;

  End If;
  Close Cublocked;
  Pkerrors.Pop;
Exception
  When Ex.Controlled_Error Then
    Raise Ex.Controlled_Error;

  When Others Then
    Errors.Seterror;
    Pkerrors.Pop;
    Raise Ex.Controlled_Error;
End TRG_BEFUPDATE_BLOCKED;
/
