create or replace PROCEDURE ADM_PERSON.LDC_PROCINFOESTABBYFILE
IS
    /******************************************************************************************
	Autor: Harrinson Henao Camelo/Horbath
    Nombre Objeto: LDC_PROCINFOESTABBYFILE
    Tipo de objeto: procedimiento
	Fecha: 25-01-2022
	Ticket: CA918
	Descripcion:    Proceso de ejecucion del PB LDPECBF - Procesamiento informacion
                    establecimientos por archivo

	Historia de modificaciones
	Fecha		Autor			    Descripcion
	25-01-2022	hahenao.horbath	    Creacion
    19/03/2023  Adrianavg           OSF-2389: Se aplican pautas técnicas y se reemplazan servicios homólogos
                                    Se declaran variables para la gestión de trazas
                                    Se reemplaza csbSP_NAME por csbMetodo, csbPUSH por csbInicio 
                                    Se retiran las variables csbPOP, csbPOP_ERC, csbPOP_ERR, csbPOP_ERR y sbMethodName
                                    Se reemplaza cnuLEVEL y cnuLEVELPUSHPOP por csbNivelTraza
                                    Se retira la constante cnuGenericError por uso de la variable Onuerrorcode
                                    Se reemplaza utl_file.file_type por pkg_gestionarchivos.styarchivo
                                    Se retira ID-ENDIF del (fblaplicaentregaxcaso('0000918')) se deja la lógica interna por estar activa la entrega en produccion
                                    Se reemplaza errors.seterror por pkg_error.seterror
                                    Se reemplaza SELECT-INTO por cursor cuDirectorio
                                    Se reemplaza pkUtlFileMgr.Fopen por pkg_gestionarchivos.ftabrirarchivo_smf
                                    Se reemplaza pkUtlFileMgr.Put_Line por pkg_gestionarchivos.prcescribirlinea_smf
                                    Se reemplaza pkUtlFileMgr.get_line por pkg_gestionarchivos.fsbobtenerlinea_smf
                                    Se añade BEGIN-END al llamado de pkg_gestionarchivos.fsbobtenerlinea_smf() para manejar
                                    la exception de fin de archivo y asignar valor a nuCodigo
                                    Se reemplaza ut_trace.trace por Pkg_Traza.Trace
                                    Se reemplaza SELECT-INTO por cursor cuDirectorio, cuExistSector
                                    Se reemplaza dapr_product.fblexist por pkg_bcproducto.fsbexisteproducto
                                    Se reemplaza utl_file.fclose por pkg_gestionarchivos.prccerrararchivo_smf
                                    Se reemplaza ut_file.isfileexisting por pkg_gestionarchivos.fblexistearchivo_smf
                                    Se ajusta bloque de excepciones según pautas técnicas
    26/04/2024  Adrianavg           OSF-2389: Se migra del esquema OPEN al esquema ADM_PERSON                                    
    19/06/2024  Adrianavg           OSF-2389: Se ajusta el nombre del llamado de fsbExisteProducto por fblExisteProducto    
	******************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	    CONSTANT VARCHAR2(35) 	    := pkg_traza.csbInicio; 
    Onuerrorcode        NUMBER                      := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage     VARCHAR2(2000);
    -----------------------------
    -- Constantes Privadas
    -----------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbVersion          CONSTANT VARCHAR2(100) := 'OSF-2389';
 
    cnuNULL_ATTRIBUTE   CONSTANT NUMBER := 2126;
    cnuEND_OF_FILE      CONSTANT NUMBER := 1; 
    
    --Variables del proceso
    sbDIRECTORY_ID      ge_boInstanceControl.stysbValue;
    sbPATH              VARCHAR2(250);
    sbFILE_NAME         ge_boInstanceControl.stysbValue;
    rcProdComerSector   daldc_prod_comerc_sector.styLDC_PROD_COMERC_SECTOR;
    sbFileToprocess     pkg_gestionarchivos.styarchivo ;
    sbFileToprocessLog  pkg_gestionarchivos.styarchivo ;
    nuCodigo            NUMBER;
    nuLinea             NUMBER := 0;
    nuCampos            NUMBER := 0;
    sbOnline            VARCHAR2(2000);
    sbOnlineLog         VARCHAR2(500);
    sbTemp              VARCHAR2(2000);
    blContinuar         BOOLEAN;
    nuProductId         ldc_prod_comerc_sector.product_id%TYPE;
    nuIdSector          ldc_prod_comerc_sector.comercial_sector_id%TYPE;
    sbNombEstab         VARCHAR2(500);
    nuExistSector       NUMBER;
    
    CURSOR cuDirectorio (p_sbdirectory_id ge_directory.directory_id%TYPE)
    IS
    SELECT PATH 
      FROM ge_directory
     WHERE directory_id= p_sbdirectory_id;
    
    CURSOR cuExistSector(p_nuIdSector  ldc_sector_comercial.comercial_sector_id%TYPE) 
    IS
    SELECT COUNT(*) 
      FROM ldc_sector_comercial
     WHERE comercial_sector_id = nuIdSector;
     
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, Osberrormessage);     
    
    --Se obtienen los valores de los parametros de la instancia
    sbDIRECTORY_ID := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DIRECTORY_ID');
    sbPATH :='';
    sbFILE_NAME := ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY', 'DESCRIPTION');
    pkg_traza.trace(csbMetodo ||' Nombre de Archivo: '||sbFILE_NAME , sbPATH);
    
    --Validacion de nulidad de atributos del PB
    IF (sbDIRECTORY_ID IS NULL) THEN
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Seleccionar Directorio ' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;         
    END IF;
    
    IF (sbFILE_NAME IS NULL) THEN
        PKG_ERROR.SETERROR;
        pkg_traza.trace(csbMetodo ||' Ingresar el nombre del Archivo ' , csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;  
    ELSE
        IF (sbFILE_NAME NOT LIKE '%.txt') THEN 
            PKG_ERROR.SETERROR;
            pkg_traza.trace(csbMetodo ||' El archivo no tiene la extension .txt' , csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            RAISE PKG_ERROR.controlled_error;
        END IF;
    END IF;
    
    --Con el directorio se encuentra donde esta la ruta
    OPEN cuDirectorio(sbDIRECTORY_ID);
    FETCH cuDirectorio INTO sbPATH;
    CLOSE cuDirectorio;
    pkg_traza.trace(csbMetodo ||' cuDirectorio--> sbPATH: '||sbPATH , csbNivelTraza); 
    
    IF NOT (pkg_gestionarchivos.fblexistearchivo_smf(sbPATH, sbFILE_NAME)) THEN
        --PKG_ERROR.SETERROR; 
        pkg_traza.trace(csbMetodo ||' El archivo ['||sbFILE_NAME||'] no existe en la ruta ['||sbPATH||'].', csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        RAISE PKG_ERROR.controlled_error;
    END IF;
    
    BEGIN
        -- Se crea el archivo de log
        sbFileToprocessLog := pkg_gestionarchivos.ftabrirarchivo_smf(sbPATH,    --Ruta del log
                                                                     'LDPECBF_'||TO_CHAR(SYSDATE, 'DDMMYYYY_HH24MISS')||'.LOG', -- Nombre del log
                                                                      'w' ); -- [Escritura]
    
        --primera linea DEL LOG de errores
        sbOnlineLog := 'INICIO PROCESAMIENTO DE INFORMACION DE ESTABLECIMIENTOS COMERCIALES - INICIO: '||TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');
        pkg_traza.trace(csbMetodo ||' sbOnlineLog: '||sbOnlineLog , csbNivelTraza);
        
        --Se escribe en el archivo del log de errores la linea
        pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
    
        -- la variable sbFileToprocess se carga con la informacion del archivo
        sbFileToprocess :=  pkg_gestionarchivos.ftabrirarchivo_smf(sbPATH,        -- Ruta del Archivo
                                                                    sbFILE_NAME,   -- Nombre del Archivo
                                                                    'r' );         -- [Read]
                            
    EXCEPTION
        WHEN OTHERS THEN
            sbOnlineLog := ('No hay lectura del Archivo - El archivo a procesar no existe en la ruta');
            pkg_traza.trace(csbMetodo ||' No hay lectura del Archivo - El archivo a procesar no existe en la ruta' , csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
            pkg_traza.trace(csbMetodo ||' Se escribe en el archivo del log de errores la linea: ' ||sbOnlineLog, csbNivelTraza); 
            COMMIT;
    END;
    
    LOOP
        --nuCodigo: esta variable es igual a 1 cuando ya no hay registros para procesar 
        BEGIN
          sbOnline:= pkg_gestionarchivos.fsbobtenerlinea_smf(sbFileToprocess);
          pkg_traza.trace(csbMetodo ||' Se obtiene linea: ' || sbOnline, csbNivelTraza);
          nucodigo:=0;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          nucodigo:=1;
        END;   
        pkg_traza.trace(csbMetodo ||' nucodigo: ' ||nucodigo, csbNivelTraza);
        
        nuLinea  := nuLinea + 1;--variable que sigue la cantidad de lineas procesadas
        blContinuar := FALSE;--variable de control de errores
        EXIT WHEN(nuCodigo = cnuend_of_file);
    
        sbTemp := '';
        nuCampos := 0;
        sbNombEstab := null;
        nuProductId := null;
        nuIdSector := null;
        nuExistSector := 0;
    
        --Este ciclo recorre dentro de la linea cada campo
        LOOP
    
            EXIT WHEN(instr(sbOnline, '|', 1, 1) = 0);
            sbTemp := substr(sbOnline,1,instr(sbOnline, '|', 1, 1) - 1);
            pkg_traza.trace(csbMetodo ||' sbTemp: ' ||sbTemp, csbNivelTraza);
            
            sbOnline := substr(sbOnline,instr(sbOnline, '|', 1, 1) + 1);
            pkg_traza.trace(csbMetodo ||' Linea: ' ||sbOnline, csbNivelTraza);
            
            nuCampos := nuCampos+1;
    
            --CAMPOS: NO_PRODUCTO|COD_SECTOR_COMERCIAL|NOMBRE_ESTABLECIMIENTO
    
            --Campo de producto
            IF (nuCampos = 1) THEN
                pkg_traza.trace(csbMetodo ||' Inicia validación producto sea numérico' , csbNivelTraza);
                BEGIN 
                    nuProductId := sbTemp;
                    pkg_traza.trace(csbMetodo ||' 1.ProductId: ' ||nuProductId, csbNivelTraza);
                EXCEPTION
                   WHEN OTHERS THEN
                     sbOnlineLog := ('Error en la linea '||nuLinea||' el numero de producto solo recibe numeros '||sbTemp);
                     pkg_traza.trace(csbMetodo ||' Error en la linea '||nuLinea||' el numero de producto solo recibe numeros '||sbTemp, csbNivelTraza);
                     pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
                     blContinuar := TRUE;
                     EXIT;
                END;
                pkg_traza.trace(csbMetodo ||' Fin validación producto sea numérico' , csbNivelTraza);
            END IF;
    
            --Campo de sector comercial
            IF (nuCampos = 2) THEN
                pkg_traza.trace(csbMetodo ||' Inicia validación sector comercial sea numérico' , csbNivelTraza);
                BEGIN 
                    nuIdSector := sbTemp;
                    pkg_traza.trace(csbMetodo ||' 2.IdSector: ' ||nuIdSector, csbNivelTraza);
                EXCEPTION
                   WHEN OTHERS THEN
                     sbOnlineLog := ('Error en la linea '||nuLinea||' el codigo del sector solo recibe numeros '||sbTemp);
                     pkg_traza.trace(csbMetodo ||' Error en la linea '||nuLinea||' el codigo del sector solo recibe numeros '||sbTemp, csbNivelTraza);
                     pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
                     blContinuar := TRUE;
                     EXIT;
                END;
                pkg_traza.trace(csbMetodo ||' Fin validación sector comercial sea numérico' , csbNivelTraza);
            END IF;
    
            --Campo de nombre de establecimiento
            IF (nuCampos = 3) THEN
                pkg_traza.trace(csbMetodo ||' Inicia validación Nombre establecimiento sea no nulo' , csbNivelTraza);
                sbNombEstab := sbTemp;
                pkg_traza.trace(csbMetodo ||' 3.Nombre establecimiento: ' ||sbNombEstab, csbNivelTraza);
                IF (sbNombEstab IS NULL) THEN
                    sbOnlineLog := ('Error en la linea '||nuLinea||' el nombre del sector esta nulo');
                    pkg_traza.trace(csbMetodo ||' Error en la linea '||nuLinea||' el nombre del sector esta nulo', csbNivelTraza);
                    pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
                    blContinuar := TRUE;
                    EXIT;
                END IF;
                pkg_traza.trace(csbMetodo ||' Fin validación Nombre establecimiento sea no nulo' , csbNivelTraza);
            END IF;
        END LOOP;
    
        IF (blContinuar) THEN
            CONTINUE;
        END IF;
    
        --Se valida que el producto exista
        pkg_traza.trace(csbMetodo ||' Inicia validación existencia del producto ' , csbNivelTraza);
        IF NOT (pkg_bcproducto.fblExisteProducto(nuProductId))  THEN
            
            sbOnlineLog := ('Error en la linea '||nuLinea||' El producto No.'||nuProductId||' no existe');
            pkg_traza.trace(csbMetodo ||' Error en la linea '||nuLinea||' El producto No.'||nuProductId||' no existe', csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);           
            CONTINUE;
            
        END IF;
        pkg_traza.trace(csbMetodo ||' Fin validación existencia del producto ' , csbNivelTraza);
        --
        pkg_traza.trace(csbMetodo ||' Inicia validación existencia del Sector comercial' , csbNivelTraza);
        OPEN cuExistSector(nuIdSector);
        FETCH cuExistSector INTO nuExistSector;
        CLOSE cuExistSector;
        pkg_traza.trace(csbMetodo ||' Existe el Sector(>0): '||nuExistSector, csbNivelTraza);
    
        IF (nuExistSector = 0) THEN
        
            sbOnlineLog := ('Error en la linea '||nuLinea||' El codigo del sector '||nuIdSector||' no existe');
            pkg_traza.trace(csbMetodo ||' Error en la linea '||nuLinea||' El codigo del sector '||nuIdSector||' no existe', csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
            CONTINUE;
            
        END IF;
        pkg_traza.trace(csbMetodo ||' Fin validación existencia del Sector comercial' , csbNivelTraza);        
    
        --Se alimenta el registro de la tabla ldc_prod_comerc_sector
        rcProdComerSector.product_id            := nuProductId;
        rcProdComerSector.comercial_sector_id   := nuIdSector;
        rcProdComerSector.nombre_establec       := sbNombEstab;
        rcProdComerSector.last_update_date      := sysdate;
        rcProdComerSector.last_user_update      := pkgeneralservices.fsbgetusername;
        pkg_traza.trace(csbMetodo ||' Usuario de ultima actualización: '||pkgeneralservices.fsbgetusername, csbNivelTraza);
        pkg_traza.trace(csbMetodo ||' Fecha de ultima actualización: '||sysdate, csbNivelTraza);
    
        IF (daldc_prod_comerc_sector.fblexist(nuProductId)) THEN
            --Se actualiza el registro
            pkg_traza.trace(csbMetodo ||' Inicia llamada a actualizar registro en LDC_PROD_COMERC_SECTOR ' , csbNivelTraza);
            daldc_prod_comerc_sector.updrecord(rcProdComerSector);
            pkg_traza.trace(csbMetodo ||' Fin llamada a actualizar registro en LDC_PROD_COMERC_SECTOR ' , csbNivelTraza);
            COMMIT;
            sbOnlineLog := ('Resultado: 0, Producto: '||nuProductId||', No. Linea: '||nuLinea||', Comentario: Actualizacion Exitosa');
            pkg_traza.trace(csbMetodo ||' Resultado: 0, Producto: '||nuProductId||', No. Linea: '||nuLinea||', Comentario: Actualizacion Exitosa', csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
        ELSE
            --Se inserta el registro
            pkg_traza.trace(csbMetodo ||' Inicia llamada a insertar registro en LDC_PROD_COMERC_SECTOR ' , csbNivelTraza);
            daldc_prod_comerc_sector.insrecord(rcProdComerSector);
            pkg_traza.trace(csbMetodo ||' Fin llamada a insertar registro en LDC_PROD_COMERC_SECTOR ' , csbNivelTraza);
            COMMIT;
            sbOnlineLog := ('Resultado: 0, Producto: '||nuProductId||', No. Linea: '||nuLinea||', Comentario: Insercion Exitosa');
            pkg_traza.trace(csbMetodo ||' Resultado: 0, Producto: '||nuProductId||', No. Linea: '||nuLinea||', Comentario: Insercion Exitosa', csbNivelTraza);
            pkg_gestionarchivos.prcescribirlinea_smf(sbFileToprocessLog, sbOnlineLog);
        END IF;
    END LOOP;
    
    pkg_gestionarchivos.prccerrararchivo_smf(sbFileToprocess);
    pkg_gestionarchivos.prccerrararchivo_smf(sbFileToprocessLog);
    COMMIT;
     
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN 
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error; 
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuerrorcode, osberrormessage);
        pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;
END LDC_PROCINFOESTABBYFILE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROCINFOESTABBYFILE', 'ADM_PERSON');
END;
/