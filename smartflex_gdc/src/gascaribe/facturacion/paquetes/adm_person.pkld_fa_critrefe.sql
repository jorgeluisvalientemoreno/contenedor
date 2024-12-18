CREATE OR REPLACE Package adm_person.Pkld_Fa_Critrefe Is
  /*****************************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_Critrefe
      Descripción    : Componente de negocio que permite operar sobre los criterios que debe cumplir un suscriptor para aplicar
                       al plan de referidos
      Autor          : javier.rodriguez.SAOJavier Rodríguez.
      Fecha          : 01/10/2012

      Métodos

      Nombre         : fboGetCritrefe
      Descripción    : función que permite validar la existencia de un criterio específico de acuerdo a su código.

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        ioCrrecodi               Entrada/Salida           Ld_Fa_Critrefe.Crrecodi%TYPE                   Código del registro de referido

  **************************************************************************************************************************************
      Nombre         : InserCritrefe
      Descripción    :  procedimiento que permite insertar un nuevo criterio de referido

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inuCrrecodi              Entrada                  Ld_Fa_Critrefe.Crrecodi%TYPE                   Código del registro de referido
        inuCrregelo              Entrada                  Ld_Fa_Critrefe.Crregelo%TYPE                   Código de la ubicación geográfica (departamento, localidad, barrio)
        inuCrrecate              Entrada                  Ld_Fa_Critrefe.Crrecate%TYPE                   Código de la categoría (uso)
        inuCrresuca              Entrada                  Ld_Fa_Critrefe.Crresuca%TYPE                   código de la subcategoría (estrato)
        InucrreSERV              Entrada                  Ld_Fa_Critrefe.CRRESERV%TYPE                   Código tipo de producto
        inuCrrevade              Entrada                  Ld_Fa_Critrefe.Crrevade%TYPE                   Valor del descuento
        idtCrrefein              Entrada                  Ld_Fa_Critrefe.Crrefein%TYPE                   Vigencia inicial
        idtCrrefefi              Entrada                  Ld_Fa_Critrefe.Crrefefi%TYPE                   Vigencia final
        inuCrreusid              Entrada                  Ld_Fa_Critrefe.Crreusid%TYPE                   Usuario que ingresa registro
        idtCrrefere              Entrada                  Ld_Fa_Critrefe.Crrefere%TYPE                   Fecha que ingresa registro
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : UpdateCritrefe
      Descripción    : procedimiento que permite actualizar un criterio de referido

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inuCrrecodi              Entrada                  Ld_Fa_Critrefe.Crrecodi%TYPE                   Código del registro de referido
        inuCrregelo              Entrada                  Ld_Fa_Critrefe.Crregelo%TYPE                   Código de la ubicación geográfica (departamento, localidad, barrio)
        inuCrrecate              Entrada                  Ld_Fa_Critrefe.Crrecate%TYPE                   Código de la categoría (uso)
        inuCrresuca              Entrada                  Ld_Fa_Critrefe.Crresuca%TYPE                   código de la subcategoría (estrato)
        InucrreSERV              Entrada                  Ld_Fa_Critrefe.CRRESERV%TYPE                   Código tipo de producto
        inuCrrevade              Entrada                  Ld_Fa_Critrefe.Crrevade%TYPE                   Valor del descuento
        idtCrrefein              Entrada                  Ld_Fa_Critrefe.Crrefein%TYPE                   Vigencia inicial
        idtCrrefefi              Entrada                  Ld_Fa_Critrefe.Crrefefi%TYPE                   Vigencia final
        inuCrreusid              Entrada                  Ld_Fa_Critrefe.Crreusid%TYPE                   Usuario que ingresa registro
        idtCrrefere              Entrada                  Ld_Fa_Critrefe.Crrefere%TYPE                   Fecha que ingresa registro
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : DeleteCritrefe
      Descripción    : procedimiento que permite borrar un criterio

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inuCrrecodi              Entrada                  Ld_Fa_Critrefe.Crrecodi%TYPE                   Código del registro de referido
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

     Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================
  ***************************************************************************************************************************/

  Function Fnuseqcritrefe Return Varchar2;

  Function Fbogetcritrefe(Iocrrecodi      In Out Ld_Fa_Critrefe.Crrecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean;

  Procedure Insercritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                          Inucrregelo     In Ld_Fa_Critrefe.Crregelo%Type,
                          Inucrrecate     In Ld_Fa_Critrefe.Crrecate%Type,
                          Inucrresuca     In Ld_Fa_Critrefe.Crresuca%Type,
                          InucrreSERV     In Ld_Fa_Critrefe.CrreSERV%Type,
                          Inucrrevade     In Ld_Fa_Critrefe.Crrevade%Type,
                          Idtcrrefein     In Ld_Fa_Critrefe.Crrefein%Type,
                          Idtcrrefefi     In Ld_Fa_Critrefe.Crrefefi%Type,
                          Inucrreusid     In Ld_Fa_Critrefe.Crreusid%Type,
                          Idtcrrefere     In Ld_Fa_Critrefe.Crrefere%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2);

  Procedure Updatecritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                           Inucrregelo     In Ld_Fa_Critrefe.Crregelo%Type,
                           Inucrrecate     In Ld_Fa_Critrefe.Crrecate%Type,
                           Inucrresuca     In Ld_Fa_Critrefe.Crresuca%Type,
                           InucrreSERV     In Ld_Fa_Critrefe.CRRESERV%Type,
                           Inucrrevade     In Ld_Fa_Critrefe.Crrevade%Type,
                           Idtcrrefein     In Ld_Fa_Critrefe.Crrefein%Type,
                           Idtcrrefefi     In Ld_Fa_Critrefe.Crrefefi%Type,
                           Inucrreusid     In Ld_Fa_Critrefe.Crreusid%Type,
                           Idtcrrefere     In Ld_Fa_Critrefe.Crrefere%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);

  Procedure Deletecritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2);
