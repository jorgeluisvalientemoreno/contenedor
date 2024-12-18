CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKGACTIVOENCURSO IS
  /********************************************************************************
  PROPIEDAD INTELECTUAL DE SURTIGAS.
  PAQUETE:    ldci_pkgActivoEnCurso
  DESCRIPCION: Paquete de primer nivel para manejar el CRUD de la tabla
               ldci_activoencurso.

  AUTOR:      Jorge Mario Galindo - ArquitecSoft
  FECHA:      05/03/2014

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR    MODIFICACION

  ********************************************************************************/
  --<<
  -- cursor de la ldci_activoencurso
  -->>
  CURSOR curecord(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                  ivasubnumero     IN ldci_activoencurso.subnumero%TYPE) IS
    SELECT ldci_activoencurso.*, ldci_activoencurso.rowid
      FROM ldci_activoencurso
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero;

  tyldc_activoencurso ldci_activoencurso%ROWTYPE;

  SUBTYPE stbldc_activoencurso IS ldci_activoencurso%ROWTYPE;

  --<<
  -- tipo usado para manipular ref cursors
  -->>
  TYPE tyrefcursor IS REF CURSOR;
  --<<
  -- subtipos
  -->>
  SUBTYPE styldc_activoencurso IS curecord%ROWTYPE;
  --<<
  -- tipos
  -->>
  TYPE tytbldc_activoencurso IS TABLE OF styldc_activoencurso INDEX BY BINARY_INTEGER;
  TYPE tyrfrecords IS REF CURSOR RETURN styldc_activoencurso;
  --<<
  -- constantes para los mensajes de error y desplegar la existencia o no de un registro
  -->>
  cnurecord_not_exist     CONSTANT NUMBER := 2;
  cnurecord_already_exist CONSTANT NUMBER := 1;
  cnutableparameter       CONSTANT NUMBER := 1000;

  --<<
  -- funcion para obtener la sociedad
  --<<
  FUNCTION fvaGetSociedad(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                          inuusecache      IN NUMBER DEFAULT 0)
    RETURN VARCHAR2;

  --<<
  -- Procedimiento para la Actualizacion de la sociedad
  -->>
  PROCEDURE ActSociedad(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        ivasociedad      IN ldci_activoencurso.sociedad%TYPE);

  --<<
  -- Funcion para obtener el texto breve
  -->>
  FUNCTION fvaGetTexto_Breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                             ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                             inuusecache      IN NUMBER DEFAULT 0)
    RETURN VARCHAR2;

  --<<
  --  Fucnion para Actualizar el Texto Breve
  -->>
  PROCEDURE acttexto_breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                           ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                           ivatexto_breve   IN ldci_activoencurso.texto_breve%TYPE);

  --<<
  -- Funcion para Validar si existe un activo fijo en curso
  -->>
  FUNCTION fboExiste(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                     ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                     inuusecache      IN NUMBER DEFAULT 0) RETURN BOOLEAN;

  --<<
  -- Funcion para validar si un Activo en curso existe
  -->>
  PROCEDURE validaLlave(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para validar  llave duplicada
  -->>
  PROCEDURE validaLlaveDuplicada(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                 ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                 inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para Consultar un Activo en Curso
  -->>
  PROCEDURE consultarRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                              ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                              orcrecord        OUT NOCOPY styldc_activoencurso,
                              inuusecache      IN NUMBER DEFAULT 0);

  --<<
  -- Funcion para consultar un Activo Fijo en Curso
  -->>
  FUNCTION frcConsultaRregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                inuusecache      IN NUMBER DEFAULT 0)
    RETURN styldc_activoencurso;

  --<<
  -- Funcion para Insertar un activo fijo en curso
  -->>
  PROCEDURE insertaregistro(ircldc_activoencurso IN ldci_activoencurso%ROWTYPE);

  --<<
  -- Funcion para Borrar un Activo Fijo en Curso
  -->>
  PROCEDURE borraregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE);

  --<<
  -- Funcion para Borrar un Activo Fijo en Curso por Rowid
  -->>
  PROCEDURE borrarowid(irirowid ROWID);

  --<<
  -- Procedimiento que sera consumido por el WS para el dato maestro de activos fijos
	-->>
  PROCEDURE proConsuWSActivoFijo(codActivo ldci_activoencurso.codigo_activo%TYPE,
                                 codSubnum ldci_activoencurso.subnumero%TYPE,
                                 sociedad  ldci_activoencurso.sociedad%TYPE,
                                 descripci ldci_activoencurso.texto_breve%TYPE);

