CREATE OR REPLACE Package      Ld_Bcnotifimascr Is
  /****************************************************************************************************************************************

  PKLD_BCNOTICODEUDORMASIVACR.GENERANOTICO
      Propiedad intelectual de LudyCom S.A.

      Package       : ld_bcNotifiMasCR

      Descripcion   : Generador de cartas masivas a Codeudores, por mora en Central de riesgo

      Autor       :  Ludycom * Javier Rodriguez C
      Fecha       :   12-01-2013 9:32 AM

      Historia de Modificaciones
      Fecha           IDEntrega

      18-11-2016      Sandra Mu?oz CA 200-792
      Modificacion Proinscosigner

      24-08-2013      smunozSAO210144
      Se reajusta todo el procedimiento de generacion de notificaciones para que se
      parezca mas a la generacion de reportes.
      Modificacion del procedimient pro_Generate_Notifications
      Creacion de los procedimientos: proFinishWithError, proInsCosigner

      22-08-2013      smunozSAO210144
      Se hace uso de la funcion pkld_fa_reglas_definidas.fnugetusers
      Procedimiento modifcado: pro_generate_notification

      12-08-2013      smunozSAO213366
      Se renombra el archivo para que sea mas claro al usuario.
      Procedimiento modificado: Fullnotifycodeudor


      29-07-2013      smunozSAO212458
      Modificacion procedimiento setmailvalidate




   **************************************************************************************************************************************/

  ----------------------------------------------------------------------------
  -- Constantes publicas del paquete:
  Cnunull_Attribute Constant Number := 8013;
  Cgclxmlformato Clob := Null;
  ----------------------------------------------------------------------------
  -- Cursores

  Cursor Cursornotification Is
    Select Ld_Notification.Notification_Id
      From Ld_Notification
     Where Ld_Notification.Notification_Id =
           (Select Max(Ld_Notification.Notification_Id) From Ld_Notification)
       And Ld_Notification.State = 'G';

  Regcursornotification Cursornotification%Rowtype;

  -- Detalle Notificaciones (LD_DETAIL_NOTIFICACION)  para PB LD_PBCCC
  Cursor Cursordetallenofificacion(Inunotify In Ld_Notification.Notification_Id%Type) Is
    Select Distinct Ld_Detail_Notification.Detail_Id,
                    Ld_Detail_Notification.Document_Number,
                    Ge_Subscriber.Address_Id
      From Ld_Detail_Notification, Ge_Subscriber
     Where Ge_Subscriber.Identification =
           Ld_Detail_Notification.Document_Number
       And Ld_Detail_Notification.Notification_Id = Inunotify
       And Ld_Detail_Notification.State = 'G';
  Regcursordetallenofificacion Cursordetallenofificacion%Rowtype;
  -- Cursor para obtener el sector_product
  Cursor Cusecprod(Sector   Ld_Type_Sector.Type_Id%Type,
                   Producto Ld_Sector_Product.Product_Id%Type,
                   Central  Ld_Sector_Product.Credit_Bureau_Id%Type) Is
    Select Ld_Sector_Product.*, Ld_Type_Sector.Nivel
      From Ld_Sector_Product, Ld_Type_Sector
     Where Sector_Id = Decode(Sector, -1, Sector_Id, Sector)
       And Product_Id = Decode(Producto, -1, Product_Id, Producto)
       And Credit_Bureau_Id =
           Decode(Central, -1, Credit_Bureau_Id, Central)
       And Sector_Id = Type_Id
     Order By Code;

  Regcusecprod Cusecprod%Rowtype;
  ----------------------------------------------------------------------------

  -- Variables Globales
  Gclxmlformato Clob;

  -- Variables Instanciadas
  Sbfecha_Impreso Ge_Boinstancecontrol.Stysbvalue;

  --Sbcredit_Bureau_Id Ge_Boinstancecontrol.Stysbvalue;
  --Sbsector_Type      Ge_Boinstancecontrol.Stysbvalue;
  Sbproduct_Type_Id Ld_Product_Type.Typrcodi%Type;
  -- Sbregister_Date    Ge_Boinstancecontrol.Stysbvalue;
  ----------------------------------------------------------------------------
  -- Variables Parametros cursor referenciado GetFillAttributesCartaNoImp
  Sbobligacion     Varchar2(400);
  Sbidentificacion Varchar2(400);
  Sbfirstname      Varchar2(400);
  Sblastname       Varchar2(400);
  Sbaddress        Varchar2(400);
  Sbphone          Varchar2(400);
  Sbgeograid       Varchar2(400);
  Sbdifenudo       Varchar2(400);
  Sbdifesape       Varchar2(400);
  Sbdifefein       Varchar2(400);

  Sbsqlattribute Varchar2(3000);
  Sbsqlfrom      Varchar2(3000);
  Sbsqlwhere     Varchar2(3000);
  Sbsqlselect    Varchar2(3000);

  -- Variable Registro de actividad
  Nuorderid         Or_Order.Order_Id%Type;
  Nuorderactivityid Varchar2(90);

  -- Variables publicas del paquete:
  Gsbcontrato     Ge_Subscriber.Identification%Type;
  Gnuobligacion   Ld_Printcodeudor.Obligacion_Id%Type;
  Gnucentral      Ld_Printcodeudor.Credit_Bureau%Type;
  Gnunotificacion Ld_Notification.Notification_Id%Type;

  -- Variables para validacion de datos de la notificacion a generar
  Sbidentificacionc Varchar2(100);
  Sbnombrec         Varchar2(100);
  Sbapellidoc       Varchar2(100);
  Sbdireccionc      Varchar2(100);
  Sbtelefonoc       Varchar2(100);
  Sbmunicipioc      Varchar2(100);
  Sbobligacionc     Varchar2(100);
  Sbfacturac        Varchar2(100);
  Sbdeudac          Varchar2(100);
  Sbfechafacturac   Varchar2(100);

  -- Variables para Guardar registro
  Sbidentificacionr Varchar2(100);
  Sbobligacionr     Varchar2(100);
  Sbcontrator       Varchar2(100);
  Sbordenidr        Varchar2(100);
  Sbactividadidr    Varchar2(100);
  Sbfechair         Varchar2(100);
  Sbfechanotir      Varchar2(100);
  Sbnotir           Varchar2(100);
  Sbdetailr         Varchar2(100);
  Sbcentralr        Varchar2(100);
  Sbproductor       Varchar2(100);
  Sbsectorr         Varchar2(100);
  Sbprint_Good      Varchar2(100);
  Sbobservacion     Varchar2(100);

  Osbprintersn Varchar2(2) := 'N';
  Gnucount     Number(20);
  Enter        Varchar2(2);

  Sbmensaje  Ld_General_Parameters.Text_Value%Type;
  Actividad  Ld_General_Parameters.Numercial_Value%Type;
  Forextmez  Ld_General_Parameters.Numercial_Value%Type;
  Sbpath     Varchar2(1000);
  Numensaje  Number(10);
  Sbtemplate Ed_Confexme.Coempadi%Type;

  Sbaddress_Id Varchar2(20);

  -----------------------------------------------------------------------------
  -- Procedimeintos

  -- Impresion Masiva de Notificaciones a codeudores
  Procedure Fullnotifycodeudor /*(Sbregister_Date Varchar2)*/
  ;

  -- Obtener plantilla y XML para carta
  Procedure Obtenerplantillafced(Inuconfexmeid In Ed_Confexme.Coemcodi%Type,
                                 Sbtemplate    Out Ed_Confexme.Coempadi%Type);

  -- Validar informacion de la carta a imprimir
  -- Procedure Setmailvalidate;

  -- Crea actividad para las notificaciones generadas
  Procedure Crearactividad(Inuactivity         In Ld_General_Parameters.Numercial_Value%Type,
                           Inuadressid         In Ab_Address.Address_Id%Type,
                           Ionuorderid         In Out Or_Order.Order_Id%Type, --Que hago con esto
                           Ionuorderactivityid In Out Varchar2);

  -----------------------------------------------------------------------------
  -- Funciones
  -- Parametro para el formato a ejecutar LF_CARTA_CODEUDOR
  Function Getcodeudor Return Ge_Subscriber.Identification%Type;

  -- Parametro para el formato a ejecutar LF_CARTA_CODEUDOR
  Function Getobligacion Return Ld_Printcodeudor.Obligacion_Id%Type;

  -- Parametro para el formato a ejecutar LF_CARTA_CODEUDOR
  Function Getnotificacion Return Ld_Notification.Notification_Id%Type;
  Function Fsbversion Return Varchar2;
  Function f_Registros_Procesar_Pbncm Return Number;
  Procedure Provalidaproprogramado;
  Function Fdtfechanotificacion Return Date;
  Procedure Pro_Generate_Notifications(Sbregister_Date Date);
