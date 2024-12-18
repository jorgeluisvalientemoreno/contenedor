CREATE OR REPLACE Package adm_person.PKLD_FA_BCHISTOCADE Is

  /************************************************************************
  Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_BCHistocade
      Descripción    : Componente de negocio  que permite administrar los cambios de estado en los descuentos por pronto pago
      Autor          : yennis.thorrens.SAOYennis thorrens
      Fecha          : 21/09/2012

      Métodos

      Nombre         : InsertHistoCade
      Descripción    : Componente de negocio que permite insertar los cambios de estado en los descuentos por pronto pago

      Parámetros

      Nombre Parámetro  Tipo de parámetro        Tipo de dato del parámetro            Descripción
       idtHicafere       Entrada                   ld_fa_histcade.hicafere%TYPE         Fecha que ingresa el registro
       inuHicacodi       Entrada                   ld_fa_histcade.hicacodi%TYPE         Código del historial
       inuHicadepp       Entrada                   ld_fa_histcade.hicadepp%TYPE         Código del descuento por pronto pago
       inuHicaesde       Entrada                   ld_fa_histcade.hicaesde%TYPE         Estado actual del registro
       inuHicausid       Entrada                   ld_fa_histcade.hicausid%TYPE         Usuario que ingresa el registro
       onuResp           Salida                    number                               Código de error

     **************************************************************************************************************************************

      Nombre         : GetHistoCade
      Descripción    : Componente de negocio que permite verificar la existencia del historil a través del código

      Parámetros     :

      Nombre Parámetro        Tipo de parámetro        Tipo de dato del parámetro            Descripción
        inuHicacodi            Entrada                  ld_fa_histcade.hicacodi%TYPE          Código del registro
        onuResp                Salida                   Number                                Código de error
      **************************************************************************************************************************************

      Nombre         : GetRegisterHistocade
      Descripción    : Componente de negocio que permite verificar la existencia de los registros de un historial a partir del código

      Parámetros

       Nombre Parámetro  Tipo de parámetro      Tipo de dato del parámetro            Descripción
        iodtHicafere       Entrada/Salida         ld_fa_histcade.hicafere%TYPE         Fecha que ingresa el registro
        inuHicacodi        Entrada                ld_fa_histcade.hicacodi%TYPE         Código de registro
        ionuHicadepp       Entrada/Salida         ld_fa_histcade.hicadepp%TYPE         Código del descuento por pronto pago
        ionuHicaesde       Entrada/Salida         ld_fa_histcade.hicaesde%TYPE         Estado actual del registro
        ionuHicausid       Entrada/Salida         ld_fa_histcade.hicausid%TYPE         Usuario que ingresa el registro
        onuResp            Salida                 Number                               Código de error

      ***************************************************************************************************************************************
      Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================
      19/06/2024        PAcosta            OSF-2845: Cambio de esquema ADM_PERSON  
      ******************************************************************/

  Procedure Inserthistocade(Idthicafere In Ld_Fa_Histcade.Hicafere%Type,
                            Inuhicacodi In Ld_Fa_Histcade.Hicacodi%Type,
                            Inuhicadepp In Ld_Fa_Histcade.Hicadepp%Type,
                            Inuhicaesde In Ld_Fa_Histcade.Hicaesde%Type,
                            Inuhicausid In Ld_Fa_Histcade.Hicausid%Type,
                            Inudiferido In Ld_Fa_Histcade.Hicadife%Type,
                            Inususcripc In Ld_Fa_Histcade.Hicasusc%Type,
                            Inuestaanct In Ld_Fa_Histcade.Hicaesan%Type,
                            Onuresp     Out Number);

  Procedure Gethistocade(Inuhicacodi In Ld_Fa_Histcade.Hicacodi%Type,
                         Onuresp     Out Number);

  Procedure Getregisterhistocade(Iodthicafere In Out Ld_Fa_Histcade.Hicafere%Type,
                                 Inuhicacodi  In Ld_Fa_Histcade.Hicacodi%Type,
                                 Ionuhicadepp In Out Ld_Fa_Histcade.Hicadepp%Type,
                                 Ionuhicaesde In Out Ld_Fa_Histcade.Hicaesde%Type,
                                 Ionuhicausid In Out Ld_Fa_Histcade.Hicausid%Type,
                                 Onuresp      Out Number);
								 FUNCTION fsbVersion RETURN varchar2;

