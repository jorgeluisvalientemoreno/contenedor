CREATE OR REPLACE Package adm_person.Pkld_Fa_Boregistrardescuento Is

  -- Author  : JERY
  -- Created : 31/05/2013 1:36:04 p. m.
  -- Purpose : Servicio que permite invocar el llamado de los objetos que insertan en la tabla maestro y detalle los descuentos a aplicados y noa aplicados a los usuarios

  /***********Historial de Modificación ****************************
  Fecha           IDEntrega
  22-08-2013      JsilveraSAO215359
  se envía nuevamente el paquete.
  30-07-2013      jsilveraSAO212465
  Se modificó el procedimiento Fnc_Registrardescuentos
  ***************************************/
  Procedure Fnc_Registrardescuentos(Inudedpsusc    In Suscripc.Susccodi%Type, -- Contrato
                                    Inudedpdife    In Diferido.Difecodi%Type, -- Diferido base
                                    Inuvaldescmat  In Ld_Fa_Detadepp.Dedpvasa%Type, -- Saldo del Descuento
                                    Valordescuento In Ld_Fa_Detadepp.Dedpvade%Type, -- Valor total del Descuento
                                    Inucuota       In Ld_Fa_Detadepp.Dedpnucu%Type, -- Numero de Cuota
                                    Inuvacu        In Ld_Fa_Detadepp.Dedpvacu%Type, -- Valor de la Cuota del Descuento
                                    Sbobservacion  In Ld_Fa_Detadepp.Dedpobse%Type, -- Observacion
                                    Usuario        In Sa_User.User_Id%Type, -- Usuario
                                    Codmatricula   In Ld_Fa_Detadepp.Deppcode%Type, -- Codigo de la Matricula
                                    Estado         In Ld_Fa_Detadepp.Deppesco%Type, -- Estado del Detalle
                                    Estamaes       In Ld_Fa_Detadepp.Deppesco%Type, -- Estado del Maestro
                                    Periodo        In Perifact.Pefacodi%Type, -- Periodo
                                    Nucuenta       In Cuencobr.Cucocodi%Type Default Null, -- cuenta de cobro
                                    Onucodregdeta  Out Ld_Fa_Detadepp.Dedpcodi%Type -- Codigo del registro de Detalle
                                    );

  Function Fnc_Validarregistrodescuento(Inudedpsusc In Suscripc.Susccodi%Type, -- Contrato
                                        Inudedpdife In Diferido.Difecodi%Type, -- Diferido base
                                        Periodo     In Perifact.Pefacodi%Type -- Periodo
                                        ) Return Boolean;
  -- Obtiene la Version actual del Paquete
  Function Fsbversion Return Varchar2;

End Pkld_Fa_Boregistrardescuento;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Boregistrardescuento Is

  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  Csbversion Constant Varchar2(250) := 'OSF-2884';

  Procedure Fnc_Registrardescuentos(Inudedpsusc    In Suscripc.Susccodi%Type, -- Contrato
                                    Inudedpdife    In Diferido.Difecodi%Type, -- Diferido base
                                    Inuvaldescmat  In Ld_Fa_Detadepp.Dedpvasa%Type, -- Saldo del Descuento
                                    Valordescuento In Ld_Fa_Detadepp.Dedpvade%Type, -- Valor total del Descuento
                                    Inucuota       In Ld_Fa_Detadepp.Dedpnucu%Type, -- Numero de Cuota
                                    Inuvacu        In Ld_Fa_Detadepp.Dedpvacu%Type, -- Valor de la Cuota del Descuento
                                    Sbobservacion  In Ld_Fa_Detadepp.Dedpobse%Type, -- Observacion
                                    Usuario        In Sa_User.User_Id%Type, -- Usuario
                                    Codmatricula   In Ld_Fa_Detadepp.Deppcode%Type, -- Codigo de la Matricula
                                    Estado         In Ld_Fa_Detadepp.Deppesco%Type, -- Estado del Detalle
                                    Estamaes       In Ld_Fa_Detadepp.Deppesco%Type, -- Estado del Maestro
                                    Periodo        In Perifact.Pefacodi%Type, -- Periodo
                                    Nucuenta       In Cuencobr.Cucocodi%Type Default Null, -- cuenta de cobro
                                    Onucodregdeta  Out Ld_Fa_Detadepp.Dedpcodi%Type -- Codigo del registro de Detalle
                                    ) Is

    /***********Historial de Modificación ****************************
    Fecha           IDEntrega

    30-07-2013      jsilveraSAO212465
    Se modificó el procedimiento para recibir nuevo parametro(Nucuenta) y enviarlo al proceso  Pkld_Fa_Bcodedetadesc.Insertdetadesc
    ***************************************/

    Osberrmsg Ge_Error_Log.Description%Type;
    Ioresp    Number;

  Begin
    --{
    Pkerrors.Push('pkLD_FA_BoRegistrarDescuento.Fnc_RegistrarDescuentos');

    -- Actualiza el registro de la Matricula del Descuento por Pronto Pago (tabla LD_FA_DESCPRPA)
    Pkld_Fa_Bcdescprpago.Updatedescprpa(Inudeppsusc => Inudedpsusc, -- Suscriptor
                                        Inudeppdife => Inudedpdife, -- Diferido base
                                        Inuesdecodi => Estamaes, -- Estado del Descuento
                                        Inusaldo    => Inuvaldescmat); -- Saldo del Descuento

    -- Asigna el Id del registro de Detalle a generar de la secuencia
    Onucodregdeta := Seq_Detadepp.Nextval;

    -- Inserta el registro de Detalle de la Aplicación del Descuento por Pronto Pago (tabla LD_FA_DETADEPP)
    Pkld_Fa_Bcodedetadesc.Insertdetadesc(Onucodregdeta, -- Codigo del Detalle
                                         Inudedpsusc, -- Contrato
                                         Inudedpdife, -- Diferido base
                                         Inuvaldescmat, -- Saldo del Descuento
                                         Valordescuento, -- Valor del Descuento
                                         Inucuota, -- Numero de Cuota
                                         Inuvacu, -- Valor de la Cuota del Descuento
                                         Sbobservacion, -- Observación
                                         Usuario, -- Usuario
                                         Sysdate, -- Fecha de Registro
                                         Codmatricula, -- Codigo de la Matricula
                                         Periodo, -- Periodo
                                         Nucuenta, -- Cuenta de cobro
                                         Estado); -- Estado del Registro

    Pkerrors.Pop;

  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Registrardescuentos;

  Function Fnc_Validarregistrodescuento(Inudedpsusc In Suscripc.Susccodi%Type, -- Contrato
                                        Inudedpdife In Diferido.Difecodi%Type, -- Diferido base
                                        Periodo     In Perifact.Pefacodi%Type -- Periodo

                                        ) Return Boolean Is

    Resul     Boolean := False;
    Osberrmsg Ge_Message.Description%Type;

  Begin

    Pkerrors.Push('pkLD_FA_BoRegistrarDescuento.fnc_Validarregistrodescuento');

    Resul := Pkld_Fa_Bcodedetadesc.Getregisterdescuento(Inudedpsusc, -- Contrato
                                                        Inudedpdife, -- Diferido base
                                                        Periodo);

    Return Resul;

    Pkerrors.Pop;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Osberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Osberrmsg);
      --}
  End Fnc_Validarregistrodescuento;

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

End Pkld_Fa_Boregistrardescuento;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Boregistrardescuento
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Boregistrardescuento'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BOREGISTRARDESCUENTO to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BOREGISTRARDESCUENTO to RSELSYS;
/
