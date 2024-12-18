CREATE OR REPLACE PACKAGE adm_person.pkld_fa_concrefe IS
  /*****************************************************************************************************************************
      Propiedad intelectual de Ludycom S.A.

      Unidad         : PKLD_FA_Concrefe
      Descripción    : Componente de negocio que permite operar sobre los conceptos establecidos en el plan de referidos
      Autor          : javier.rodriguez.SAOJavier Rodríguez.
      Fecha          : 01/10/2012

      Métodos

      Nombre         : fsbSeqConcrefe
      Descripción    : función que permite obtener el siguiente consecutivo de la tabla ld_fa_concrefe

      Parámetros     : No hay parámetros

  **************************************************************************************************************************************

      Nombre         : fboGetConcRefe
      Descripción    : función que permite validar la existencia de un concepto específico.

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        ionucorecodi             Entrada/Salida           Ld_Fa_Concrefe.Corecodi%TYPE                   Código del concepto referido
        ionucrrecodi             Entrada/Salida           Ld_Fa_Critrefe.Crrecodi%TYPE                   Código del criterio de referido

  **************************************************************************************************************************************
      Nombre         : InsertConcRefe
      Descripción    : procedimiento que permite insertar un nuevo concepto perteneciente al plan de referidos.

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inucorecodi              Entrada                  ld_fa_concrefe.corecodi%TYPE                   código del concepto referido
        inucoreconc              Entrada                  ld_fa_concrefe.coreconc%TYPE                   código del concepto
        inucoreprio              Entrada                  ld_fa_concrefe.coreprio%TYPE                   prioridad
        inucorevami              Entrada                  ld_fa_concrefe.corevami%TYPE                   valor mínimo del concepto
        inucoreusid              Entrada                  ld_fa_concrefe.coreusid%TYPE                   usuario que ingresa registro
        idtcorefere              Entrada                  ld_fa_concrefe.corefere%TYPE                   fecha que ingresa registro
        inucrrecodi              Entrada                  ld_fa_concrefe.crrecodi%TYPE                   código del criterio de referido
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : UpdateConcRefe
      Descripción    : procedimiento que permite actualizar un concepto definido dentro del plan de referido.

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inucorecodi              Entrada                  ld_fa_concrefe.corecodi%TYPE                   Código del concepto referido
        inucoreconc              Entrada                  ld_fa_concrefe.coreconc%TYPE                   Código del concepto
        inucoreprio              Entrada                  ld_fa_concrefe.coreprio%TYPE                   Prioridad
        inucorevami              Entrada                  ld_fa_concrefe.corevami%TYPE                   Valor mínimo del concepto
        inucoreusid              Entrada                  ld_fa_concrefe.coreusid%TYPE                   Usuario que ingresa registro
        idtcorefere              Entrada                  ld_fa_concrefe.corefere%TYPE                   Fecha que ingresa registro
        inucrrecodi              Entrada                  ld_fa_concrefe.crrecodi%TYPE                   Código del criterio de referido
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

      Nombre         : DeleteConcRefe
      Descripción    : procedimiento que permite borrar un concepto definido dentro del plan de referido.

      Parámetros     :

      Nombre Parámetro         Tipo de parámetro        Tipo de dato del parámetro                     Descripción
        inucorecodi              Entrada                  ld_fa_concrefe.corecodi%TYPE,                  Código del concepto referido
        inucrrecodi              Entrada                  ld_fa_concrefe.crrecodi%TYPE                   Código del criterio de referido
        onuErrormessage          Salida                   Number                                         Parámetro para mensaje de error
        osbErrormessage          Salida                   Varchar2                                       Parámetro para mensaje de error

  **************************************************************************************************************************************

     Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================
  ***************************************************************************************************************************/

  FUNCTION fsbseqconcrefe RETURN VARCHAR2;

  FUNCTION fbogetconcrefe(ionucorecodi    IN OUT ld_fa_concrefe.corecodi%TYPE,
                          ionucrrecodi    IN OUT ld_fa_critrefe.crrecodi%TYPE,
                          onuerrormessage OUT NUMBER,
                          osberrormessage OUT VARCHAR2) RETURN BOOLEAN;

  PROCEDURE insertconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucoreconc     IN ld_fa_concrefe.coreconc%TYPE,
                           inucoreprio     IN ld_fa_concrefe.coreprio%TYPE,
                           inucorevami     IN ld_fa_concrefe.corevami%TYPE,
                           inucoreusid     IN ld_fa_concrefe.coreusid%TYPE,
                           idtcorefere     IN ld_fa_concrefe.corefere%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2);

  PROCEDURE updateconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucoreconc     IN ld_fa_concrefe.coreconc%TYPE,
                           inucoreprio     IN ld_fa_concrefe.coreprio%TYPE,
                           inucorevami     IN ld_fa_concrefe.corevami%TYPE,
                           inucoreusid     IN ld_fa_concrefe.coreusid%TYPE,
                           idtcorefere     IN ld_fa_concrefe.corefere%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2);

  PROCEDURE deleteconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2);
