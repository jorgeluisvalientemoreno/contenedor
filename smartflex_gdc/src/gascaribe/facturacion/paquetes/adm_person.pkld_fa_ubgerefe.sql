CREATE OR REPLACE Package adm_person.Pkld_Fa_Ubgerefe Is
  /*****************************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_Ubgerefe
      Descripcion    : Componente de negocio que permite configurar las ubicaciones geograficas a las que debe pertenecer el
                       referente o referido.
      Autor          : javier.rodriguez.SAOJavier Rodriguez.
      Fecha          : 24/09/2012

      Metodos

      Nombre         : fnuSeqUbgerefe
      Descripcion    : funcion que permite obtener el siguiente consecutivo de la tabla relacionada con las ubicaciones geograficas.

      Parametros     : No hay parametros

  **************************************************************************************************************************************


      Nombre         : fboGetUbgerefe
      Descripcion    : funcion que permite validar la existencia de una ubicacion geografica.

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        ionuugrecodi             Entrada/Salida           ld_fa_ubgerefe.ugrecodi%TYPE                   codigo de la ubicacion geografica
        onuErrormessage          Salida                   Number                                         Parametro de mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro de mensaje de error

  **************************************************************************************************************************************
      Nombre         : InsertUbgerefe
      Descripcion    : procedimiento que permite insertar nuevas ubicaciones geograficas

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuugrecodi              Entrada                  ld_fa_ubgerefe.ugrecodi%TYPE                   Codigo de la ubicacion geografica
        inuugregelo              Entrada                  ld_fa_ubgerefe.ugregelo%TYPE                   Codigo de la ubicacion geografica (departamento, localidad, barrio)
        idtugrefein              Entrada                  ld_fa_ubgerefe.ugrefein%TYPE                   Vigencia inicial
        idtugrefefi              Entrada                  ld_fa_ubgerefe.ugrefefi%TYPE                   Vigencia final
        inuugreusid              Entrada                  ld_fa_ubgerefe.ugreusid%TYPE                   Usuario que ingresa registro
        idtugrefere              Entrada                  ld_fa_ubgerefe.ugrefere%TYPE                   Fecha que ingresa registro
        inugretire               Entrada                  ld_fa_ubgerefe.ugretire%TYPE                   Tipo (referido, referente)
        onuErrormessage          Entrada                  Number                                         Parametro de mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro de mensaje de error

  **************************************************************************************************************************************

      Nombre         : UpdateUbgerefe
      Descripcion    : procedimiento que permite actualizar una ubicacion geografica a partir de su codigo o cualquier otro dato

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuugrecodi              Entrada                  ld_fa_ubgerefe.ugrecodi%TYPE                   Codigo de la ubicacion geografica
        inuugregelo              Entrada                  ld_fa_ubgerefe.ugregelo%TYPE                   Codigo de la ubicacion geografica (departamento, localidad, barrio)
        idtugrefein              Entrada                  ld_fa_ubgerefe.ugrefein%TYPE                   Vigencia inicial
        idtugrefefi              Entrada                  ld_fa_ubgerefe.ugrefefi%TYPE                   Vigencia final
        inuugreusid              Entrada                  ld_fa_ubgerefe.ugreusid%TYPE                   Usuario que ingresa registro
        idtugrefere              Entrada                  ld_fa_ubgerefe.ugrefere%TYPE                   Fecha que ingresa registro
        inugretire               Entrada                  ld_fa_ubgerefe.ugretire%TYPE                   Tipo (referido, referente)
        onuErrormessage          Entrada                  Number                                         Parametro de mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro de mensaje de error

  **************************************************************************************************************************************

      Nombre         : DeleteUbgerefe
      Descripcion    : procedimiento que permite borrar una ubicacion geografica a partir de su codigo

      Parametros     :

      Nombre Parametro         Tipo de parametro        Tipo de dato del parametro                     Descripcion
        inuugrecodi              Entrada                  ld_fa_ubgerefe.ugrecodi%TYPE                   Codigo de la ubicacion geografica
        onuErrormessage          Salida                   Number                                         Parametro de mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parametro de mensaje de error

  **************************************************************************************************************************************

     Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
  ***************************************************************************************************************************/

  Function Fsbsequbgerefe Return Varchar2;

  Function Fbogetubgerefe(Ionuugrecodi    In Out Ld_Fa_Ubgerefe.Ugrecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean;

  Procedure Insertubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Inuugregelo     In Ld_Fa_Ubgerefe.Ugregelo%Type,
                           Idtugrefein     In Ld_Fa_Ubgerefe.Ugrefein%Type,
                           Idtugrefefi     In Ld_Fa_Ubgerefe.Ugrefefi%Type,
                           Inuugreusid     In Ld_Fa_Ubgerefe.Ugreusid%Type,
                           Idtugrefere     In Ld_Fa_Ubgerefe.Ugrefere%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

  Procedure Updateubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Inuugregelo     In Ld_Fa_Ubgerefe.Ugregelo%Type,
                           Idtugrefein     In Ld_Fa_Ubgerefe.Ugrefein%Type,
                           Idtugrefefi     In Ld_Fa_Ubgerefe.Ugrefefi%Type,
                           Inuugreusid     In Ld_Fa_Ubgerefe.Ugreusid%Type,
                           Idtugrefere     In Ld_Fa_Ubgerefe.Ugrefere%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

  Procedure Deleteubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

End Pkld_Fa_Ubgerefe;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Ubgerefe Is

  /*Variables locales*/
  Gsberrmsg    Ge_Error_Log.Description%Type;
  Boencontrado Boolean; /*variable que indica la existencia de la ubicacion geografica*/

  Function Fsbsequbgerefe Return Varchar2 Is
    Sbvalor Varchar2(3000);
  Begin
    Pkerrors.Push('pkld_fa_ubgerefe.fsbSeqUbgerefe');
    Select Seq_Ld_Fa_Ubgrefe.Nextval
      Into Sbvalor
      From Dual;
    Return Sbvalor;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End;

  /*funcion que permite verificar la existencia de una ubicacion geografica*/
  Function Fbogetubgerefe(Ionuugrecodi    In Out Ld_Fa_Ubgerefe.Ugrecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean Is
    Cursor Cubuubgerefe Is
      Select Lu.Ugrecodi
        From Ld_Fa_Ubgerefe Lu
       Where Lu.Ugrecodi = Ionuugrecodi;
  Begin
    Pkerrors.Push('pkld_fa_ubgerefe.fboGetUbgerefe');
    Open Cubuubgerefe;
    Fetch Cubuubgerefe
      Into Ionuugrecodi;
    /*se valida la existencia de registros en el cursor*/
    If (Cubuubgerefe%Notfound) Then
      Onuerrormessage := -1;
      Osberrormessage := 'la ubicacion geografica no esta beneficiada';
      Boencontrado    := False; /*False si la ubicacion geografica no existe*/
    Else
      Onuerrormessage := 1;
      Osberrormessage := 'ubicacion geografica beneficiada';
      Boencontrado    := True; /*True si la ubicacion geografica existe*/
    End If;

    Close Cubuubgerefe;
    Return Boencontrado;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Fbogetubgerefe;

  /*procedimiento para insertar una nueva ubicacion geografica*/
  Procedure Insertubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Inuugregelo     In Ld_Fa_Ubgerefe.Ugregelo%Type,
                           Idtugrefein     In Ld_Fa_Ubgerefe.Ugrefein%Type,
                           Idtugrefefi     In Ld_Fa_Ubgerefe.Ugrefefi%Type,
                           Inuugreusid     In Ld_Fa_Ubgerefe.Ugreusid%Type,
                           Idtugrefere     In Ld_Fa_Ubgerefe.Ugrefere%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nuugrecodi Ld_Fa_Ubgerefe.Ugrecodi%Type := Inuugrecodi; /*variable para codigo de la ubicacion geografica */
  Begin
    Pkerrors.Push('pkld_fa_ubgerefe.InsertUbgerefe');
    Boencontrado := Fbogetubgerefe(Nuugrecodi, Onuerrormessage, Osberrormessage);
    /*se verifica la existencia de la ubicacion geografica*/
    If (Boencontrado = True) Then
      Onuerrormessage := -1;
      Osberrormessage := 'La ubicacion geografica ya ha sido matriculada';
    Else
      Begin
        /*se realiza la insercion de la nueva ubicacion geografica*/
        Insert Into Ld_Fa_Ubgerefe
          (Ugrecodi, Ugregelo, Ugrefein, Ugrefefi, Ugreusid, Ugrefere)
        Values
          (Inuugrecodi,
           Inuugregelo,
           Idtugrefein,
           Idtugrefefi,
           Inuugreusid,
           Idtugrefere
           );
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'Ubicacion geografica matriculado exitosamente';
    End If;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Insertubgerefe;

  Procedure Updateubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Inuugregelo     In Ld_Fa_Ubgerefe.Ugregelo%Type,
                           Idtugrefein     In Ld_Fa_Ubgerefe.Ugrefein%Type,
                           Idtugrefefi     In Ld_Fa_Ubgerefe.Ugrefefi%Type,
                           Inuugreusid     In Ld_Fa_Ubgerefe.Ugreusid%Type,
                           Idtugrefere     In Ld_Fa_Ubgerefe.Ugrefere%Type
                          ,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nuugrecodi Ld_Fa_Ubgerefe.Ugrecodi%Type := Inuugrecodi; /*variable para codigo de la ubicacion geografica*/
  Begin
    Pkerrors.Push('pkld_fa_ubgerefe.UpdateUbgerefe');
    Boencontrado := Fbogetubgerefe(Nuugrecodi, Onuerrormessage, Osberrormessage);
    /*se valida la existencia de la ubicacion geografica*/
    If (Boencontrado = False) Then
      Onuerrormessage := -1;
      Osberrormessage := 'La ubicacion geografica no ha sido matriculada';
    Else
      Begin
        /*se realiza la actualizacion de la ubicacion geografica especificada*/
        Update Ld_Fa_Ubgerefe k
           Set Ugregelo = Inuugregelo,
               Ugrefein = Idtugrefein,
               Ugrefefi = Idtugrefefi,
               Ugreusid = Inuugreusid,
               Ugrefere = Idtugrefere
         Where Ugrecodi = Ugrecodi;
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'Ubicacion geografica actualizada exitosamente';
      Commit;
    End If;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Updateubgerefe;

  /*procedimiento para borrar una ubicacion geografica*/
  Procedure Deleteubgerefe(Inuugrecodi     In Ld_Fa_Ubgerefe.Ugrecodi%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is

    Nuugrecodi Ld_Fa_Ubgerefe.Ugrecodi%Type := Inuugrecodi; /*variable para codigo de la ubicacion geografica */
  Begin
    Pkerrors.Push('pkld_fa_ubgerefe.DeleteUbgerefe');
    Boencontrado := Fbogetubgerefe(Nuugrecodi, Onuerrormessage, Osberrormessage);
    /*se verifica la existencia de la ubicacion geografica*/
    If (Boencontrado = False) Then
      Onuerrormessage := -1;
      Osberrormessage := 'La ubicacion geografica no existe';
    Else
      Begin
        /*se borra la respectiva ubicacion geografica*/
        Delete Ld_Fa_Ubgerefe
         Where Ugrecodi = Inuugrecodi;
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'ubicacion geografica Eliminada';
      Commit;
    End If;
  Exception
    When Others Then
      Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
      Pkerrors.Pop;
      Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
  End Deleteubgerefe;

End Pkld_Fa_Ubgerefe;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Ubgerefe
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Ubgerefe'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on adm_person.PKLD_FA_UBGEREFE to REXEOPEN;
GRANT EXECUTE on adm_person.PKLD_FA_UBGEREFE to RSELSYS;
/
