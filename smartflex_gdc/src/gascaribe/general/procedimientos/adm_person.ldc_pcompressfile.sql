CREATE OR REPLACE PROCEDURE adm_person.ldc_pcompressfile (isboriginpath    IN	VARCHAR2, 
                                                          isbfilename      IN    VARCHAR2)
IS
    /*******************************************************************************
    Metodo:       LDC_pCompressFile
    Descripcion:  Comprime un archivo en formato .zip y borra el original
    
    Autor:        Horbath Technologies/Harrinson Henao
    Fecha:        12/01/2022
    Caso:         CA834
    
    Entrada        Descripcion
    isboriginpath   Ruta del archivo en el servidor
    isbfilename     Nombre del archivo
    
    Salida             Descripcion
    
    Historia de Modificaciones
    FECHA          AUTOR       DESCRIPCION
    12-01-2022     hahenao     CA834 Creacion
    26-02-2024     jpinedc     OSF-2375: Se implementan directrices desarrollo
    17/04/2024     PAcosta     OSF-2532: Se crea el objeto en el esquema adm_person 
    08/10/2024     jpinedc     OSF-3162: Se usa pkg_BOUtilidades.prcGeneraArchivoZip
    ********************************************************************************/
    csbmetodo        CONSTANT VARCHAR2(70) := 'LDC_PCOMPRESSFILE';
    csbniveltraza    CONSTANT NUMBER(2)    := pkg_traza.fnuniveltrzdef;    
    nuerror          NUMBER;
    sberror          VARCHAR2(4000);
    
    
BEGIN
    pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbinicio);  
    
    pkg_traza.TRACE('isboriginpath|'|| isboriginpath, csbniveltraza);

    pkg_traza.TRACE('isbfilename|'|| isbfilename, csbniveltraza);
        
    pkg_BOUtilidades.prcGeneraArchivoZip(isboriginpath,isbfilename||'.xls', True);    
        
    pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin);  

    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.geterror(nuerror,sberror);        
            pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin_erc);
            pkg_traza.TRACE('sbError => ' || sberror, csbniveltraza );
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN       
            pkg_error.seterror;
            pkg_error.geterror(nuerror,sberror);
            pkg_traza.TRACE(csbmetodo, csbniveltraza, pkg_traza.csbfin_err);               
            pkg_traza.TRACE('sbError => ' || sberror, csbniveltraza );
            RAISE pkg_error.controlled_error;
END ldc_pcompressfile;
/
PROMPT Otorgando permisos de ejecucion a LDC_PCOMPRESSFILE
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PCOMPRESSFILE','ADM_PERSON');
END;
/