END LDCI_PKGACTIVOENCURSO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKGACTIVOENCURSO IS
  /********************************************************************************
  PROPIEDAD INTELECTUAL DE SURTIGAS.
  PAQUETE:     ldci_pkgActivoEnCurso
  DESCRIPCION: Paquete de primer nivel para manejar el CRUD de la tabla
               ldci_activoencurso.

  AUTOR:       Jorge Mario Galindo - ArquitecSoft
  FECHA:       05/03/2014

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR    MODIFICACION

  ********************************************************************************/

  --<<
  -- Tipo Cursor
  -->>
  TYPE tyrfldc_activoencurso IS REF CURSOR;

  --<<
  -- Tipos referenciando al registro
  --<<
  TYPE tytbcodigo_activo IS TABLE OF ldci_activoencurso.codigo_activo%TYPE INDEX BY BINARY_INTEGER;
  TYPE tytbsubnumero IS TABLE OF ldci_activoencurso.subnumero%TYPE INDEX BY BINARY_INTEGER;
  TYPE tytbsociedad IS TABLE OF ldci_activoencurso.sociedad%TYPE INDEX BY BINARY_INTEGER;
  TYPE tytbtexto_breve IS TABLE OF ldci_activoencurso.texto_breve%TYPE INDEX BY BINARY_INTEGER;

  --<<
  -- Tipo de Dato
  -->>
  TYPE tyrcldc_activoencurso IS RECORD(
    codigo_activo tytbcodigo_activo,
    subnumero     tytbsubnumero,
    sociedad      tytbsociedad,
    texto_breve   tytbtexto_breve);

  --<<
  --Variables Globales
  -->>
  rcRecOfTab   tyrcLDC_ACTIVOENCURSO;
  rcData       cuRecord%ROWTYPE;
  rcRecordNull cuRecord%ROWTYPE;
  cnuCACHEON   NUMBER := 1;

  FUNCTION fblCargaPrevia(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE)
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fblCargaPrevia
    DESCRIPCION: Carga la Carga Previa.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              TRUE             => Existe
                           FALSE            => No Existe

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
   RETURN BOOLEAN IS
  BEGIN
    IF (iVACODIGO_ACTIVO = rcData.CODIGO_ACTIVO AND
       iVASUBNUMERO = rcData.SUBNUMERO) THEN
      RETURN(TRUE);
    END IF;
    RETURN(FALSE);
  END;

  PROCEDURE reCarga(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                    ivasubnumero     IN ldci_activoencurso.subnumero%TYPE) IS
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDIMIENTO:    reCarga
    DESCRIPCION:      Procedimiento para la Recarga de un Activo Fijo en Curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    IF (curecord%ISOPEN) THEN
      CLOSE curecord;
    END IF;
    OPEN curecord(ivacodigo_activo, ivasubnumero);
    FETCH curecord
      INTO rcdata;
    IF (curecord%NOTFOUND) THEN
      CLOSE curecord;
      rcdata := rcrecordnull;
      RAISE no_data_found;
    END IF;
    CLOSE curecord;
  END;

  FUNCTION fvaGetSociedad(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                          inuusecache      IN NUMBER DEFAULT 0)
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fvaGetSociedad
    DESCRIPCION: funcion para obtener la sociedad.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Sociedad

    AUTOR:       Jorge Mario Galindo - ArquitecSoft
    FECHA:       05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
   RETURN VARCHAR2 IS
  BEGIN
    IF (inuusecache = cnucacheon AND
       fblcargaprevia(ivacodigo_activo, ivasubnumero)) THEN
      RETURN(rcdata.sociedad);
    END IF;
    recarga(ivacodigo_activo, ivasubnumero);
    RETURN(rcdata.sociedad);

  EXCEPTION
    WHEN OTHERS THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       RETURN NULL;
  END;

  PROCEDURE ActSociedad(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        ivasociedad      IN ldci_activoencurso.sociedad%TYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDIMIENTO:    ActSociedad
    DESCRIPCION:      Procedimiento para actualizar la sociedad de un activo fijo en
                      curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           ivasociedad      => Sociedad
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:            Jorge Mario Galindo - ArquitecSoft
    FECHA:            05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    UPDATE ldci_activoencurso
       SET sociedad = ivasociedad
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero;

    rcdata.sociedad := ivasociedad;
  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;

  END;

  FUNCTION fvaGetTexto_Breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                             ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                             inuusecache      IN NUMBER DEFAULT 0)
  /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fvaGetTexto_Breve
    DESCRIPCION: Funcion para obtener el texto breve.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Texto Breve

    AUTOR:       Jorge Mario Galindo - ArquitecSoft
    FECHA:       05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
   RETURN VARCHAR2 IS
  BEGIN
    IF (inuusecache = cnucacheon AND
       fblcargaprevia(ivacodigo_activo, ivasubnumero)) THEN
      RETURN(rcdata.texto_breve);
    END IF;
    recarga(ivacodigo_activo, ivasubnumero);
    RETURN(rcdata.texto_breve);

  EXCEPTION
    WHEN OTHERS THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       RETURN NULL;

  END;

  PROCEDURE actTexto_Breve(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                           ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                           ivatexto_breve   IN ldci_activoencurso.texto_breve%TYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:     actTexto_Breve
    PROCEDIMIENTO: Actualiza el texto breve de un activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           ivatexto_breve   => Descripcion
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:         Jorge Mario Galindo - ArquitecSoft
    FECHA:         05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    UPDATE ldci_activoencurso
       SET texto_breve = ivatexto_breve
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero;

    rcdata.texto_breve := ivatexto_breve;
  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  PROCEDURE cargar(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                   ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                   inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   cargar
    DESCRIPCION: Carga la informacion de un activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    IF (inuusecache = cnucacheon AND
       fblcargaprevia(ivacodigo_activo, ivasubnumero)) THEN
      RETURN;
    END IF;
    recarga(ivacodigo_activo, ivasubnumero);
  END;

  FUNCTION fboExiste(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                     ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                     inuusecache      IN NUMBER DEFAULT 0) RETURN BOOLEAN IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCION:     fboExiste
    DESCRIPCION: Funcion para validar si un activo fijo Existe.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              TRUE             => Existe
                           FALSE            => No Existe

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    cargar(ivacodigo_activo, ivasubnumero, inuusecache);
    RETURN(TRUE);
  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
      RETURN(FALSE);
  END;

  PROCEDURE validaLlave(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                        ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                        inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   validaLlave
    DESCRIPCION: Valida la llave de un activo dijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    cargar(ivacodigo_activo, ivasubnumero, inuusecache);

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  PROCEDURE validaLlaveDuplicada(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                 ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                 inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   validaLlaveDuplicada
    DESCRIPCION: Valida la llave de un activo dijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    cargar(ivacodigo_activo, ivasubnumero, inuusecache);

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
      RETURN;
  END;

  PROCEDURE consultarRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                              ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                              orcrecord        OUT NOCOPY styldc_activoencurso,
                              inuusecache      IN NUMBER DEFAULT 0) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   consultarRegistro
    DESCRIPCION: Consulta un Activo Fijo En Curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  orcrecord        => record
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    cargar(ivacodigo_activo, ivasubnumero, inuusecache);
    orcrecord := rcdata;

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  FUNCTION frcConsultaRregistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                                ivasubnumero     IN ldci_activoencurso.subnumero%TYPE,
                                inuusecache      IN NUMBER DEFAULT 0)
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    FUNCTION:    frcConsultaRregistro
    DESCRIPCION: consulta y retorna en una referencia de cursor el codigo de activo
                 fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Codigo de Activo
                           ivasubnumero     => Subnumero
                           inuusecache      => Control
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              styldc_activoencurso => cursor referenciado

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
   RETURN styldc_activoencurso IS
  BEGIN
    cargar(ivacodigo_activo, ivasubnumero, inuusecache);
    RETURN(rcdata);

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;

  END;

  PROCEDURE insertaRegistro(ircldc_activoencurso IN ldci_activoencurso%ROWTYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   insertaRegistro
    DESCRIPCION: Procedimiento para la insercion de  un activo fijo en curso.

    PARAMETROS DE ENTRADA: ircldc_activoencurso => Type de Activo en Curso
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    INSERT INTO ldci_activoencurso
      (

       codigo_activo,
       subnumero,
       sociedad,
       texto_breve)
    VALUES
      (

       ircldc_activoencurso.codigo_activo,
       ircldc_activoencurso.subnumero,
       ircldc_activoencurso.sociedad,
       ircldc_activoencurso.texto_breve

       );

  EXCEPTION
    WHEN dup_val_on_index THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  PROCEDURE borraRegistro(ivacodigo_activo IN ldci_activoencurso.codigo_activo%TYPE,
                          ivasubnumero     IN ldci_activoencurso.subnumero%TYPE) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   borraRegistro
    DESCRIPCION: borra un registro de activo fijo en curso.

    PARAMETROS DE ENTRADA: ivacodigo_activo => Activo fijo
                           ivasubnumero     => Subnumero
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    DELETE FROM ldci_activoencurso
     WHERE codigo_activo = ivacodigo_activo
       AND subnumero = ivasubnumero;

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
   END;

  PROCEDURE borraRowid(irirowid ROWID) IS
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   borraRowid
    DESCRIPCION: borra un registro de activo fijo en curso por rowid.

    PARAMETROS DE ENTRADA: irirowid => Rowid del activo Fijo
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  BEGIN
    DELETE FROM ldci_activoencurso WHERE ROWID = irirowid;

  EXCEPTION
    WHEN no_data_found THEN
      ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END;

  PROCEDURE proConsuWSActivoFijo(codActivo ldci_activoencurso.codigo_activo%TYPE,
                                 codSubnum ldci_activoencurso.subnumero%TYPE,
                                 sociedad  ldci_activoencurso.sociedad%TYPE,
                                 descripci ldci_activoencurso.texto_breve%TYPE)
    /********************************************************************************
    PROPIEDAD INTELECTUAL DE SURTIGAS.
    PROCEDURE:   proConsuWSActivoFijo
    DESCRIPCION: Logica para la actualizacion de un activo fijo en curso.

    PARAMETROS DE ENTRADA: codActivo => Codigo Activo en Curso
                           codSubnum => Codigo Subnumero
                           sociedad  => Sociedad
                           descripci => Descripcion Breve
    PARAMETROS DE SALIDA:  Ninguno
    RETORNOS:              Ninguno

    AUTOR:      Jorge Mario Galindo - ArquitecSoft
    FECHA:      05/03/2014

    HISTORIA DE MODIFICACIONES
    FECHA         AUTOR    MODIFICACION

    ********************************************************************************/
  IS

    --<<
    -- Parametros
    -->>
    sbError   VARCHAR2(2000);
    nuError   NUMBER := -1;

    --<<
    -- Subtipo
    -->>
    vStbrcLdc_ActivoEnCurso    ldci_pkgActivoEnCurso.stbLdc_ActivoEnCurso;


  BEGIN

    --<<
    -- Se valida si el codigo de activo en curso pasado
    -- por parametro de entrada existe
    -->>
    IF (ldci_pkgActivoEnCurso.fboExiste(ivacodigo_activo => codActivo, ivasubnumero => codSubnum))THEN

       --<<
       -- Se actualiza la sociedad
       -->>
       ldci_pkgActivoEnCurso.ActSociedad(ivacodigo_activo => codActivo,
                                        ivasubnumero     => codSubnum,
                                        ivasociedad      => sociedad);

       --<<
       -- Se actualiza el texto Breve
       -->>
       ldci_pkgActivoEnCurso.ActTexto_Breve(ivacodigo_activo => codActivo,
                                           ivasubnumero     => codSubnum,
                                           ivatexto_breve   => descripci);

    ELSE

       --<<
       -- Seteo los datos del activo en curso a insertar
       -->>
       vStbrcLdc_ActivoEnCurso.Codigo_Activo := codActivo;
       vStbrcLdc_ActivoEnCurso.Subnumero     := codSubnum;
       vStbrcLdc_ActivoEnCurso.Sociedad      := sociedad;
       vStbrcLdc_ActivoEnCurso.Texto_Breve   := descripci;

       --<<
       -- Inserto el Activo Fijo en Curso
       -->>
       ldci_pkgActivoEnCurso.insertaregistro(ircldc_activoencurso => vStbrcLdc_ActivoEnCurso);

    END IF;

    --<<
    -- Guardo los cambios
    -->>
    COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
  END proConsuWSActivoFijo;

END LDCI_PKGACTIVOENCURSO;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKGACTIVOENCURSO
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKGACTIVOENCURSO','ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKGACTIVOENCURSO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKGACTIVOENCURSO to INTEGRADESA;
/


