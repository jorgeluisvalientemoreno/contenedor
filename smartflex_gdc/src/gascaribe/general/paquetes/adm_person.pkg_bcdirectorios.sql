create or replace package adm_person.pkg_bcdirectorios is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : adm_person.pkg_bcdirectorios
    Descripcion     : Contiene los métodos para realizar las consultas de directorios
                      en ge_directory
    Autor           : Edilay Peña Osorio - MVM
    Fecha           : 12/10/2023



    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    epenao    12/10/2023       OSF-1702: Creación
***************************************************************************/

--Obtiene la ruta para el id de directorio enviado
 FUNCTION fsbGetRuta 
 (
    inuDirectorio    in    ge_directory.directory_id%type
 )
 RETURN ge_directory.path%type;

end pkg_bcdirectorios;

/
create or replace package body adm_person.pkg_bcdirectorios is
    
    --Constantes para la gestión de traza
    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete    
    
FUNCTION fsbGetRuta 
(
    inuDirectorio    in    ge_directory.directory_id%type
)
RETURN ge_directory.path%type
IS 
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Programa        : fsbGetRuta
    Descripcion     : Obtiene la ruta para el id de directorio enviado
    Autor           : Edilay Peña Osorio - MVM
    Fecha           : 12/10/2023

    Parametros de Entrada

       Nombre                  Tipo                           Descripción
    ===================    =========                         =============================
    inuDirectorio          ge_directory.directory_id%type    Id del directorio a consultar. 
       

    Parametros de Salida     



    Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    epenao    12/10/2023       OSF-1702: Creación
***************************************************************************/
    
   csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbGetRuta';--nombre del método
   nuCodError    ge_error_log.message_id%TYPE;--Código mensaje de error
   sbMenError    ge_error_log.description%TYPE;--Descripción mensaje de error

   osbRuta    ge_directory.path%type;

   cursor cuRuta is 
       SELECT path
         FROM ge_directory
        WHERE directory_id = inuDirectorio;


begin 
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        open cuRuta;
            fetch cuRuta into osbRuta;
        close cuRuta;

    pkg_traza.trace('Id directorio: '||inuDirectorio||
                    ' - Ruta obtenida: '||osbRuta, pkg_traza.cnuNivelTrzDef);

     
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return osbRuta;
 EXCEPTION
      WHEN OTHERS THEN
          pkg_error.SetError;  
          pkg_error.GetError(nuCodError,sbMenError);          
          pkg_traza.trace(csbMetodo, 'Error:'||nuCodError||'-'||sbMenError);
          pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          RETURN osbRuta;
end fsbGetRuta;

end pkg_bcdirectorios;
/

PROMPT Otorgando permisos de ejecución a pkg_bcdirectorios
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCDIRECTORIOS','ADM_PERSON');
END;
/