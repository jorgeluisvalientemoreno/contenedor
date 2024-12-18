CREATE OR REPLACE PACKAGE adm_person.ldc_pkuicargaperiodos
AS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    26/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  
    
    PROCEDURE ProcessLDCCPC;

    PROCEDURE ProcessLDCCPF;

    PROCEDURE pobtSearhCargaMasiva(inuCodigo     IN ldc_cargperi.capecodi%TYPE,
                                   isbNombre     IN ldc_cargperi.capename%TYPE,
                                   isbEvento     IN ldc_cargperi.CAPEEVEN%TYPE,
                                   idtFechaIni   IN ldc_cargperi.CAPEDATE%TYPE,
                                   idtFechaFin   IN ldc_cargperi.CAPEDATE%TYPE,
                                   ocuDataCursor  OUT constants.tyRefCursor);

    PROCEDURE pobtGetCargaMasiva(sbCodigo      IN VARCHAR2,
                                 ocuDataCursor  OUT constants.tyRefCursor);

END ldc_pkuicargaperiodos;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkuicargaperiodos
AS

    PROCEDURE ProcessLDCCPC
    IS

    sbCAPENAME ge_boInstanceControl.stysbValue;

    BEGIN
        sbCAPENAME := ge_boInstanceControl.fsbGetFieldValue ('LDC_CARGPERI', 'CAPENAME');

        ldc_pkbocargaperiodos.ProcessLDCCPC(sbCAPENAME);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDCCPC;

    PROCEDURE ProcessLDCCPF
    IS

    sbCAPENAME ge_boInstanceControl.stysbValue;

    BEGIN
        sbCAPENAME := ge_boInstanceControl.fsbGetFieldValue ('LDC_CARGPERI', 'CAPENAME');

        ldc_pkbocargaperiodos.ProcessLDCCPF(sbCAPENAME);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ProcessLDCCPF;
    /**************************************************************************
      Propiedad Intelectual de EFIGAS
      Procedimiento     :  pobtGetCargaMasiva
      Descripcion : Servicio de consulta PI LDCPCF
      Autor       : Luis Lozada
      Fecha       : 10-09-2017

      Par�metros: sbCodigo: variable con los datos de la consulta del PI

      Historia de Modificaciones
        Fecha               Autor                Modificación
      =========           =========          ====================
      10-09-2017         llozada               Creación.
    **************************************************************************/
    PROCEDURE pobtGetCargaMasiva(sbCodigo      IN VARCHAR2,
                                 ocuDataCursor  OUT constants.tyRefCursor) IS
    BEGIN

        ldc_pkbocargaperiodos.pobtGetCargaMasiva(sbCodigo,ocuDataCursor);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END pobtGetCargaMasiva;

    /**************************************************************************
      Propiedad Intelectual de EFIGAS
      Procedimiento     :  pobtGetCargaMasiva
      Descripcion : Servicio de búsqueda PI LDCPCF
      Autor       : Luis Lozada
      Fecha       : 10-09-2017

      Par�metros: sbCodigo: variable con los datos de la consulta del PI

      Historia de Modificaciones
        Fecha               Autor                Modificación
      =========           =========          ====================
      10-09-2017         llozada               Creación.
    **************************************************************************/
    PROCEDURE pobtSearhCargaMasiva(inuCodigo     IN ldc_cargperi.capecodi%TYPE,
                                   isbNombre     IN ldc_cargperi.capename%TYPE,
                                   isbEvento     IN ldc_cargperi.CAPEEVEN%TYPE,
                                   idtFechaIni   IN ldc_cargperi.CAPEDATE%TYPE,
                                   idtFechaFin   IN ldc_cargperi.CAPEDATE%TYPE,
                                   ocuDataCursor  OUT constants.tyRefCursor) IS
        sbSql       VARCHAR2(32767);
        sbAtributos Ge_BoUtilities.styStatement;

        nuCodigo    ldc_cargperi.capecodi%TYPE;
        sbNombre    ldc_cargperi.capename%TYPE;

        sbUserId VARCHAR2(16);
        --======================================================================

    BEGIN

        IF(idtFechaIni IS NOT NULL AND idtFechaFin IS NULL) THEN
            ge_boerrors.seterrorcodeargument(2741, 'La fecha fin no puede ser null.');
        END IF;

        IF( idtFechaFin IS NOT NULL AND idtFechaIni IS NULL) THEN
            ge_boerrors.seterrorcodeargument(2741, 'La fecha inicial no puede ser null.');
        END IF;

        IF(ut_date.fdtDateWithFormat(idtFechaIni) > ut_date.fdtDateWithFormat(idtFechaFin))THEN
            ge_boerrors.seterrorcodeargument(2741, 'La fecha inicial debe ser menor a la fecha final.');
        END IF;

        ldc_pkbocargaperiodos.pobtSearhCargaMasiva(inuCodigo,
                                                   isbNombre,
                                                   isbEvento,
                                                   idtFechaIni,
                                                   idtFechaFin,
                                                   ocuDataCursor);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END pobtSearhCargaMasiva;

END ldc_pkuicargaperiodos;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKUICARGAPERIODOS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKUICARGAPERIODOS', 'ADM_PERSON');
END;
/