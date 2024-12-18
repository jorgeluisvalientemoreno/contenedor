CREATE OR REPLACE PROCEDURE  adm_person.ldc_os_insertfileorder(isbfilename       IN cc_file.file_name%TYPE,
                                                               isbobservation    IN cc_file.observation%TYPE,
                                                               inuorderid        IN cc_file.object_id%TYPE,     -- id campo_tabla
                                                               ibbfilesrc        IN cc_file.file_src%TYPE,
                                                               osbfileid         OUT VARCHAR2,
                                                               onuerrorcode      OUT NUMBER,
                                                               osberrormessage   OUT VARCHAR2)
IS
    /**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_INSERTFILEORDER
    
    Descripción     API que permite asociar o adjuntar una archivo a una orden,
                    haciendo uso del servicio de Smartflex CC_BSATTACHFILES.INSERTFILE
                    Retorna el ID del Archivo
    
    Parametros	       Descripcion
    Entrada:
        isbfilename*       Nombre del archivo
        isbobservation    Descripcion u observacion
        inuorderid        id campo_tabla (inuobjectid)
        ibbfilesrc        Archivo fuente (blob)
    Salida:
        osbfileid         Codigo del archivo creado
        onuErrorCode:     Codigo de error.
        osbErrorMessage   Mensaje de error.
    
    Historia de Modificaciones
    Fecha             Autor             Modificación
    ============     ==========      =====================================
    16/04/2024        PAcosta         OSF-2532: Se crea el objeto en el esquema adm_person                                        
    07/09/2014        oparra          TEAM 85. Creación procedure
    ***********************************************************************/  

    sbobjeclevel   cc_file.object_level%TYPE;  -- variable para la tabla
    nufiletypeid   cc_file.file_type_id%TYPE;  -- Tipo de archivo
    nufilesize     cc_file.file_size%TYPE;      -- Tamanño del archivo

BEGIN
    sbobjeclevel    := 'OR_ORDER';
    nufiletypeid    := 1;       -- Tipo de archivo general

    IF isbfilename IS NULL THEN
        onuerrorcode    := -1;
        osberrormessage := 'El nombre del archivo es obligatorio';
        RETURN;
    END IF;

    IF inuorderid IS NULL THEN
        onuerrorcode    := -1;
        osberrormessage := 'No se ingreso el número de la orden';
        RETURN;
    END IF;

    IF ibbfilesrc IS NOT NULL THEN
        nufilesize      :=  dbms_lob.getlength(ibbfilesrc);
    ELSE
        onuerrorcode    := -1;
        osberrormessage := 'No se adjunto ningun archivo';
        RETURN;
    END IF;

    -- Metodo  de Smartflex que crea los archivos
    cc_bsattachfiles.insertfile
    (
        isbfilename,
		nufilesize,
		isbobservation,
		sbobjeclevel,     -- nombre tabla
		inuorderid,       -- inuobjectid
		ibbfilesrc,       -- fuente archivo
		nufiletypeid,
		osbfileid,
		onuerrorcode,
        osberrormessage
    );   
    
EXCEPTION
    WHEN ex.controlled_error THEN
        ERRORS.geterror(onuerrorcode, osberrormessage);
    WHEN OTHERS THEN
        ERRORS.seterror;
        ERRORS.geterror(onuerrorcode, osberrormessage);
END ldc_os_insertfileorder;
/
PROMPT Otorgando permisos de ejecucion a LDC_OS_INSERTFILEORDER
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_OS_INSERTFILEORDER','ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre ldc_os_insertfileorder para reportes
GRANT EXECUTE ON adm_person.ldc_os_insertfileorder TO rexereportes;
/