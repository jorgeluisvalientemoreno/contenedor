CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLD_FA_CRITDESC
  Before insert Or Update Or Delete OF CRDECODE,CRDEGELO,CRDECATE,CRDESUCA,CRDETIPR,CRDEVADE,CRDECOAP,CRDENUDE,CRDETISO,CRDECOBA,
                                        CRDEFEIN, CRDEFEFI, CRDEPRDE, CRDETIDE, CRDEGEPA, CRDEGEDE,CRDEGEBA  ON LD_FA_CRITDESC
  FOR EACH ROW
Declare
  Pragma Autonomous_Transaction;
  Cnuerror_2741 Number := 2741;
  Sbmensaje     Ge_Message.Description%Type;
  Cantidaddias  Number;
  Fechaactual   Date;
  Diferencia    Date;
  Codcriterio   Ld_Fa_Critdesc.Crdecode%Type;

  /*Cursor para validar si el criterios a actualizar está siendo usado en la tabla de descuento pronto pago*/
  Cursor Curdescprpa Is
    Select Max(l.Deppfere) Fecha From Ld_Fa_Descprpa l;
  /*Cursor para obtener los registros asociados*/
  Cursor Curdescprpa2 Is
    Select * From Ld_Fa_Descprpa l Where l.Deppcrde = Codcriterio;

  /*Cursor para validar que el criterio a ingresar no esté dentro de la fechas de vigencias del registro existente*/
  Cursor Curcritdesc Is

    Select Count(1)
      From Ld_Fa_Critdesc d
     Where d.Crdegepa = :New.Crdegepa
       And d.Crdegede = :New.Crdegede
       And d.Crdegelo = :New.Crdegelo
       And (d.Crdegeba = :New.Crdegeba Or
           (d.Crdegeba Is Null And :New.Crdegeba Is Null))
       And d.Crdecate = :New.Crdecate
       And d.Crdesuca = :New.Crdesuca
       And d.Crdetiso = :New.Crdetiso
       And d.Crdecoba = :New.Crdecoba
       And d.Crdecoap = :New.Crdecoap
       And d.Crdetide = :New.Crdetide
       And d.Crdetipr = :New.Crdetipr
       And (d.Crdevade = :New.Crdevade Or
           (d.Crdevade Is Null And :New.Crdevade Is Null)) --
       And (d.Crdeprde = :New.Crdeprde Or
           (d.Crdeprde Is Null And :New.Crdeprde Is Null))
       And (:New.Crdefein Between d.Crdefein And d.Crdefefi Or
           :New.Crdefefi Between d.Crdefein And d.Crdefefi Or
           d.Crdefein Between :New.Crdefein And :New.Crdefefi Or
           d.Crdefefi Between :New.Crdefein And :New.Crdefefi);

  Regcurdescprpa  Curdescprpa%Rowtype;
  Regcurdescprpa2 Curdescprpa2%Rowtype;
  Contador        Number;
