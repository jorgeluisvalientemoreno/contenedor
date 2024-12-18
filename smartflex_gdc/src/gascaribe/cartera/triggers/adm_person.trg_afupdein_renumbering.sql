CREATE OR REPLACE Trigger ADM_PERSON.TRG_AFUPDEIN_RENUMBERING
  After Insert On Ld_Renumbering
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

  Pkerrors.Push('Trg_Afupdein_Renumbering');
  /* If (:New.Identification_Number != :Old.Identification_Number) Then*/
  If (:New.Current_Number_Obligation = :New.New_Number_Obligation) Then
    Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741,
                                     'El número de obligación nueva no puede ser igual al número de obligación anterior');
  End If;
  Open Curge_Subscriber;
  Fetch Curge_Subscriber
    Into Nucantsusc;
  Close Curge_Subscriber;
  If (Nucantsusc = 0) Then
    Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741,
                                     'Número de Identificación No Válido');

  End If;

  Open Curdiferido(:New.New_Number_Obligation);
  Fetch Curdiferido
    Into Nudiferido;
  Close Curdiferido;

  If (Nudiferido = 0) Then
    Open Curservsusc(:New.New_Number_Obligation);
    Fetch Curservsusc
      Into Nuservsusc;
    Close Curservsusc;

    If (Nuservsusc = 0) Then
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741,
                                       'Número de Obligación no válido');

    End If;

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

    End If;

  End If;

  Pkerrors.Pop;
Exception
  When Ex.Controlled_Error Then
    Raise Ex.Controlled_Error;

  When Others Then
    Errors.Seterror;
    Pkerrors.Pop;
    Raise Ex.Controlled_Error;

End TRG_AFUPDEIN_RENUMBERING;
/
