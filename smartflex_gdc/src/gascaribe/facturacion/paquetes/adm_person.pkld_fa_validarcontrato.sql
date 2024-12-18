CREATE OR REPLACE Package adm_person.Pkld_Fa_Validarcontrato Is

  -- Author  : JERY
  -- Created : 31/05/2013 11:07:44 a. m.
  -- Purpose : Servicio que obtiene las funciones de validaciones correspondientes a las refinanaciaciones, cuentas vencidas, cuentas sin vencer y pagos realziados


/****************Historial e Modificaciones **************************
Fecha               Usuario
2013-08-15           JsilveraSAO213253
Se crea la función   fbgetabono para obtener los abonos realizados por los usuarios
Se crea la función   Fblgetcargocuotafina para validar si el usuario tiene la uota de financiación generada
*********************************************************************/
  v_p_Solicitud_Refinanciacion Mo_Packages.Package_Type_Id%Type := 279;

  -- Función para validar la cantidad de Refinanciaciones
  Function Fbovalidaterefinancing(Inususccodi    In Suscripc.Susccodi%Type, -- Codigo del Suscriptor
                                  Fechamatricula In Date -- Fecha de Matricula al Descuento por Pronto Pago
                                  ) Return Boolean;

  /*Función que valida la cantidad de Pagos realizados por un usuario, si estan dentro de su fecha limite de pago o no*/
  Function Fnc_Validapagosmes1(Inususc         In Suscripc.Susccodi%Type, -- contrato
                               Fechalimpago    In Perifact.Pefafepa%Type, -- Fecha limite de pago
                               Periodoanterior In Perifact.Pefacodi%Type -- periodo anterior del anterior
                               ) Return Boolean;

  Function Fnc_Validapagosmes2(Inususc         In Suscripc.Susccodi%Type, -- contrato
                               Fechalimpago    In Perifact.Pefaffpa%Type, -- Segunda Fecha de pago de la segunda factura
                               Periodoanterior In Perifact.Pefacodi%Type, -- periodo anterior
                               Nudias          In Number) Return Boolean;

  -- Servicio para obtener la cantidad de Facturas con Saldo
  Function Fnc_Validarcuentasvencidas(Inususc       In Suscripc.Susccodi%Type,
                                      Periodoactual In Perifact.Pefacodi%Type)
    Return Number;

  -- Servicio para determinar si hay Factura con Saldo en el Periodo Actual
  Function Fnc_Facturamesactual(Inususc       In Suscripc.Susccodi%Type,
                                Periodoactual In Perifact.Pefacodi%Type)
    Return Boolean;

  -- Servicio para obtener el Periodo de la Factura vencida cuando solo hay una
  Function Fnuobtperifactvenc(Inuidsusc     In Suscripc.Susccodi%Type,
                              Inuidperiactu In Perifact.Pefacodi%Type)
    Return Perifact.Pefacodi%Type;

  -- Obtiene la Fecha del Último Pago aplicado a la Factura de un Periodo especifico
  Function Fdtultipagofactperi(Inuidsusc    In Suscripc.Susccodi%Type,
                               Inuidperiodo In Perifact.Pefacodi%Type)
    Return Cuencobr.Cucofepa%Type;
  -- Servicio para determinar si tiene o no cargo de financiaciación para la factura generada.
  Function Fblgetcargocuotafina(Inufactura   In Factura.Factcodi%Type, -- Numero de factura
                                Inucuenta    In Cuencobr.Cucocodi%Type, -- Cuenta de cobro
                                Inuconccargo In Cargos.Cargconc%Type, -- concepto del Cargo
                                Inunuse      In Servsusc.Sesunuse%Type

                                ) Return Boolean;
  -- retorna el total del abono
  Function fbgetabono(nususcodi  in suscripc.susccodi%type,
                      nuPeriodo  in perifact.pefacodi%type,
                      Nudifecodi in diferido.difecodi%type) return number;
  -- Obtiene la Version actual del Paquete
  Function Fsbversion Return Varchar2;