Begin
  Pkerrors.Push('TRGLD_FA_CRITDESC');
  Cantidaddias := Ld_Fa_Fnu_Paragene('DIAS_ATRAS_FECHA_INICIAL_CRITERIOS');

  If (Inserting) Then
    Codcriterio := :New.Crdecode;
  Elsif (Updating) Then
    Codcriterio := :Old.Crdecode;
  Else
    Codcriterio := :Old.Crdecode;
    -- Fechaactual  := :old.Crdefein;
  End If;
  If (Inserting) Then
    Fechaactual := :New.Crdefein;
  Elsif (Updating) Then
    Fechaactual := :Old.Crdefein;
  End If;

  If (Inserting Or Updating) Then
    If (:New.Crdeprde Is Not Null And :New.Crdevade Is Not Null) Then
      Sbmensaje := 'Los campos Valor del Descuento y Porcentaje son excluyentes. Sólo se debe digitar el que corresponda al valor indicado en el campo Valor/Porcentaje';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    Else
      If (:New.Crdetide = 'P') Then
        If (:New.Crdeprde Is Null) Then
          Sbmensaje := 'Debe diligenciar el valor correspondiente al porcentaje de Descuento a otorgar';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);

        End If;
      Else
        If (:New.Crdevade Is Null) Then
          Sbmensaje := 'Debe diligenciar el valor correspondiente al Valor del Descuento a otorgar';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
        End If;
      End If;
    End If;
    If (:New.Crdeprde > 100) Then
      Sbmensaje := 'El porcentaje de descuento indicado no es válido';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If;

  End If;
  If (Inserting) Then
    If (Fechaactual < Trunc(Sysdate)) Then
      Diferencia := (Trunc(Sysdate) - Cantidaddias);
      Ut_Trace.Trace('Diferencia ' || Diferencia, 1);
      If (:New.Crdefein < Diferencia) Then
        Sbmensaje := 'La fecha inicial de la vigencia se encuentra fuera del rango permitido';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
      End If;
    End If;
    Open Curcritdesc;
    Fetch Curcritdesc
      Into Contador;
    Close Curcritdesc;

    If (Contador > 0) Then
      Sbmensaje := 'Ya existe un criterio con las misma configuración vigente en este rango';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If;
  End If;
  /*Validar si el criterio a modificar se encuentra relacionado*/
  If (Updating) Then
    Ut_Trace.Trace('entró aqui update', 1);
    Open Curdescprpa;
    Fetch Curdescprpa
      Into Regcurdescprpa;
     Diferencia := (trunc(:Old.Crdefein) - Cantidaddias);
    if :new.Crdefein< Diferencia then
      Sbmensaje := 'La fecha inicial de la vigencia se encuentra fuera del rango permitido';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    end if;
    If (Curdescprpa%Found) Then
      Ut_Trace.Trace('entró aqui update' || Codcriterio, 1);

      If (:Old.Crdefefi != :New.Crdefefi) Then
        If (:New.Crdefefi < Regcurdescprpa.Fecha) Then
          Sbmensaje := 'La Fecha de Finalización de vigencia del criterio que intenta actualizar no es valida';
          Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
        End If;
      End If;

    End If;

    If (Curdescprpa%Isopen) Then
      Close Curdescprpa;

    End If;
    Open Curdescprpa2;
    Fetch Curdescprpa2
      Into Regcurdescprpa2;
    If (Curdescprpa2%Found) Then
      If (:Old.Crdegelo != :New.Crdegelo Or :Old.Crdecate != :New.Crdecate Or
         :Old.Crdesuca != :New.Crdesuca Or :Old.Crdevade != :New.Crdevade Or
         :Old.Crdeprde != :New.Crdeprde Or :Old.Crdecoap != :New.Crdecoap Or
         :Old.Crdetiso != :New.Crdetiso Or :Old.Crdecoba != :New.Crdecoba Or
         :Old.Crdetide != :New.Crdetide Or :Old.Crdegepa != :New.Crdegepa Or
         :Old.Crdegede != :New.Crdegede Or :Old.Crdegeba != :New.Crdegeba Or
         :Old.Crdefein != :New.Crdefein) Then
        Sbmensaje := 'El criterio que intenta actualizar tiene suscriptores relacionados';
        Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);

      End If;
    End If;

    If (Curdescprpa2%Isopen) Then
      Close Curdescprpa2;

    End If;


    Open Curcritdesc;
    Fetch Curcritdesc
      Into Contador;
    Close Curcritdesc;

    If (Contador > 1) Then
      Sbmensaje := 'Ya existe un criterio con las misma configuración vigente en este rango';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If;

  End If;

  If (Deleting) Then
    Open Curdescprpa2;
    Fetch Curdescprpa2
      Into Regcurdescprpa2;
    If (Curdescprpa2%Found) Then
      Sbmensaje := 'El criterio que intenta borrar tiene suscriptores relacionados';
      Ge_Boerrors.Seterrorcodeargument(Cnuerror_2741, Sbmensaje);
    End If;
  End If;

  If (Curdescprpa2%Isopen) Then
    Close Curdescprpa2;

  End If;

Exception
  --{
  When Ex.Controlled_Error Then
    Raise Ex.Controlled_Error;

  When Others Then
    Errors.Seterror;
    Raise Ex.Controlled_Error;
End Trgld_Fa_Critdesc;
/