End;
/
CREATE OR REPLACE Package Body      Ld_Bcnotifimascr Is

  Csbversion Constant Varchar2(250) := '210144';

  -- Variables globales
  g_Program_Id     Estaprog.Esprprog%Type; -- Identificador del programa que se esta ejecutando
  g_Reg_a_Procesar Number; -- Cantidad de registros a procesar
  g_Reg_Procesados Number := 0; -- Numero de registros procesados
  -------------
  nuano number;
  numes number;
  -------------
  Procedure Pro_Actualizaavance(p_Fin_Proceso Varchar2 Default 'N') Is

    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   Sandra Mu?oz
    Fecha creacion:          26-07-2013
    Nombre:                  pro_actualizaavance

    Proposito:
    Actualizar el porcentaje de registros procesados en la tabla estaprog

    Parametros:
    * p_fin_proceso: Indica si si va a registrar el fin del proceso actualizando
                     el numero de registros procesados.  Si no se indica, se asume
                     que debe incrementarse el contador de registros procesados y
                     evaluar si con este se completa un nuevo 1% y se actualiza el
                     porcentaje de avance en staprog

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    26-07-2013      usuarioSAO212457
    Creacion.

    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.

    *******************************************************************************/

  Begin
    -- Solo incrementa el contador si aun no se ha terminado de ejecutar el proceso
    If p_Fin_Proceso = 'N' Then
      g_Reg_Procesados := g_Reg_Procesados + 1;
    End If; -- If p_fin_proceso = 'N' Then

    -- Se actualiza estaprog si se completo un nuevo 1% en el procesamiento o si se terminaron de
    -- procesar todos los registros
    If p_Fin_Proceso = 'S' Then
      Pkstatusexeprogrammgr.Upstatusexeprogramat(Isbprog       => g_Program_Id,
                                                 Isbmens       => 'Ultima linea procesada: ' ||
                                                                  g_Reg_Procesados,
                                                 Inutotalreg   => g_Reg_a_Procesar,
                                                 Inucurrentreg => g_Reg_Procesados);
      Pkgeneralservices.Committransaction;
    End If;
  Exception
    When Others Then
      Null;
  End Pro_Actualizaavance;
  /***************************************************************************************************************************************

  Nombre         : Fullnotifycodeudor
  Descripcion    : Procedimiento encargado de la impresion Masiva de Notificaciones a codeudores

  Autor       :  Ludycom
  Fecha       :   12-01-2013 9:32 AM

  Parametros     :
   Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

    Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
     29-08-2013     JsilveraSAO210144  La funcion de notificacion a codeudores no recibe mas parametros.
                                       Este objeto no puede ser masivo

    27-08-2013     JsilveraSAO210144   Se quita llamado al paquete UTL_File

    14-08-2013     KCienfuegosSAO212457
    Se implento el registro en estaprog para el proceso de notificacion

    12-08-2013        smunozSAO213366
    Se renombra el archivo para que sea mas claro al usuario.

    01-08-2013      JsilveraSAO212461
    * Se actualiza procedimiento Fullnotifycodeudor para recibir parametros de entrada que le enviara el Proceso Stand alone de
       PBNCM. Esto se realizo porque se necesitaba que el aplicativo no quedara bloqueado una vez este proceso se
       ejecutara. Se queria liberar pantalla despues de que el usuario presionara el boton Procesar.
    * Creacion del Proceso  Provalidaproprogramado
    * Manejo de Log de Proceso. Secrea un archivo para identificar si el proceso de carga se realizo de forma exitosa o no.


  ***************************************************************************************************************************************/

  Procedure Fullnotifycodeudor /*(Sbregister_Date Varchar2)*/
   Is
    Gsberrmsg      Ge_Error_Log.Description%Type;
    v_Seq_Estaprog Number; -- Secuencia con la que se crea el programa en estalog
    v_Programa     Estaprog.Esprprog%Type := 'PBNCM'; -- Nombre del proceso
    cnuNULL_ATTRIBUTE constant number := 2741;

    sbREGISTER_DATE ge_boInstanceControl.stysbValue;

  Begin
    Pkerrors.Push('Ld_Bcnotifimascr.Fullnotifycodeudor');
    sbREGISTER_DATE := ge_boInstanceControl.fsbGetFieldValue('LD_NOTIFICATION',
                                                             'REGISTER_DATE');
    Gnucount        := 0;

    /*Se inicializa el atributo donde se almacenara el id de la secuencia de la entidad estaprog*/
    v_Seq_Estaprog := Sqesprprog.Nextval;
    g_Program_Id   := v_Programa || v_Seq_Estaprog;

    -- Iniciar el registro en estaprog indicando el numero de registros a procesar
    Pkstatusexeprogrammgr.Addrecord(g_Program_Id,
                                    'Proceso en ejecucion ...',
                                    g_Reg_a_Procesar);

    Pkgeneralservices.Committransaction;
    ------------------------------------------------
    -- User code

    Ut_Trace.Trace('FullNotifyCodeudor', 15);
    /*Obtener El valor de la actividad*/
    Provapatapa('ACTIVIDAD_CARTA_CODEUDOR', 'N', Actividad, Sbmensaje);

    If (Actividad Is Null) Then
      Ge_Boerrors.Seterrorcodeargument(Cnunull_Attribute,
                                       'No existe ACTIVIDAD_CARTA_CODEUDOR en parametros ');

    End If;

    /* Obtener Valor de la Extraccion y mezcla del formato */
    Provapatapa('VALOR_FORMATO_EJECUTABLE', 'N', Forextmez, Sbmensaje);

    If (Forextmez Is Null) Then
      Ge_Boerrors.Seterrorcodeargument(Cnunull_Attribute,
                                       'No existe VALOR_FORMATO_EJECUTABLE en parametros ');
    End If;

    Provapatapa('RUTA_CARTA_CODEUDOR', 'S', Numensaje, Sbpath);

    If (Sbpath Is Null) Then
      Ge_Boerrors.Seterrorcodeargument(Cnunull_Attribute,
                                       'No existe RUTA_CARTA_CODEUDOR en parametros ');

    End If;

    -- Calculo del numero de registros a procesar
    g_Reg_a_Procesar := f_Registros_Procesar_Pbncm;

    Open Cursornotification;
    Fetch Cursornotification
      Into Regcursornotification;
    If (Cursornotification%Notfound) Then
      Close Cursornotification;
      Ge_Boerrors.Seterrorcodeargument(Cnunull_Attribute,
                                       'No hay Notificaciones Pendientes para imprimir');
    Else
      Close Cursornotification;

      For Rgcunotification In Cursornotification Loop

        Ut_Trace.Trace('Imprimiendo notificacion=' ||
                       Rgcunotification.Notification_Id,
                       15);
        Open Cursordetallenofificacion(Regcursornotification.Notification_Id);
        Fetch Cursordetallenofificacion
          Into Regcursordetallenofificacion;
        If (Cursordetallenofificacion%Notfound) Then
          Close Cursordetallenofificacion;

          Ge_Boerrors.Seterrorcodeargument(Cnunull_Attribute,
                                           'No hay Notificaciones Pendientes para imprimir');

        Else
          Close Cursordetallenofificacion;
          For Rgcunotidetalle In Cursordetallenofificacion(Rgcunotification.Notification_Id) Loop

               --Creo Actividad por cada carta generada
            Crearactividad(Actividad,
                           Rgcunotidetalle.Address_Id,
                           Nuorderid, --Que hago con este registro
                           Nuorderactivityid); --Que hago con este registro
            Pro_Actualizaavance;

            Gnunotificacion := Rgcunotification.Notification_Id;
            Gsbcontrato     := Rgcunotidetalle.Document_Number;
             Sbordenidr      := Nuorderid;
            Sbactividadidr  := Nuorderactivityid;
            Sbfechair := Sbregister_Date;

            Gnucount := Gnucount + 1;

            Obtenerplantillafced(Forextmez, Sbtemplate);
            Dbms_Output.Put_Line('nombre plantilla: ' || Sbtemplate);
            Ut_Trace.Trace('nombre plantilla: ' || Sbtemplate, 3);

            Update Ld_Detail_Notification d
               Set d.State = 'I'
             Where d.Document_Number = Rgcunotidetalle.Document_Number
               And d.Notification_Id = Rgcunotification.Notification_Id
               And d.Detail_Id = Rgcunotidetalle.Detail_Id;

            Commit;
          End Loop;
        End If;
      End Loop;
      Id_Bogeneralprinting.Exporttopdffrommem(Sbpath,
                                              'NOTIFICACION_',
                                              Sbtemplate,
                                              Cgclxmlformato);
      Commit;
      /*  Update Ld_Notification d
         Set d.State = 'I'
       Where d.Notification_Id = Regcursornotification.Notification_Id;
      Commit;*/
    End If;

    -- Actualiza el registro de seguimiento del proceso en ESTAPROG a Terminado OK
    Pro_Actualizaavance(p_Fin_Proceso => 'S');
    Pkstatusexeprogrammgr.Processfinishok(g_Program_Id);
    Pkgeneralservices.Committransaction;
    Pkerrors.Pop;
  Exception
    When Ex.Controlled_Error Then
      Rollback;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkstatusexeprogrammgr.Upstatusexeprogramat(Isbprog       => g_Program_Id,
                                                 Isbmens       => 'Proceso terminado con error. ' ||
                                                                  Gsberrmsg,
                                                 Inutotalreg   => g_Reg_Procesados,
                                                 Inucurrentreg => g_Reg_a_Procesar);
      Pkstatusexeprogrammgr.Processfinishnok(g_Program_Id, Gsberrmsg);
      Pkgeneralservices.Committransaction;
      Dbms_Application_Info.Set_Module(Module_Name => 'PBNCM',
                                       Action_Name => Null);
      Errors.Seterror;
      Ge_Boerrors.Seterrorcodeargument(2741, Gsberrmsg);
      Pkerrors.Pop;

    When Others Then
      Rollback;
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkstatusexeprogrammgr.Upstatusexeprogramat(Isbprog       => g_Program_Id,
                                                 Isbmens       => 'Proceso terminado con error. ' ||
                                                                  Gsberrmsg,
                                                 Inutotalreg   => g_Reg_Procesados,
                                                 Inucurrentreg => g_Reg_a_Procesar);
      Pkstatusexeprogrammgr.Processfinishnok(g_Program_Id, Gsberrmsg);
      Pkgeneralservices.Committransaction;
      Dbms_Application_Info.Set_Module(Module_Name => 'PBNCM',
                                       Action_Name => Null);
      Errors.Seterror;
      Ge_Boerrors.Seterrorcodeargument(2741, Gsberrmsg);
      Pkerrors.Pop;
  End;

  /***************************************************************************************************************************************
     Nombre         : Obtenerplantillafced
     Descripcion    : Procimiento encargado de Obtener plantilla y el  XML para carta

     Autor       :  Ludycom
     Fecha       :   12-01-2013 9:32 AM

     Parametros     :
      Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion
         Inuconfexmeid    Entrada                 Ed_Confexme.Coemcodi%Type           Codifgo de la Extracion y mezcla
         Sbtemplate       Salida                  Ed_Confexme.Coempadi%Type           Parametro extractor de dise?o

     Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
  ***************************************************************************************************************************************/

  Procedure Obtenerplantillafced(Inuconfexmeid In Ed_Confexme.Coemcodi%Type,
                                 Sbtemplate    Out Ed_Confexme.Coempadi%Type) Is

    Rctemplate       Pktbled_Confexme.Cued_Confexme%Rowtype; /* Plantilla */
    Sbformatident    Ed_Confexme.Coempada%Type; /* Identificador del formato */
    Nudigiformatcode Ed_Formato.Formcodi%Type; /* Codigo del formato */
    Clclobdata       Clob;

  Begin

    Pkerrors.Push('Ld_Bcnotifimascr.Obtenerplantillafced');
    -- Proceso:
    Pkbced_Confexme.Obtieneregistro(Inuconfexmeid, Rctemplate);

    --Obtiene la configuracion de extraccion y mezcla
    Sbformatident := Rctemplate.Coempada;

    /* Obtiene el formato */
    Nudigiformatcode := Pkboinsertmgr.Getcodeformato(Sbformatident);

    /*Ejecuta proceso de extraccion de datos, puede retornar datos en texto plano, xml o html*/
    Pkbodataextractor.Executerules(Nudigiformatcode, Clclobdata);

    If Cgclxmlformato Is Null Then
      Cgclxmlformato := Clclobdata;
    Else
      If Clclobdata Is Not Null Then
        Dbms_Lob.Append(Cgclxmlformato, Clclobdata);
      End If;
    End If;

    /* Obtiene el template */
    Sbtemplate := Rctemplate.Coempadi;
    Pkerrors.Pop;
  Exception
    When Ex.Controlled_Error Then
      Pkerrors.Pop;
      Raise;

    When Others Then
      Errors.Seterror;
      Pkerrors.Pop;
      Raise Ex.Controlled_Error;
  End;
  /**************************************************************************************************************************************
  Nombre         : Setmailvalidate
  Descripcion    : Procedimiento encargado de validar la informacion de la carta a imprimir

  Autor       :  Ludycom
  Fecha       :   12-01-2013 9:32 AM

  Parametros     :


   Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

  Historia de Modificaciones
  Fecha           IDEntrega

  29-07-2013      smunozSAO212458
  Correccion en el cursor Curnotification ya que tenia en comentario la linea
  And d.Difecodi = Ldn.Obligacion



  ***************************************************************************************************************************************/

  /***************************************************************************************************************************************
  Nombre         : Crearactividad
  Descripcion    : Procedimiento encargado de Crear la  actividad para las notificaciones generadas

  Autor       :  Ludycom
  Fecha       :   12-01-2013 9:32 AM

  Parametros     :
   Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro                       Descripcion
     Inuactivity          Entrada             Ld_General_Parameters.Numercial_Value%Type
     Inuadressid          Entrada             Ab_Address.Address_Id%Type
     Ionuorderid          Entrada/Salida      Or_Order.Order_Id%Type, --Que hago con esto
     Ionuorderactivityid  Entrada/Salida      Varchar2

   Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ***************************************************************************************************************************************/
  Procedure Crearactividad(Inuactivity         In Ld_General_Parameters.Numercial_Value%Type,
                           Inuadressid         In Ab_Address.Address_Id%Type,
                           Ionuorderid         In Out Or_Order.Order_Id%Type, --Que hago con esto
                           Ionuorderactivityid In Out Varchar2) Is --Que hago con esto
  Begin
    Pkerrors.Push('Ld_Bcnotifimascr.Crearactividad');
    Or_Boorderactivities.Createactivity(Inuactivity,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Inuadressid,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Null,
                                        Ionuorderid,
                                        Ionuorderactivityid,
                                        Null,
                                        Ge_Boconstants.Csbno);
    Pkerrors.Pop;
  Exception
    When Ex.Controlled_Error Then
      Pkerrors.Pop;
      Raise;

    When Others Then
      Errors.Seterror;
      Pkerrors.Pop;
      Raise Ex.Controlled_Error;
  End;
  /**************************************************************************************************************************************
     Nombre         : Getcodeudor
     Descripcion    : Procedimiento encargado de obtener el Parametro para el formato a ejecutar LF_CARTA_CODEUDOR

     Autor       :  Ludycom
     Fecha       :   12-01-2013 9:32 AM

     Parametros     :


      Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

      Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
  ***************************************************************************************************************************************/

  /* Parametro para el formato a ejecutar */
  Function Getcodeudor Return Ge_Subscriber.Identification%Type Is
  Begin
    Pkerrors.Push('Ld_Bcnotifimascr.Getcodeudor');
    Return Gsbcontrato;
    Pkerrors.Pop;
  End;
  /***************************************************************************************************************************************
     Nombre         : Getobligacion
     Descripcion    :  Procedimiento encargado de obtener el Parametro para el formato a ejecutar LF_CARTA_CODEUDOR

     Autor       :  Ludycom
     Fecha       :   12-01-2013 9:32 AM

     Parametros     :


      Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

     Historia de Modificaciones
     Fecha             Autor             Modificacion
     =========         =========         ====================
  **************************************************************************************************************************************/
  Function Getobligacion Return Ld_Printcodeudor.Obligacion_Id%Type Is
  Begin
    Pkerrors.Push('Ld_Bcnotifimascr.Getobligacion');
    Return Gnuobligacion;
    Pkerrors.Pop;
  End;

  /**************************************************************************************************************************************
      Nombre         : Getnotificacion
      Descripcion    : Procedimiento encargado de obtener el Parametro para el formato a ejecutar LF_CARTA_CODEUDOR

      Autor       :  Ludycom
      Fecha       :   12-01-2013 9:32 AM

      Parametros     :
       Nombre Parametro  Tipo de Parametro      Tipo de dato del parametro            Descripcion

     Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
  **************************************************************************************************************************************/
  Function Getnotificacion Return Ld_Notification.Notification_Id%Type Is
  Begin
    Pkerrors.Push('Ld_Bcnotifimascr.Getnotificacion');
    Return Gnunotificacion;
    Pkerrors.Pop;
  End;
  Procedure Provalidaproprogramado Is
    /****************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Nombre         :  Provalidaproprogramado
    Descripcion    : Procso que se encarga de realizar las validaciones necesarias de las variables o
    parametros de la pantalla de ejecucion de este proceso

    Parametros     :

    Nombre Parametro  Tipo de Parametro        Tipo de dato del parametro            Descripcion



    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega

    01-08-2013      JsilveraSAO212461
    * Creacion del Proceso  Provalidaproprogramado
    *****************************************************************************/

    Cnunull_Attribute Constant Number := 2126;

    Sbregister_Date Ge_Boinstancecontrol.Stysbvalue;
  Begin
    Sbregister_Date := Ge_Boinstancecontrol.Fsbgetfieldvalue('LD_NOTIFICATION',
                                                             'REGISTER_DATE');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    If (Sbregister_Date Is Null) Then
      Errors.Seterror(Cnunull_Attribute, 'Fecha de Registro');
      Raise Ex.Controlled_Error;
    End If;

    ------------------------------------------------
    -- User code
    ------------------------------------------------

  Exception
    When Ex.Controlled_Error Then
      Raise;

    When Others Then
      Errors.Seterror;
      Raise Ex.Controlled_Error;
  End Provalidaproprogramado;

  Function f_Registros_Procesar_Pbncm Return Number Is
    --Producto
    /*******************************************************************************
    Propiedad intelectual:   LUDYCOM
    Autor:                   KCienfuegos.SAO212457
    Fecha creacion:          15-08-2013
    Nombre:                  f_registros_procesar_pbncm

    Proposito:
    Calcular el numero de registros a procesar para el proceso PBNCM

    Parametros:
    * p_credit_bureau: Central
    * p_formato:       Formato a usar

    Historia de Modificaciones (De la mas reciente a la mas antigua)

    Fecha           IDEntrega


    DD-MM-2013      usuarioSAO######
    Descripcion breve, precisa y clara de la modificacion realizada.
    *******************************************************************************/

    -- Variables
    v_Reg_a_Procesar Number := 0; -- Registros a procesar
  Begin
    For Rgcunotification In Cursornotification Loop
      For Rgcunotidetalle In Cursordetallenofificacion(Rgcunotification.Notification_Id) Loop

        v_Reg_a_Procesar := v_Reg_a_Procesar + 1;

      End Loop;
    End Loop;

    Return v_Reg_a_Procesar;
  Exception
    When Others Then
      Return 0;
  End f_Registros_Procesar_Pbncm;

  /****************************************************************************
    Funcion       :  fdtFechaNotificacion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/
  Function Fdtfechanotificacion Return Date Is
    Dtfecha Date;
  Begin
    Select Ld_Notification.Date_Notification
      Into Dtfecha
      From Ld_Notification
     Where Ld_Notification.Notification_Id =
           (Select Max(Ld_Notification.Notification_Id)
              From Ld_Notification
             Where Ld_Notification.State = 'G');
    Return Dtfecha;
  Exception
    When Others Then
      Return Null;
  End;

  Procedure Profinishwitherror(Isberror Varchar2, Isbprogram Varchar2) Is

    /*******************************************************************************
      Propiedad intelectual:   LUDYCOM
      Autor:                   Sandra Mu?oz

      Proposito:
        Ejecuta las instrucciones que tienen que ve con el manejo de errores

      Historia de Modificaciones (De la mas reciente a la mas antigua)

        Fecha           IDEntrega

        24-08-2013      smunozSAO210144
        Creacion del procedimiento
    *******************************************************************************/

    Sberrmsg Varchar2(1000);
  Begin
    -- Inserta el registro de seguimiento del proceso en ESTAPROG
    Pkstatusexeprogrammgr.Addrecord(Isbprogram,
                                    'Proceso en ejecucion ...',
                                    0);
    Pkstatusexeprogrammgr.Processfinishnok(Isbprogram, Sberrmsg);
    Pkgeneralservices.Committransaction;
    Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Isberror, Sberrmsg);
    Pkerrors.Pop;
    Raise_Application_Error(Pkconstante.Nuerror_Level2, Sberrmsg);
    Dbms_Application_Info.Set_Module(Module_Name => 'CRGNC',
                                     Action_Name => Null);
  Exception
    When Others Then
      Null;
  End;

  Procedure Proinscosigner(Inuident_Type_Id  Ge_Subscriber.Ident_Type_Id%Type,
                           Isbidentification Ge_Subscriber.Identification%Type) Is

    /*******************************************************************************
      Propiedad intelectual:   LUDYCOM
      Autor:                   Sandra Mu?oz

      Proposito:
        Ingresa en una tabla los codeudores a quienes se les generara notificacion

      Historia de Modificaciones (De la mas reciente a la mas antigua)

        Fecha           IDEntrega

        18-11-2016      Sandra Mu?oz. CA 200-792
        Se agrega el par?metro isbTipoResponsable para evitar que el paquete quede descompilado

        24-08-2013      smunozSAO210144
        Creacion del procedimiento
    *******************************************************************************/

  Begin

    -- Solo se envia la notificacion si el codeudor ha dado su autorizacion
    If Ld_Bcgenerationrandomsample.Fsbclientedioautorizparaenvio(Inuident_Type_Id  => Inuident_Type_Id,
                                                                 Isbidentification => Isbidentification,
                                                                 isbTipoResponsable => 'C'
                                                                 --,inuidproduct => NULL
                                                                ) = 'S' Then
      Begin
        Insert Into Ld_Cosigner_Tmp
          (Ident_Type_Id, Identification)
        Values
          (Inuident_Type_Id, Isbidentification);

        Dbms_Output.Put_Line(Isbidentification);

      Exception
        When Others Then
          -- Si ocurre un error no se inserta ya que lo mas probable es porque ya el
          -- suscriptor exista y asi nos aseguramos que solo exista un registro por
          -- persona
          Null;
      End;

    End If;
  End Proinscosigner;

  Procedure Pro_Generate_Notifications(Sbregister_Date Date) Is

    /*******************************************************************************
      Propiedad intelectual:   LUDYCOM
      Autor:                   Sandra Mu?oz
      Fecha creacion:          18-08-2013


      Proposito:
            Genera las notificaciones a codeudores

      Historia de Modificaciones (De la mas reciente a la mas antigua)

        Fecha           IDEntrega

        24-04-2013      smunozSAO210144
        Se realiza un ajuste a la estructura del programa para que se parezca
        a la generacion del reporte

        23-08-2013      smunozSAO210144
        Se hace uso del parametro REPORTAR_CODEUDOR_CENTRAL para ejecutar o no el
        proceso.

        22-08-2013      smunozSAO210144
        Se hace uso de la funcion  pkld_fa_reglas_definidas.fnugetusers.

        08-08-2013      smunozSAO210144
        Creacion.


        DD-MM-2013      usuarioSAO######
        Descripcion breve, precisa y clara de la modificacion realizada.
    *******************************************************************************/

    Sbprogram                   Varchar2(50); -- Identificador del proceso
    Nurectoprocess              Number := 0; -- Registros a procesar
    Sberrormessage              Estaprog.Esprmesg%Type;
    Nulastcreditbureauapr       Ld_Sector_Product.Credit_Bureau_Id%Type; -- Codigo de la ulitma central que se estaba verificando si tiene todas sus muestras aprobadas
    Nulastsectorapr             Ld_Sector_Product.Sector_Id%Type; -- Codigo del ultimo sector al que se le ha verificado si tiene muestra aprobada
    Boexists                    Boolean; -- Verificar si existen criterios
    Nuamount                    Ld_Selection_Criteria.Minimum_Amount%Type; -- Numero de facturas
    Nusubsnumber                Ld_Selection_Criteria.Subscriber_Number%Type; -- Numero de suscriptores para la muestra
    Nuoverduebills              Ld_Selection_Criteria.Overdue_Bills%Type; --
    Nucategory                  Ld_Selection_Criteria.Category%Type; -- Categoria
    Nulastscoreneg              Number; -- Indica si un usuario fue reportado negativamente en el ultimo reporte impreso
    Nuexists                    Number := 0; -- Indica si un usuario ya esta reportado
    Nuscorenow                  Number := 0; -- Indica si un usuario
    Nunotification_Id           Ld_Notification.Notification_Id%Type; -- Identificador del encabezado
    Nudetail                    Ld_Detail_Notification.Detail_Id%Type := 0; -- Identificador del detalle
    Nurecprocess                Number := 0; -- Registros procesados hasta el momento
    Nuonepercent                Number; -- Numero de registros que corresponde al 1%
    v_Respuesta                 Number(8); -- Indica si se pudo obtener el parametro general. smunozSAO212456
    v_Reportar_Codeudor_Central Ld_General_Parameters.Text_Value%Type; -- Valor del parametro

    -- Permite obtener los tipos de sector y opcionalmente recuperar informacion de cierto
    -- registro en adelante.
    Cursor Cu_Sectors Is
      Select Credit_Bureau_Id,
             Sector_Id,
             Description_Sector,
             Product_Id,
             Credit_Bureau_Id Nivel
        From (Select Ld_Sector_Product.*,
                     Ld_Type_Sector.Nivel,
                     Ld_Type_Sector.Description Description_Sector
                From Ld_Sector_Product, Ld_Type_Sector -- Tabla sin indice porque es muy peque?a
               Where Sector_Id = Type_Id
               Order By Code);

    -- Recorrer todos los codeudores. smunozSAO210144
    Cursor Cu_Codeudores Is
      Select Ident_Type_Id, Identification From Ld_Cosigner_Tmp;

  Begin

    --------------------------------------------------------------------------------------------------
    -- Matricula en estaprog
    --------------------------------------------------------------------------------------------------

    -- Obtener el identificador del proceso
    Sbprogram := 'CRGNC' || Sqesprprog.Nextval;

    -- Inserta el registro de seguimiento del proceso en ESTAPROG
    Pkstatusexeprogrammgr.Addrecord(Sbprogram,
                                    'Proceso en ejecucion ...',
                                    0);

    -- Aisenta en la base de datos el registro de seguimiento de la ejecucion del Proceso
    Pkgeneralservices.Committransaction;

    -------------------------------------------------------------------------------------------------
    -- Validaciones para terminar el proceso
    -------------------------------------------------------------------------------------------------
    Provapatapa('REPORTAR_CODEUDOR_CENTRAL',
                'S',
                v_Respuesta,
                v_Reportar_Codeudor_Central);

    -- Si no se estan reportando codeudores, no se ejecuta el proceso de notificacion
    If v_Reportar_Codeudor_Central = 'N' Then
      Profinishwitherror(Isberror   => 'El sistema no esta parametrizado para enviar notificacion a
                                        codeudores - Parametro general: REPORTAR_CODEUDOR_CENTRAL',
                         Isbprogram => Sbprogram);
    End If;

    -- Verifica si existen criterios para todos los sectores a procesar

    Sberrormessage := Null;
    For Rg_Sector In Cu_Sectors Loop

      -- Se debe obtener la informacion por sector.
      Boexists := Ld_Bcselectioncriteria.Fbogetselectioncriteriaid(Rg_Sector.Sector_Id,
                                                                   Rg_Sector.Credit_Bureau_Id,
                                                                   Nuamount,
                                                                   Nusubsnumber,
                                                                   Nuoverduebills,
                                                                   Nucategory);

      If Not Boexists Then

        If Nulastcreditbureauapr Is Null Or
           Nulastcreditbureauapr <> Rg_Sector.Credit_Bureau_Id Then

          If Nulastcreditbureauapr Is Null Then
            Sberrormessage := Sberrormessage ||
                              Ld_Bcequivalreport.Fnugetcreditbureaudesc(Rg_Sector.Credit_Bureau_Id) ||
                              ', sector(es): ';
          Else
            Sberrormessage := Sberrormessage || '. ' ||
                              Ld_Bcequivalreport.Fnugetcreditbureaudesc(Rg_Sector.Credit_Bureau_Id) ||
                              ', sector(es): ';
          End If;
          Nulastcreditbureauapr := Rg_Sector.Credit_Bureau_Id;
          Nulastsectorapr       := Null;

        End If; --  If Not Nulastcreditbureauapr = Rgstrsector.Credit_Bureau_Id Then

        If Nulastsectorapr Is Null Or
           Nulastsectorapr <> Rg_Sector.Sector_Id Then
          If Nulastsectorapr Is Null Then
            Sberrormessage := Sberrormessage ||
                              Rg_Sector.Description_Sector;
          Else
            Sberrormessage := Sberrormessage || ', ' ||
                              Rg_Sector.Description_Sector;
          End If;
          Nulastsectorapr := Rg_Sector.Sector_Id;

        End If; -- If Nulastsectorapr Is Null Or Nulastsectorapr <> Rgstrsector.Sector_Id Then
      End If; --

    End Loop; --  If Not boexists Then

    If Sberrormessage Is Not Null Then
      Profinishwitherror(Isberror   => 'No se encontraron criterios para la generacion para ' ||
                                       Sberrormessage,
                         Isbprogram => Sbprogram);
    End If;

    ------------------------------------------------------------------------------------------------
    -- Obtener los codeudores asociados a los suscriptores que al dia de hoy cumplen con los
    -- criterios para ser rerportados
    ------------------------------------------------------------------------------------------------

    For Rg_Sector In Cu_Sectors Loop

      Boexists := Ld_Bcselectioncriteria.Fbogetselectioncriteriaid(Rg_Sector.Sector_Id,
                                                                   Rg_Sector.Credit_Bureau_Id,
                                                                   Nuamount,
                                                                   Nusubsnumber,
                                                                   Nuoverduebills,
                                                                   Nucategory);

     /* For Rg_Servicios In Ld_Bcgenerationrandomsample.Cu_Servicios(p_Credit_Bureau_Id  => Rg_Sector.Credit_Bureau_Id,
                                                                   p_Typesector        => Rg_Sector.Sector_Id,
                                                                   p_Typeproductid     => Rg_Sector.Product_Id,
                                                                   p_Category          => Nucategory,
                                                                   p_Overduebills      => Nuoverduebills,
                                                                   p_Repomuestra       => 'R',
                                                                   p_Subscriber_Number => Null,
                                                                   p_nuano             => nuano,
                                                                   p_numes             => numes) Loop

       Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Ser.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Ser.Identification);
        For Rg_Codeudor_Ser In Ld_Bcgenerationrandomsample.Cu_Codeudor_Ser(nupackage => Rg_Servicios.sesunuse) Loop

          Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Ser.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Ser.Identification);

        End Loop;
      End Loop;*/

     /*  For Rg_Servicios_Not_Exists In Ld_Bcgenerationrandomsample.Cu_Servicios_Not_Exists(p_Credit_Bureau_Id => Rg_Sector.Credit_Bureau_Id,
                                                                                         p_Typeproductid    => Rg_Sector.Product_Id,
                                                                                         p_Category         => Nucategory,
                                                                                         p_Overduebills     => Nuoverduebills,
                                                                                         p_nuano             => nuano,
                                                                                         p_numes             => numes) Loop


          Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Ser.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Ser.Identification);

       For Rg_Codeudor_Ser In Ld_Bcgenerationrandomsample.Cu_Codeudor_Ser(nupackage => Rg_Servicios_Not_Exists.Sesunuse) Loop

          Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Ser.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Ser.Identification);

        End Loop;
      End Loop;*/

      For Rg_Diferido In Ld_Bcgenerationrandomsample.Cu_Diferido(p_Amount            => Nuamount,
                                                                 p_Subscriber_Number => Null,
                                                                 p_Duebil            => Nuoverduebills,
                                                                 p_Category          => Nucategory,
                                                                 p_Typeproductid     => Rg_Sector.Product_Id,
                                                                 p_Repomuestra       => 'R',
                                                                 p_Credit_Bureau_Id  => Rg_Sector.Credit_Bureau_Id) Loop
        For Rg_Codeudor_Dif In Ld_Bcgenerationrandomsample.Cu_Codeudor_Dif(p_Cudifcodi => Rg_Diferido.Difecodi) Loop

          Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Dif.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Dif.Identification);

        End Loop;
      End Loop;

      For Rg_Diferido_Not_Exists In Ld_Bcgenerationrandomsample.Cu_Diferido_Not_Exists(p_Amount           => Nuamount,
                                                                                       p_Duebil           => Nuoverduebills,
                                                                                       p_Category         => Nucategory,
                                                                                       p_Typeproductid    => Rg_Sector.Product_Id,
                                                                                       p_Credit_Bureau_Id => Rg_Sector.Credit_Bureau_Id) Loop

        For Rg_Codeudor_Dif In Ld_Bcgenerationrandomsample.Cu_Codeudor_Dif(p_Cudifcodi => Rg_Diferido_Not_Exists.Difecodi) Loop

          Proinscosigner(Inuident_Type_Id  => Rg_Codeudor_Dif.Ident_Type_Id,
                         Isbidentification => Rg_Codeudor_Dif.Identification);

        End Loop;
      End Loop;
    End Loop; --For Rg_Sector In Cu_Sectors Loop
    ----------------------------------------------------------------------------------------------
    -- Iniciar el registro del avance
    ----------------------------------------------------------------------------------------------

    -- Numero de registros a procesar
    Begin
      Select Count(1) Into Nurectoprocess From Ld_Cosigner_Tmp Lct;
    Exception
      When Others Then
        Nurectoprocess := 0;
    End;

    If Nurectoprocess = 0 Then
      Profinishwitherror(Isberror   => 'No se encontraron deudores para enviar notificaciones.',
                         Isbprogram => Sbprogram);
    End If;

    -- Calcular el numero de registros que corresponde al 1%
    Nuonepercent := Trunc(Nurectoprocess / 100);

    If Nuonepercent = 0 Then
      Nuonepercent := 1;
    End If;

    ----------------------------------------------------------------------------------------------
    -- Generar notificaciones
    ----------------------------------------------------------------------------------------------

    -- Crear el encabezado de la notificacion
    Nunotification_Id := Seq_Ld_Notification.Nextval;

    Begin
      Insert Into Ld_Notification Ln
        (Notification_Id, Date_Notification, User_Id)
      Values
      -- Se hace uso de la funcion  pkld_fa_reglas_definidas.fnugetusers. smunozSAO210144
        (Nunotification_Id, Sysdate, Pkld_Fa_Reglas_Definidas.Fnugetusers);
    Exception
      When Others Then
        Profinishwitherror('No fue posible crear el encabezado de las notificaciones. ' ||
                           Sqlerrm,
                           Isbprogram => Sbprogram);
    End;

    For Rg_Codeudores In Cu_Codeudores Loop

      Nurecprocess := Nurecprocess + 1;

      Begin
        Select Count(1)
          Into Nuexists
          From Ld_Reported_Deferred Lrd
         Where Lrd.Identification_Type = Rg_Codeudores.Ident_Type_Id
           And Lrd.Identification = Rg_Codeudores.Identification;
      Exception
        When Others Then
          Nuexists := 0;
      End;

      -- Si nunca antes ha estado reportado, se notifica
      -- If Nuexists = 0 Then

      If Nuexists = 0 Then
        Begin
          Select Count(1)
            Into Nuexists
            From Ld_Reported_Products Lrp
           Where Lrp.Identification_Type = Rg_Codeudores.Ident_Type_Id
             And Lrp.Identification = Rg_Codeudores.Identification;
        Exception
          When Others Then
            Nuexists := 0;
        End;
      End If;

      -- Si nunca antes ha estado reportado, se notifica
      If Nuexists = 0 Then

        Begin
          Nudetail := Nudetail + 1;

          -- Se hace uso de la funcion pkld_fa_reglas_definidas.fnugetusers. smunozSAO210144
          Insert Into Ld_Detail_Notification Ldn
            (Detail_Id,
             User_Id,
             Register_Date,
             Notification_Id,
             Document_Number,
             State,
             Document_Type,
             Score)
          Values
            (Nudetail,
             Pkld_Fa_Reglas_Definidas.Fnugetusers,
             Sbregister_Date,
             Nunotification_Id,
             Rg_Codeudores.Identification,
             'G',
             Rg_Codeudores.Ident_Type_Id,
             'N');

        Exception
          When Others Then
            Nudetail := Nudetail - 1;
        End;

        -- Si ya ha estado reportado
      Else

        -- Buscar si en el o los ultimos reportes generados por central y producto el usuario estaba
        -- calificado como positivo
        Begin
          Select Count(1)
            Into Nulastscoreneg
            From Ld_Sample_Detai Lsd
           Where Lsd.Sample_Id In
                 (Select Max(Ls.Sample_Id)
                    From Ld_Sample         Ls,
                         Ld_Sector_Product Lsp,
                         Ld_Type_Sector    Lts
                   Where Lsp.Sector_Id = Lts.Type_Id
                     And Decode(Ls.Type_Sector,
                                -1,
                                Lsp.Sector_Id,
                                Ls.Type_Sector) = Lsp.Sector_Id
                     And Ls.Flag = 'S'
                   Group By Ls.Type_Sector, Ls.Credit_Bureau_Id)
             And Lsd.Score = 'N'
             And Lsd.Identification_Number = Rg_Codeudores.Identification; -- Deuda - Castigado

        Exception
          When Others Then
            Nulastscoreneg := 0; -- Al dia
        End;

        -- Si en el ultimo reporte se califico como positivo, se busca si hubo variacion en estado
        If Nulastscoreneg = 0 Then

          -- Se busca si en este momento el usuario cambiaria su calificacon a negativo
          Begin
            Select Count(1)
              Into Nuscorenow
              From Servsusc, Ge_Subscriber, Suscripc, Pr_Product
             Where Ge_Subscriber.Subscriber_Id = Suscripc.Suscclie
               And Sesususc = Susccodi
               And Product_Id = Sesunuse
               And Sesucate = Decode(Nucategory, -1, Sesucate, Nucategory)
               And Sesuesfn In ('D', 'C'); -- Deuda - Castigado
          Exception
            When Others Then
              Nuscorenow := 0;
          End;

          If Nuscorenow = 0 Then
            Begin
              Select Count(1)
                Into Nuscorenow
                From Ge_Subscriber, Diferido, Servsusc, Suscripc
               Where Subscriber_Id = Suscclie
                 And Susccodi = Sesususc
                 And Difenuse = Sesunuse
                 And Sesucate =
                     Decode(Nucategory, -1, Sesucate, Nucategory);
            Exception
              When Others Then
                Nuscorenow := 0;

            End;

          End If;

          -- Si cambio a negativo se reporta
          If Nuscorenow > 0 Then

            Begin
              Nudetail := Nudetail + 1;

              -- Se hace uso de la funcion pkld_fa_reglas_definidas.fnugetusers. smunozSAO210144
              Insert Into Ld_Detail_Notification Ldn
                (Detail_Id,
                 User_Id,
                 Register_Date,
                 Notification_Id,
                 Document_Number,
                 State,
                 Document_Type,
                 Score)
              Values
                (Nudetail,
                 Pkld_Fa_Reglas_Definidas.Fnugetusers,
                 Sbregister_Date,
                 Nunotification_Id,
                 Rg_Codeudores.Identification,
                 'G',
                 Rg_Codeudores.Ident_Type_Id,
                 'N');

            Exception
              When Others Then
                Nudetail := Nudetail - 1;
            End;
          End If;

        End If;

      End If;
      --      End Loop; -- For rg_Deudores In cu_Deudores Loop

      -- Graba cada 1%
      If Mod(Nudetail, Nuonepercent) = 0 Then
        Pkstatusexeprogrammgr.Upstatusexeprogramat(Isbprog       => Sbprogram,
                                                   Isbmens       => Null,
                                                   Inutotalreg   => Nurectoprocess,
                                                   Inucurrentreg => Nurecprocess);
        Pkgeneralservices.Committransaction;

      End If;

    End Loop; --For rg_Codeudores In cu_Codeudores Loop

    -- Actualiza el registro de seguimiento del proceso en ESTAPROG a Terminado OK
    Pkstatusexeprogrammgr.Upstatusexeprogramat(Isbprog       => Sbprogram,
                                               Isbmens       => Null,
                                               Inutotalreg   => Nurectoprocess,
                                               Inucurrentreg => Nurecprocess);
    Pkstatusexeprogrammgr.Processfinishok(Sbprogram);

    Update Ld_Notification n
       Set n.State = 'G'
     Where n.Notification_Id = Nunotification_Id;

    -- Finaliza la transaccion del proceso
    Pkgeneralservices.Committransaction;
    --  End If;
    Pkerrors.Pop;
  Exception
    When Others Then
      Sberrormessage := 'Se ha presentado un error al ejecutar el procedimiento. ' ||
                        Sqlerrm;
      Profinishwitherror(Sberrormessage || Sqlerrm,
                         Isbprogram => Sbprogram);

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
    -- Retorna el SAO con que se realizo la ultima entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;
End;
/
GRANT EXECUTE on LD_BCNOTIFIMASCR to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BCNOTIFIMASCR to REXEOPEN;
GRANT EXECUTE on LD_BCNOTIFIMASCR to RSELSYS;
/
