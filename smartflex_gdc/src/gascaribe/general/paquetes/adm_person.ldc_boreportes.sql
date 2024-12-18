CREATE OR REPLACE PACKAGE adm_person.ldc_boreportes  IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOREPORTES
  Descripcion    : PAQUETE PARA EL MANEJO DE DATOS PARA LOS REPORTES
  Autor          : Jorge Valiente
  Fecha          : 12/08/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/06/2024      Adrianavg           OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ******************************************************************/

  /*VACTOR PARA ALMACENAR LOS DATOS PROVENIENETES LINEA DE ARCHIVO*/
  TYPE TBARRAY IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUCODIGOLOCALIDAD
  Descripcion    : RETORNA EL CODIGO DE LA LOCALIDAD TIPO 3

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUCODIGOLOCALIDAD(INUGEOGRAP_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE)
    RETURN NUMBER;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUDESCRIPCIONOLOCALIDAD
  Descripcion    : RETORNA LA DESCRIPCION DE LA LOCALIDAD TIPO 3

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBDESCRIPCIONOLOCALIDAD(INUGEOGRAP_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE)
    RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUVALIDADATO
  Descripcion    : RETORNA 1 SI EXISTE EL DATO 0 SINO EXISTE

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUVALIDADATONUMERICO(INUDATO NUMBER, SBPARAMETRO VARCHAR2)
    RETURN NUMBER;

  FUNCTION FNUVALIDAPARAMETRONUMERICO(INUDATO NUMBER, SBPARAMETRO VARCHAR2)
    RETURN NUMBER;

