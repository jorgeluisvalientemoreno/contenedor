CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDATE_NOVELTY
  After Update Or Delete Of Type_Register, Current_Number_Obligation, Identification_Number, Identification_Type, Branch_Code, Novelty_Obligation_Dc, Novelty_Date, Novelty_Obligation_Cf, User_Id, Register_Date, Product_Type_Id

On Ld_Novelty
  For Each Row

  /*******************************************************************************
    Historia de Modificaciones (De la más reciente a la más antigua)

    Fecha           IDEntrega

    03-08-2013      smunozSAO212518
    Se realizan modificaciones para hacer uso de las nuevas columnas creadas en
    la tabla ld_novelty.

    DD-MM-2013      usuarioSAO######
    Descripción breve, precisa y clara de la modificación realizada.
*******************************************************************************/

Declare
  /*Trigger para validar que los registros re- numerados no sean modificados una vez el flag de envio a centrales estén en S*/
  sbmensaje     ge_message.description%Type;
  cnuerror_2741 Number := 2741;

  Cursor curge_subscriber Is
    Select Count(1)
      From ge_subscriber s
     Where s.identification = to_char(:new.identification_number);

  Cursor curdiferido(nuobligacion diferido.difecodi%Type) Is
    Select Count(1) From diferido d Where d.difecodi = nuobligacion;

  Cursor curservsusc(nuobligacion servsusc.sesunuse%Type) Is
    Select Count(1) From servsusc s Where s.sesunuse = nuobligacion;

  nucantsusc Number;
  nuservsusc Number;
  nudiferido Number;
  sbName     GE_BOINSTANCECONTROL.stysbName;
Begin

  pkerrors.push('TRG_AFUPDATE_NOVELTY');

  -- Se hace la validación usando la nueva definición de las columnas. smunozSAO213438
  If (:old.flag_envio = 'S' And :old.credit_bureau_id = '1') Then
    sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo DataCrédito';
    ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
  Elsif (:old.flag_envio = 'S' And :old.credit_bureau_id = '2') Then
    sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo Cifin';
    ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
  End If;
  -- Sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo';

  If (:new.identification_number != :old.identification_number) Then
    Open curge_subscriber;
    Fetch curge_subscriber
      Into nucantsusc;
    Close curge_subscriber;
    If (nucantsusc = 0) Then
      ge_boerrors.seterrorcodeargument(cnuerror_2741,
                                       'Número de Identificación No Válido');

    End If;
  End If;

  If (:new.current_number_obligation != :old.current_number_obligation) Then
    Open curdiferido(:new.current_number_obligation);
    Fetch curdiferido
      Into nudiferido;
    Close curdiferido;

    If (nudiferido = 0) Then
      Open curservsusc(:new.current_number_obligation);
      Fetch curservsusc
        Into nuservsusc;
      Close curservsusc;

      If (nuservsusc = 0) Then
        ge_boerrors.seterrorcodeargument(cnuerror_2741,
                                         'Número de Obligación no válido');

      End If;

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
End TRG_AFUPDATE_NOVELTY;
/
