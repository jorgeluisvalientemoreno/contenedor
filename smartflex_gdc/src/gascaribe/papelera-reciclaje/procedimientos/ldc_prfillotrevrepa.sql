CREATE OR REPLACE PROCEDURE ldc_prFillOTREVRepa IS
/*****************************************************************
   Propiedad intelectual de HORBATH (c).

   Unidad         : ldc_prFillOTREVRepa
   Descripcion    : Procedimiento para llenar la tabla LDC_OTREV_REPA con marcados 102 O 104
   Autor          :
   Fecha          : 04/04/2018

   Parametros              Descripcion
   ============         ===================

   Fecha             Autor             Modificacion
   =========       =========           ====================
   04/04/2018       jbrito             CASO 200-1871 Creacion
   31/05/2018	    dsaltarin		   Caso 200-1970 Se modifica las marcas 102 y 140 para que se carguen de parametros.
   09/12/2020       ljlb               CA 337 se coloca validacion de producto excluido
   26/06/2024       jpinedc            OSF-2606: * Se usa pkg_Correo
                                       * Ajustes por estándares
   ******************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) :=  'ldc_prFillOTREVRepa';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    
   	SBESTACORT LD_PARAMETER.VALUE_CHAIN%TYPE:=pkg_BCLD_Parameter.fsbObtieneValorCadena('ESTADO_CORTE_OTREV');
	SBCATEGORI LD_PARAMETER.VALUE_CHAIN%TYPE:=pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_CATEG_VALIDOS_OTREV');
	NUCANMESES LD_PARAMETER.NUMERIC_VALUE%TYPE:=pkg_BCLD_Parameter.fnuObtieneValorNumerico('VALIDAR_MESES_OTREV');
	NUMARCA102 LD_PARAMETER.NUMERIC_VALUE%TYPE:=pkg_BCLD_Parameter.fnuObtieneValorNumerico('MARCA_PRODUCTO_102');
	NUMARCA104 LD_PARAMETER.NUMERIC_VALUE%TYPE:=pkg_BCLD_Parameter.fnuObtieneValorNumerico('MARCA_PRODUCTO_104');

    sbVAL_TIPO_PAQUETE_OTREV LD_PARAMETER.VALUE_CHAIN%type := pkg_BCLD_Parameter.fsbObtieneValorCadena('VAL_TIPO_PAQUETE_OTREV');

    cursor cuOTREV is
      WITH TABLA AS(
      (SELECT P.PRODUCT_ID
      FROM PR_PRODUCT P
      WHERE PRODUCT_TYPE_ID=7014
        AND PRODUCT_STATUS_ID=1
        AND ldc_getEdadRP(P.PRODUCT_ID) > NUCANMESES
        AND INSTR(SBCATEGORI, P.CATEGORY_ID||',')>0
	   INTERSECT
	   SELECT ID_PRODUCTO
		 FROM LDC_MARCA_PRODUCTO
		 WHERE SUSPENSION_TYPE_ID IN (NUMARCA102,NUMARCA104) --200-1970
	  )
        MINUS
      SELECT PRODUCT_ID
        FROM MO_PACKAGES P,
             MO_MOTIVE   M,
             PS_MOTIVE_STATUS S
       WHERE EXISTS (
                SELECT to_number(regexp_substr(sbVAL_TIPO_PAQUETE_OTREV,'[^,]+', 1,LEVEL))
                FROM dual
                WHERE to_number(regexp_substr(sbVAL_TIPO_PAQUETE_OTREV,'[^,]+', 1,LEVEL)) = P.PACKAGE_TYPE_ID
                CONNECT BY regexp_substr(sbVAL_TIPO_PAQUETE_OTREV, '[^,]+', 1, LEVEL) IS NOT NULL
                )
         AND P.MOTIVE_STATUS_ID = S.MOTIVE_STATUS_ID
         AND 2 = S.MOTI_STATUS_TYPE_ID
         AND S.MOTIVE_STATUS_ID not in (14, 32, 51)
         AND P.PACKAGE_ID = M.PACKAGE_ID
        MINUS
      SELECT PRODUCT_ID
        FROM LDC_TRAB_CERT C,
             OR_ORDER_ACTIVITY A,
             OR_ORDER O,
             MO_PACKAGES P
       WHERE A.ORDER_ID = O.ORDER_ID
         AND O.ORDER_STATUS_ID IN (0, 5, 7)
         AND O.TASK_TYPE_ID = ID_TRABCERT
         AND A.PACKAGE_ID = P.PACKAGE_ID
         AND P.PACKAGE_TYPE_ID = 100101
      )
      SELECT SESUNUSE "PRODUCT_ID",
             CL.SUBSCRIBER_ID "CLIENTE",
             CL.IDENTIFICATION "IDENTIFICACION",
             NVL(CL.SUBSCRIBER_NAME, '-') "NOMBRE",
             NVL(CL.SUBS_LAST_NAME, '-') "APELLIDO",
             NVL(DI.ADDRESS,'-') "DIRECCION",
             LO.GEO_LOCA_FATHER_ID "CODIGO_DEPARTAMENTO",
             NVL((SELECT DE.DESCRIPTION FROM GE_GEOGRA_LOCATION DE WHERE DE.GEOGRAP_LOCATION_ID=LO.GEO_LOCA_FATHER_ID),'-') "DEPARTAMENTO",
             LO.GEOGRAP_LOCATION_ID "CODIGO_LOCALIDAD",
             NVL(LO.DESCRIPTION,'-') "LOCALIDAD",
             SE.OPERATING_SECTOR_ID "CODIGO_BARRIO",
             NVL((SELECT BA.DESCRIPTION FROM GE_GEOGRA_LOCATION BA WHERE BA.GEOGRAP_LOCATION_ID=SE.OPERATING_SECTOR_ID),'-') "BARRIO",
             SE.SESUCICL "CICLO",
             PR.CATEGORY_ID "USO",
             PR.SUBCATEGORY_ID "ESTRATO",
             LDC_GETEDADRP(PR.PRODUCT_ID) "MESES",
             (SELECT SUSPENSION_TYPE_ID FROM LDC_MARCA_PRODUCTO WHERE PR.PRODUCT_ID = LDC_MARCA_PRODUCTO.ID_PRODUCTO ) "MARCA"
        FROM TABLA,
             PR_PRODUCT PR,
             SERVSUSC SE,
             SUSCRIPC SU,
             GE_SUBSCRIBER CL,
             AB_ADDRESS DI,
             GE_GEOGRA_LOCATION LO,
			 AB_SEGMENTS SE
       WHERE TABLA.PRODUCT_ID = PR.PRODUCT_ID
         AND PR.PRODUCT_ID = SE.SESUNUSE
         AND SE.SESUSUSC = SU.SUSCCODI
         AND SU.SUSCCLIE = CL.SUBSCRIBER_ID
         AND PR.ADDRESS_ID = DI.ADDRESS_ID
         AND DI.GEOGRAP_LOCATION_ID = LO.GEOGRAP_LOCATION_ID
         AND SE.SESUESFN != 'C'
         AND CL.ACTIVE = 'Y'
		     AND DI.SEGMENT_ID = SE.SEGMENTS_ID
         AND INSTR(SBESTACORT, SE.SESUESCO) > 0
		 and LDC_PKGESTPREXCLURP.FUNVALEXCLURP(PR.PRODUCT_ID) = 0;


    sbQuery varchar2(2000);
    -- Tipo de dato cuOTREV Spacheco ara 7808 optimizacion
    TYPE tycuOTREV IS TABLE OF cuOTREV%ROWTYPE;

    -- Variable del tipo de dato tycuOTREV Spacheco ara 7808 optimizacion
    vtycuOTREV tycuOTREV := tycuOTREV();

    sbDestinatarios              VARCHAR2(2000);
    sbAsunto           Varchar2(255) := '';
    
    CURSOR cuCorreo
    IS
    SELECT P.E_MAIL
    FROM ge_person p
    WHERE p.person_id = pkg_BOPersonal.fnuGetPersonaID;    

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    OPEN cuCorreo;
    FETCH cuCorreo INTO sbDestinatarios;
    CLOSE cuCorreo;

    IF sbDestinatarios is not null THEN
    
        sbAsunto := 'Notificacion: Procesos de Revisión Periodica ';
        
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Inicia La ejecucion del Proceso: ldc_prFillOTREVRepa'
        );
        

    END IF;
    
	SBESTACORT := SBESTACORT||',';
	SBCATEGORI := SBCATEGORI||',';


    --/*
    sbQuery := 'truncate table LDC_OTREV_REPA';
    execute immediate sbQuery;

    pkg_Traza.Trace('Inicio LDC_OTREV_REPA - ' ||
                         sysdate);

    OPEN cuOTREV;

    LOOP

      
      -- Borrar tabla PL vtycuOTREV      
      vtycuOTREV.DELETE;

      -- Carga controlada de registros      
      FETCH cuOTREV BULK COLLECT
        INTO vtycuOTREV LIMIT 1000;
      
      -- Recorrido de registros de la tabla pl tbl_datos      
      FOR nuindice IN 1 .. vtycuOTREV.COUNT LOOP
        --Aranda 7434
        --Validar las ordes de RP

          BEGIN

            
            -- Inserta registros en la tabla LDC_OTREV_REPA
            
            INSERT INTO /*+ append */
            LDC_OTREV_REPA
            VALUES
              (vtycuOTREV(nuindice).PRODUCT_ID,
              vtycuOTREV(nuindice).CLIENTE,
              vtycuOTREV(nuindice).IDENTIFICACION,
              vtycuOTREV(nuindice).NOMBRE,
              vtycuOTREV(nuindice).APELLIDO,
              vtycuOTREV(nuindice).DIRECCION,
              vtycuOTREV(nuindice).CODIGO_DEPARTAMENTO,
              vtycuOTREV(nuindice).DEPARTAMENTO,
              vtycuOTREV(nuindice).CODIGO_LOCALIDAD,
              vtycuOTREV(nuindice).LOCALIDAD,
              vtycuOTREV(nuindice).CODIGO_BARRIO,
              vtycuOTREV(nuindice).BARRIO,
              vtycuOTREV(nuindice).CICLO,
              vtycuOTREV(nuindice).USO,
              vtycuOTREV(nuindice).ESTRATO,
              vtycuOTREV(nuindice).MESES,
              vtycuOTREV(nuindice).MARCA);

          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;
        END LOOP;
        COMMIT;--commit cada 1000 registros

      EXIT WHEN cuOTREV%NOTFOUND;

    END LOOP;

    
    -- Cierre del cursor cuOTREV.    
    IF (cuOTREV%ISOPEN) THEN
      CLOSE cuOTREV;
    END IF;
    COMMIT;

    pkg_Traza.Trace('Fin ldc_prFillOTREVRepa - ' ||sysdate);

   IF sbDestinatarios is not null THEN
        sbAsunto := 'Notificacion: Procesos de Revisión Periodica ';
        
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbDestinatarios,
            isbAsunto           => sbAsunto,
            isbMensaje          => 'Termina La ejecucion del Proceso: ldc_prFillOTREVRepa'
        );
        
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      
    
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);        
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_error.Controlled_Error;
END ldc_prFillOTREVRepa;
/

GRANT EXECUTE on LDC_PRFILLOTREVREPA to SYSTEM_OBJ_PRIVS_ROLE;
/

