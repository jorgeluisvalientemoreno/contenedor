CREATE OR REPLACE Package adm_person.Pkld_Fa_Bcodedetadesc Is

  /*************************************************************************************************************
        Propiedad intelectual de Ludycom S.A.

        Unidad         : pkLD_FA_BcoDeDetaDesc
        Descripción    : Componente de negocio que permite gestionar los detalles de descuento por pronto pago.
        Autor          : Jsilvera.SAOJery.Silvera.
        Fecha          : 21/09/2012

        Métodos

        Nombre         : InsertDetaDesc
        Descripción    : Componente de negocio que permite insertar los detalles de descuento por pronto pago.

        Parámetros     :

        Nombre Parámetro     Tipo de parámetro        Tipo de dato del parámetro                  Descripción
          inudedpcodi          Entrada                  ld_fa_detadepp.dedpcodi%TYPE                Parámetro del código del detalle de descuento por pronto pago
          inudedpsusc          Entrada                  ld_fa_detadepp.dedpsusc%TYPE                Parámetro de suscripción
          inudedpdife          Entrada                  ld_fa_detadepp.dedpdife%TYPE                Parámetro de código diferido
          inudedpvasa          Entrada                  ld_fa_detadepp.dedpvasa%TYPE                Parámetro de valor saldo descuento
          inudedpvade          Entrada                  ld_fa_detadepp.dedpvade%TYPE                Parámetro de valor descuento
          inudedpnucu          Entrada                  ld_fa_detadepp.dedpnucu%TYPE                Parámetro de cuota
          inudedpvacu          Entrada                  ld_fa_detadepp.dedpvacu%TYPE                Parámetro de valor cuota
          isbdedpobse          Entrada                  ld_fa_detadepp.dedpobse%TYPE                Parámetro de observaciones
          inudedpusid          Entrada                  ld_fa_detadepp.dedpusid%TYPE                Parámetro del id de usuario
          idtdedpfere          Entrada                  ld_fa_detadepp.dedpfere%TYPE                Parámetro de fecha que ingresa registro
          inudeppcode          Entrada                  ld_fa_detadepp.deppcode%TYPE                Parámetro de código del descuento por pronto pago
          onuResp              Salida                   Number                                      Parámetro de código de error
  **************************************************************************************************************************************

        Nombre         : GetDetaDesc
        Descripción    : Componente de negocio que permite obtener la cantidad de registros de un Detalle
                         de Descuento específico.

        Parámetros     :

        Nombre Parámetro     Tipo de parámetro        Tipo de dato del parámetro                   Descripción
          inudedpcodi          Entrada                  ld_fa_detadepp.dedpcodi%TYPE                 Parámetro del código del detalle de descuento por pronto pago
          onuResp              Salida                   Number                                       Parámetro de código de error
   **************************************************************************************************************************************

        Nombre         : GetRegisterDetaDesc
        Descripción    : Componente de negocio que permite obtener el detalle de los descuentos por pronto pago que se han
                         realizado a un supscriptor específico.

        Parámetros     :

        Nombre Parámetro     Tipo de parámetro        Tipo de dato del parámetro                   Descripción
          inudedpcodi          Entrada                  ld_fa_detadepp.dedpcodi%TYPE                 Parámetro del código del detalle de descuento por pronto pago
          ionudedpsusc         Entrada/Salida           ld_fa_detadepp.dedpsusc%TYPE                 Parámetro de suscripción
          ionudedpdife         Entrada/Salida           ld_fa_detadepp.dedpdife%TYPE                 Parámetro de código diferido
          ionudedpvasa         Entrada/Salida           ld_fa_detadepp.dedpvasa%TYPE                 Parámetro de valor saldo descuento
          ionudedpvade         Entrada/Salida           ld_fa_detadepp.dedpvade%TYPE                 Parámetro de valor descuento
          ionudedpnucu         Entrada/Salida           ld_fa_detadepp.dedpnucu%TYPE                 Parámetro de cuota
          ionudedpvacu         Entrada/Salida           ld_fa_detadepp.dedpvacu%TYPE                 Parámetro de valor cuota
          iosbdedpobse         Entrada/Salida           ld_fa_detadepp.dedpobse%TYPE                 Parámetro de observaciones
          ionudedpusid         Entrada/Salida           ld_fa_detadepp.dedpusid%TYPE                 Parámetro de usuario
          iodtdedpfere         Entrada/Salida           ld_fa_detadepp.dedpfere%TYPE                 Parámetro de fecha que ingresa registro
          ionudeppcode         Entrada/Salida           ld_fa_detadepp.deppcode%TYPE                 Parámetro de código del descuento por pronto pago
          onuResp              Salida                   Number                                       Parámetro de código de error
   **************************************************************************************************************************************

        Nombre         : GetMaximaFecha
        Descripción    : Componente de negocio que permite obtener la última fecha de registro de una suscripción específica.

        Parámetros     :

          Nombre Parámetro     Tipo de parámetro        Tipo de dato del parámetro                 Descripción
          inudedpsusc          Entrada                  ld_fa_detadepp.dedpsusc%TYPE                 Parámetro de suscripción
          odtFecha             Salida                   ld_fa_detadepp.dedpfere%TYPE                 Parámetro de fecha que ingresa registro
          onuResp              Salida                   Number                                       Parámetro de código de error
   **************************************************************************************************************************************

        Historia de Modificaciones
        Fecha             Autor             Modificación
        =========         =========         ====================
    ******************************************************************************************************************/
  /**************************************************************************************************************************************

       Nombre         : getiddescp
       Descripción    : Función que retorna el consecutivo de la secuencia para el Detalle del Descuento

       Parámetros     :


  **************************************************************************************************************************************

       Historia de Modificaciones
       Fecha             Autor             Modificación
       =========         =========         ====================
   ******************************************************************************************************************/

  -- Inserta los detalles del Descuento por Pronto Pago
  Procedure Insertdetadesc(Inudedpcodi In Ld_Fa_Detadepp.Dedpcodi%Type,
                           Inudedpsusc In Ld_Fa_Detadepp.Dedpsusc%Type,
                           Inudedpdife In Ld_Fa_Detadepp.Dedpdife%Type,
                           Inudedpvasa In Ld_Fa_Detadepp.Dedpvasa%Type,
                           Inudedpvade In Ld_Fa_Detadepp.Dedpvade%Type,
                           Inudedpnucu In Ld_Fa_Detadepp.Dedpnucu%Type,
                           Inudedpvacu In Ld_Fa_Detadepp.Dedpvacu%Type,
                           Isbdedpobse In Ld_Fa_Detadepp.Dedpobse%Type,
                           Inudedpusid In Ld_Fa_Detadepp.Dedpusid%Type,
                           Idtdedpfere In Ld_Fa_Detadepp.Dedpfere%Type,
                           Inudeppcode In Ld_Fa_Detadepp.Deppcode%Type,
                           Inudepppefa In Ld_Fa_Detadepp.Depppefa%Type,
                           InuDeppcuco In ld_fa_detadepp.deppcuco%Type,
                           Inudeppesco In Ld_Fa_Detadepp.Deppesco%Type);

  -- Obtiene la cantidad de registros de un Detalle de Descuento específico
  Procedure Getdetadesc(Inudedpcodi In Ld_Fa_Detadepp.Dedpcodi%Type,
                        Onuresp     Out Number);

  -- Obtiene el detalle de los Descuentos por Pronto Pago que se han realizado
  -- a un suscriptor específico
  Procedure Getregisterdetadesc(Inudedpcodi  In Ld_Fa_Detadepp.Dedpcodi%Type,
                                Ionudedpsusc In Out Ld_Fa_Detadepp.Dedpsusc%Type,
                                Ionudedpdife In Out Ld_Fa_Detadepp.Dedpdife%Type,
                                Ionudedpvasa In Out Ld_Fa_Detadepp.Dedpvasa%Type,
                                Ionudedpvade In Out Ld_Fa_Detadepp.Dedpvade%Type,
                                Ionudedpnucu In Out Ld_Fa_Detadepp.Dedpnucu%Type,
                                Ionudedpvacu In Out Ld_Fa_Detadepp.Dedpvacu%Type,
                                Iosbdedpobse In Out Ld_Fa_Detadepp.Dedpobse%Type,
                                Ionudedpusid In Out Ld_Fa_Detadepp.Dedpusid%Type,
                                Iodtdedpfere In Out Ld_Fa_Detadepp.Dedpfere%Type,
                                Ionudeppcode In Out Ld_Fa_Detadepp.Deppcode%Type,
                                Onuresp      Out Number);

  -- Obtiene la última Fecha de Registro de una suscripción específica
  Procedure Getmaximafecha(Inudedpsusc In Ld_Fa_Detadepp.Dedpsusc%Type,
                           Odtfecha    Out Ld_Fa_Detadepp.Dedpfere%Type,
                           Onuresp     Out Number);

  -- Obtiene el siguiente numero de la secuencia para el Detalle del Descuento
  Function Getiddescp Return Number;
  -- Obtiene tru o false dependiendo si se enucuentra o no el registro procesado para el periodo indicado

  Function Getregisterdescuento(Nususcripc Suscripc.Susccodi%Type,
                                Nudiferido Diferido.Difecodi%Type,
                                Nupefa     Perifact.Pefacodi%Type)
    Return Boolean;

  -- Obtiene la Version actual del Paquete
  Function Fsbversion Return Varchar2;

