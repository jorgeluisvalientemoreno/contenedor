CREATE OR REPLACE TRIGGER ADM_PERSON.TRGIDU_DETADEPP
  before insert or Update on ld_fa_detadepp
   for each Row

Declare

  Nuusuairo Sa_User.User_Id%Type; /*Usuario*/

  Nurespuesta Number; /*Respuesta*/
  Gsberrmsg   Ge_Message.Description%Type; /*Mensajes*/

Begin

  Pkerrors.Push('TrgIDU_Detadepp');
  Begin
    Select Sa_User.User_Id
      Into Nuusuairo
      From Sa_User
     Where Sa_User.Mask = User;
  Exception
    When Others Then
      Nuusuairo := -1;
  End;

  Pkld_Fa_Bchistocade.Inserthistocade(Idthicafere => Sysdate,
                                      Inuhicacodi => Seq_Histcade.Nextval,
                                      Inuhicadepp => :New.Dedpcodi,
                                      Inuhicaesde => :New.Deppesco,
                                      Inuhicausid => Nuusuairo,
                                      Inudiferido => :New.Dedpdife,
                                      Inususcripc => :New.Dedpsusc,
                                      Inuestaanct => :Old.Deppesco,
                                      Onuresp     => Nurespuesta);

  Pkerrors.Pop;

Exception
  When Others Then
    Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
    Pkerrors.Pop;
    Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);

End TRGIDU_DETADEPP;
/
