CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLD_GENERAL_PARAM
  BEFORE UPDATE OF TEXT_VALUE,NUMERCIAL_VALUE,PARAMETER_ID ON LD_GENERAL_PARAMETERS
  FOR EACH ROW
/*Trigger para validar que el usuario solo llene un valor sea numerico o texto*/
Declare
  Sberrmsg  Ge_Error_Log.Description%Type;
  Nuerrcode Number;
  Nunum     Parametr.Pamenume%Type;
  Sbvalor   Parametr.Pamechar%Type;
  Nucodigo  Parametr.Pamecodi%Type;
Begin
  Pkerrors.Push('TRGLD_GENERAL_PARAM');

  Nunum    := To_Number(Substr(:New.Numercial_Value, 1, 10));
  Sbvalor  := Substr(:New.Text_Value, 1, 80);
  Nucodigo := Substr(:New.Parameter_Id, 1, 30);
  Le_Boliqpropiasval.Val_Valorparametro(Nunum, Sbvalor, Nucodigo);

  Pkerrors.Pop;
Exception

  When Login_Denied Or Pkconstante.Exerror_Level2 Then

    Pkerrors.Pop;
    Raise;

  When Others Then
    Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
    Pkerrors.Pop;
    Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
End TRGLD_GENERAL_PARAM;
/