END LDC_BOREPORTES;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOREPORTES IS

  /*****************************************************************
  Propiedad intelectual de PETI.
  Unidad         : LDC_BOREPORTES
  Descripcion    : PAQUETE PARA EL MANEJO DE DATOS PARA LOS REPORTES
  Autor          : Jorge Valiente
  Fecha          : 12/08/2014

   Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUSBFUNCTION
  Descripcion    :

  Autor          :
  Fecha          : DD/MM/YYYY

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUSBFUNCTION(ISB VARCHAR2, INU NUMBER) RETURN NUMBER IS

  BEGIN
    UT_TRACE.TRACE('INICIO ', 10);

    UT_TRACE.TRACE('FIN ', 10);

    RETURN(1);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(-1);

  END FNUSBFUNCTION;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : PROCEDIMIENTO
  Descripcion    :

  Autor          :
  Fecha          : DD/MM/YYYY

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  PROCEDURE PROCEDIMIENTO(ISB VARCHAR2, INU NUMBER) IS

  BEGIN

    UT_TRACE.TRACE('INICIO ', 10);

    UT_TRACE.TRACE('FIN ', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;

    when OTHERS then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

  END PROCEDIMIENTO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUCODIGOLOCALIDAD
  Descripcion    : RETORNA EL CODIGO DE LA LOCALIDAD TIPO 3

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUCODIGOLOCALIDAD(INUGEOGRAP_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE)
    RETURN NUMBER IS

    CURSOR CULOCALIDAD IS
      SELECT GE.GEOGRAP_LOCATION_ID
        FROM GE_GEOGRA_LOCATION GE
       WHERE GE.GEOGRAP_LOCATION_ID = INUGEOGRAP_LOCATION_ID
         AND GE.GEOG_LOCA_AREA_TYPE =
             DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_TYPE_LOCATION', NULL);

    NUGEOGRAP_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOREPORTES.FNUCODIGOLOCALIDAD', 10);

    OPEN CULOCALIDAD;
    FETCH CULOCALIDAD
      INTO NUGEOGRAP_LOCATION_ID;
    CLOSE CULOCALIDAD;

    UT_TRACE.TRACE('FIN LDC_BOREPORTES.FNUCODIGOLOCALIDAD', 10);

    RETURN(NUGEOGRAP_LOCATION_ID);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(-1);

  END FNUCODIGOLOCALIDAD;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FSBDESCRIPCIONOLOCALIDAD
  Descripcion    : RETORNA LA DESCRIPCION DE LA LOCALIDAD TIPO 3

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBDESCRIPCIONOLOCALIDAD(INUGEOGRAP_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE)
    RETURN VARCHAR2 IS

    CURSOR CULOCALIDAD IS
      SELECT GE.DESCRIPTION
        FROM GE_GEOGRA_LOCATION GE
       WHERE GE.GEOGRAP_LOCATION_ID = INUGEOGRAP_LOCATION_ID
         AND GE.GEOG_LOCA_AREA_TYPE =
             DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_TYPE_LOCATION', NULL);

    SBDESCRIPTION GE_GEOGRA_LOCATION.DESCRIPTION%TYPE;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOREPORTES.FSBDESCRIPCIONOLOCALIDAD', 10);

    OPEN CULOCALIDAD;
    FETCH CULOCALIDAD
      INTO SBDESCRIPTION;
    CLOSE CULOCALIDAD;

    UT_TRACE.TRACE('FIN LDC_BOREPORTES.FSBDESCRIPCIONOLOCALIDAD', 10);

    RETURN(SBDESCRIPTION);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN('-1');

  END FSBDESCRIPCIONOLOCALIDAD;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUVALIDADATO
  Descripcion    : RETORNA 1 SI EXISTE EL DATO 0 SINO EXISTE

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUVALIDADATONUMERICO(INUDATO NUMBER, SBPARAMETRO VARCHAR2)
    RETURN NUMBER IS

    CURSOR CUEXISTE IS
      SELECT NVL(COUNT(1), 0)
        FROM DUAL
       WHERE INUDATO IN
             (SELECT TO_NUMBER(COLUMN_VALUE)
                FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.FSBGETVALUE_CHAIN(SBPARAMETRO,
                                                                                         NULL),
                                                        ',')));

    NUEXISTE NUMBER;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOREPORTES.FNUVALIDADATONUMERICO', 10);

    OPEN CUEXISTE;
    FETCH CUEXISTE
      INTO NUEXISTE;
    CLOSE CUEXISTE;

    UT_TRACE.TRACE('FIN LDC_BOREPORTES.FNUVALIDADATONUMERICO', 10);

    RETURN(NUEXISTE);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(0);

  END FNUVALIDADATONUMERICO;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : FNUVALIDAPARAMETRONUMERICO
  Descripcion    : RETORNA 1 SI EXISTE 0 SINO EXISTE EL DATO IGUAL AL PARAMETRO NUMERICO

  Autor          : JORGE VALIENTE
  Fecha          : 12/08/2014

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FNUVALIDAPARAMETRONUMERICO(INUDATO NUMBER, SBPARAMETRO VARCHAR2)
    RETURN NUMBER IS

    CURSOR CUEXISTE IS
      SELECT NVL(COUNT(1), 0)
        FROM DUAL
       WHERE INUDATO = DALD_PARAMETER.FSBGETVALUE_CHAIN(SBPARAMETRO,NULL);

    NUEXISTE NUMBER;

  BEGIN

    UT_TRACE.TRACE('INICIO LDC_BOREPORTES.FNUVALIDAPARAMETRONUMERICO', 10);

    OPEN CUEXISTE;
    FETCH CUEXISTE
      INTO NUEXISTE;
    CLOSE CUEXISTE;

    UT_TRACE.TRACE('FIN LDC_BOREPORTES.FNUVALIDAPARAMETRONUMERICO', 10);

    RETURN(NUEXISTE);

  EXCEPTION
    WHEN OTHERS THEN
      RETURN(0);

  END FNUVALIDAPARAMETRONUMERICO;

END LDC_BOREPORTES;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BOREPORTES
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOREPORTES', 'ADM_PERSON'); 
END;
/