End Pkld_Fa_Bchistocade;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Bchistocade Is
 csbVersion constant varchar2(250) := 'SAO209498';
  /*Procedimiento para insertar el historial de los descuentos por pronto pago*/
  Procedure Inserthistocade(Idthicafere In Ld_Fa_Histcade.Hicafere%Type,
                            Inuhicacodi In Ld_Fa_Histcade.Hicacodi%Type,
                            Inuhicadepp In Ld_Fa_Histcade.Hicadepp%Type,
                            Inuhicaesde In Ld_Fa_Histcade.Hicaesde%Type,
                            Inuhicausid In Ld_Fa_Histcade.Hicausid%Type,
                            Inudiferido In Ld_Fa_Histcade.Hicadife%Type,
                            Inususcripc In Ld_Fa_Histcade.Hicasusc%Type,
                            Inuestaanct In Ld_Fa_Histcade.Hicaesan%Type,
                            Onuresp     Out Number) Is

    Gsberrmsg Ge_Error_Log.Description%Type; /*mensaje de error en la excepción*/

  Begin
    Pkerrors.Push('PKLD_FA_BCHISTOCADE.InsertHistoCade');
    Gethistocade(Inuhicacodi, Onuresp);
    /*se insertan datos en la tabla Historial de Cambios de estado en Descuentos por Pronto Pago*/
    If (Onuresp != 1) Then
      Insert Into Ld_Fa_Histcade
        (Hicafere,
         Hicacodi,
         Hicadepp,
         Hicaesde,
         Hicausid,
         Hicadife,
         Hicasusc,
         Hicaesan)
      Values
        (Idthicafere,
         Inuhicacodi,
         Inuhicadepp,
         Inuhicaesde,
         Inuhicausid,
         Inudiferido,
         Inususcripc,
         Inuestaanct);
    End If;
    Pkerrors.Pop;
    Onuresp := 1;

    /*Validación de excepciones*/
  Exception
    When Others Then
      Rollback;
      Onuresp := -1;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Inserthistocade;

  /*Procedimiento que permite verificar la existencia de los registros dentro de un historial*/
  Procedure Gethistocade(Inuhicacodi In Ld_Fa_Histcade.Hicacodi%Type,
                         Onuresp     Out Number) Is
    Gsberrmsg  Ge_Error_Log.Description%Type; /*mensaje de error en la excepción*/
    Nucontador Number; /*contador para el número de registros dentro de un historial*/

    /*cursor para obtener el número de registros dentro de un historial*/
    Cursor Culd_Fa_Histcade Is
      Select Count(1) From Ld_Fa_Histcade Where Hicacodi = Inuhicacodi;
  Begin

    Pkerrors.Push('PKLD_FA_BCHISTOCADE.GetHistoCade');
    /*se abre el cursor y luego se verifica que hayan registros en el cursor*/
    Open Culd_Fa_Histcade;
    Fetch Culd_Fa_Histcade
      Into Nucontador;
    Close Culd_Fa_Histcade;

    If (Nucontador = 0) Then
      Onuresp := 0;
    Else
      Onuresp := 1;
    End If;

    Pkerrors.Pop;


    /*Validación de excepciones*/
  Exception
    When Others Then
      Rollback;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Gethistocade;

  /*Procedimiento que permite verificar la existencia de un historial a partir de un código*/
  Procedure Getregisterhistocade(Iodthicafere In Out Ld_Fa_Histcade.Hicafere%Type,
                                 Inuhicacodi  In Ld_Fa_Histcade.Hicacodi%Type,
                                 Ionuhicadepp In Out Ld_Fa_Histcade.Hicadepp%Type,
                                 Ionuhicaesde In Out Ld_Fa_Histcade.Hicaesde%Type,
                                 Ionuhicausid In Out Ld_Fa_Histcade.Hicausid%Type,
                                 Onuresp      Out Number) Is
    Gsberrmsg Ge_Error_Log.Description%Type;

    /*cursor para obtener los datos de determinado historial, a partir del código*/
    Cursor Culd_Fa_Histcade Is
      Select Hicafere, Hicadepp, Hicaesde, Hicausid
        From Ld_Fa_Histcade
       Where Hicacodi = Inuhicacodi;

  Begin
    Pkerrors.Push('PKLD_FA_BCHISTOCADE.GetRegisterHistocade');

    /*se abre el cursor y luego se verifica que existan datos en el cursor*/
    Open Culd_Fa_Histcade;
    Fetch Culd_Fa_Histcade
      Into Iodthicafere, Ionuhicadepp, Ionuhicaesde, Ionuhicausid;
    If (Culd_Fa_Histcade%Notfound) Then
      Onuresp := 0;
    Else
      Onuresp := 1;
    End If;
    Close Culd_Fa_Histcade;
    Pkerrors.Pop;
    Onuresp := 1;

    /*Validación de excepciones*/
  Exception
    When Others Then
      Rollback;
      Onuresp := -1;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Getregisterhistocade;
   /****************************************************************************
      Funcion       :  fsbVersion

      Descripcion  :  Obtiene el SAO que identifica la version asociada a la
                       ultima entrega del paquete

      Retorno      :  csbVersion - Version del Paquete
    *****************************************************************************/

    FUNCTION fsbVersion RETURN varchar2 IS
    BEGIN
    --{
        -- Retorna el SAO con que se realizó la última entrega del paquete
        return (csbVersion);
    --}
    END fsbVersion;
End Pkld_Fa_Bchistocade;
/
PROMPT Otorgando permisos de ejecucion a PKLD_FA_BCHISTOCADE
BEGIN
    pkg_utilidades.praplicarpermisos('PKLD_FA_BCHISTOCADE', 'ADM_PERSON');
END;
/