End;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Validarcontrato Is
  --{
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  Csbversion Constant Varchar2(250) := 'OSF-2884';

  -- Valida si un suscriptor ha presentado una Refinanciado posterior a su Fecha de Matrìcula al Descuento

  Function Fbovalidaterefinancing(Inususccodi    In Suscripc.Susccodi%Type, -- Codigo del Suscriptor
                                  Fechamatricula In Date -- Fecha de Matricula al Descuento por Pronto Pago
                                  ) Return Boolean Is

    Borefinancia Boolean := False; -- TRUE - Cuando hay Refinanciaciación, FALSE - En caso contrario

    Cursor Curefinan Is
      Select /*+ first_rows(1) */
       p.Package_Id
        From Mo_Packages p, Mo_Motive m
       Where m.Subscription_Id = Inususccodi
         And m.Attention_Date > Fechamatricula
         And p.Package_Id = m.Package_Id
         And p.Package_Type_Id = v_p_Solicitud_Refinanciacion -- Solicitud de Financiacion de Deuda
         And p.Motive_Status_Id =
             Ld_Fa_Fnu_Paragene('ESTADO_SOLICITUD_ATENDIDA');

    Regcurefinan Curefinan%Rowtype;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.fboValidateRefinancing');

    -- Verifica si hay alguna Refinanciaciones
    Open Curefinan;
    Fetch Curefinan
      Into Regcurefinan;

    If (Curefinan%Found) Then
      --{
      Borefinancia := True;
      --}
    End If;

    Close Curefinan;
    Pkerrors.Pop;
    Return(Borefinancia);

  Exception
    When Others Then
      If (Curefinan%Isopen) Then
        Close Curefinan;
      End If;

      Pkerrors.Pop;
      --}
  End Fbovalidaterefinancing;

  -- Valida los Papos del Periodo de Facturación correspondiente a dos meses atras (mes 1)

  Function Fnc_Validapagosmes1(Inususc         In Suscripc.Susccodi%Type, -- Contrato
                               Fechalimpago    In Perifact.Pefafepa%Type, -- Segunda Fecha de Pago de la segunda Factura
                               Periodoanterior In Perifact.Pefacodi%Type) -- Periodo anterior
   Return Boolean Is

    /*************************************************************************************************************
          Propiedad intelectual de Ludycom S.A.

          Unidad         : Fnc_ValidaPagosMes1
          Descripci¿n    : Función que valida las Cuentas con Saldo y los Pagos realizados
                           de un usuario del Periodo de Facturación 1 a validar.
          Autor          : Jsilvera.SAO157301.
          Fecha          : 31/05/2013

         Par¿metros     :

          Nombre Par¿metro  Tipo de par¿metro        Tipo de dato del par¿metro            Descripción
         Inususc             Entrada                   Suscripc.Susccodi%Type,              Contrato
         FechaLimPago       Entrada                    perifact.pefaffpa%Type,              Fecha de pago
        PeriodoAnterior     Entrada                    perifact.pefacodi%Type               Periodo anterior

    **************************************************************************************************************************************

          Historia de Modificaciones
          Fecha             Autor             Modificación
          =========         =========         ====================
    *******************************************************************************************************************/

    /*Cursor para validar los pagos de un usuario, si estan dentro de la fecha o fuera de la fecha*/
    Cursor Curpagos Is
      Select Count(Unique Factcodi) /*Si conteo es 0, la factura fue pagada dentro de la fecha limite de pago*/
        From Factura f, Cuencobr c
       Where f.Factpefa = Periodoanterior
         And Factcodi = c.Cucocodi
         And (Nvl(c.Cucosacu, 0) - c.Cucovare - Nvl(c.Cucovrap, 0)) = 0
         And (c.Cucofepa > Fechalimpago)
         And f.Factsusc = Inususc
         And f.Factprog = 6; -- programa de la FGCC

    /*Declaración de Variables*/
    Contpagos Number;
    Osberrmsg Ge_Message.Description%Type;

    -- Se retorna False cuando se pago dentro de la segunda fecha limite de pago mas n días y
    -- True cuando se pagó por fuera de la segunda fecha limite de pago mas n días
    Bopagosfuera Boolean := False;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.Fnc_ValidaPagosMes1');

    /*Cursor Obtiene la cantidad de pagos realizados fuera de la segunda Fecha limite de pago*/
    Open Curpagos;
    Fetch Curpagos
      Into Contpagos;
    Close Curpagos;

    /*Cantidad de Pagos realziados fuera de la segunda Fecha limite de pago*/

    If (Contpagos > 0) Then
      --{
      Bopagosfuera := True; -- Se retorna True cuando se pagó por fuera de la segunda fecha limite de pago mas n días
      --}
    End If;

    Pkerrors.Pop;

  Exception
    When Others Then
      If (Curpagos%Isopen) Then
        --{
        Close Curpagos;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Validapagosmes1;

  /*Función que valida los pagos del Periodo de Facturación anterior*/
  Function Fnc_Validapagosmes2(Inususc         In Suscripc.Susccodi%Type, --contrato
                               Fechalimpago    In Perifact.Pefaffpa%Type, -- Segunda Fecha de pago de la segunda factura
                               Periodoanterior In Perifact.Pefacodi%Type, -- periodo anterior
                               Nudias          In Number) -- cantidad de días
   Return Boolean Is

    /*************************************************************************************************************
          Propiedad intelectual de Ludycom S.A.

          Unidad         : Fnc_ValidapagosMes2
          Descripci¿n    : Función que Valida Las cuentas con saldo y pagos realizados de un usuario del periodo de Facturación 2.
          Autor          : Jsilvera.SAO157301.
          Fecha          : 31/05/2013

         Par¿metros     :

          Nombre Par¿metro  Tipo de par¿metro        Tipo de dato del par¿metro            Descripción
         Inususc             Entrada                   Suscripc.Susccodi%Type,              Contrato
         FechaLimPago       Entrada                    perifact.pefaffpa%Type,              Fecha de pago
        PeriodoAnterior     Entrada                    perifact.pefacodi%Type               Periodo anterior

    **************************************************************************************************************************************

          Historia de Modificaciones
          Fecha             Autor             Modificación
          =========         =========         ====================
    *******************************************************************************************************************/

    /*Cursor Para validar los pagos de un usuario, si estan dentro de la fecha o fuera de la fecha*/
    Cursor Curpagos Is
      Select Count(Unique Factcodi) /*Si conteo es 0, la factura fue pagada dentro de la fecha limite de pago*/
        From Factura f, Cuencobr c
       Where f.Factpefa = Periodoanterior
         And Factcodi = c.Cucocodi
         And (Nvl(c.Cucosacu, 0) - c.Cucovare - Nvl(c.Cucovrap, 0)) = 0
         And (c.Cucofepa > Fechalimpago + Nudias)
         And f.Factsusc = Inususc
         And f.Factprog = 6; -- programa de la FGCC

    /*Declaración de Variables*/
    Contpagos Number;
    Osberrmsg Ge_Message.Description%Type;

    -- Se retorna False cuando se pago dentro de la segunda fecha limite de pago mas n días y
    -- True cuando se pagó por fuera de la segunda fecha limite de pago mas n días
    Bopagosfuera Boolean := False;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.Fnc_ValidapagosMes2');

    /*Cursor Obtiene la cantidad de pagos realziados fuera de la segunda Fecha limite de pago*/
    Open Curpagos;
    Fetch Curpagos
      Into Contpagos;
    Close Curpagos;

    /*Cantidad de Pagos realizados fuera de la segunda Fecha limite de pago*/

    If (Contpagos > 0) Then
      --{
      Bopagosfuera := True; -- Se retorna True cuando se pagó por fuera de la segunda fecha limite de pago mas n días
      --}
    End If;

    Pkerrors.Pop;

  Exception
    When Others Then
      If (Curpagos%Isopen) Then
        --{
        Close Curpagos;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Validapagosmes2;

  Function Fnc_Validarcuentasvencidas(Inususc       In Suscripc.Susccodi%Type, -- Contrato
                                      Periodoactual In Perifact.Pefacodi%Type) -- Periodo actual
   Return Number Is

    /*************************************************************************************************************
          Propiedad intelectual de Ludycom S.A.

          Unidad         : Fnc_Validarcuentasvencidas
          Descripcion    : Función que obtiene la cantidad de Facturas con Saldo que tiene un suscriptor
                           generadas por FGCC y que no sean del Periodo actual
          Autor          : Jsilvera.SAO157301.
          Fecha          : 16/05/2013

         Par¿metros     :

          Nombre Par¿metro  Tipo de par¿metro        Tipo de dato del par¿metro            Descripción
          Inususc            Entrada                   suscripc.susscodi%Type,             Contrato dle Cliente
          Periodoactual      Entrada                   Perifact.pefacodi%type,              Periodo actual de Facturación
    **************************************************************************************************************************************
    Retornos
    Cantidad de cuentas vencidas


          Historia de Modificaciones
          Fecha             Autor             Modificación
          =========         =========         ====================
    *******************************************************************************************************************/

    -- Cursor para obtener la cantidad de Facturas con saldo del programa FGCC que no sean del Periodo Actual
    Cursor Curcuentascobroanterior Is
      Select Count(Unique Factcodi)
        From Factura, Cuencobr
       Where Factsusc = Inususc
         And Factpefa != Periodoactual
         And Factprog = 6 -- Corresponde al programa FGCC
         And Cucofact = Factcodi
         And (Nvl(Cucosacu, 0) - Cucovare - Nvl(Cucovrap, 0)) > 0;

    Cuentasvencidas Number;
    Osberrmsg       Ge_Message.Description%Type;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.Fnc_ValidarCuentasVencidas');

    -- Se obtiene la cantidad de Facturas vencidas para un Contrato de Periodos diferentes al actual
    Open Curcuentascobroanterior;
    Fetch Curcuentascobroanterior
      Into Cuentasvencidas;
    Close Curcuentascobroanterior;

    Pkerrors.Pop;
    Return(Cuentasvencidas); -- Retorna la cantidad de Facturas vencidas

  Exception
    When Others Then
      If (Curcuentascobroanterior%Isopen) Then
        --{
        Close Curcuentascobroanterior;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Validarcuentasvencidas;

  Function Fnc_Facturamesactual(Inususc       In Suscripc.Susccodi%Type,
                                Periodoactual In Perifact.Pefacodi%Type)
    Return Boolean Is

    /*************************************************************************************************************
          Propiedad intelectual de Ludycom S.A.

          Unidad         : Fnc_FacturaMesActual
          Descripcion    : Función que determina si hay Factura con Saldo en el Periodo actual
          Autor          : Jsilvera.SAO157301.
          Fecha          : 16/05/2013

         Par¿metros     :

          Nombre Par¿metro  Tipo de par¿metro        Tipo de dato del par¿metro            Descripción
          Inususc            Entrada                   suscripc.susscodi%Type,             Contrato dle Cliente
          Periodoactual      Entrada                   Perifact.pefacodi%type,              Periodo actual de Facturación
    **************************************************************************************************************************************
    Retornos
    True  -  Encuentra Facturas con Saldo
    False -  No encuentra Facturas con Saldo

          Historia de Modificaciones
          Fecha             Autor             Modificación
          =========         =========         ====================
    *******************************************************************************************************************/

    -- Cursor para contar la cantidad de Facturas con Saldo del Periodo actual generadas por FGCC
    Cursor Curfactura Is
      Select Count(Unique Factcodi)
        From Factura f, Cuencobr c
       Where Factsusc = Inususc
         And Factpefa = Periodoactual
         And Factprog = 6 -- Corresponda al programa FGCC
         And c.Cucofact = f.Factcodi
         And (Nvl(c.Cucosacu, 0) - c.Cucovare - Nvl(c.Cucovrap, 0)) > 0;

    Facturaactual Number;
    Osberrmsg     Ge_Error_Log.Description%Type;

    -- Devuelve FALSE si no encontró Factura con Saldo del periodo actual generada
    -- y TRUE si la encontró
    Bofacturaactual Boolean := False;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.Fnc_FacturaMesActual');

    -- Se cuentan las Facturas con Saldo del Periodo actual
    Open Curfactura;
    Fetch Curfactura
      Into Facturaactual;
    Close Curfactura;

    -- Valida el conteo de las Facturas del Periodo actual

    If (Facturaactual > 1) Then
      --{
      Bofacturaactual := True; -- Devuelve TRUE porque encontró Factura
      --}
    End If;

    Pkerrors.Pop;
    Return(Bofacturaactual);

  Exception
    When Others Then
      If (Curfactura%Isopen) Then
        --{
        Close Curfactura;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Facturamesactual;

  /*************************************************************************************************************
        Propiedad intelectual de Ludycom S.A.

        Unidad         : fnuObtPeriFactVenc
        Descripcion    : Función que obtener el Periodo de la Factura vencida cuando solo hay una
        Autor          : Jsilvera.SAO157301.
        Fecha          : 02/05/2013

       Par¿metros     :

        Nombre Par¿metro   Tipo de par¿metro        Tipo de dato del par¿metro           Descripción
        inuIdSusc          Entrada                  suscripc.susscodi%Type,              Contrato dle Cliente
        inuIdPeriActu      Entrada                  perifact.pefacodi%type,              Periodo actual de Facturación
  **************************************************************************************************************************************
  Retornos
    nuPeriFactuVenci - El codigo del Periodo de la Factura vencida

        Historia de Modificaciones
        Fecha             Autor             Modificación
        =========         =========         ====================
  *******************************************************************************************************************/

  Function Fnuobtperifactvenc(Inuidsusc     In Suscripc.Susccodi%Type,
                              Inuidperiactu In Perifact.Pefacodi%Type)
    Return Perifact.Pefacodi%Type Is

    -- Cursor para obtener el Periodo de la Factura vencida
    Cursor Cufacturavencida Is
      Select Unique Factpefa
        From Factura, Cuencobr
       Where Factsusc = Inuidsusc
         And Factpefa != Inuidperiactu
         And Factprog = 6 -- Corresponda al programa FGCC
         And Cucofact = Factcodi
         And (Nvl(Cucosacu, 0) - Cucovare - Nvl(Cucovrap, 0)) > 0;

    Nuperifactuvenci Factura.Factpefa%Type; -- Periodo de la Factura vencida
    Sberrmsg         Ge_Error_Log.Description%Type; -- Mensaje de Error

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.fnuObtPeriFactVenc');

    -- Se cuentan las Facturas con Saldo del Periodo actual
    Open Cufacturavencida;
    Fetch Cufacturavencida
      Into Nuperifactuvenci;

    If (Cufacturavencida%Notfound) Then
      --{
      Nuperifactuvenci := -1;
      --}
    End If;

    Close Cufacturavencida;
    Pkerrors.Pop;
    Return(Nuperifactuvenci);

  Exception
    When Others Then
      If (Cufacturavencida%Isopen) Then
        --{
        Close Cufacturavencida;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
      --}
  End Fnuobtperifactvenc;

  /*************************************************************************************************************
        Propiedad intelectual de Ludycom S.A.

        Unidad         : fnuObtPeriFactVenc
        Descripcion    : Función que obtiene la Fecha del Último Pago aplicado a la
                         Factura de un Periodo especifico ya cancelada
        Autor          : Jsilvera.SAO157301.
        Fecha          : 02/05/2013

       Par¿metros     :

        Nombre Par¿metro   Tipo de par¿metro        Tipo de dato del par¿metro           Descripción
        inuIdSusc          Entrada                  suscripc.susscodi%Type,              Contrato dle Cliente
        inuIdPeriodo       Entrada                  perifact.pefacodi%type,              Periodo actual de Facturación
  **************************************************************************************************************************************
  Retornos
    dtPeriFactuVenci - Fecha del Último Pago aplicado a la Factura

        Historia de Modificaciones
        Fecha             Autor             Modificación
        =========         =========         ====================
  *******************************************************************************************************************/

  Function Fdtultipagofactperi(Inuidsusc    In Suscripc.Susccodi%Type,
                               Inuidperiodo In Perifact.Pefacodi%Type)
    Return Cuencobr.Cucofepa%Type Is

    -- Cursor para obtener la Fecha del último Pago aplicado
    Cursor Cufecultpago Is
      Select Max(Cucofepa)
        From Factura, Cuencobr
       Where Factsusc = Inuidsusc
         And Factpefa = Inuidperiodo
         And Factprog = 6 -- Corresponda al programa FGCC
         And Cucofact = Factcodi
         And (Nvl(Cucosacu, 0) - Cucovare - Nvl(Cucovrap, 0)) = 0; -- No tenga Saldo pendiente

    Dtultipagoapli Cuencobr.Cucofepa%Type; -- Ultimo Pago aplicado a la Factura
    Sberrmsg       Ge_Error_Log.Description%Type; -- Mensaje de Error

  Begin
    --{
    Pkerrors.Push('pkLD_FA_ValidarContrato.fdtUltiPagoFactPeri');

    -- Se obtiene la último Fecha de Pago de la Factura

    Open Cufecultpago;
    Fetch Cufecultpago
      Into Dtultipagoapli;
    Close Cufecultpago;

    Pkerrors.Pop;
    Return(Dtultipagoapli);

  Exception
    When Others Then
      If (Cufecultpago%Isopen) Then
        --{
        Close Cufecultpago;
        --}
      End If;

      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
      --}
  End Fdtultipagofactperi;
  /****************************************************************************
    Funcion       :  Fblgetcargocuotafina

    Descripcion :  Devuelve true si encuentra cargo de la cuota de financiaciación generada y false si no encuentra

    Retorno     :  TRUE - FALSE
  *****************************************************************************/
  Function Fblgetcargocuotafina(Inufactura   In Factura.Factcodi%Type, -- Numero de factura
                                Inucuenta    In Cuencobr.Cucocodi%Type, -- Cuenta de cobro
                                Inuconccargo In Cargos.Cargconc%Type, -- concepto del Cargo
                                Inunuse      In Servsusc.Sesunuse%Type

                                ) Return Boolean Is
    Cantidad Number := 0;
    Sberrmsg ge_message.description%type;
  Begin
    Select Count(*)
      Into Cantidad
      From Cuencobr b, Cargos c
     Where b.Cucofact = Inufactura
       And b.Cucocodi = Inucuenta
       And b.Cuconuse = Inunuse
       And b.Cucocodi = c.Cargcuco
       And c.Cargconc = Inuconccargo
       And (c.Cargvalo >= 0);

    If (Cantidad > 0) Then
      Return True;
    Else
      Return False;
    End If;
  Exception
    when Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
  End Fblgetcargocuotafina;

  /****************************************************************************
    Funcion       :  fbgetabono

    Descripcion :  Obtiene el valor del abono realziado por un suscriptor a la financiación de la venta

    Retorno     :  total del abono
  *****************************************************************************/
  Function fbgetabono(nususcodi  in suscripc.susccodi%type,
                      nuPeriodo  in perifact.pefacodi%type,
                      Nudifecodi in diferido.difecodi%type) return number Is

    /*Declaración de Cursores*/
    cursor CurAbono Is
      Select nvl(sum(cucovato), 0)
        From Factura f, Cuencobr c, cargos g
       Where Factsusc = nususcodi -- suscripc
         And Factpefa = nuPeriodo -- Periodo
         and Factprog IN (34, 704, 701) -- Corresponde al programa FTDU: Traslado diferido de contrato, FTDE: Traslado de Producto, FTDM Traslado masivo
         And c.Cucofact = f.Factcodi
         And Nvl(c.Cucosacu, 0) = 0
         and g.cargcuco = c.cucocodi
         and g.cargdoso like '%DF-%' || Nudifecodi; -- número del diferido

    /*Declaración de Variables*/
    Sberrmsg   ge_message.description%type;
    nucucovato cuencobr.cucovato%type;

  Begin
    Open CurAbono;
    Fetch CurAbono
      into nucucovato;
    close CurAbono;

    return nucucovato;

  Exception
    when Others Then

      If (CurAbono%Isopen) Then
        --{
        Close CurAbono;
        --}
      End If;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Sberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
  End;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function Fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la último entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;

--}
End Pkld_Fa_Validarcontrato;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Validarcontrato
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Validarcontrato'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_VALIDARCONTRATO to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_VALIDARCONTRATO to RSELSYS;
/