CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETFNBINFO(inupkgvsi IN mo_packages.package_id%TYPE)
RETURN VARCHAR2 IS
/*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fsbGetFNBInfo
  Descripcion    : Devuelve informacion de una venta a partir de la solicitud de servicio
  Autor          : Adrian Baldovino Barrios
  Fecha          : 03/06/2015

  Parametros                 Descripcion
  ============            ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  03/06/2015      Adrian Baldovino    Creado para ARA 6798
  20/02/2024      Adrianavg           OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                      Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                      Se ajusta el bloque de excepciones según las pautas técnicas
                                      Se reemplaza DAMO_PACKAGES.FSBGETCOMMENT_ por PKG_BCSOLICITUDES.FSBGETCOMENTARIO
                                      Se reemplaza DAAB_ADDRESS.FSBGETADDRESS por PKG_BCDIRECCIONES.FSBGETDIRECCION
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
	--Obtiene codigo de solicitud de la venta
	CURSOR cuGetFNBPkg 
    IS
    SELECT id_pkg_fnb
      FROM ldc_fnb_vsi
     WHERE id_pkg_vsi = InuPkgVSI;

	--Obtiene fecha de entrega
	CURSOR cuDelivDate(inuPackageFNB mo_packages.package_id%TYPE) 
    IS
    SELECT dd.deliver_date
      FROM ldc_fnb_deliver_date dd
     WHERE dd.package_id = inupackagefnb;
     
  --Obtiene informacion del deudor
    CURSOR cuPromissoryInfo(inuPackageFNB mo_packages.package_id%TYPE) 
    IS
    SELECT lp.debtorname, lp.identification, lp.propertyphone_id, lp.address_id
      FROM ld_promissory lp
     WHERE lp.package_id = inuPackageFNB 
       AND lp.promissory_type = 'D';

	--Obtiene la descripcion del barrio
    CURSOR cugetnbhood (inuadressid ld_promissory.address_id%TYPE) 
    IS
    SELECT ge_geogra_location.description
      FROM ab_address, ge_geogra_location
     WHERE ab_address.address_id = inuadressid
       AND ab_address.neighborthood_id = ge_geogra_location.geograp_location_id;
       
	--Obtiene descripcion de la ciudad
    CURSOR cuGetCity(inuAdressId ld_promissory.address_id%TYPE) IS
    SELECT ge_geogra_location.description
      FROM ab_address, ge_geogra_location
     WHERE ab_address.address_id = inuAdressId 
       AND ab_address.geograp_location_id = ge_geogra_location.geograp_location_id;

	sbComment     VARCHAR2(5000);
	nuPackageFNB  mo_packages.package_id%TYPE;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inupkgvsi: ' || inupkgvsi, csbNivelTraza);
  
    sbComment := '';
    
    pkg_traza.trace(csbMetodo ||' FLAG_OBSERVA_NOTI_OT: ' || dald_parameter.fsbgetvalue_chain('FLAG_OBSERVA_NOTI_OT'), csbNivelTraza);
    
    IF dald_parameter.fsbgetvalue_chain('FLAG_OBSERVA_NOTI_OT') = 'S' THEN
    
        --Se obtiene la solicitud de la venta
        FOR rgcuGetFNBPkg IN cuGetFNBPkg LOOP
            nuPackageFNB := rgcuGetFNBPkg.Id_Pkg_Fnb;
        END LOOP;
        pkg_traza.trace(csbMetodo ||' nuPackageFNB: ' || nuPackageFNB, csbNivelTraza);
        
        IF nuPackageFNB IS NOT NULL THEN
            --Se obtiene comentario de la venta
            sbComment  := pkg_bcsolicitudes.fsbgetcomentario(nuPackageFNB);
            pkg_traza.trace(csbMetodo ||' Comentario de la venta: ' || sbComment, csbNivelTraza);
            
            --Se obtiene informacion del deudor
            FOR rgCuPromissoryInfo IN cuPromissoryInfo(nuPackageFNB) LOOP
                sbComment := sbComment || ' - ' || rgCuPromissoryInfo.Debtorname || ' - Identificacion: ' ||
                                                   rgCuPromissoryInfo.Identification || ' - Tel: ' ||
                                                   rgCuPromissoryInfo.Propertyphone_Id || ' - Dir: ' ||
                                                   pkg_bcdirecciones.fsbgetdireccion(rgCuPromissoryInfo.Address_Id);
        
                pkg_traza.trace(csbMetodo ||' sbComment+informacion del deudor: ' || sbComment, csbNivelTraza);
                
                --Obtiene descripcion del barrio
                FOR rgcuGetNbhood IN cuGetNbhood(rgCuPromissoryInfo.Address_Id) LOOP
                    sbComment := sbComment || ' ' || rgcuGetNbhood.Description;
                END LOOP;
                pkg_traza.trace(csbMetodo ||' sbComment+descripcion del barrio: ' || sbComment, csbNivelTraza);
                
                --Obtiene descripcion de la ciudad
                FOR rgcuGetCity IN cuGetCity(rgCuPromissoryInfo.Address_Id) LOOP
                    sbComment := sbComment || ' ' || rgcuGetCity.Description;
                END LOOP;
                pkg_traza.trace(csbMetodo ||' sbComment+descripcion de la ciudad: ' || sbComment, csbNivelTraza);
            END LOOP;
        
            --Obtiene fecha de entrega
            FOR rgcuDelivDate IN cuDelivDate(nuPackageFNB) LOOP
                sbComment := sbComment || ' Fecha entrega: '|| to_char(rgcuDelivDate.Deliver_Date, 'DD-MM-YYYY');
            END LOOP;
                pkg_traza.trace(csbMetodo ||' sbComment+Fecha entrega: ' || sbComment, csbNivelTraza);
        END IF;
    
    END IF;
    
    pkg_traza.trace(csbMetodo ||' Comentario: ' || sbComment, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
	RETURN sbComment;

EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR THEN
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
         RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
END FSBGETFNBINFO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETFNBINFO
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETFNBINFO', 'ADM_PERSON'); 
END;
/