End Pkld_Fa_Bcodedetadesc;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Bcodedetadesc Is
  --{

  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  Csbversion Constant Varchar2(250) := 'OSF-2884';

  -- Inserta los detalles del Descuento por Pronto Pago
/*Historial de Modificaciones
  Usuario                 SAO              Descripción
 Jery Ann Silvera      SAO212465       Se agrega nuevo parametro de entrada, Cuenta de Cobro para que puedan
                                        Validar cuales son los cargos generados de esta aplicación de descuento
*/
  Procedure Insertdetadesc(Inudedpcodi In Ld_Fa_Detadepp.Dedpcodi%Type,
                           Inudedpsusc In Ld_Fa_Detadepp.Dedpsusc%Type,
                           Inudedpdife In Ld_Fa_Detadepp.Dedpdife%Type,
                           Inudedpvasa In Ld_Fa_Detadepp.Dedpvasa%Type,
                           Inudedpvade In Ld_Fa_Detadepp.Dedpvade%Type,
                           Inudedpnucu In Ld_Fa_Detadepp.Dedpnucu%Type,
                           Inudedpvacu In Ld_Fa_Detadepp.Dedpvacu%Type,
                           Isbdedpobse In Ld_Fa_Detadepp.Dedpobse%Type,
                           Inudedpusid In Ld_Fa_Detadepp.Dedpusid%Type,
                           Idtdedpfere In Ld_Fa_Detadepp.Dedpfere%Type,
                           Inudeppcode In Ld_Fa_Detadepp.Deppcode%Type,
                           Inudepppefa In Ld_Fa_Detadepp.Depppefa%Type,
                           InuDeppcuco In ld_fa_detadepp.deppcuco%Type, -- cuenta de cobro
                           Inudeppesco In Ld_Fa_Detadepp.Deppesco%Type
                           ) Is

    Onuresp   Number;
    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Eerror

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.InsertDetaDesc');

    -- Obtiene la cantidad de registros de un Detalle de Descuento específico
    Getdetadesc(Inudedpcodi, Onuresp);

    -- Valida que el Detalle a insertar ya no exista

    If (Onuresp = 0) Then
      --{
      Insert Into Ld_Fa_Detadepp
        (Dedpcodi,
         Dedpsusc,
         Dedpdife,
         Dedpvasa,
         Dedpvade,
         Dedpnucu,
         Dedpvacu,
         Dedpobse,
         Dedpusid,
         Dedpfere,
         Deppcode,
         Depppefa,
         Deppesco,
         deppcuco)
      Values
        (Inudedpcodi,
         Inudedpsusc,
         Inudedpdife,
         Inudedpvasa,
         Inudedpvade,
         Inudedpnucu,
         Inudedpvacu,
         Isbdedpobse,
         Inudedpusid,
         Idtdedpfere,
         Inudeppcode,
         Inudepppefa,
         Inudeppesco,
         InuDeppcuco);
      --}
    End If;

    Pkerrors.Pop;

  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Insertdetadesc;

  -- Obtiene la cantidad de registros de un Detalle de Descuento específico

  Procedure Getdetadesc(Inudedpcodi In Ld_Fa_Detadepp.Dedpcodi%Type,
                        Onuresp     Out Number) Is

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error

    -- Cursor para obtener la cantidad de registros de un Detalle de Descuento específico
    Cursor Culd_Fa_Detadepp Is
      Select Count(1) From Ld_Fa_Detadepp Where Dedpcodi = Inudedpcodi;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.GetDetaDesc');

    -- Abre el cursor y verifica si hay registros
    Open Culd_Fa_Detadepp;
    Fetch Culd_Fa_Detadepp
      Into Onuresp;

    If (Culd_Fa_Detadepp%Notfound) Then
      --{
      Onuresp := 0;
      --}
    End If;

    Close Culd_Fa_Detadepp;
    Pkerrors.Pop;

  Exception
    When Others Then
      If (Culd_Fa_Detadepp%Isopen) Then
        --{
        Close Culd_Fa_Detadepp;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Getdetadesc;

  -- Obtiene el detalle de los Descuentos por Pronto Pago que se han realizado
  -- a un suscriptor específico

  Procedure Getregisterdetadesc(Inudedpcodi  In Ld_Fa_Detadepp.Dedpcodi%Type,
                                Ionudedpsusc In Out Ld_Fa_Detadepp.Dedpsusc%Type,
                                Ionudedpdife In Out Ld_Fa_Detadepp.Dedpdife%Type,
                                Ionudedpvasa In Out Ld_Fa_Detadepp.Dedpvasa%Type,
                                Ionudedpvade In Out Ld_Fa_Detadepp.Dedpvade%Type,
                                Ionudedpnucu In Out Ld_Fa_Detadepp.Dedpnucu%Type,
                                Ionudedpvacu In Out Ld_Fa_Detadepp.Dedpvacu%Type,
                                Iosbdedpobse In Out Ld_Fa_Detadepp.Dedpobse%Type,
                                Ionudedpusid In Out Ld_Fa_Detadepp.Dedpusid%Type,
                                Iodtdedpfere In Out Ld_Fa_Detadepp.Dedpfere%Type,
                                Ionudeppcode In Out Ld_Fa_Detadepp.Deppcode%Type,
                                Onuresp      Out Number) Is

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error

    -- Obtiene los detalles del Descuento por Pronto Pago a partir de un detalle específico
    Cursor Culd_Fa_Detadepp Is
      Select Dedpsusc,
             Dedpdife,
             Dedpvasa,
             Dedpvade,
             Dedpnucu,
             Dedpvacu,
             Dedpobse,
             Dedpusid,
             Dedpfere,
             Deppcode
        From Ld_Fa_Detadepp d
       Where Dedpcodi = Inudedpcodi;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.GetRegisterDetaDesc');
    Onuresp := 0;

    -- Se abre el cursor y se verifica que hayan datos
    Open Culd_Fa_Detadepp;
    Fetch Culd_Fa_Detadepp
      Into Ionudedpsusc,
           Ionudedpdife,
           Ionudedpvasa,
           Ionudedpvade,
           Ionudedpnucu,
           Ionudedpvacu,
           Iosbdedpobse,
           Ionudedpusid,
           Iodtdedpfere,
           Ionudeppcode;

    If (Culd_Fa_Detadepp%Found) Then
      --{
      Onuresp := 1;
      --}
    End If;

    Close Culd_Fa_Detadepp;
    Pkerrors.Pop;

  Exception
    When Others Then
      If (Culd_Fa_Detadepp%Isopen) Then
        --{
        Close Culd_Fa_Detadepp;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Getregisterdetadesc;

  -- Obtiene la última Fecha de Registro de una suscripción específica

  Procedure Getmaximafecha(Inudedpsusc In Ld_Fa_Detadepp.Dedpsusc%Type,
                           Odtfecha    Out Ld_Fa_Detadepp.Dedpfere%Type,
                           Onuresp     Out Number) Is

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error

    -- Cursor para obtener la última fecha de registro de la Suscripción
    Cursor Cumaxfecha Is
      Select Max(Deppfere)
        From Ld_Fa_Descprpa
       Where Deppsusc = Inudedpsusc;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.GetMaximaFecha');

    -- Se abre el cursor y se verifica que hayan datos
    Open Cumaxfecha;
    Fetch Cumaxfecha
      Into Odtfecha;

    If (Cumaxfecha%Notfound) Then
      --{
      Odtfecha := Sysdate;
      --}
    End If;

    Close Cumaxfecha;
    Pkerrors.Pop;
    Onuresp := 1;

  Exception
    When Others Then
      If (Cumaxfecha%Isopen) Then
        --{
        Close Cumaxfecha;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Getmaximafecha;

  -- Obtiene el siguiente numero de la secuencia para el Detalle del Descuento

  Function Getiddescp Return Number Is

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error
    Secuencia Number;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.GetIdDescP');

    -- Obtiene el siguiente valor de la secuencia
    Select Seq_Detadepp.Nextval Into Secuencia From Dual;

    Pkerrors.Pop;
    Return(Secuencia);

  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Getiddescp;
  /****************************************************************************
    Funcion       :  GetRegisterDescuento

    Descripcion :  Obtiene True o False si encuentra o no este registro procesado para el periodo de facturaicón enviado como parametro

    Retorno     :  True: si encuentra el registro procesado.
                   False: Si no encuentra el registro Procesado
  *****************************************************************************/

  Function Getregisterdescuento(Nususcripc Suscripc.Susccodi%Type,
                                Nudiferido Diferido.Difecodi%Type,
                                Nupefa     Perifact.Pefacodi%Type)
    Return Boolean Is

    Gsberrmsg Ge_Error_Log.Description%Type; -- Mensaje de Error
    Regis Number;
  Begin
    --{
    Pkerrors.Push('pkLD_FA_BcoDeDetaDesc.GetRegisterDescuento');

    -- Consulta para saber si este registro fué o no procesado
    Select Count(1)
      Into Regis
      From Ld_Fa_Detadepp d
     Where d.Dedpsusc = Nususcripc
       And d.Dedpdife = Nudiferido
       And d.Depppefa = Nupefa;
    If (Regis > 0) Then
      Return True; -- encontró datos
    Else
      Return False; -- no encontró datos
    End If;

    Pkerrors.Pop;

  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
      --}
  End Getregisterdescuento;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function Fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;

--}
End Pkld_Fa_Bcodedetadesc;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Bcodedetadesc
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Bcodedetadesc'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCODEDETADESC to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCODEDETADESC to RSELSYS;
/
