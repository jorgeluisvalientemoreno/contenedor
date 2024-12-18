CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDEIN_NOVELTY
  After Insert Or Update Of TYPE_REGISTER,
CURRENT_NUMBER_OBLIGATION,
IDENTIFICATION_NUMBER,
IDENTIFICATION_TYPE,
BRANCH_CODE,
NOVELTY_OBLIGATION_DC,
NOVELTY_DATE,
NOVELTY_OBLIGATION_CF,
USER_ID,
REGISTER_DATE,
PRODUCT_TYPE_ID
On ld_novelty
  For Each Row


/*******************************************************************************
    Historia de Modificaciones (De la más reciente a la más antigua)

    Fecha           IDEntrega

    03-08-2013      smunozSAO212518
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.
    Se realizan modificaciones para que se controle el ingreso de información
    dependiendo de la central que se está procesando.


    DD-MM-2013      usuarioSAO######
    Descripción breve, precisa y clara de la modificación realizada.
*******************************************************************************/

Declare
  /*Trigger para validar que los registros re- numerados no sean modificador una vez el flag de envio a centrales estén en S*/
  Sbmensaje     Ge_Message.Description%Type;
  Cnuerror_2741 Number := 2741;

  Cursor Curge_Subscriber Is
    Select Count(1)
      From Ge_Subscriber s
     Where s.Identification = To_Char(:New.Identification_Number);

  Cursor Curdiferido(Nuobligacion Diferido.Difecodi%Type) Is
    Select Count(1) From Diferido d Where d.Difecodi = Nuobligacion;

  Cursor Curservsusc(Nuobligacion Servsusc.Sesunuse%Type) Is
    Select Count(1) From Servsusc s Where s.Sesunuse = Nuobligacion;

  Nucantsusc Number;
  Nuservsusc Number;
  Nudiferido Number;

Begin

  Pkerrors.Push('Trg_Afupdein_novelty');
  /* If (:New.Identification_Number != :Old.Identification_Number) Then*/
  Open Curge_Subscriber;
  Fetch Curge_Subscriber
    Into Nucantsusc;
  Close Curge_Subscriber;
  If (Nucantsusc = 0) Then
    Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741,
                                     'Número de Identificación No Válido');

  End If;

  Open Curdiferido(:New.Current_Number_Obligation);
  Fetch Curdiferido
    Into Nudiferido;
  Close Curdiferido;

  If (Nudiferido = 0) Then
    Open Curservsusc(:New.Current_Number_Obligation);
    Fetch Curservsusc
      Into Nuservsusc;
    Close Curservsusc;

    If (Nuservsusc = 0) Then
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741,
                                       'Número de Obligación no válido');

      If (UPDATING) Then

        -- Usar las nuevas definiciones de las columnas.  smunozSAO213438
        If :old.Flag_Envio = 'S' And :old.credit_bureau_id = '1' Then
          Sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo DataCrédito';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);

        Elsif :old.Flag_Envio = 'S' And :old.credit_bureau_id = '2' Then
          Sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo Cifin';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);

        End If;
      End If;

    End If;
  End If;

  -- Obligar el ingreso de las columnas dependiendo de la central.  smunozSAO213438

  -- Datacrédito
  If :New.Credit_Bureau_Id = '1' Then
    If :New.Novelty_Obligation_Dc Is Null Then
      sbMensaje := 'Es necesario que ingrese el número de la novedad para Datacrédito';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    Elsif :New.Identification_Type_Dc Is Null Then
      sbMensaje := 'Es necesario que ingrese el tipo de identificación.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    Elsif :New.Novelty_Obligation_Cf Is Not Null Then
      sbMensaje := 'No debe ingresar  la justificación de la acción '||
                   'ya que esta información sólo se requiere para la central de riesgo Cifin.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If;

    -- Cifin
  Elsif :New.Credit_Bureau_Id = '2' Then
    If :New.Novelty_Obligation_Cf Is Null Then
      sbMensaje := 'Es necesario que ingrese la justificación de la acción.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    Elsif :New.Novelty_Obligation_Dc Is Not Null Then
      sbMensaje := 'No debe ingresar la novedad para datacrédito.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    Elsif :New.Identification_Type_Dc Is Not Null Then
      sbMensaje := 'No debe ingresar el tipo de identificación.';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If; -- If :New.Novelty_Obligation_Cf Is Null Then
  End If; -- If :New.Credit_Bureau_Id = '1' Then

  Pkerrors.Pop;
Exception
  When Ex.Controlled_Error Then
    Raise Ex.Controlled_Error;

  When Others Then
    Errors.Seterror;
    Pkerrors.Pop;
    Raise Ex.Controlled_Error;

End TRG_AFUPDEIN_NOVELTY;
/
