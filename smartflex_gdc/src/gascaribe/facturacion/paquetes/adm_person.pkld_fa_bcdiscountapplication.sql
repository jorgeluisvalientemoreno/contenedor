CREATE OR REPLACE Package adm_person.Pkld_Fa_Bcdiscountapplication Is
  /*****************************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : Pkld_Fa_Bcdiscountapplication
      Descripcion    : Componente de negocio que permite obtener informacion de los usuarios que han obtenido descuentos
                       por referido.
      Autor          : javier.rodriguez.SAOJavier Rodriguez.
      Fecha          : 01/10/2012

      Metodos

      Nombre         : fnuUsersApplication
      Descripcion    : funcion que permite obtener informacion de suscriptores que este registrados para descuento

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuRefesusc              Entrada                  Ld_Fa_Referido.Refesusc%TYPE                   Suscripcion del referido
        onuCount                 Salida                   number                                         Suscriptores que estan registrados para descuentos
        onuErrormessage          Salida                   Number                                         Parametro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro para mensaje de error

  **************************************************************************************************************************************
      Nombre         : PrintGetUser
      Descripcion    : procedimiento que permite obtener un suscriptor especifico al que se le ha aplicado algun descuento por referido

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        ionuRefesusc             Entrada/Salida           Ld_Fa_Referido.Refesusc%TYPE                   Suscripcion del referido
        onurefecodi                   Salida                      ld_fa_referido.refecodi%TYPE                     Codigo del referido
        onuErrormessage          Salida                   Number                                         Parametro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : cuPrintgetusers
      Descripcion    : funcion que permite obtener todos los suscriptores a los cuales se les ha aplicado descuento por referido.

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        rfPrintUsers             Entrada/Salida           tySusc                                         Cursor para

  **************************************************************************************************************************************

     Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
  ***************************************************************************************************************************/

  Function Fnuusersapplication(Inusubscriber   In Ld_Fa_Referido.Refesusc%Type,
                               Onucount        Out Number,
                               Onuerrormessage Out Number,
                               Osberrormessage Out Varchar2) Return Number;

  Procedure Printgetuser(Ionurefesusc    In Out Ld_Fa_Referido.Refesusc%Type,
                         Onurefecodi     Out Ld_Fa_Referido.Refecodi%Type,
                         Onuerrormessage Out Number,
                         Osberrormessage Out Varchar2);

  Type Cursosusc Is Ref Cursor;

  Function Cuprintgetusers(Fo_Cursor In Out Cursosusc) Return Cursosusc;
    Function Fsbversion Return Varchar2;
