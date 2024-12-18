CREATE OR REPLACE trigger ADM_PERSON.TRG_AFUPDATE_RENUMBERING
  after Update Of TYPE_REGISTER,
CURRENT_NUMBER_OBLIGATION,
IDENTIFICATION_NUMBER,
NEW_NUMBER_OBLIGATION,
OLD_CODE_BRANCH,
CURRENT_CODE_BRANCH
 on ld_renumbering
  for each Row

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
Begin

  pkerrors.push('Trg_Afupdate_Renumbering');

  -- Modificación del nombre de las columnas de acuerdo a la tabla ld_renumbering.
  -- smunozSAO213438
  If :new.flag_envio = 'S' And :NEW.Credit_Bureau_Id = 1 Then
    sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo DataCrédito';
    ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
  Elsif :new.flag_envio = 'S' And :NEW.Credit_Bureau_Id = 2 Then
    sbmensaje := 'No se puede actualizar el registro. Este registro ya fué procesado y gestionado ante la central de Riesgo Cifin';
    ge_boerrors.seterrorcodeargument(cnuerror_2741, sbmensaje);
  End If;

  If (:new.current_number_obligation = :new.new_number_obligation) Then
    ge_boerrors.seterrorcodeargument(cnuerror_2741,
                                     'El número de obligación nueva no puede ser igual al número de obligación anterior');
  End If;
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

  If (:new.new_number_obligation != :old.new_number_obligation) Then
    Open curdiferido(:new.new_number_obligation);
    Fetch curdiferido
      Into nudiferido;
    Close curdiferido;

    If (nudiferido = 0) Then
      Open curservsusc(:new.new_number_obligation);
      Fetch curservsusc
        Into nuservsusc;
      Close curservsusc;

      If (nuservsusc = 0) Then
        ge_boerrors.seterrorcodeargument(cnuerror_2741,
                                         'Número de Obligación no válido');

      End If;

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
End TRG_AFUPDATE_RENUMBERING;
/
