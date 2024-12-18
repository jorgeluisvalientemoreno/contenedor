CREATE OR REPLACE Package adm_person.Pkld_Fa_Referido Is

  /*****************************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_Referido
      Descripcion    : Componente de negocio que permite gestionar los referidos.
      Autor          : javier.rodriguez.SAOJavier Rodriguez.
      Fecha          : 01/10/2012

      Metodos

      Nombre         : fsbSeqreferido
      Descripcion    : funcion que permite obtener el siguiente consecutivo de la tabla Referidos

      Parametros     : No hay parametros

      Historia de Modificaciones
      Fecha   	               Autor            Modificacion
      ====================   =========        ====================
      15/07/2024              PAcosta         OSF-2885: Cambio de esquema ADM_PERSON       
                                              Retiro marcacion esquema .open objetos de lógica 
  **************************************************************************************************************************************

      Nombre         : fboGetReferido
      Descripcion    : funcion que permite validar la existencia de un referido, a partir del codigo de registro.

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        ionuRefecodi             Entrada/Salida           Ld_Fa_Referido.Refecodi%TYPE                   Codigo del registro de referido

  **************************************************************************************************************************************
      Nombre         : InsertReferido
      Descripcion    : procedimiento que permite realizar la insercion de nuevos referidos

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuRefecodi              Entrada                  Ld_Fa_Referido.Refecodi%TYPE                   Codigo del registro de referido
        inuRefesusc              Entrada                  Ld_Fa_Referido.Refesusc%TYPE                   Suscripcion del referido
        inuRefesure              Entrada                  Ld_Fa_Referido.Refesure%TYPE                   Suscripcion del referente
        idtRefefele              Entrada                  Ld_Fa_Referido.Refefele%TYPE                   Fecha de legalizacion
        inuRefevade              Entrada                  Ld_Fa_Referido.Refevade%TYPE                   Valor del descuento
        inuRefeusid              Entrada                  Ld_Fa_Referido.Refeusid%TYPE                   Usuario que ingresa registro
        idtRefefere              Entrada                  Ld_Fa_Referido.Refefere%TYPE                   Fecha que ingresa registro
        inuCrrecodi              Entrada                  Ld_Fa_Referido.Crrecodi%TYPE                   Codigo de criterio
        inuEsdecodi              Entrada                  Ld_Fa_Referido.Esdecodi%TYPE                   Estado
        onuErrormessage          Salida                   Number                                         Parametro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : UpdateReferido
      Descripcion    : procedimiento que permite realizar la actualizacion de un referido existente.

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuRefecodi              Entrada                  Ld_Fa_Referido.Refecodi%TYPE                   Codigo del registro de referido
        inuRefesusc              Entrada                  Ld_Fa_Referido.Refesusc%TYPE                   Suscripcion del referido
        inuRefesure              Entrada                  Ld_Fa_Referido.Refesure%TYPE                   Suscripcion del referente
        idtRefefele              Entrada                  Ld_Fa_Referido.Refefele%TYPE                   Fecha de legalizacion
        inuRefevade              Entrada                  Ld_Fa_Referido.Refevade%TYPE                   Valor del descuento
        inuRefeusid              Entrada                  Ld_Fa_Referido.Refeusid%TYPE                   Usuario que ingresa registro
        idtRefefere              Entrada                  Ld_Fa_Referido.Refefere%TYPE                   Fecha que ingresa registro
        inuCrrecodi              Entrada                  Ld_Fa_Referido.Crrecodi%TYPE                   Codigo de criterio
        inuEsdecodi              Entrada                  Ld_Fa_Referido.Esdecodi%TYPE                   Estado
        onuErrormessage          Salida                   Number                                         Parametro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : DeleteReferido
      Descripcion    : procedimiento que permite realizar la eliminacion de referidos existentes.

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuRefecodi              Entrada                  Ld_Fa_Referido.Refecodi%TYPE                   Codigo del registro de referido
        onuErrormessage          Salida                   Number                                         Parametro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro para mensaje de error

  **************************************************************************************************************************************

     Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      05-08-2013       JsilveraSAO213880   Validar que un referido no se le permita aplicar más de dos descuentos
  ***************************************************************************************************************************/
  Function Fsbversion Return Varchar2;
  Function Fbogetreferido(Ionurefecodi    In Ld_Fa_Referido.Refecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean;

  Procedure Insertreferido(Inurefecodi     In Ld_Fa_Referido.Refecodi%Type,
                           Inurefesusc     In Ld_Fa_Referido.Refesusc%Type,
                           Inurefesure     In Ld_Fa_Referido.Refesure%Type,
                           Idtrefefele     In Ld_Fa_Referido.Refefele%Type,
                           Inurefevade     In Ld_Fa_Referido.Refevade%Type,
                           Inurefeusid     In Ld_Fa_Referido.Refeusid%Type,
                           Idtrefefere     In Ld_Fa_Referido.Refefere%Type,
                           Inucrrecodi     In Ld_Fa_Referido.Crrecodi%Type,
                           Inuesdecodi     In Ld_Fa_Referido.Esdecodi%Type,
                           Inurefenupe     In Ld_Fa_Referido.Refenupe%Type,
                           Inurefesove     In Ld_Fa_Referido.Refesove%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

  Procedure Updatereferido(Inurefecodi     In Ld_Fa_Referido.Refecodi%Type,
                           Idtrefefele     In Ld_Fa_Referido.Refefele%Type,
                           Inuesdecodi     In Ld_Fa_Referido.Esdecodi%Type,
                           Inurefenupe     In Ld_Fa_Referido.Refenupe%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

End Pkld_Fa_Referido;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Referido Is

  Boencontrado Boolean := True; /*variable booleana para respuesta a busqueda referido*/
  Csbversion Constant Varchar2(250) := 'SAO213880';

  /*funcion para verificar la existencia de un referido, a partir de su codigo de registro*/
  Function Fbogetreferido(Ionurefecodi    In Ld_Fa_Referido.Refecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean Is
    Cursor Cubureferido Is
      Select Rf.Refecodi
        From Ld_Fa_Referido Rf
       Where Rf.Refecodi = Ionurefecodi;

    Nurefecodi Ld_Fa_Referido.Refecodi%Type;
  Begin
    Pkerrors.Push('Pkld_Fa_Referido.fboGetReferido');
    Open Cubureferido;
    Fetch Cubureferido
      Into Nurefecodi;
    /*valida si existen datos en el cursor*/
    If (Cubureferido%Notfound) Then
      Onuerrormessage := 1;
      Osberrormessage := 'Correcto se puede registrar';
      Boencontrado    := False;
    Else
      Onuerrormessage := 1;
      Osberrormessage := 'El registro ya existe';
      Boencontrado    := True;
    End If;
    Close Cubureferido;
    Return Boencontrado;
  Exception
    When Others Then
      Onuerrormessage := -1;
      Osberrormessage := 'Error de busqueda';

  End Fbogetreferido;

  /*Verifica si para un mismo suscrictor y solicitud de Visita exista un registro en la entidad de referidos*/
  Function Fbovalidatereferido(Ionurefesusc    In Ld_Fa_Referido.Refesusc%Type,
                               Ionurefenupe    In Ld_Fa_Referido.Refenupe%Type,
                               Onuerrormessage Out Number,
                               Osberrormessage Out Varchar2) Return Boolean Is
    Cursor Cubureferido Is
      Select Rf.Refecodi
        From Ld_Fa_Referido Rf
       Where Rf.Refesusc = Ionurefesusc
         And Rf.Refenupe = Ionurefenupe;

    Nurefecodi Ld_Fa_Referido.Refecodi%Type;
  Begin
    Pkerrors.Push('Pkld_Fa_Referido.FboValidatereferido');
    Open Cubureferido;
    Fetch Cubureferido
      Into Nurefecodi;
    /*valida si existen datos en el cursor*/
    If (Cubureferido%Notfound) Then
      Onuerrormessage := 1;
      Osberrormessage := 'Correcto se puede registrar';
      Boencontrado    := False;
    Else
      Onuerrormessage := 1;
      Osberrormessage := 'El registro ya existe';
      Boencontrado    := True;
    End If;
    If (Cubureferido%Isopen) Then
      Close Cubureferido;
    End If;
    Return Boencontrado;
  Exception
    When Others Then
      Onuerrormessage := -1;
      Osberrormessage := 'Error de busqueda';

  End Fbovalidatereferido;
  /*procedimiento para crear un nuevo registro de referido*/
  Procedure Insertreferido(Inurefecodi     In Ld_Fa_Referido.Refecodi%Type,
                           Inurefesusc     In Ld_Fa_Referido.Refesusc%Type,
                           Inurefesure     In Ld_Fa_Referido.Refesure%Type,
                           Idtrefefele     In Ld_Fa_Referido.Refefele%Type,
                           Inurefevade     In Ld_Fa_Referido.Refevade%Type,
                           Inurefeusid     In Ld_Fa_Referido.Refeusid%Type,
                           Idtrefefere     In Ld_Fa_Referido.Refefere%Type,
                           Inucrrecodi     In Ld_Fa_Referido.Crrecodi%Type,
                           Inuesdecodi     In Ld_Fa_Referido.Esdecodi%Type,
                           Inurefenupe     In Ld_Fa_Referido.Refenupe%Type,
                           Inurefesove     In Ld_Fa_Referido.Refesove%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nurefecodi Ld_Fa_Referido.Refecodi%Type := Inurefecodi; /*variable para codigo de registro de referido*/
    --Pragma Autonomous_Transaction;
  Begin
    Boencontrado := Fbovalidatereferido(Inurefesusc,
                                        Inurefenupe, --Fbogetreferido(Nurefecodi,
                                        Onuerrormessage,
                                        Osberrormessage);
    Pkerrors.Push('Pkld_Fa_Referido.InsertReferido');
    /*verifica si el referido a insertar ya existe*/
    If (Boencontrado) Then
      Onuerrormessage := -1;
      Osberrormessage := 'El Referido ya ha sido matriculado';
    Else
      Begin
        Insert Into Ld_Fa_Referido
          (Refecodi,
           Refesusc,
           Refesure,
           Refefele,
           Refevade,
           Refeusid,
           Refefere,
           Crrecodi,
           Esdecodi,
           Refenupe)
        Values
          (Inurefecodi,
           Inurefesusc,
           Inurefesure,
           Idtrefefele,
           Inurefevade,
           Inurefeusid,
           Idtrefefere,
           Inucrrecodi,
           Inuesdecodi,
           Inurefenupe);
        Onuerrormessage := 1;
        Osberrormessage := 'Referido creado.';
        -- Commit;
      Exception
        When Others Then
          Onuerrormessage := -1;
          Osberrormessage := 'Error al guardar el registro referido';
      End;
    End If;
  End Insertreferido;

  /*procedimiento para actualizar registro de un referido*/
  Procedure Updatereferido(Inurefecodi     In Ld_Fa_Referido.Refecodi%Type,
                           Idtrefefele     In Ld_Fa_Referido.Refefele%Type,
                           Inuesdecodi     In Ld_Fa_Referido.Esdecodi%Type,
                           Inurefenupe     In Ld_Fa_Referido.Refenupe%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nurefecodi Ld_Fa_Referido.Refecodi%Type := Inurefecodi; /*variable para codigo de registro de referido*/
  Begin
    Pkerrors.Push('Pkld_Fa_Referido.UpdateReferido');
    /*funcion para verificar el referido*/
    Boencontrado := Fbogetreferido(Nurefecodi,
                                   Onuerrormessage,
                                   Osberrormessage);
    /*verifica que el referido a actualizar existe*/
    If (Boencontrado = False) Then
      Onuerrormessage := -1;
      Osberrormessage := 'El Referido no existe';
    Else
      Begin
        Update Ld_Fa_Referido
           Set Esdecodi = Inuesdecodi,
               Refesove = Inurefenupe,
               Refefele = Idtrefefele
         Where Refecodi = Nurefecodi /*
                                                                             And Refesusc = Inurefesusc
                                                                             And Refesure = Inurefesure
                                                                             And Refefele = Idtrefefele
                                                                             And Refevade = Inurefevade
                                                                             And Refeusid = Inurefeusid
                                                                             And Refefere = Idtrefefere
                                                                             And Crrecodi = Inucrrecodi*/
        ;
        Onuerrormessage := 1;
        Osberrormessage := 'Registro actualizado.';
      Exception
        When Others Then
          Onuerrormessage := -1;
          Osberrormessage := 'Se presentaron errores al actualizar';
      End;
    End If;
  Exception
    When Others Then
      Onuerrormessage := -1;
      Osberrormessage := 'Se presentaron errores al actualizar';
  End Updatereferido;
  Function Fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(Csbversion);
    --}
  End Fsbversion;
End Pkld_Fa_Referido;
/
PROMPT Otorgando permisos de ejecucion a PKLD_FA_REFERIDO
BEGIN
    pkg_utilidades.praplicarpermisos('PKLD_FA_REFERIDO', 'ADM_PERSON');
END;
/