CREATE OR REPLACE PROCEDURE ADM_PERSON.ldc_prFillOTREVdet(r IN NUMBER, rini IN NUMBER, rfin IN NUMBER) IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    
    Unidad         : prFillOTREVDET
    Descripcion    : Procedimiento para llenar la tabla usada en el reporte prceso OTREV
    Autor          :
    Fecha          : 16/05/2014
    
    Parametros              Descripcion
    ============         ===================
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    23/06/2015       Mmejia              Aranda 7434. Se modifca los filtros del cursor  cuOTREV segun
                                         se especifica en el aranda.
    17/06/2015       Spacheco            aranda 7808 se realiza optimizacion de proceso
    28/07/2014       socoro@horbath.com  Aranda 3554: Se modifica cursor cuOTREV para no considerar los
                                         productos con solicitud 100270 - Certificaci?n de Trabajos en estado 13 - Registrado.
    11/09/2014       Jorge Valiente      RNP2180: 1. Modificacion del cursor cuOTTREV para qur al final filtre solamente los
                                         prodcutos que no este identificados como items especiales
                                         2. Crear un cursor para registrar los items especiales para definido en la
                                         legalizacion de calentadores especiales
    02/09/2105       Jos?? Crist??bal 	 Se crea este procedimiento para sacarlo del procedimiento LDC_BCPERIODICREVIEW,
                     Filigrana Paz       se modificaron los cursores cuOTREV_items_especiales se le quito el HINT + PARALLEL ,
                                         el cursor cuOTREV se le quito el HINT + PARALLEL , ademas se Optimizo las consulta del cursor
    31/10/2016       HORBATH             Se afina cursor cuOTREV acorde a principios de performance de bd 11g
    04/04/2018       HORBATH             Se agregan las nuevas validaciones solicitadas en el caso 200-1871. Se crea cursor para GDC.
    09/12/2020       ljlb                CA 337 se coloca validacion de producto excluido
    26/04/2024       PACOSTA             OSF-2598: Se retita el llamado al esquema OPEN (open.)                                   
                                         Se crea el objeto en el esquema adm_person
    12/06/2024       ADRIANAVG           OSF-2820: Aplicar pautas ténicas de V8 
                                         Se reemplaza DALD_PARAMETER.FNUGETNUMERIC_VALUE por PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO
                                         Se reemplaza DALD_PARAMETER.FSBGETVALUE_CHAIN por PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA
                                         Se reemplaza LDC_BOUTILITIES.SPLITSTRINGS por REGEXP_SUBSTR
                                         Se retira código comentariado
                                         Se retira truncate de la entidad ldc_otrev_items_especiales y el EXECUTE IMMEDIATE sbQuery;
                                         Se declaran variables para el manejo de la traza
                                         Se reemplaza dbms_output.put_line por pkg_traza.trace
                                         Se reemplaza pkErrors.Push por pkg_traza.trace
                                         Se reemplaza pkErrors.Pop por pkg_traza.trace
                                         Se retira el IF-ENDIF del fblAplicaEntrega('OSS_RPS_JGBA_2001871_1') 
                                         Se retira declaración del cursor cuOTREV_items_especiales y cuValOrdRP, la lógica de invocación se encontraba comentariada
                                         Se retira declaración del Tipo de dato tycuOTREV_items_especiales
                                         Se retira declaración de Variable del tipo vtycuOTREV_items_especiales
                                         Se retira variable rccuValOrdRP
                                         Se retira declaración y asignación a la variable sbQuery := 'truncate table ldc_otrev';
                                         Se retira commit que estaba de más
                                         Se retira la variable nuMESESRPITEMESPECIAL, v_id_items_estado_inv_USO, nuitem y nuCant
                                         Se retira el cursor cuOTREV
                                         Se ajusta la declaración del type tycuOTREV que apunte al cursor cuOTREV_GDC
    ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(100)      := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;  
    Onuerrorcode         NUMBER                      := pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);  

    nuTitrVisitaFall          ld_parameter.value_chain%type;
    nuCantVisitaFAll          ld_parameter.numeric_value%type;
    nuDiasUltiVisita          ld_parameter.numeric_value%type;
	SBESTACORT                ld_parameter.value_chain%TYPE     :=PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('ESTADO_CORTE_OTREV');
	SBCATEGORI                ld_parameter.value_chain%TYPE     :=PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('COD_CATEG_VALIDOS_OTREV');
	NUCANMESES                ld_parameter.numeric_value%TYPE   :=PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('VALIDAR_MESES_OTREV');
    ---rnp2180

