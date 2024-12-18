create or replace PROCEDURE adm_person.ldc_valida_orasar IS

  /*******************************************************************************
   Historia de Modificaciones
   FECHA            AUTOR       DESCRIPCION 
   24/04/2024       Adrianavg   OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/  
cnuNULL_ATTRIBUTE constant number := 2126;

sbDIRECTORY_ID ge_boInstanceControl.stysbValue;
sbDESCRIPTION ge_boInstanceControl.stysbValue;
sbFILE_NAME ge_boInstanceControl.stysbValue;

BEGIN
    sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');
    sbDESCRIPTION := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DESCRIPTION');
    sbFILE_NAME := ge_boInstanceControl.fsbGetFieldValue ('GE_BATCH_PROCESS', 'FILE_NAME');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbDIRECTORY_ID is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Directorio');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (sbFILE_NAME is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Nombre del Archivo');
        raise ex.CONTROLLED_ERROR;
    end if;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_VALIDA_ORASAR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDC_VALIDA_ORASAR
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDA_ORASAR', 'ADM_PERSON'); 
END;
/