End Pkld_Fa_Bcdiscountapplication;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Bcdiscountapplication Is

  Gsberrmsg Ge_Error_Log.Description%Type; /*variable para mensaje de error*/
  Csbversion Constant Varchar2(250) := 'OSF-2884';
  /*funcion para obtener informacion de suscriptores que este registrados para descuento*/
  Function Fnuusersapplication(Inusubscriber   In Ld_Fa_Referido.Refesusc%Type,
                               Onucount        Out Number,
                               Onuerrormessage Out Number,
                               Osberrormessage Out Varchar2) Return Number Is
  Begin
    Pkerrors.Push('Pkld_Fa_Bcdiscountapplication.fnuUsersapplication');
    /*obtiene el numero de descuentos que han sido aplicados a un suscriptor especifico*/
    Select Count(1)
      Into Onucount /* Resultado de conteo de ventas efectivas*/
      From Ld_Fa_Referido l
     Where l.Refesure = Inusubscriber /* Suscriptor referente al que se contara ventas efectivas*/
       And Esdecodi = (Select Le.Esdecodi
                         From Ld_Fa_Estadesc Le
                        Where Upper(Le.Esdedesc) = Upper('APLICADO')
                          And Upper(Le.Esdetide) = Upper('r')); /* Valor que especifica que el referido ya tuvo la venta efectiva*/

    Onuerrormessage := -1;
    Osberrormessage := 'No hay conceptos para este subscriptor';
    Return Onucount;
  Exception
    /*validacion de excepciones*/
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Fnuusersapplication;

  /*procedimiento para obtener un suscriptor especifico al cual se le ha aplicado algun descuento por referido*/
  Procedure Printgetuser(Ionurefesusc    In Out Ld_Fa_Referido.Refesusc%Type,
                         Onurefecodi     Out Ld_Fa_Referido.Refecodi%Type,
                         Onuerrormessage Out Number,
                         Osberrormessage Out Varchar2) Is
    /*cursor para obtener el suscriptor*/
    Cursor Cusubscriptorreg Is
      Select Lf.Refecodi, Lf.Refesure /* Codigo del referido, codigo del suscritptor referente*/
        From Ld_Fa_Referido Lf, Ld_Fa_Critrefe Lr, Servsusc s
       Where Lf.Refesure = Ionurefesusc /* Codigo del subscriptor al que se le evaluara la aplicacion del descuento por referido */
         And Lf.Esdecodi = (Select Le.Esdecodi
                              From Ld_Fa_Estadesc Le
                             Where Upper(Le.Esdedesc) = Upper('APLICADO')
                               And Upper(Le.Esdetide) = Upper('r')) /* Valor que especifica que el referido ya tuvo la venta efectiva*/
         And Lf.Crrecodi = Lr.Crrecodi /* Pertenece a unl criterio referido establecido*/
         And s.Sesususc = Lf.Refesure /* Asociar sevicios con el referido*/
         And s.Sesuserv = Lr.Crreserv /*  validar que tenga el servicio manejado por el criterio del referido*/
         And s.Sesucate = Lr.Crrecate /*  Validar que se encuentre en la categoria establecida por el criterio del referido*/
         And s.Sesusuca = Lr.Crresuca /*  Validar que se encuentre en la subcategoria establecida por el criterio del referido*/
         And Lf.Refefele Between Lr.Crrefein And Lr.Crrefefi; /* Que la fecha de registro del referido se encuentre entre las exigidas por el criterio referido*/
  Begin
    Open Cusubscriptorreg;
    Fetch Cusubscriptorreg
      Into Ionurefesusc, Onurefecodi;
    Pkerrors.Push('Pkld_Fa_Bcdiscountapplication.Printgetuser');
    /*valida si existen datos en el cursor*/
    If (Cusubscriptorreg%Notfound) Then
      Onuerrormessage := -1;
      Osberrormessage := 'No hay suscriptores con descuentos para aplicar';
    End If;
    /*validacion de excepciones*/
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);

  End;

  /*funcion que permite obtener un cursor con todos los suscriptores a los cuales se les ha aplicado descuento por referido*/
  Function Cuprintgetusers(Fo_Cursor In Out Cursosusc) Return Cursosusc Is
  Begin
    Pkerrors.Push('PKLD_FA_BCGEOGRAPHICALCONFIG.cuPrintgetusers');
    Open Fo_Cursor For
      Select Lf.Refecodi, Lf.Refesure /* Codigo del referido, codigo del suscritptor referente*/
        From Ld_Fa_Referido Lf, Ld_Fa_Critrefe Lr, Servsusc s
       Where Lf.Esdecodi = (Select Le.Esdecodi
                              From Ld_Fa_Estadesc Le
                             Where Upper(Le.Esdedesc) = Upper('REGISTRADO')
                               And Upper(Le.Esdetide) = Upper('r')) /* Valor que especifica que el referido ya tuvo la venta efectiva*/
         And Lf.Crrecodi = Lr.Crrecodi /* Pertenece a unl criterio referido establecido*/
         And s.Sesususc = Lf.Refesure /* Asociar sevicios con el referido*/
         And s.Sesuserv = Lr.Crreserv /*  validar que tenga el servicio manejado por el criterio del referido*/
         And s.Sesucate = Lr.Crrecate /*  Validar que se encuentre en la categoria establecida por el criterio del referido*/
         And s.Sesusuca = Lr.Crresuca /*  Validar que se encuentre en la subcategoria establecida por el criterio del referido*/
         And Lf.Refefele Between Lr.Crrefein And Lr.Crrefefi; /* Que la fecha de registro del referido se encuentre entre las exigidas por el criterio referido*/
    Return Fo_Cursor;
    /*validacion de excepciones*/
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);

  End;
    Function Fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;

End Pkld_Fa_Bcdiscountapplication;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Bcdiscountapplication
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Bcdiscountapplication'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCDISCOUNTAPPLICATION to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BCDISCOUNTAPPLICATION to RSELSYS;
/