END pkld_fa_concrefe;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkld_fa_concrefe IS

  /*Variables locales*/
  gsberrmsg    ge_error_log.description%TYPE;
  boencontrado BOOLEAN; /*Variable booleana para respuesta a búsqueda referido*/

  FUNCTION fsbseqconcrefe RETURN VARCHAR2 IS
    sbvalor VARCHAR2(3000);
  BEGIN
    pkerrors.push('PKLD_FA_CONCREFE.fsbSeqConcrefe');
    SELECT seq_ld_fa_concrefe.nextval
      INTO sbvalor
      FROM dual;
    RETURN sbvalor;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END;

  /*función que permite verificar la existencia de un concepto*/
  FUNCTION fbogetconcrefe(ionucorecodi    IN OUT ld_fa_concrefe.corecodi%TYPE,
                          ionucrrecodi    IN OUT ld_fa_critrefe.crrecodi%TYPE,
                          onuerrormessage OUT NUMBER,
                          osberrormessage OUT VARCHAR2) RETURN BOOLEAN IS
    CURSOR cubuconcrefe IS
      SELECT cr.corecodi, cr.crrecodi
        FROM ld_fa_concrefe cr
       WHERE cr.corecodi = ionucorecodi AND
             cr.crrecodi = ionucrrecodi;
  BEGIN
    pkerrors.push('PKLD_FA_CONCREFE.fboGetConcRefe');
    OPEN cubuconcrefe;
    FETCH cubuconcrefe
      INTO ionucorecodi, ionucrrecodi;
    /*se verifica que existan datos en el cursor*/
    IF (cubuconcrefe%NOTFOUND) THEN
      onuerrormessage := -1;
      osberrormessage := 'El registro no existe' || SQLERRM;
      boencontrado    := FALSE; /*False si no existen registros*/
    ELSE
      onuerrormessage := 1;
      osberrormessage := 'Encontrado' || SQLERRM;
      boencontrado    := TRUE; /*True si existen registros*/
    END IF;

    CLOSE cubuconcrefe;
    RETURN boencontrado;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END fbogetconcrefe;

  /*procedimiento para insertar un nuevo concepto para el plan de referidos*/
  PROCEDURE insertconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucoreconc     IN ld_fa_concrefe.coreconc%TYPE,
                           inucoreprio     IN ld_fa_concrefe.coreprio%TYPE,
                           inucorevami     IN ld_fa_concrefe.corevami%TYPE,
                           inucoreusid     IN ld_fa_concrefe.coreusid%TYPE,
                           idtcorefere     IN ld_fa_concrefe.corefere%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2) IS
    nucorecodi ld_fa_concrefe.corecodi%TYPE := inucorecodi; /*variable para código del concepto referido*/
    nucrrecodi ld_fa_concrefe.crrecodi%TYPE := inucrrecodi; /*variable para código del criterio de referido*/
  BEGIN
    pkerrors.push('PKLD_FA_CONCREFE.InsertConcRefe');
    boencontrado := fbogetconcrefe(nucorecodi,
                                   nucrrecodi,
                                   onuerrormessage,
                                   osberrormessage);
    /*se verifica la existencia del concepto*/
    IF (boencontrado = TRUE) THEN
      onuerrormessage := -1;
      osberrormessage := 'El Concepto ya existe';
    ELSE
      BEGIN
        /*se realiza la inserción del nuevo concepto*/
        INSERT INTO ld_fa_concrefe
          (corecodi,
           coreconc,
           coreprio,
           corevami,
           coreusid,
           corefere,
           crrecodi)
        VALUES
          (inucorecodi,
           inucoreconc,
           inucoreprio,
           inucorevami,
           inucoreusid,
           idtcorefere,
           inucrrecodi);
      END;
      onuerrormessage := 1;
      osberrormessage := 'Concepto exitoso';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END insertconcrefe;

  /*procedimiento para actualizar un concepto perteneciente al plan de referidos*/
  PROCEDURE updateconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucoreconc     IN ld_fa_concrefe.coreconc%TYPE,
                           inucoreprio     IN ld_fa_concrefe.coreprio%TYPE,
                           inucorevami     IN ld_fa_concrefe.corevami%TYPE,
                           inucoreusid     IN ld_fa_concrefe.coreusid%TYPE,
                           idtcorefere     IN ld_fa_concrefe.corefere%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2) IS
    nucorecodi ld_fa_concrefe.corecodi%TYPE := inucorecodi; /*variable para código del concepto referido*/
    nucrrecodi ld_fa_concrefe.crrecodi%TYPE := inucrrecodi; /*variable para código del criterio de referido*/
  BEGIN
    pkerrors.push('PKLD_FA_CONCREFE.UpdateConcRefe');
    boencontrado := fbogetconcrefe(nucorecodi,
                                   nucrrecodi,
                                   onuerrormessage,
                                   osberrormessage);
    /*se verifica la existencia del concepto*/
    IF (boencontrado = FALSE) THEN
      onuerrormessage := -1;
      osberrormessage := 'El Concepto no existe';
    ELSE
      BEGIN
        /*se actualiza el respectivo concepto*/
        UPDATE ld_fa_concrefe
           SET coreconc = inucoreconc,
               coreprio = inucoreprio,
               corevami = inucorevami,
               coreusid = inucoreusid,
               corefere = idtcorefere
         WHERE corecodi = inucorecodi AND
               crrecodi = inucrrecodi;

      END;
      onuerrormessage := 1;
      osberrormessage := 'Actualizacion exitosa';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END updateconcrefe;

  /*procedimiento para borrar un concepto definido en el plan de referidos*/
  PROCEDURE deleteconcrefe(inucorecodi     IN ld_fa_concrefe.corecodi%TYPE,
                           inucrrecodi     IN ld_fa_concrefe.crrecodi%TYPE,
                           onuerrormessage OUT NUMBER,
                           osberrormessage OUT VARCHAR2) IS
    nucorecodi ld_fa_concrefe.corecodi%TYPE := inucorecodi; /*variable para código del concepto referido*/
    nucrrecodi ld_fa_concrefe.crrecodi%TYPE := inucrrecodi; /*variable para código del criterio de referido*/
  BEGIN
    /*se verifica la existencia del concepto*/
    boencontrado := fbogetconcrefe(nucorecodi,
                                   nucrrecodi,
                                   onuerrormessage,
                                   osberrormessage);
    IF (boencontrado = FALSE) THEN
      onuerrormessage := -1;
      osberrormessage := 'El detalle referido no existe';
    ELSE
      BEGIN
        pkerrors.push('PKLD_FA_CONCREFE.DeleteConcRefe');
        /*se borra el respectivo concepto*/
        DELETE ld_fa_concrefe
         WHERE corecodi = inucorecodi OR
               crrecodi = inucrrecodi;
      END;
      onuerrormessage := 1;
      osberrormessage := 'Detalle Referido Eliminado';
      COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      pkerrors.notifyerror(pkerrors.fsblastobject, SQLERRM, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
  END deleteconcrefe;
END pkld_fa_concrefe;
/
Prompt Otorgando permisos sobre ADM_PERSON.pkld_fa_concrefe
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkld_fa_concrefe'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on adm_person.PKLD_FA_CONCREFE to REXEOPEN;
GRANT EXECUTE on adm_person.PKLD_FA_CONCREFE to RSELSYS;
/