End Pkld_Fa_Critrefe;
/
CREATE OR REPLACE Package Body adm_person.Pkld_Fa_Critrefe Is

  /*Variables locales*/
  Boencontrado Boolean; /*Variable booleana para respuesta a búsqueda de criterio de referido*/

  Function Fnuseqcritrefe Return Varchar2 Is
    Sbvalor Varchar2(3000);
  Begin
    Select Seq_Ld_Fa_Critrefe.Nextval
      Into Sbvalor
      From Dual;
    Return Sbvalor;
  End;

  /*función que permite verificar la existencia de un criterio de referidos*/
  Function Fbogetcritrefe(Iocrrecodi      In Out Ld_Fa_Critrefe.Crrecodi%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Return Boolean Is
    Cursor Cubucritrefe Is
      Select Cr.Crrecodi
        From Ld_Fa_Critrefe Cr
       Where Cr.Crrecodi = Iocrrecodi;
  Begin

    Open Cubucritrefe;
    Fetch Cubucritrefe
      Into Iocrrecodi;
    /*valida si el registro está vacío*/
    If (Cubucritrefe%Notfound) Then
      Onuerrormessage := -1;
      Osberrormessage := 'No existe el registro' || Sqlerrm;
      Boencontrado    := False; /*False si no tiene registros para ese código*/
    Else
      Onuerrormessage := 1;
      Osberrormessage := 'econtrado' || Sqlerrm;
      Boencontrado    := True; /*True si obtiene registros,*/
    End If;

    Close Cubucritrefe;
    Return Boencontrado;
  End Fbogetcritrefe;

  /*procedimiento para insertar un nuevo detalle de referido*/
  Procedure Insercritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                          Inucrregelo     In Ld_Fa_Critrefe.Crregelo%Type,
                          Inucrrecate     In Ld_Fa_Critrefe.Crrecate%Type,
                          Inucrresuca     In Ld_Fa_Critrefe.Crresuca%Type,
                          InucrreSERV     In Ld_Fa_Critrefe.CrreSERV%Type,
                          Inucrrevade     In Ld_Fa_Critrefe.Crrevade%Type,
                          Idtcrrefein     In Ld_Fa_Critrefe.Crrefein%Type,
                          Idtcrrefefi     In Ld_Fa_Critrefe.Crrefefi%Type,
                          Inucrreusid     In Ld_Fa_Critrefe.Crreusid%Type,
                          Idtcrrefere     In Ld_Fa_Critrefe.Crrefere%Type,
                          Onuerrormessage Out Number,
                          Osberrormessage Out Varchar2) Is
    Nucrrecodi Ld_Fa_Critrefe.Crrecodi%Type := Inucrrecodi; /*variable para código del registro de referido*/
  Begin
    /*valida la existencia del criterio de referido*/
    Boencontrado := Fbogetcritrefe(Nucrrecodi, Onuerrormessage, Osberrormessage);
    If (Boencontrado = True) Then
      Onuerrormessage := -1;
      Osberrormessage := 'El Criterio referido ya existe';
    Else
      Begin
        /*realiza la inserción del nuevo detalle de referido*/
        Insert Into Ld_Fa_Critrefe
          (Crrecodi,
           Crregelo,
           Crrecate,
           Crresuca,
           CrreSERV,
           Crrevade,
           Crrefein,
           Crrefefi,
           Crreusid,
           Crrefere)
        Values
          (Inucrrecodi,
           Inucrregelo,
           Inucrrecate,
           Inucrresuca,
           InucrreSERV,
           Inucrrevade,
           Idtcrrefein,
           Idtcrrefefi,
           Inucrreusid,
           Idtcrrefere);
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'criterio registrado exitosamente';
    End If;
  End Insercritrefe;

  /*procedimiento para actualizar criterios de referido*/
  Procedure Updatecritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                           Inucrregelo     In Ld_Fa_Critrefe.Crregelo%Type,
                           Inucrrecate     In Ld_Fa_Critrefe.Crrecate%Type,
                           Inucrresuca     In Ld_Fa_Critrefe.Crresuca%Type,
                           InucrreSERV     In Ld_Fa_Critrefe.CrreSERV%Type,
                           Inucrrevade     In Ld_Fa_Critrefe.Crrevade%Type,
                           Idtcrrefein     In Ld_Fa_Critrefe.Crrefein%Type,
                           Idtcrrefefi     In Ld_Fa_Critrefe.Crrefefi%Type,
                           Inucrreusid     In Ld_Fa_Critrefe.Crreusid%Type,
                           Idtcrrefere     In Ld_Fa_Critrefe.Crrefere%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nucrrecodi Ld_Fa_Critrefe.Crrecodi%Type := Inucrrecodi; /*variable para código del registro de referido*/
  Begin
    /*valida la existencia del criterio de referido*/
    Boencontrado := Fbogetcritrefe(Nucrrecodi, Onuerrormessage, Osberrormessage);
    If (Boencontrado = False) Then
      Onuerrormessage := -1;
      Osberrormessage := 'El Criterio referido ya existe';
    Else
      Begin
        Update Ld_Fa_Critrefe
           Set Crregelo = Inucrregelo,
               Crrecate = Inucrrecate,
               Crresuca = Inucrresuca,
               CrreSERV = InucrreSERV,
               Crrevade = Inucrrevade,
               Crrefein = Idtcrrefein,
               Crrefefi = Idtcrrefefi,
               Crreusid = Inucrreusid,
               Crrefere = Idtcrrefere
         Where Crrecodi = Inucrrecodi;
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'criterio registrado exitosamente';
      Commit;
    End If;
  End Updatecritrefe;

  /*procedimiento para borrar un criterio de referido existente*/
  Procedure Deletecritrefe(Inucrrecodi     In Ld_Fa_Critrefe.Crrecodi%Type,
                           Onuerrormessage Out Number,
                           Osberrormessage Out Varchar2) Is
    Nucrrecodi Ld_Fa_Critrefe.Crrecodi%Type := Inucrrecodi; /*variable para código del registro de referido*/
  Begin
    /*verifica la existencia del criterio de referido*/
    Boencontrado := Fbogetcritrefe(Nucrrecodi, Onuerrormessage, Osberrormessage);
    If (Boencontrado = False) Then
      Onuerrormessage := -1;
      Osberrormessage := 'El Criterio referido ya existe';
    Else
      Begin
        Delete From Ld_Fa_Critrefe
         Where Crrecodi = Inucrrecodi;
      End;
      Onuerrormessage := 1;
      Osberrormessage := 'criterio registrado exitosamente';
      Commit; --Valido Update
    End If;
  End Deletecritrefe;
End Pkld_Fa_Critrefe;
/
Prompt Otorgando permisos sobre ADM_PERSON.Pkld_Fa_Critrefe
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('Pkld_Fa_Critrefe'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on adm_person.PKLD_FA_CRITREFE to REXEOPEN;
GRANT EXECUTE on adm_person.PKLD_FA_CRITREFE to RSELSYS;
/
