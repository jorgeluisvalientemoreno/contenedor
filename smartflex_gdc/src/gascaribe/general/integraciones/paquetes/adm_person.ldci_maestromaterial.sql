CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_MAESTROMATERIAL AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   FUNCION    : LDCI_MAESTROMATERIAL
   AUTOR      : Mauricio Fernando Ortiz
   FECHA      : 11/12/2012
   RICEF      : I003
   DESCRIPCION: Paquete que permite el mantenimiento del maestro de materiales

  Historia de Modificaciones
  Autor     Fecha       Descripcion
  jpinedc   29/04/2024  OSF-2581: proNotificarMaterial: Se reemplaza ldc_sendEmail por 
                        pkg_Correo.prcEnviaCorreo
  fvalencia 02/07/2024  OSF-2793: Se modifica el procedimiento proNotificarMaterial
  jpinedc   21/04/2025  OSF-4264: proNotificarMaterial: Se modifica
*/

Procedure proNotificarMaterial(isbEmpresa     in VARCHAR2,      -- Empresa                          ,
                              Isbcodmaterial  In Varchar2,     -- codMaterial
                              Isbdescmaterial In Varchar2,     -- descMaterial
                              Isbtipomaterial In Varchar2,     -- tipoMaterial
                              Isbgrarticulos  In Varchar2,     -- GRArticulos
                              Isbunmedida     In Varchar2,     -- Unidad de Medida
                              Isbestadomat    In Varchar2,     -- estado
                              Inuporciva      In Number,       -- porcentaje iva
                              isbItemDoVal    in VARCHAR2,     -- doble valoracion
                              isbItemSeri     in varchar2     -- material serializado
                              );    
