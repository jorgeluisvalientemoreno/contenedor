CREATE OR REPLACE PACKAGE adm_person.LDC_BOARCHIVO IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOARCHIVO
  Descripcion    : PAQUETE PARA EL MANEJO DE ARCHIVOS
  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  /*VACTOR PARA ALMACENAR LOS DATOS PROVENIENETES LINEA DE ARCHIVO*/
  TYPE TBARRAY IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRVALIDAEXISTENCIAABRIR
  Descripcion    : PROCEDIMIENTO PARA VALIDAR LA EXISTENCIA DEL ARCHIVO A PROCESAR

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRVALIDAEXISTENCIAABRIR(SBRUTA         IN VARCHAR2,
                                    SBARCHIVO      IN VARCHAR2,
                                    NUCODIGOERROOR OUT NUMBER,
                                    SBMENSAJEERROR OUT VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FBLENREXIST
  Descripcion    : FUNCION QUE RETORNA VECTOR CON LOS DATOS DE LA LINEA DEL ARCHIVO

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION FSBARRAYVARCHAR(SBLINE      VARCHAR2,
                           SBCHARACTER VARCHAR2,
                           NUCOUNT     NUMBER) RETURN TBARRAY;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FBLENREXIST
  Descripcion    : FUNCION QUE RETORNA LA CANTIDAD DE VECES QUE EXISTE UN CARACTER EN UNA LINEA DE TEXTO

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION FNUCOUNTCHARACTER(SBLINE VARCHAR2, SBCHARACTER VARCHAR2)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRPROCESACONSTELE
  Descripcion    : PROCEDIMIENTO QUE PROCESA CONSUMO TELEMDIDOS

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRPROCESACONSTELE(SBLINEA         IN VARCHAR2,
                              ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                              OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PROPROCESAARCHIVO
  Descripcion    : PROCEDIMIENTO QUE PERMITE GENERAR ARCHIVO DE ASOBANCARIA2001

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROPROCESAARCHIVO(SBRUTA_ORIGEN      LD_PARAMETER.VALUE_CHAIN%TYPE,
                              SBRUTA_DESTINO     LD_PARAMETER.VALUE_CHAIN%TYPE,
                              SBARCHIVO_PROCESAR VARCHAR2,
                              SBARCHIVO_FINAL    VARCHAR2,
                              SBARCHIVO_LOG      VARCHAR2,
                              SBSERVICIO         VARCHAR2);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PROARCHIVOCONSUMOSTELEMEDIDOS
  Descripcion    : PROCEDIMIENTO QUE PROCESAR ARCHIVO DE CONSUMOS TELEMEDIDOS

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROARCHIVOCONSUMOSTELEMEDIDOS;

END LDC_BOARCHIVO;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOARCHIVO IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOARCHIVO
  Descripcion    : PAQUETE PARA EL MANEJO DE ARCHIVOS
  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRVALIDAEXISTENCIAABRIR
  Descripcion    : PROCEDIMIENTO PARA VALIDAR LA EXISTENCIA DEL ARCHIVO A PROCESAR

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRVALIDAEXISTENCIAABRIR(SBRUTA         IN VARCHAR2,
                                    SBARCHIVO      IN VARCHAR2,
                                    NUCODIGOERROOR OUT NUMBER,
                                    SBMENSAJEERROR OUT VARCHAR2) IS
    V_ARCHIVO UTL_FILE.FILE_TYPE;
  BEGIN

    NUCODIGOERROOR := 0;
    SBMENSAJEERROR := NULL;

    UT_TRACE.TRACE('INICIO LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR', 10);
    V_ARCHIVO := UTL_FILE.FOPEN(SBRUTA, SBARCHIVO, 'R');
    UTL_FILE.FCLOSE(V_ARCHIVO);
    UT_TRACE.TRACE('FIN LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR', 10);

  EXCEPTION
    WHEN UTL_FILE.INVALID_OPERATION THEN
      NUCODIGOERROOR := -1;
      SBMENSAJEERROR := 'EL ARCHIVO NO EXISTE O ESTA SIENDO UTILIZADO POR OTRO PROCESO';
    WHEN UTL_FILE.ACCESS_DENIED THEN
      NUCODIGOERROOR := -1;
      SBMENSAJEERROR := 'EL ARCHIVO NO TIENE PERMISO DE LECTURA';
  END PRVALIDAEXISTENCIAABRIR;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FBLENREXIST
  Descripcion    : FUNCION QUE RETORNA VECTOR CON LOS DATOS DE LA LINEA DEL ARCHIVO

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION FSBARRAYVARCHAR(SBLINE      VARCHAR2,
                           SBCHARACTER VARCHAR2,
                           NUCOUNT     NUMBER) RETURN TBARRAY IS

    SBFINISHLINE   VARCHAR2(4000);
    SBSUBLINE      VARCHAR2(4000);
    SBARRAYVARCHAR TBARRAY;

  BEGIN

    SBFINISHLINE := SBLINE;
    FOR NUPOSITION IN 1 .. NUCOUNT LOOP
      SBSUBLINE := SUBSTR(SBFINISHLINE,
                          1,
                          LENGTH(REGEXP_SUBSTR(SBFINISHLINE,
                                               '.*?\' || SBCHARACTER,
                                               1,
                                               1)) - 1);
      IF SBSUBLINE IS NOT NULL THEN
        SBARRAYVARCHAR(NUPOSITION) := SBSUBLINE;
        SBFINISHLINE := SUBSTR(SBFINISHLINE,
                               LENGTH(REGEXP_SUBSTR(SBFINISHLINE,
                                                    '.*?\' || SBCHARACTER,
                                                    1,
                                                    1)) + 1);
      ELSE
        SBARRAYVARCHAR(NUPOSITION) := SBFINISHLINE;
      END IF;

      UT_TRACE.TRACE('SBSUBLINE [' || SBSUBLINE || ']', 10);
      UT_TRACE.TRACE('SBFINISHLINE [' || SBFINISHLINE || ']', 10);
      UT_TRACE.TRACE('SBARRAYVARCHAR(' || NUPOSITION || ')[' ||
                     SBARRAYVARCHAR(NUPOSITION) || ']',
                     10);
    END LOOP;
    --SBARRAYVARCHAR(NUCOUNT + 1) := SBFINISHLINE;

    /*RETORNA VECTOR CON LOS DATOS DE LA LINEA DEL ARCHIVO*/
    RETURN(SBARRAYVARCHAR);

  EXCEPTION
    /*RETORNA LA LINEA DEL ARCHIVO PLANO CON NULO*/
    WHEN OTHERS THEN
      FOR NUPOSITION IN 1 .. NUCOUNT LOOP
        SBARRAYVARCHAR(NUPOSITION) := NULL;
      END LOOP;
      SBARRAYVARCHAR(NUCOUNT + 1) := NULL;
      RETURN(SBARRAYVARCHAR);

  END FSBARRAYVARCHAR;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FBLENREXIST
  Descripcion    : FUNCION QUE RETORNA LA CANTIDAD DE VECES QUE EXISTE UN CARACTER EN UNA LINEA DE TEXTO

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  FUNCTION FNUCOUNTCHARACTER(SBLINE VARCHAR2, SBCHARACTER VARCHAR2)
    RETURN NUMBER IS

    SBFINISHLINE VARCHAR2(4000);
    NUCOUNT      NUMBER;

  BEGIN

    /*INICIALIZA EN CONTADOR DE CARACTERES*/
    NUCOUNT := 0;

    LOOP
      NUCOUNT      := NUCOUNT + 1;
      SBFINISHLINE := REGEXP_SUBSTR(SBLINE,
                                    '.*?\' || SBCHARACTER,
                                    1,
                                    NUCOUNT);
      EXIT WHEN SBFINISHLINE IS NULL OR LENGTH(SBFINISHLINE) = 0;
    END LOOP;

    /*RETORNA LA CANTIDAD DE CARACTERES*/
    RETURN(NUCOUNT);

  EXCEPTION
    /*RETORNA LA LINEA DEL ARCHIVO PLANO CON NULO*/
    WHEN OTHERS THEN
      NUCOUNT := 0;
      RETURN(NUCOUNT);

  END FNUCOUNTCHARACTER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PRPROCESACONSTELE
  Descripcion    : PROCEDIMIENTO QUE PROCESA CONSUMO TELEMDIDOS

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PRPROCESACONSTELE(SBLINEA         IN VARCHAR2,
                              ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                              OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE) IS

    NUCANTIDAD          NUMBER;
    NUCONTADOR          NUMBER;
    SBARRAYVARCHAR      TBARRAY;
    ISBMEASELEMCODE     VARCHAR2(4000);
    INUCONSUMPTIONTYPE  NUMBER;
    IDTCONSUMPTIONDATE  DATE;
    INUCONSUMPTIONUNITS NUMBER;
    SBCHARACTER         LD_PARAMETER.Value_Chain%TYPE;
  BEGIN

    SBCHARACTER := DALD_PARAMETER.fsbGetValue_Chain('CAR_SEP_ARH_CON_TEL',
                                                    NULL);

    NUCANTIDAD := LDC_BOARCHIVO.FNUCOUNTCHARACTER(SBLINEA, SBCHARACTER);

    SBARRAYVARCHAR := LDC_BOARCHIVO.FSBARRAYVARCHAR(SBLINEA,
                                                    SBCHARACTER,
                                                    NUCANTIDAD);

    FOR NUCONTADOR IN 1 .. NUCANTIDAD LOOP
      IF ISBMEASELEMCODE IS NULL THEN
        ISBMEASELEMCODE := SBARRAYVARCHAR(NUCONTADOR);
      ELSIF INUCONSUMPTIONTYPE IS NULL THEN
        INUCONSUMPTIONTYPE := TO_NUMBER(SBARRAYVARCHAR(NUCONTADOR));
      ELSIF IDTCONSUMPTIONDATE IS NULL THEN
        IDTCONSUMPTIONDATE := TO_DATE(SBARRAYVARCHAR(NUCONTADOR));
      ELSIF INUCONSUMPTIONUNITS IS NULL THEN
        INUCONSUMPTIONUNITS := TO_NUMBER(SBARRAYVARCHAR(NUCONTADOR));
      END IF;
    END LOOP;

    OS_REGTELEMEASCONSUMPTION(ISBMEASELEMCODE,
                              INUCONSUMPTIONTYPE,
                              IDTCONSUMPTIONDATE,
                              INUCONSUMPTIONUNITS,
                              ONUERRORCODE,
                              OSBERRORMESSAGE);

  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'EL AL PROCESAR CONSUMOS TELEMEDIDOS CON EL SERVICIO OS_REGTELEMEASCONSUMPTION';
  END PRPROCESACONSTELE;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PROPROCESAARCHIVO
  Descripcion    : PROCEDIMIENTO QUE PERMITE GENERAR ARCHIVO DE ASOBANCARIA2001

  Autor          : Jorge Valiente
  Fecha          : 16/06/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROPROCESAARCHIVO(SBRUTA_ORIGEN      LD_PARAMETER.VALUE_CHAIN%TYPE,
                              SBRUTA_DESTINO     LD_PARAMETER.VALUE_CHAIN%TYPE,
                              SBARCHIVO_PROCESAR VARCHAR2,
                              SBARCHIVO_FINAL    VARCHAR2,
                              SBARCHIVO_LOG      VARCHAR2,
                              SBSERVICIO         VARCHAR2) IS

    SBLINEA      VARCHAR2(4000) := NULL;
    SBNEWLINEA   VARCHAR2(4000) := NULL;
    SBARCHI      VARCHAR2(4000) := NULL;
    ARCH         UTL_FILE.FILE_TYPE;
    ASBA         UTL_FILE.FILE_TYPE;
    INCO         UTL_FILE.FILE_TYPE;
    NUALERTA     NUMBER;
    SBNOMARCINC  VARCHAR2(4000) := NULL;
    NUCANTREGI   NUMBER;
    NUREGISTRO   NUMBER;
    SBRUTA       VARCHAR2(4000) := NULL;
    SBMESSAGE    VARCHAR2(4000) := NULL;
    NUVALUE      CONCILIA.CONCVATO%TYPE := 0;
    NUTOTALVALUE CONCILIA.CONCVATO%TYPE;
    NUDUMMY      NUMBER;

    ONUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;

    SBEJECUCION VARCHAR2(4000);
  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOARCHIVO.PROPROCESAARCHIVO', 10);

    /* NUMERO DE REGISTROS DEL ARCHIVO */
    NUREGISTRO := 1;
    NUCANTREGI := 1;

    /* NOMBRE DEL ARCHIVO A PROCESAR */
    SBARCHI := SBARCHIVO_PROCESAR;
    UT_TRACE.TRACE('NOMBRE DEL ARCHIVO A PROCESAR --> ' || SBARCHI, 10);

    /* RUTA DONDE SE DEJARA EL ARCHIVO */
    SBRUTA := SBRUTA_DESTINO;
    UT_TRACE.TRACE('RUTA DONDE SE DEJARA EL ARCHIVO --> ' ||
                   SBRUTA_DESTINO,
                   10);

    /* CREA EL ARCHIVO DE INCONSISTENCIAS */
    SBNOMARCINC := SBARCHIVO_LOG || REPLACE(REPLACE(REPLACE(TO_CHAR(SYSDATE,
                                                                    'DD/MM/YYYY HH:MI'),
                                                            '/',
                                                            '_'),
                                                    ':',
                                                    '_'),
                                            ' ',
                                            '_') || '.TXT';
    INCO        := UTL_FILE.FOPEN(SBRUTA_DESTINO, SBNOMARCINC, 'W');
    UTL_FILE.PUT_LINE(INCO, SBARCHI);
    UT_TRACE.TRACE('CREA EL ARCHIVO DE INCONSISTENCIAS --> ' ||
                   SBNOMARCINC,
                   10);

    /* CREAR EL ARCHIVO FINAL */
    SBNOMARCINC := SBARCHIVO_FINAL || REPLACE(REPLACE(REPLACE(TO_CHAR(SYSDATE,
                                                                      'DD/MM/YYYY HH:MI'),
                                                              '/',
                                                              '_'),
                                                      ':',
                                                      '_'),
                                              ' ',
                                              '_') || '.TXT';
    ASBA        := UTL_FILE.FOPEN(SBRUTA_DESTINO, SBNOMARCINC, 'W');
    UT_TRACE.TRACE('CREA EL ARCHIVO FINAL --> ' || SBNOMARCINC, 10);

    /*  ABRE ARCHIVO A PROCESAR  */
    ARCH := UTL_FILE.FOPEN(SBRUTA_ORIGEN, SBARCHI, 'R');
    UT_TRACE.TRACE('ABRE ARCHIVO ORIGINAL --> ' || SBARCHIVO_PROCESAR, 10);

    /*INICIALIZA EL VALOR TOTAL DE LAS CONCILACIONES*/
    NUTOTALVALUE := 0;

    /* RECORRE EL ARCHIVO*/
    LOOP
      BEGIN
        UTL_FILE.get_line(ARCH, SBLINEA);
        UT_TRACE.TRACE('LINEA --> ' || SBLINEA, 10);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
      END;
      SBEJECUCION := 'BEGIN ' || SBSERVICIO || '(''' || SBLINEA ||
                     ''',:ONUERRORCODE,:OSBERRORMESSAGE); END;';

      EXECUTE IMMEDIATE SBEJECUCION
        USING OUT ONUERRORCODE, OUT OSBERRORMESSAGE;
      UT_TRACE.TRACE('SBMESSAGE --> ' || SBMESSAGE, 10);
      IF ONUERRORCODE = 0 THEN
        UTL_FILE.PUT_LINE(ASBA,
                          'LINEA ' || NUREGISTRO || ' PROCESADA CON EXITO');
        NUCANTREGI := NUCANTREGI + 1;
      ELSE
        UTL_FILE.PUT_LINE(INCO,
                          'ERROR EN LA LINEA ' || NUREGISTRO || ' [' ||
                          ONUERRORCODE || ' - ' || OSBERRORMESSAGE || ']');
      END IF;

      NUREGISTRO := NUREGISTRO + 1;

      --NUOK      := FINPREPROCESA(SBLINEANT, NUREGISTRO, INCO);
    END LOOP;

    UTL_FILE.FCLOSE(ARCH);
    UTL_FILE.FCLOSE(INCO);
    UTL_FILE.FCLOSE(ASBA);

    UT_TRACE.TRACE('FIN LDC_BOARCHIVO.PROPROCESAARCHIVO', 10);

  END PROPROCESAARCHIVO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PROARCHIVOCONSUMOSTELEMEDIDOS
  Descripcion    : PROCEDIMIENTO QUE PROCESAR ARCHIVO DE CONSUMOS TELEMEDIDOS

  Autor          : Jorge Valiente
  Fecha          : 02/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROARCHIVOCONSUMOSTELEMEDIDOS IS

    SBLINEA      VARCHAR2(4000) := NULL;
    SBNEWLINEA   VARCHAR2(4000) := NULL;
    SBARCHI      VARCHAR2(4000) := NULL;
    ARCH         UTL_FILE.FILE_TYPE;
    ASBA         UTL_FILE.FILE_TYPE;
    INCO         UTL_FILE.FILE_TYPE;
    NUALERTA     NUMBER;
    SBNOMARCINC  VARCHAR2(4000) := NULL;
    NUCANTREGI   NUMBER;
    NUREGISTRO   NUMBER;
    SBRUTA       VARCHAR2(4000) := NULL;
    SBMESSAGE    VARCHAR2(4000) := NULL;
    NUVALUE      CONCILIA.CONCVATO%TYPE := 0;
    NUTOTALVALUE CONCILIA.CONCVATO%TYPE;
    NUDUMMY      NUMBER;

    sbCOMEDESC                    ge_boInstanceControl.stysbValue;
    RUTA_ORIGEN_ARCHIVO_CONSTELE  LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('RUTA_ORIGEN_ARCHIVO_CONSTELE',
                                                                                                    NULL);
    RUTA_DESTINO_ARCHIVO_CONSTELE LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('RUTA_DESTINO_ARCHIVO_CONSTELE',
                                                                                                    NULL);
    NOMBRE_ARCHIVO_FINAL_CONSTELE LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('NOMBRE_ARCHIVO_FINAL_CONSTELE',
                                                                                                    NULL);
    NOMBRE_ARCHIVO_LOG_CONSTELE   LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('NOMBRE_ARCHIVO_LOG_CONSTELE',
                                                                                                    NULL);
    cnuNULL_ATTRIBUTE constant number := 2126;

    ONUERRORCODE GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOARCHIVO.PROARCHIVOCONSUMOSTELEMEDIDOS',
                   10);

    sbCOMEDESC := ge_boInstanceControl.fsbGetFieldValue('COMENTAR',
                                                        'COMEDESC');

    if (sbCOMEDESC is null) then
      Errors.SetError(cnuNULL_ATTRIBUTE, 'NOMBRE ARCHIVO');
      raise ex.CONTROLLED_ERROR;
    end if;

    IF RUTA_ORIGEN_ARCHIVO_CONSTELE IS NULL THEN
      Errors.SetError(cnuNULL_ATTRIBUTE,
                      'RUTA ORIGEN ARCHIVO CONSUMO TELEMEDIDO');
      raise ex.CONTROLLED_ERROR;
    END IF;

    IF RUTA_DESTINO_ARCHIVO_CONSTELE IS NULL THEN
      Errors.SetError(cnuNULL_ATTRIBUTE,
                      'RUTA DESTINO ARCHIVO CONSUMO TELEMEDIDO');
      raise ex.CONTROLLED_ERROR;
    END IF;

    IF NOMBRE_ARCHIVO_FINAL_CONSTELE IS NULL THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'NOMBRE ARCHIVO FINAL');
      raise ex.CONTROLLED_ERROR;
    END IF;

    IF NOMBRE_ARCHIVO_LOG_CONSTELE IS NULL THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, 'NOMBRE ARCHIVO LOG');
      raise ex.CONTROLLED_ERROR;
    END IF;

    LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR(RUTA_ORIGEN_ARCHIVO_CONSTELE,
                                          sbCOMEDESC,
                                          ONUERRORCODE,
                                          OSBERRORMESSAGE);
    IF ONUERRORCODE = -1 THEN
      Errors.SetError(cnuNULL_ATTRIBUTE, OSBERRORMESSAGE);
      raise ex.CONTROLLED_ERROR;
    END IF;

    LDC_BOARCHIVO.PROPROCESAARCHIVO(RUTA_ORIGEN_ARCHIVO_CONSTELE,
                                    RUTA_DESTINO_ARCHIVO_CONSTELE,
                                    sbCOMEDESC,
                                    NOMBRE_ARCHIVO_FINAL_CONSTELE,
                                    NOMBRE_ARCHIVO_LOG_CONSTELE,
                                    'LDC_BOARCHIVO.PRPROCESACONSTELE');

    UT_TRACE.TRACE('FIN LDC_BOARCHIVO.PROARCHIVOCONSUMOSTELEMEDIDOS', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PROARCHIVOCONSUMOSTELEMEDIDOS;

END LDC_BOARCHIVO;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOARCHIVO
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOARCHIVO', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_BOARCHIVO para reportes
GRANT EXECUTE ON adm_person.LDC_BOARCHIVO TO rexereportes;
/
