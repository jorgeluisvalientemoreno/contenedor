CREATE OR REPLACE TRIGGER ADM_PERSON.TRGUPDGENERALPARAAUDI
  BEFORE UPDATE or DELETE ON ld_general_parameters
  FOR EACH ROW

     /*Este trigger se dispara cuando se va a  realizar una  actualización sobre   la entidad  LD_FA_PARAGENE (parámetros generales)
    y se encargará  de  llamar   a  los  procesos  encargados  de  realizar  las respectivas inserciones .*/

Declare
  /*Declaración de Variables*/
  Consecutivo Number; /*consecutivo para el código de registro de la tabla auditoria*/
  Session     Number; /*sesión en la que se autentica el usuario*/
  Terminal    Varchar2(60); /*terminal desde la cual se inicia sesión*/
  Nuresp      Number; /*variable para código de error*/
  Sberrmsg    Ge_Message.Description%Type; /*Mensajes*/

Begin
  Pkerrors.Push('TrgUpdGeneralParaAudi');
  Begin
    Select Userenv('SESSIONID'), Userenv('TERMINAL')
      Into Session, Terminal
      From Dual;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
  End;

  If (Updating) Then

    If (:New.Parameter_Id Is Not Null) Then
      Dald_General_Audiace.Insertgaudiace(Seq_Ld_General_Audiace.Nextval,
                                          'UPDATE',
                                          'LD_GENERAL_PARAMETERS',
                                          'PARAMETERID',
                                          :Old.Parameter_Id,
                                          :New.Parameter_Id,
                                          Session,
                                          :New.User_Id,
                                          Sysdate,
                                          'CR',
                                          Terminal,
                                          Consecutivo,
                                          Nuresp);

    End If;
    If (:New.Parameter_Desc Is Not Null) Then
      Dald_General_Audiace.Insertgaudiace(Seq_Ld_General_Audiace.Nextval,
                                          'UPDATE',
                                          'LD_GENERAL_PARAMETERS',
                                          'PARAMETER_DESC',
                                          :Old.Parameter_Desc,
                                          :New.Parameter_Desc,
                                          Session,
                                          :New.User_Id,
                                          Sysdate,
                                          'CR',
                                          Terminal,
                                          Consecutivo,
                                          Nuresp);
    End If;

    If (:New.Numercial_Value Is Not Null) Then
      Dald_General_Audiace.Insertgaudiace(Seq_Ld_General_Audiace.Nextval,
                                          'UPDATE',
                                          'LD_GENERAL_PARAMETERS',
                                          'NUMERCIAL_VALUE',
                                          :Old.Numercial_Value,
                                          :New.Numercial_Value,
                                          Session,
                                          :New.User_Id,
                                          Sysdate,
                                          'CR',
                                          Terminal,
                                          Consecutivo,
                                          Nuresp);
    End If;

    If (:New.Text_Value Is Not Null) Then
      Dald_General_Audiace.Insertgaudiace(Seq_Ld_General_Audiace.Nextval,
                                          'UPDATE',
                                          'LD_GENERAL_PARAMETERS',
                                          'TEXT_VALUE',
                                          :Old.Text_Value,
                                          :New.Text_Value,
                                          Session,
                                          :New.User_Id,
                                          Sysdate,
                                          'CR',
                                          Terminal,
                                          Consecutivo,
                                          Nuresp);
    End If;

  End If;
  Pkerrors.Pop;
Exception
  When Others Then
    Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
    Pkerrors.Pop;
    Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
End;
/