END LDCI_MAESTROMATERIAL;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_MAESTROMATERIAL
AS
    PROCEDURE proObtenerXmlItem (
        Sbitemcode   IN     Ldci_Itemtmp.Item_Code%TYPE,
        Itemxml         OUT CLOB)
    AS
        /*
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      PROCEDIMIENTO : proObtenerXmlItem
      AUTOR : MAURICIO FERNANDO ORTIZ
      FECHA : 10/12/2012
      RICEF      : I003
      DESCRIPCION : Procedimiento para obtener el xml que va a actualizarce

      Parametros de Entrada
       Sbitemcode  Ldci_Itemtmp.Item_Code%Type

      Parametros de Salida
        Itemxml Out Clob
      Historia de Modificaciones

      Autor        Fecha       Descripcion.
     */
        -- define las variables
        Ctx                       DBMS_XMLGEN.Ctxhandle;

        -- definicion de excepciones
        exceErrXmlGenNewcontext   EXCEPTION;
    BEGIN
        -- crea el contexto xml
        Ctx :=
            DBMS_XMLGEN.NEWCONTEXT (
                   'SELECT * FROM LDCI_ITEMTMP WHERE ITEM_CODE = '''
                || Sbitemcode
                || '''');

        DBMS_XMLGEN.setRowTag (Ctx, '');
        ITEMXML := DBMS_XMLGEN.getXML (CTX);

        IF (DBMS_XMLGEN.Getnumrowsprocessed (Ctx) = 0)
        THEN
            RAISE exceErrXmlGenNewcontext;
        END IF;

        ITEMXML := REPLACE (ITEMXML, '<ROWSET', '<UPDATE_ITEM');
        ITEMXML := REPLACE (ITEMXML, '</ROWSET>', '</UPDATE_ITEM>');
        DBMS_XMLGEN.Closecontext (Ctx);
        pkg_traza.trace('proObtenerXmlItem.[68] <Itemxml>' || CHR (13) || Itemxml, pkg_traza.cnuNivelTrzDef);
    EXCEPTION
        WHEN exceErrXmlGenNewcontext
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proObtenerXmlItem]:'
                || CHR (13)
                || 'El codigo de SAP es requerido.');
        WHEN OTHERS
        THEN
            Raise_Application_Error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proObtenerXmlItem]:'
                || CHR (13)
                || 'Exception obteniendo xml '
                || SQLERRM
                || ' | '
                || DBMS_UTILITY.format_error_backtrace);
    END proObtenerXmlItem;

    Procedure proNotificarMaterial(isbEmpresa      in VARCHAR2,      -- Empresa                          
                              Isbcodmaterial  In Varchar2,     -- codMaterial
                              Isbdescmaterial In Varchar2,     -- descMaterial
                              Isbtipomaterial In Varchar2,     -- tipoMaterial
                              Isbgrarticulos  In Varchar2,     -- GRArticulos
                              Isbunmedida     In Varchar2,     -- Unidad de Medida
                              Isbestadomat    In Varchar2,     -- estado
                              Inuporciva      In Number,       -- porcentaje iva
                              isbItemDoVal    in VARCHAR2,     -- doble valoracion
                              isbItemSeri     in varchar2     -- material serializado
                              )
    AS
        /*
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      PROCEDIMIENTO : proNotificarMaterial
        AUTOR : MAURICIO FERNANDO ORTIZ
        FECHA : 11/12/2012
         RICEF      : I003
      DESCRIPCION : Procedimiento para notificar materiales

      Parametros de Entrada
      sbCodmaterial  In VARCHAR2
      sbDescmaterial In VARCHAR2
      sbTipomaterial In VARCHAR2
      sbGrarticulos  In VARCHAR2
      sbUnmedida     in VARCHAR2
      sbEstadomat    In VARCHAR2
      Nuporciva    In Number
      sbItemDoVal  in VARCHAR2

      Parametros de Salida

      Historia de Modificaciones

      Autor                                        Fecha       Descripcion.
      carlos.virgen<carlos.virgen@olsoftware.com>  21-10-2014  #OYM_CEV_5139_1: NC nc:2674,2675,2676, mejora en el manejo de la clasificaicon de items
       Horbath                                      12/12/2019  CA 226 se valida si el tipo de movimiento esta configurado en el parametro LDC_TIPOMARECU
                                                                en caso afirmativo se inserta en la tabla LDCI_MATERECU
       Mateo Velez/OL                               17/04/2020  CASO 343 Se cambio la logica que asignaba el flag de recuperable mantenimiendo el flag al momento de
                                                                de actualizar y asignando 'N' al crearlo.
     MABG/GDC           02/03/2021  Caso 630: Se modifica el procedimiento para que haga el registro en la forma GEITS del item y tambien
                    para que registre la categoria de acuerdo a la descripcion del item
        felipe.valencia                             02/07/2024  OSF-2793: agrega validación de item obsoleto
        lubin.pineda                                21/04/2025  OSF-4264: Se agrega argumento de entrada isbEmpresa.
                                                                Se inserta o actualiza el registro del material para la
                                                                empresa en multiempresa.materiales         
     */
        -- define variables
        Nuunimed               Ldci_Itemtmp.Measure_Unit%TYPE;
        Sbisrecovery           Ldci_Itemtmp.Is_Recovery%TYPE;
        Sbitemdobleval         Ldci_Itemtmp.Item_Code%TYPE;
        Payloadupdate          CLOB;
        Nuresultado            NUMBER (18) := -1;
        sbMsj                  VARCHAR2 (3000) := '';

        nuRanCodItemDova       GE_ITEMS.ITEMS_ID%TYPE;
        Ionuitemsid            GE_ITEMS.ITEMS_ID%TYPE;
        Inuitemclassif         GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
        Inuitemtipo            GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        Inuconcept             GE_ITEMS.CONCEPT%TYPE;
        Inuconceptdiscount     GE_ITEMS.DISCOUNT_CONCEPT%TYPE;
        Isbprovtype            GE_ITEMS.PROVISIONING_TYPE%TYPE;
        Isbplatform            GE_ITEMS.PLATFORM%TYPE;
        Inuitemsgama           NUMBER (4, 0);
        Inuinitstatus          NUMBER (4, 0);
        Isbshared              GE_ITEMS.SHARED%TYPE;

        -- variables para carga de parametros
        sbTipoHerrSAP          LDCI_CARASEWE.CASEVALO%TYPE;
        sbClaseHerrOSF         LDCI_CARASEWE.CASEVALO%TYPE;
        sbClaseMateOSF         LDCI_CARASEWE.CASEVALO%TYPE;
        sbClaseSeriOSF         LDCI_CARASEWE.CASEVALO%TYPE;
        sbRanCodItemDova       LDCI_CARASEWE.CASEVALO%TYPE;
        sbListTipoMedi         LDCI_CARASEWE.CASEVALO%TYPE;
        sbListTipoRegu         LDCI_CARASEWE.CASEVALO%TYPE;
        sbListTipoSello        LDCI_CARASEWE.CASEVALO%TYPE;  --#OYM_CEV_5139_1
        onuError               NUMBER;
        osbError               VARCHAR2 (4000);

        -- definicion de cursores
        --cursor de homologacion tipos
        CURSOR cuHomologaTipos (sbListTipoEquip   VARCHAR2,
                                sbTipoMatSAP      VARCHAR2)
        IS
            SELECT TIPO_ITEMS_OSF_ID, TIPO_SAP
              FROM (WITH
                        TAB
                        AS
                            (SELECT SUBSTR (sbListTipoEquip,
                                            1,
                                            INSTR (sbListTipoEquip, '|') - 1)
                                        TIPO_ITEMS_OSF_ID,
                                    SUBSTR (sbListTipoEquip,
                                            INSTR (sbListTipoEquip, '|') + 1,
                                            LENGTH (sbListTipoEquip))
                                        STR
                               FROM DUAL)
                        SELECT TIPO_ITEMS_OSF_ID,
                               REGEXP_SUBSTR (STR,
                                              '[^,]+',
                                              1,
                                              LEVEL)    TIPO_SAP
                          FROM TAB
                    CONNECT BY LEVEL <=
                               (SELECT LENGTH (REPLACE (STR, ',', NULL))
                                  FROM TAB))
             WHERE TIPO_SAP = sbTipoMatSAP;

        reHomologaTipo         cuHomologaTipos%ROWTYPE;      --#OYM_CEV_5139_1

        -- deifinicion de variables tipo registro
        reGE_MEASURE_UNIT      pkg_bcunidadesmedida.styUnidadMedida;
        reGE_ITEMS             pkg_bcitems.styItem;

        --INICIO CA 226
        sbTipoMate             VARCHAR2 (4000)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('LDC_TIPOMARECU'); --se almcena tipos de materiales
        nuexisteTiMa           NUMBER; --se almacena si existe tipo de material
        sbdatos                VARCHAR2 (1); --se almacena resultado si existe registro de items recuperado

        --FIN CA 226

        -- excepciones
        exceParametros         EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
        exceOs_Set_Newitem     EXCEPTION; -- manejo de excepciones de la API Os_Set_Newitem
        exceOs_Update_Item     EXCEPTION; -- manejo de excepciones de la API Os_Update_Item
        exce_GE_MEASURE_UNIT   EXCEPTION; -- manejo de excepciones de la API Os_Update_Item
        exce_ITEM_CLASSIF_ID   EXCEPTION; -- manejo de excepciones de la API Os_Update_Item
        exce_TIPO_ITEMS_ID     EXCEPTION; -- #OYM_CEV_5139_1 Excepcion para el manejo de la asignacion del tipo de material

        /*variables y cursores caso 630*/

        swValItem              BOOLEAN := FALSE;

        sbPermValGEITS         VARCHAR2 (2)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('PERMVALGEITS');
        sbPermValCateg         VARCHAR2 (2)
            := pkg_BCLD_Parameter.fsbObtieneValorCadena ('PERMVALCATEGORIA');
        nuCate                 NUMBER := 0;

        nuEstadoInicial       NUMBER;
        sbObsoleto            VARCHAR2 (2);
        sbHabilitado          VARCHAR2(1);  

        CURSOR CuValDescCate (sbDescItem ge_items.description%TYPE)
        IS
            SELECT ROUND (TO_NUMBER (REGEXP_SUBSTR (COLUMN_VALUE,
                                                    '[^,]+',
                                                    1,
                                                    2)))    nuCategoria
              FROM (SELECT *
                      FROM (SELECT *
                              FROM TABLE (
                                       ldc_boutilities.splitstrings (
                                           pkg_BCLD_Parameter.fsbObtieneValorCadena ('CATEITEMS'),
                                           '|'))))
             WHERE INSTR (UPPER (sbDescItem),
                          REGEXP_SUBSTR (COLUMN_VALUE,
                                         '[^,]+',
                                         1,
                                         1),
                          1,
                          1) > 0;

        CURSOR cuTipoMaterias
        IS
        SELECT COUNT (1)
        FROM (    SELECT TRIM (REGEXP_SUBSTR (sbTipomate,
                                            '[^,]+',
                                            1,
                                            LEVEL))    AS TIMA
                    FROM DUAL
            CONNECT BY REGEXP_SUBSTR (sbTipomate,
                                        '[^,]+',
                                        1,
                                        LEVEL)
                            IS NOT NULL)
        WHERE Isbtipomaterial = TIMA;

    /*fin variables y cursores caso 630*/
    
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
    BEGIN
        -- carga los parametos de la interfaz
        -- carga el codigo del tipo herrameinta SAP
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'TIPO_HERR_SAP',
                                            sbTipoHerrSAP,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        -- carga codigo clase mateiral OSF
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'CLASE_MATE_OSF',
                                            sbClaseMateOSF,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;                                       --if(sbMens != '0') then

        -- carga codigo clase herrameinta OSF
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'CLASE_HERR_OSF',
                                            sbClaseHerrOSF,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        -- carga codigo clase item serializado OSF
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'CLASE_SERI_OSF',
                                            sbClaseSeriOSF,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;                                       --if(sbMens != '0') then

        -- carga el rango para crear los items de doble valoraicon
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'RANGO_COD_ITEM_DVAL',
                                            sbRanCodItemDova,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        -- carga homologacion tipo medidor
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'EQUI_TIPO_MEDIDOR',
                                            sbListTipoMedi,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        -- carga homologacion regulador
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'EQUI_TIPO_REGULADOR',
                                            sbListTipoRegu,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        -- #OYM_CEV_5139_1 carga homologacion sello
        LDCI_PKWEBSERVUTILS.proCaraServWeb ('WS_MAESTRO_MATERIAL',
                                            'EQUI_TIPO_SELLO',
                                            sbListTipoSello,
                                            sbMsj);

        IF (sbMsj != '0')
        THEN
            RAISE exceParametros;
        END IF;

        nuRanCodItemDova := TO_NUMBER (sbRanCodItemDova);

        -- abre el cursor del item para validar la clasificacion
        reGE_ITEMS := pkg_bcitems.frcObtieneRegistroItem(isbCODMATERIAL);

        IF  reGE_ITEMS.ITEMS_ID IS NOT NULL OR NVL(reGE_ITEMS.ITEMS_ID,0) <> 0 THEN
            sbIsRecovery := reGE_ITEMS.Recovery;
            pkg_traza.trace('sbIsRecovery: ' || sbIsRecovery, pkg_traza.cnuNivelTrzDef);
        ELSE
            sbIsRecovery := 'N';
        END IF;

        -- determina si es un material serializado
        IF (isbItemSeri IS NULL OR isbItemSeri = '')
        THEN
            -- determina clase de item
            IF (sbTipoHerrSAP = Isbtipomaterial)
            THEN
                Inuitemclassif := TO_NUMBER (sbClaseHerrOSF);
            ELSE
                Inuitemclassif := TO_NUMBER (sbClaseMateOSF);
            END IF;                --if (sbTipoHerrSAP = Isbtipomaterial) then
        ELSE
            -- carga la homologacion de tipos
            Inuitemclassif := TO_NUMBER (sbClaseSeriOSF);

            --#OYM_CEV_5139_1: Se valida la homolograion de tipos SAP; OSF
            --Valida si es medidor
            pkg_traza.trace (
                   '[LDCI_MAESTROMATERIAL 292 ] sbListTipoMedi : '
                || sbListTipoMedi, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace (
                   '[LDCI_MAESTROMATERIAL 292 ] Isbtipomaterial : '
                || Isbtipomaterial, pkg_traza.cnuNivelTrzDef);

            OPEN cuHomologaTipos (sbListTipoMedi, Isbtipomaterial);

            FETCH cuHomologaTipos INTO reHomologaTipo;

            IF cuHomologaTipos%NOTFOUND
            THEN
                CLOSE cuHomologaTipos;

                --Valida si es regulador
                OPEN cuHomologaTipos (sbListTipoRegu, Isbtipomaterial);

                FETCH cuHomologaTipos INTO reHomologaTipo;

                IF cuHomologaTipos%NOTFOUND
                THEN
                    CLOSE cuHomologaTipos;

                    --Valida si es sello
                    OPEN cuHomologaTipos (sbListTipoSello, Isbtipomaterial);

                    FETCH cuHomologaTipos INTO reHomologaTipo;

                    IF cuHomologaTipos%NOTFOUND
                    THEN
                        CLOSE cuHomologaTipos;

                        RAISE exce_TIPO_ITEMS_ID;
                    END IF;                 --if cuHomologaTipos%NOTFOUND then
                END IF;                     --if cuHomologaTipos%NOTFOUND then
            END IF;                         --if cuHomologaTipos%NOTFOUND then

            CLOSE cuHomologaTipos;

            Inuitemtipo := TO_NUMBER (reHomologaTipo.TIPO_ITEMS_OSF_ID);
        END IF;            --if (isbItemSeri is null or isbItemSeri = '') then

        IF (Inuitemclassif <> reGE_ITEMS.ITEM_CLASSIF_ID)
        THEN
            RAISE exce_ITEM_CLASSIF_ID;
        END IF;       --if (Inuitemclassif <> reGE_ITEMS.ITEM_CLASSIF_ID) then

        Inuconcept := NULL;

        Isbprovtype := 'N';                                             --'N';

        -- determina la unidad de medida
        reGE_MEASURE_UNIT := pkg_bcunidadesmedida.frcObtieneRegistro(Isbunmedida);

        nuUnimed := reGE_MEASURE_UNIT.MEASURE_UNIT_ID;

        IF (nuUnimed IS NULL)
        THEN
            RAISE exce_GE_MEASURE_UNIT;
        END IF;                                   

        /* ALMACENAR EN TABLA TEMPORAL CON VALORES A PROCESAR*/
        /* SI HUBO DOBLE VALORACION, SE INSERTARA INFORMACION DEL CODIGO DEL ITEM DE DOBLE VALORACION*/
        pkg_traza.trace('iSbcodmaterial: ' || iSbcodmaterial, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('iSbdescmaterial: ' || iSbdescmaterial, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Nuunimed: ' || Nuunimed, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Sbisrecovery: ' || Sbisrecovery, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Sbitemdobleval: ' || Sbitemdobleval, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Isbestadomat: ' || Isbestadomat, pkg_traza.cnuNivelTrzDef);


        IF (Isbestadomat IS NULL) THEN
            nuEstadoInicial  := 1;
            sbObsoleto            := 'N';
        ELSIF (Isbestadomat = 'X' ) THEN
            nuEstadoInicial       := 15;
            sbObsoleto            := 'S';
        ELSE
            nuEstadoInicial       := 15;
            sbObsoleto            := 'N';
        END IF;

        sbHabilitado := CASE sbObsoleto WHEN 'S' THEN 'N' ELSE  'S' END;

        pkg_traza.trace('sbHabilitado: ' || sbHabilitado, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('nuEstadoInicial: ' || nuEstadoInicial, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('sbObsoleto: ' || sbObsoleto, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Inuitemsgama: ' || Inuitemsgama, pkg_traza.cnuNivelTrzDef);

        pkg_ldci_itemtmp.prInsertaInformacionItemTmp
        (
            iSbcodmaterial,
            iSbdescmaterial,
            Nuunimed,
            Sbisrecovery,
            Sbitemdobleval,
            nuEstadoInicial,
            sbObsoleto,
            Inuitemsgama,
            onuError,
            osbError
        );

        IF (NVL(onuError,0) <> 0) THEN
            pkg_error.setErrorMessage( isbMsgErrr => osbError);
        END IF;

        /* PROCESAR ITEM
            CARGAR XML DE TABLA TEMPORAL PARA ACTUALIZAR
         */
        proObtenerXmlItem (iSbcodmaterial, Payloadupdate);

        /* ACTUALIZAR MATERIAL*/
        API_UPDATE_ITEM(Payloadupdate, Nuresultado, Sbmsj);

        /* SI NO ACTUALIZA */
        IF Nuresultado != 0
        THEN
            /* CREAR MATERIAL MATERIAL*/
            Ionuitemsid := TO_NUMBER (iSbcodmaterial);

            sbIsRecovery := 'N';

            API_SET_NEWITEM (iSbcodmaterial,
                            Ionuitemsid,
                            iSbdescmaterial,
                            Inuitemclassif,
                            Inuitemtipo,
                            Nuunimed,
                            Inuconcept,
                            Inuconceptdiscount,
                            Isbprovtype,
                            Isbplatform,
                            sbIsRecovery,
                            Sbitemdobleval,
                            Inuitemsgama,
                            Inuinitstatus,
                            Isbshared,
                            Nuresultado,
                            Sbmsj);

            IF Nuresultado = 0
            THEN
                
                pkg_Materiales.prcInsRegistro( iSbcodmaterial, isbEmpresa, sbHabilitado );
                /* INSERTO SATISFACTORIAMENTE*/
                COMMIT;
                swValItem := TRUE;                                --- caso 630
            ELSE
                /* NO INSERTO SATISFACTORIAMENTE*/
                RAISE exceOs_Set_Newitem;
            END IF;                                  --If Nuresultado = 0 Then
        ELSE
        
            IF pkg_Materiales.fblExiste( iSbcodmaterial, isbEmpresa ) THEN
                pkg_Materiales.prcActHabilitado( iSbcodmaterial, isbEmpresa, sbHabilitado );        
            ELSE
                pkg_Materiales.prcInsRegistro( iSbcodmaterial, isbEmpresa, sbHabilitado );
            END IF;
            
            /* ACTUALIZO SATISFACTORIAMENTE*/
            COMMIT;

            swValItem := TRUE;                                    --- caso 630
        END IF;                                     --If Nuresultado != 0 Then

        pkg_ldci_itemtmp.prEliminaTemporalItem;

        reGE_ITEMS := pkg_bcitems.frcObtieneRegistroItem(isbCODMATERIAL);

        IF (reGE_ITEMS.ITEMS_ID IS NOT NULL)
        THEN
            -- se valida si el item es de clasificacion 21 y tipo 20
            IF (    reGE_ITEMS.item_classif_id =
                    TO_NUMBER (sbClaseSeriOSF)
                AND reGE_ITEMS.id_items_tipo =
                    TO_NUMBER (
                        SUBSTR (sbListTipoMedi,
                                1,
                                INSTR (sbListTipoMedi, '|') - 1)))
            THEN
                ------------------------ VALIDACION FORMA GEITS ----------------------------

                IF (sbPermValGEITS = 'S')
                THEN
                    -- si la variable no es nula quiere decir que no se presento un error y si igual a 0 quiere decir que no encontro registro
                    IF (pkg_bcmaestromateriales.fblExisteEstructuraMaterial( TO_NUMBER (isbCODMATERIAL)) = FALSE)
                    THEN
                        BEGIN
                            pkg_ldci_contesse.prInsertaControlMaterial(TO_NUMBER(isbCODMATERIAL),onuError, osbError);
                            IF (NVL(onuError,0) <> 0) THEN
                                pkg_error.setErrorMessage( isbMsgErrr => osbError);
                            END IF;
                            COMMIT;
                        EXCEPTION
                            WHEN pkg_Error.CONTROLLED_ERROR
                            THEN
                                ROLLBACK;
                                pkg_error.setErrorMessage( isbMsgErrr => SQLERRM);
                            WHEN OTHERS
                            THEN
                                ROLLBACK;
                                pkg_Error.setError;
                                pkg_error.setErrorMessage( isbMsgErrr => SQLERRM);
                        END;
                    END IF;
                END IF;                    -- fin IF(sbPermValGEITS = 'S')



                -----------------------------   VALIDACION CATEGORIA -----------------------------

                IF (sbPermValCateg = 'S')
                THEN
                    -- si la variable no es nula quiere decir que no se presento un error y si igual a 0 quiere decir que no encontro registro
                    IF (pkg_bcgamaitems.fblTieneGamaItem( reGE_ITEMS.items_id) = FALSE)
                    THEN
                        IF (CuValDescCate%ISOPEN)
                        THEN
                            CLOSE CuValDescCate;
                        END IF;

                        OPEN CuValDescCate (reGE_ITEMS.DESCRIPTION);
                        FETCH CuValDescCate INTO nuCate;
                        CLOSE CuValDescCate;

                        -- si la variable nuCate es mayor a cero quiere decir que encontro el valor de la categoria en el parametro CATEITEMS
                        -- de acuerdo a la descripcion del item
                        IF (nuCate > 0)
                        THEN
                            BEGIN                                                    
                                pkg_ldci_itemtmp.prInsertaInformacionItemTmp
                                (
                                    reGE_ITEMS.items_id,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    NULL,
                                    nuCate,
                                    onuError,
                                    osbError
                                );

                                IF (NVL(onuError,0) <> 0) THEN
                                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                                END IF;


                                proObtenerXmlItem (reGE_ITEMS.items_id, Payloadupdate);

                                /* ACTUALIZAR MATERIAL*/
                                API_UPDATE_ITEM(Payloadupdate, Nuresultado, Sbmsj);

                                pkg_ldci_itemtmp.prEliminaTemporalItem;
                                COMMIT;
                            EXCEPTION
                                WHEN pkg_Error.CONTROLLED_ERROR
                                THEN
                                    ROLLBACK;
                                    pkg_error.setErrorMessage( isbMsgErrr =>  SQLERRM);
                                WHEN OTHERS
                                THEN
                                    ROLLBACK;
                                    pkg_Error.setError;
                                    pkg_error.setErrorMessage( isbMsgErrr => SQLERRM);
                            END;
                        ELSE
                            -- en caso que la variable nuCate no es mayor a cero quiere decir que no encontro en la descripcion del item
                            -- algun termino que este relacionado con el parametro CATEITEMS por lo que se envia el correo

                            DECLARE
                                CURSOR cuEmails IS
                                    SELECT COLUMN_VALUE
                                      FROM TABLE (
                                               ldc_boutilities.splitstrings (
                                                   pkg_BCLD_Parameter.fsbObtieneValorCadena ('NOTIFEMAILS'),
                                                   ','));
                            BEGIN
                                FOR i IN cuEmails
                                LOOP
                                        
                                    pkg_Correo.prcEnviaCorreo
                                    (
                                        isbRemitente        => sbRemitente,
                                        isbDestinatarios    => i.COLUMN_VALUE,
                                        isbAsunto           => 'Creacion de Item Interfaz de Materiales',
                                        isbMensaje          => 'No se pudo determinar la categoria para el Item ['
                                        || TO_CHAR (reGE_ITEMS.items_id)
                                        || ' - '
                                        || TO_CHAR (
                                               reGE_ITEMS.DESCRIPTION)
                                        || '] , favor revisar y gestionar la correccion de la descripcion del item en SAP'
                                    );  
                                                                          
                                END LOOP;
                            EXCEPTION
                                WHEN pkg_Error.CONTROLLED_ERROR
                                THEN
                                    ROLLBACK;
                                    pkg_error.setErrorMessage( isbMsgErrr => SQLERRM);
                                WHEN OTHERS
                                THEN
                                    ROLLBACK;
                                    pkg_Error.setError;
                                    pkg_error.setErrorMessage( isbMsgErrr => SQLERRM);
                            END;
                        END IF;
                    END IF; -- fin IF nuValCate is not null and nuValCate = 0
                END IF;                    -- fin IF(sbPermValCateg = 'S')
            END IF;                            -- IF(sbPermValGEITS = 'S')
        END IF;                                    -- if(cuGE_ITEMS%FOUND)

        --se valida si existe tipo de material en el parametro
        IF (cuTipoMaterias%ISOPEN) THEN
            CLOSE cuTipoMaterias;
        END IF;

        OPEN cuTipoMaterias;
        FETCH cuTipoMaterias INTO  nuexisteTima;
        CLOSE  cuTipoMaterias;

        IF nuexisteTima > 0
        THEN
            IF Ionuitemsid IS NULL
            THEN
                Ionuitemsid := iSbcodmaterial;
            END IF;

            IF (pkg_bcmaestromateriales.fblExisteItemRecuperado(Ionuitemsid) = FALSE) THEN
                --si no existe se inserta
                pkg_ldci_materecu.prInsertaMaterialRecuperado(Ionuitemsid, Isbtipomaterial, SYSDATE,onuError, osbError);
                IF (NVL(onuError,0) <> 0) THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
            ELSE
                --si existe se actualiza
                pkg_ldci_materecu.prActualizaMaterialRecuperado(Ionuitemsid, Isbtipomaterial, SYSDATE,onuError, osbError);
                IF (NVL(onuError,0) <> 0) THEN
                    pkg_error.setErrorMessage( isbMsgErrr => osbError);
                END IF;
            END IF;
        END IF;

        COMMIT;
    EXCEPTION
        WHEN exce_TIPO_ITEMS_ID
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial]:'
                || CHR (13)
                || 'La tipo '
                || Isbtipomaterial
                || ' del ITEM '
                || isbCODMATERIAL
                || '-'
                || isbDESCMATERIAL
                || ' no se encuentra homologado.');
        WHEN exce_ITEM_CLASSIF_ID
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial]:'
                || CHR (13)
                || 'El ITEM '
                || isbCODMATERIAL
                || '-'
                || isbDESCMATERIAL
                || ' de clasificacion '
                || reGE_ITEMS.ITEM_CLASSIF_ID
                || ' no puede cambiar a clasificacion '
                || Inuitemclassif);

            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;
        WHEN exce_GE_MEASURE_UNIT
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial]:'
                || CHR (13)
                || 'La unidad de medida ['
                || Isbunmedida
                || '] no existe o no esta homologada.');
            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;

            COMMIT;
        WHEN exceParametros
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial]:'
                || CHR (13)
                || 'Error cargando parametro del sistema :'
                || sbMsj);
            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;

            COMMIT;
        WHEN exceOs_Set_Newitem
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial.Os_Set_Newitem]:'
                || CHR (13)
                || 'Exception notificando material: '
                || Nuresultado
                || ' | '
                || Sbmsj);
            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;

            COMMIT;
        WHEN exceOs_Update_Item
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial.Os_Update_Item]:'
                || CHR (13)
                || 'Exception notificando material: '
                || Nuresultado
                || ' | '
                || Sbmsj);
            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;

            COMMIT;
        WHEN OTHERS
        THEN
            raise_application_error (
                -20100,
                   '[LDCI_MAESTROMATERIAL.proNotificarMaterial]:'
                || CHR (13)
                || 'Exception notificando material: '
                || SQLERRM
                || ' | '
                || DBMS_UTILITY.format_error_backtrace);
            ROLLBACK;

            pkg_ldci_itemtmp.prEliminaTemporalItem;

            COMMIT;
    END proNotificarMaterial;
END LDCI_MAESTROMATERIAL;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_MAESTROMATERIAL', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_MAESTROMATERIAL to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_MAESTROMATERIAL to INTEGRADESA;
/