---josecf: por motivo de pueba se quiete el /*+ PARALLEL */
                               
    CURSOR cuOTREV_GDC IS
	WITH TABLA AS(
     SELECT P.PRODUCT_ID
       FROM PR_PRODUCT P
      WHERE PRODUCT_TYPE_ID=7014
        AND PRODUCT_STATUS_ID=1
        AND PRODUCT_ID BETWEEN RINI AND RFIN
        AND ldc_getEdadRP(P.PRODUCT_ID) > NUCANMESES
        AND INSTR(SBCATEGORI, P.CATEGORY_ID||',')>0
     MINUS
      SELECT ID_PRODUCTO
        FROM LDC_MARCA_PRODUCTO
       WHERE ID_PRODUCTO BETWEEN RINI AND RFIN
     MINUS
      SELECT PRODUCT_ID
        FROM MO_PACKAGES P,
             MO_MOTIVE   M,
             PS_MOTIVE_STATUS S
       WHERE EXISTS (SELECT 'X' FROM (SELECT to_number(regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_TIPO_PAQUETE_OTREV'), '[^,]+', 1, LEVEL)) AS COLUMN_VALUE
                       FROM dual
                    CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('VAL_TIPO_PAQUETE_OTREV'), '[^,]+', 1, LEVEL) IS NOT NULL) 
                      WHERE P.PACKAGE_TYPE_ID = TO_NUMBER(COLUMN_VALUE))
         AND P.MOTIVE_STATUS_ID = S.MOTIVE_STATUS_ID
         AND 2 = S.MOTI_STATUS_TYPE_ID
         AND S.MOTIVE_STATUS_ID not in (14, 32, 51)
         AND P.PACKAGE_ID = M.PACKAGE_ID
         AND PRODUCT_ID BETWEEN RINI AND RFIN
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
         AND PRODUCT_ID BETWEEN RINI AND RFIN
     MINUS
      SELECT PRODUCT_ID
        FROM LDC_CANT_VISITA_FALLIDA N
       WHERE INSTR(nuTitrVisitaFall , TASK_TYPE_ID) > 0
         AND PRODUCT_ID BETWEEN RINI AND RFIN
         AND N.CANTIDAD > nuCantVisitaFAll
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
             DI.NEIGHBORTHOOD_ID "CODIGO_BARRIO",
             NVL((SELECT BA.DESCRIPTION FROM GE_GEOGRA_LOCATION BA WHERE BA.GEOGRAP_LOCATION_ID=DI.NEIGHBORTHOOD_ID),'-') "BARRIO",
             SE.SESUCICL "CICLO",
             PR.CATEGORY_ID "USO",
             PR.SUBCATEGORY_ID "ESTRATO",
             LDC_GETEDADRP(PR.PRODUCT_ID) "MESES"
        FROM TABLA,
             PR_PRODUCT PR,
             SERVSUSC SE,
             SUSCRIPC SU,
             GE_SUBSCRIBER CL,
             AB_ADDRESS DI,
             GE_GEOGRA_LOCATION LO
       WHERE TABLA.PRODUCT_ID = PR.PRODUCT_ID
         AND PR.PRODUCT_ID = SE.SESUNUSE
         AND SE.SESUSUSC = SU.SUSCCODI
         AND SU.SUSCCLIE = CL.SUBSCRIBER_ID
         AND PR.ADDRESS_ID = DI.ADDRESS_ID
         AND DI.GEOGRAP_LOCATION_ID = LO.GEOGRAP_LOCATION_ID
         AND SE.SESUESFN != 'C'
         AND CL.ACTIVE = 'Y'
         AND INSTR(SBESTACORT , SE.SESUESCO||',') > 0
         --inicio ca 337
         and LDC_PKGESTPREXCLURP.FUNVALEXCLURP(pr.PRODUCT_ID) = 0;
         --fin ca 337;
    
    -- Tipo de dato cuOTREV Spacheco ara 7808 optimizacion
    TYPE tycuOTREV IS TABLE OF cuOTREV_GDC%ROWTYPE;
    
    -- Variable del tipo de dato tycuOTREV Spacheco ara 7808 optimizacion
    vtycuOTREV tycuOTREV := tycuOTREV();
 
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio); 
    pkg_traza.trace(csbMetodo ||' r: ' || r, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' rini: ' || rini, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' rfin: ' || rfin, csbNivelTraza);

    pkg_traza.trace(csbMetodo ||' SBESTACORT: ' || SBESTACORT, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' SBCATEGORI: ' || SBCATEGORI, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' NUCANMESES: ' || NUCANMESES, csbNivelTraza);    

    UPDATE ldc_rangogenint SET inicia=sysdate WHERE codrango=r;
    pkg_traza.trace(csbMetodo ||' UPDATE ldc_rangogenint: codrango= '||r , csbNivelTraza);
    COMMIT; 

 -- ESTA INSTRUCCION AHORA SE EJECUTA DESDE EL PROCEDIMIENTO PRINCIPAL 
    pkg_traza.trace(csbMetodo ||' Inicio LDC_BCPeriodicReview.prFillOTREV - ' || sysdate, csbNivelTraza);

       nuTitrVisitaFall          := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA ('TITR_VISITA_FALLIDA_OTREV');
       pkg_traza.trace(csbMetodo ||' nuTitrVisitaFall: ' || nuTitrVisitaFall, csbNivelTraza);
       
       nuCantVisitaFAll          := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('CANT_VISITA_FALLIDA_OTREV');
       pkg_traza.trace(csbMetodo ||' nuCantVisitaFAll: ' || nuCantVisitaFAll, csbNivelTraza);
       
       nuDiasUltiVisita          := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('CANT_DIAS_VISITA_FALLIDA_OTREV');
       pkg_traza.trace(csbMetodo ||' nuDiasUltiVisita: ' || nuDiasUltiVisita, csbNivelTraza);
       
	   SBESTACORT := SBESTACORT||',';
	   SBCATEGORI := SBCATEGORI||',';
       
    -- Apertura CURSOR cuOTREV_GDC
      OPEN cuOTREV_GDC;

        LOOP
        pkg_traza.trace(csbMetodo ||' Inicia LOOP cuOTREV_GDC ', csbNivelTraza);
          --<<Borrar tabla PL vtycuOTREV-->>
          vtycuOTREV.DELETE;

          --<<Carga controlada de registros-->>
          FETCH cuOTREV_GDC BULK COLLECT
            INTO vtycuOTREV LIMIT 1000;
          pkg_traza.trace(csbMetodo ||' vtycuOTREV.COUNT: '||vtycuOTREV.COUNT, csbNivelTraza);
          --<<Recorrido de registros de la tabla pl tbl_datos-->>
          FOR nuindice IN 1 .. vtycuOTREV.COUNT LOOP 
            --Aranda 7434
            --Validar las ordes de RP 
              BEGIN
                --<<-- Inserta registros en la tabla ldc_otrev-->>
                INSERT INTO /*+ append */
                ldc_otrev
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
                  vtycuOTREV(nuindice).MESES);

              EXCEPTION
                WHEN OTHERS THEN
                  NULL;
              END;
             --Validacion de ordenes de RP
            END LOOP;
            pkg_traza.trace(csbMetodo ||' Fin FOR-LOOP vtycuOTREV ', csbNivelTraza);
            COMMIT;--commit cada 1000 regIStros

          EXIT WHEN cuOTREV_GDC%NOTFOUND;

        END LOOP;
        pkg_traza.trace(csbMetodo ||' Fin LOOP cuOTREV_GDC ', csbNivelTraza);
        
        --<<Cierre del cursor cuOTREV.-->>
        IF (cuOTREV_GDC%ISOPEN) THEN

          CLOSE cuOTREV_GDC;

        END IF;

    COMMIT;
    pkg_traza.trace(csbMetodo ||' Fin LDC_BCPeriodicReview.prFillOTREV - ' || sysdate, csbNivelTraza);
    UPDATE ldc_rangogenint SET finaliza=sysdate,ejecutado=0,OBSERVACION='TERMINO' WHERE codrango=r;
    pkg_traza.trace(csbMetodo ||' UPDATE ldc_rangogenint: OBSERVACION=TERMINO en codrango: '||r , csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
  EXCEPTION
    WHEN OTHERS THEN
      UPDATE ldc_rangogenint SET finaliza=sysdate,ejecutado=0,OBSERVACION='CON ERRORES' WHERE codrango=r;
      pkg_traza.trace(csbMetodo ||' UPDATE ldc_rangogenint: OBSERVACION=CON ERRORES en codrango= '||r , csbNivelTraza);
      pkg_traza.trace(csbMetodo ||' Error: ' ||  sqlcode || ' - ' || sqlerrm, csbNivelTraza); 
      pkg_Error.setError;
      pkg_Error.getError(onuerrorcode, osberrormessage);
      pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;  
END ldc_prFillOTREVDET;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRFILLOTREVDET
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRFILLOTREVDET', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_PRFILLOTREVDET para reportes
GRANT EXECUTE ON adm_person.LDC_PRFILLOTREVDET TO rexereportes;
/