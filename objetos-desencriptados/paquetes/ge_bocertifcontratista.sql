PACKAGE BODY Ge_BoCertifContratista
IS






























































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO425174';

    
    
    
    
    CNUORDENSINVERIF     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE     := 9601;
    
    CNUORDENCONAJUSINVER CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE     := 8363;

    CSBVERIFICAORDEN            CONSTANT VARCHAR2(1) := 'Y'; 

    CNUERR_VERIFICA             CONSTANT NUMBER := 9321; 
    CNUERR_ACTACLOSE            CONSTANT NUMBER := 9341; 
    CNUERR_NOVERIFICAR          CONSTANT NUMBER := 9421; 
    CNUERR_NOEXISACTA           CONSTANT NUMBER := 9641; 

    
    
    

    
    
    

    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

     


















    FUNCTION FSBOBTNOMBREEMPRESA
    (
        INUEMPRESA          IN      GE_CONTRATISTA.ID_EMPRESA%TYPE
    )
    RETURN SISTEMA.SISTEMPR%TYPE
    IS
        SBRESULT            SISTEMA.SISTEMPR%TYPE := NULL;
    BEGIN
        IF PKTBLSISTEMA.FBLEXIST(INUEMPRESA) THEN
            SBRESULT := PKTBLSISTEMA.FSBGETCOMPANYNAME(INUEMPRESA);
        ELSE
            SBRESULT := NULL;
        END IF;
        RETURN SBRESULT;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN  SBRESULT;
    END FSBOBTNOMBREEMPRESA;
    

    




















    PROCEDURE PARTIRACTA
    (
        IRCACTA             IN      DAGE_ACTA.STYGE_ACTA,
        IDTFECHAFIN         IN      GE_ACTA.FECHA_FIN%TYPE
    )
    IS
        RCNUEVAACTA             DAGE_ACTA.STYGE_ACTA;

        






















        PROCEDURE CREARACTA
        IS
        BEGIN

            RCNUEVAACTA.ID_ACTA     := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE
                                       (
                                            'GE_ACTA',
                                            'SEQ_GE_ACTA'
                                        );
            RCNUEVAACTA.ID_PERIODO              := IRCACTA.ID_PERIODO;
            RCNUEVAACTA.NOMBRE                  := IRCACTA.NOMBRE;
            RCNUEVAACTA.ID_TIPO_ACTA            := IRCACTA.ID_TIPO_ACTA;
            RCNUEVAACTA.FECHA_CREACION          := UT_DATE.FDTSYSDATE;
            RCNUEVAACTA.FECHA_INICIO            := IDTFECHAFIN + 1/86400;
            RCNUEVAACTA.FECHA_FIN               := IRCACTA.FECHA_FIN;
            RCNUEVAACTA.ESTADO                  := IRCACTA.ESTADO;
            RCNUEVAACTA.ID_CONTRATO             := IRCACTA.ID_CONTRATO;
            RCNUEVAACTA.ID_BASE_ADMINISTRATIVA  := IRCACTA.ID_BASE_ADMINISTRATIVA;
            RCNUEVAACTA.VALOR_TOTAL             := 0;
            RCNUEVAACTA.PERSON_ID               := IRCACTA.PERSON_ID;

            DAGE_ACTA.INSRECORD(RCNUEVAACTA);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END CREARACTA;

        





















        PROCEDURE REPARTIRORDENES
        IS
        BEGIN

            
            FOR RCORDEN IN GE_BCCERTIFCONTRATISTA.CUORDENESACTA(IRCACTA.ID_ACTA) LOOP
                
                
                IF RCORDEN.EXECUTION_FINAL_DATE > IDTFECHAFIN THEN
                    
                    GE_BCCERTIFCONTRATISTA.MODIFICARDETALLE
                    (
                        IRCACTA.ID_ACTA,
                        RCNUEVAACTA.ID_ACTA,
                        RCORDEN.ORDER_ID
                    );
                END IF;

            END LOOP;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
            END REPARTIRORDENES;
    BEGIN
        CREARACTA;
        REPARTIRORDENES;
        
        
        CT_BCCERTIFICATE.UPDCERTIFICATE(RCNUEVAACTA.ID_ACTA,
                                        CT_BCCERTIFICATE.FNUCALCULATECERTIFTOTALVALUE(RCNUEVAACTA.ID_ACTA),
                                        UT_DATE.FDTSYSDATE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PARTIRACTA;
    
    


























































    PROCEDURE CERRARACTA
    (
        INUACTA             IN      GE_ACTA.ID_ACTA%TYPE,
        IDTFECHAFIN         IN      GE_ACTA.FECHA_FIN%TYPE,
        ISBFLAG             IN      VARCHAR2
    )
    IS
        RCACTA                      DAGE_ACTA.STYGE_ACTA;
        CSBMETODO                   GE_PARAMETER.VALUE%TYPE;
        NUCONTRACT                  GE_CONTRATO.ID_CONTRATO%TYPE;
        NUCONTRATISTA               GE_CONTRATISTA.ID_CONTRATISTA%TYPE;
        NUCOMPANY                   GE_CONTRATISTA.ID_EMPRESA%TYPE;
        
        SBTOKEN                     VARCHAR2(1);
        NUCOMPROBANTE               NUMBER;
        SBTIENEIMPU                 VARCHAR2(2);
        INUTIPODOCU                 GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE;
        
        ONUNUMAUTORIZADO            CONSECUT.CONSNUME%TYPE;
        OSBSERIE                    CONSECUT.CONSSERI%TYPE;
        ONUCONSECUTI                CONSECUT.CONSCODI%TYPE;
        ONUTIPOCOMP                 TIPOCOMP.TICOCODI%TYPE;
        

        NUADJORDERID                OR_ORDER.ORDER_ID%TYPE;
        DTVERIFICATIONDATE          CT_ORDER_CERTIFICA.VERIFICATION_DATE%TYPE;
        
        RCCONTRACT                  DAGE_CONTRATO.STYGE_CONTRATO;
        NUDESCUENTOANTICIPO         GE_CONTRATO.ANTICIPO_AMORTIZADO%TYPE;
        NUVALORANTICIPO             GE_CONTRATO.VALOR_ANTICIPO%TYPE;
        NUANTICIPOADICIONAL         GE_CONTRATO.ANTICIPO_AMORTIZADO%TYPE;
        NUDESCUENTOFONDOGAR         GE_CONTRATO.ACUMUL_FONDO_GARANT%TYPE;
        
        RCDETALLEACTA               DAGE_DETALLE_ACTA.STYGE_DETALLE_ACTA;
        RCITEM                      DAGE_ITEMS.STYGE_ITEMS;
        
        NUDOWNPAYMENTITEM           GE_ITEMS.ITEMS_ID%TYPE;
        
        BLCONTRATOEXCEDIDO          BOOLEAN := FALSE;
        
        CNUERROR_NEG_VAL            CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900223;
        CNUERROR_CONTRACT_EXCEEDED  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3492;
        CNUERROR_NO_DOWN_PAYMENT    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300006;
        CNUERROR_INV_DOWN_PAYMENT   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3560;
        CNUERROR_DOWN_PAYMENT_EXC   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3472;
        CNUERROR_NO_WARR_FUND       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300007;
        CNUERROR_INV_WARR_FUND      CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3574;
        CNUERROR_EXCEEDED_WARR_FUND CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3509;
        CNUERROR_EXC_WARR_FUND_PAY  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300009;
        CNUERROR_CERTIF_IS_PENDING  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900776;
        CNUERROR_CERT_HAS_ASOC_PENDING  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902843;
        CNUGENERIC_MSG                  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901110;
        
        
        CNUCERTBILLS CONSTANT NUMBER := GE_BOCONSTANTS.FNUGETDOCTYPECERTBILLS;
        
        NUPENDASOCCERT              GE_ACTA.ID_ACTA%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO Ge_BoCertifContratista.CerrarActa',12);

        
        IF (DAGE_ACTA.FNUGETIS_PENDING(INUACTA)=CT_BOCONSTANTS.CNUIS_PENDING) THEN
           ERRORS.SETERROR(CNUERROR_CERTIF_IS_PENDING);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        
        NUPENDASOCCERT := CT_BCCERTIFICATE.FNUHASPENDINGASOCCERTS(INUACTA);
        
        IF NUPENDASOCCERT IS NOT NULL THEN
            ERRORS.SETERROR
            (
                CNUERROR_CERT_HAS_ASOC_PENDING,
                INUACTA||'|'||NUPENDASOCCERT
            );
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        
        DAGE_ACTA.GETRECORD(INUACTA, RCACTA);
        
        IF (RCACTA.ID_TIPO_ACTA  = CT_BOCONSTANTS.FNUGETLIQUIDATIONCERTITYPE ) THEN
            
            IF(IDTFECHAFIN < RCACTA.FECHA_FIN) THEN
                UT_TRACE.TRACE('SE DIVIDE EL ACTA EN DOS',12);
                
                GE_BOCERTIFCONTRATISTA.PARTIRACTA
                (
                    RCACTA,
                    IDTFECHAFIN
                );
            END IF;
        END IF;
        
        
        RCACTA.VALOR_TOTAL := NVL(CT_BCCERTIFICATE.FNUCALCULATECERTIFTOTALVALUE(INUACTA),
                                  0);
        
        
        IF ISBFLAG = OR_BOCONSTANTS.CSBSI THEN
            UT_TRACE.TRACE('EL FLAG ESTA PRENDIDO',12);
            
            
            IF (GE_BCCERTIFCONTRATISTA.FBLACTAORDMODNOVER(INUACTA)) THEN
                GE_BOERRORS.SETERRORCODE(CNUORDENCONAJUSINVER);
                RAISE EX.CONTROLLED_ERROR;
                RETURN;
            END IF;
            
            
            FOR RCORDENACTA IN GE_BCCERTIFCONTRATISTA.CUORDENESACTA(INUACTA) LOOP
                UT_TRACE.TRACE('SE VERIFICA LA ORDEN: ' || RCORDENACTA.ORDER_ID,12);
                IF RCORDENACTA.VERIFICATION_DATE IS NULL THEN
                    CT_BOCERTIFICATE.VERIFYORDERBYCERTIFICATE
                    (   RCORDENACTA.ORDER_ID,
                        INUACTA,
                        OR_BOCONSTANTS.CSBSI,
                        NULL,
                        NUADJORDERID,
                        DTVERIFICATIONDATE
                    );
                 END IF;
            END LOOP;
        ELSE
            UT_TRACE.TRACE('EL FLAG ESTA APAGADO',12);
            
            FOR RCORDENACTA IN GE_BCCERTIFCONTRATISTA.CUORDENESACTA(INUACTA) LOOP
                UT_TRACE.TRACE('SE VERIFICA LA ORDEN: ' || RCORDENACTA.ORDER_ID,12);
                IF RCORDENACTA.VERIFICATION_DATE IS NULL THEN
                    GE_BOERRORS.SETERRORCODE(CNUORDENSINVERIF);
                    RAISE EX.CONTROLLED_ERROR;
                    RETURN;
                END IF;
            END LOOP;
        END IF;
        
        
        IF (RCACTA.VALOR_TOTAL < 0) THEN
            GE_BOERRORS.SETERRORCODE(CNUERROR_NEG_VAL);
            RAISE EX.CONTROLLED_ERROR;
            RETURN;
        END IF;
        
        
        IF ( RCACTA.ID_TIPO_ACTA = CT_BOCONSTANTS.FNUGETBILLINGCERTITYPE ) THEN
            NUCONTRACT      := RCACTA.ID_CONTRATO;
            NUCONTRATISTA   := DAGE_CONTRATO.FNUGETID_CONTRATISTA(NUCONTRACT);
            NUCOMPANY       := DAGE_CONTRATISTA.FNUGETID_EMPRESA(NUCONTRATISTA);
            
            SBTOKEN         := '-';
            SBTIENEIMPU     := 'N';
            INUTIPODOCU     := CNUCERTBILLS;

            
            CT_BOCERTIFICATE.GETFISCALNUMBER
            (
                SBTOKEN,
                NUCOMPROBANTE, 
                SBTIENEIMPU,
                INUTIPODOCU,
                NUCONTRATISTA,
                NUCOMPANY,
                ONUNUMAUTORIZADO,
                OSBSERIE,
                ONUCONSECUTI,
                ONUTIPOCOMP
            );
            
            UT_TRACE.TRACE('onuNumAutorizado:'||ONUNUMAUTORIZADO||CHR(10)||
                           'osbSerie:'||OSBSERIE||CHR(10)||
                           'onuConsecuti:'||ONUCONSECUTI||CHR(10)||
                           'onuConsecuti:'||ONUCONSECUTI||CHR(10)||
                           'onuTipoComp:'||ONUTIPOCOMP,14);

            RCACTA.NUMERO_FISCAL    :=   ONUNUMAUTORIZADO;
            RCACTA.ID_CONSECUTIVO   :=   ONUCONSECUTI;

        END IF;

        
        IF ( RCACTA.ID_TIPO_ACTA = CT_BOCONSTANTS.FNUGETLIQUIDATIONCERTITYPE ) THEN
            DAGE_CONTRATO.GETRECORD(RCACTA.ID_CONTRATO,
                                    RCCONTRACT);

            RCCONTRACT.VALOR_TOTAL_PAGADO := NVL(RCCONTRACT.VALOR_TOTAL_PAGADO,
                                                 0) + NVL(RCACTA.VALOR_LIQUIDADO, RCACTA.VALOR_TOTAL);  

            
            IF (    (RCACTA.VALOR_TOTAL > 0)
                AND (RCCONTRACT.VALOR_TOTAL_PAGADO > RCCONTRACT.VALOR_TOTAL_CONTRATO)) THEN
                ERRORS.SETERROR(CNUERROR_CONTRACT_EXCEEDED);
                
                CT_BOPROCESSLOG.REGPROCESSLOGNOCOMMIT(RCACTA.ID_CONTRATO,
                                                      RCACTA.ID_PERIODO,
                                                      IDTFECHAFIN,
                                                      NULL,
                                                      NULL,
                                                      NULL);
                BLCONTRATOEXCEDIDO := TRUE;
            END IF;

            NUDESCUENTOANTICIPO := CT_BCCERTIFICATE.FNUCERTIFTOTALVALUEBYITEM(INUACTA,
                                                                              GE_BOITEMSCONSTANTS.CNUDOWNPAYMENTITEM);

            
            IF (    (RCCONTRACT.VALOR_ANTICIPO IS NULL)
                AND (NUDESCUENTOANTICIPO IS NOT NULL)) THEN
                GE_BOERRORS.SETERRORCODE(CNUERROR_NO_DOWN_PAYMENT);
                RAISE EX.CONTROLLED_ERROR;
                RETURN;
            END IF;
            
            
            IF (RCCONTRACT.VALOR_ANTICIPO IS NOT NULL) THEN
                NUDESCUENTOANTICIPO := NVL(NUDESCUENTOANTICIPO,
                                           0);

                
                IF (NUDESCUENTOANTICIPO > 0) THEN
                    GE_BOERRORS.SETERRORCODE(CNUERROR_INV_DOWN_PAYMENT);
                    RAISE EX.CONTROLLED_ERROR;
                    RETURN;
                END IF;

                NUDESCUENTOANTICIPO := NUDESCUENTOANTICIPO * -1;
                RCCONTRACT.ANTICIPO_AMORTIZADO := NVL(RCCONTRACT.ANTICIPO_AMORTIZADO,
                                                      0) + NUDESCUENTOANTICIPO;

                NUVALORANTICIPO := NVL(RCCONTRACT.VALOR_ANTICIPO,
                                       0);
                
                IF (RCCONTRACT.ANTICIPO_AMORTIZADO > NUVALORANTICIPO) THEN
                    NUANTICIPOADICIONAL := RCCONTRACT.ANTICIPO_AMORTIZADO - NUVALORANTICIPO;

                    ERRORS.SETERROR(CNUERROR_DOWN_PAYMENT_EXC,
                                    INUACTA||'|'||NUDESCUENTOANTICIPO||'|'||(NUDESCUENTOANTICIPO-NUANTICIPOADICIONAL));
                    
                    CT_BOPROCESSLOG.REGPROCESSLOGNOCOMMIT(RCACTA.ID_CONTRATO,
                                                          RCACTA.ID_PERIODO,
                                                          IDTFECHAFIN,
                                                          NULL,
                                                          GE_BOITEMSCONSTANTS.CNUDOWNPAYMENTITEM,
                                                          NULL);

                    
                    RCCONTRACT.ANTICIPO_AMORTIZADO := NUVALORANTICIPO;

                    
                    RCACTA.VALOR_TOTAL := RCACTA.VALOR_TOTAL + NUANTICIPOADICIONAL;

                    
                    DAGE_ITEMS.GETRECORD(GE_BOITEMSCONSTANTS.CNUDOWNPAYMENTITEM,
                                         RCITEM);
                                         
                    
                    NUDOWNPAYMENTITEM := GE_BOITEMSCONSTANTS.CNUDOWNPAYMENTITEM;

                    RCDETALLEACTA.ID_DETALLE_ACTA       := GE_BOSEQUENCE.FNUNEXTGE_DETALLE_ACTA;
                    RCDETALLEACTA.ID_ITEMS              := NUDOWNPAYMENTITEM;
                    RCDETALLEACTA.DESCRIPCION_ITEMS     := NUDOWNPAYMENTITEM||' - '||RCITEM.DESCRIPTION;
                    RCDETALLEACTA.CANTIDAD              := NULL;
                    RCDETALLEACTA.VALOR_UNITARIO        := NULL;
                    RCDETALLEACTA.VALOR_TOTAL           := NUANTICIPOADICIONAL;
                    RCDETALLEACTA.ID_ACTA               := INUACTA;
                    RCDETALLEACTA.ID_LISTA_UNIT_COSTO   := NULL;
                    RCDETALLEACTA.ID_ORDEN              := NULL;
                    RCDETALLEACTA.CONDITION_BY_PLAN_ID  := NULL;
                    RCDETALLEACTA.TIPO_GENERACION       := CT_BOCONSTANTS.FSBGETAUTODETGENTYPE;
                    RCDETALLEACTA.PORCEN_CUMPLIMIENTO   := NULL;
                    RCDETALLEACTA.PORCEN_PONDERADO      := NULL;
                    RCDETALLEACTA.ID_UNIDAD_MEDIDA      := RCITEM.MEASURE_UNIT_ID;
                    RCDETALLEACTA.REFERENCE_ITEM_ID     := NUDOWNPAYMENTITEM;

                    DAGE_DETALLE_ACTA.INSRECORD(RCDETALLEACTA);
                END IF;

            END IF;

            NUDESCUENTOFONDOGAR := CT_BCCERTIFICATE.FNUCERTIFTOTALVALUEBYITEM(INUACTA,
                                                                              GE_BOITEMSCONSTANTS.CNUWARRANTYFUNDITEM);

            
            
            IF (    (RCCONTRACT.PORCEN_FONDO_GARANT IS NULL)
                AND (NUDESCUENTOFONDOGAR IS NOT NULL)) THEN
                GE_BOERRORS.SETERRORCODE(CNUERROR_NO_WARR_FUND);
                RAISE EX.CONTROLLED_ERROR;
                RETURN;
            END IF;

            
            IF (RCCONTRACT.PORCEN_FONDO_GARANT IS NOT NULL) THEN
                NUDESCUENTOFONDOGAR := NVL(NUDESCUENTOFONDOGAR,
                                           0);

                
                IF (NUDESCUENTOFONDOGAR > 0) THEN
                    GE_BOERRORS.SETERRORCODE(CNUERROR_INV_WARR_FUND);
                    RAISE EX.CONTROLLED_ERROR;
                    RETURN;
                END IF;

                NUDESCUENTOFONDOGAR := NUDESCUENTOFONDOGAR * -1;
                RCCONTRACT.ACUMUL_FONDO_GARANT := NVL(RCCONTRACT.ACUMUL_FONDO_GARANT,
                                                      0) + NUDESCUENTOFONDOGAR;

                
                IF (    (NUDESCUENTOFONDOGAR > 0)
                    AND (RCCONTRACT.ACUMUL_FONDO_GARANT > RCCONTRACT.VALOR_TOTAL_CONTRATO)) THEN
                    ERRORS.SETERROR(CNUERROR_EXCEEDED_WARR_FUND);
                    
                    CT_BOPROCESSLOG.REGPROCESSLOGNOCOMMIT(RCACTA.ID_CONTRATO,
                                                          RCACTA.ID_PERIODO,
                                                          IDTFECHAFIN,
                                                          NULL,
                                                          GE_BOITEMSCONSTANTS.CNUWARRANTYFUNDITEM,
                                                          NULL);
                END IF;
            
            END IF;

            IF (NOT(BLCONTRATOEXCEDIDO)) THEN
                
                IF (    (   (RCACTA.VALOR_TOTAL > 0)
                         OR (NUDESCUENTOFONDOGAR > 0)
                        )
                    AND ((RCCONTRACT.VALOR_TOTAL_PAGADO + RCCONTRACT.ACUMUL_FONDO_GARANT) > RCCONTRACT.VALOR_TOTAL_CONTRATO)) THEN
                    ERRORS.SETERROR(CNUERROR_EXC_WARR_FUND_PAY);
                    
                    CT_BOPROCESSLOG.REGPROCESSLOGNOCOMMIT(RCACTA.ID_CONTRATO,
                                                          RCACTA.ID_PERIODO,
                                                          IDTFECHAFIN,
                                                          NULL,
                                                          GE_BOITEMSCONSTANTS.CNUWARRANTYFUNDITEM,
                                                          NULL);
                END IF;
            END IF;

            DAGE_CONTRATO.UPDRECORD(RCCONTRACT);
        END IF;

        UT_TRACE.TRACE('SE MODIFICA EL ACTA: ' ,12);
        RCACTA.FECHA_CIERRE         := UT_DATE.FDTSYSDATE;
        RCACTA.FECHA_FIN            := IDTFECHAFIN;
        RCACTA.ESTADO               := GE_BOCONSTANTS.CSBACTA_CERRADA;
        RCACTA.FECHA_ULT_ACTUALIZAC := UT_DATE.FDTSYSDATE;
        DAGE_ACTA.UPDRECORD(RCACTA);
        
        
        ERRORS.SETERROR
        (
            CNUGENERIC_MSG,
            'El usuario '||DASA_USER.FSBGETMASK(SA_BOUSER.FNUGETUSERID)||' cerr� el acta '||RCACTA.ID_ACTA||', desde '||UT_SESSION.GETTERMINAL||'.'
        );
        
        
        CT_BOPROCESSLOG.REGPROCESSLOGNOCOMMIT
        (
            RCACTA.ID_CONTRATO,
            RCACTA.ID_PERIODO,
            IDTFECHAFIN,
            NULL,
            NULL,
            NULL
        );
        
        UT_TRACE.TRACE('FIN Ge_BoCertifContratista.CerrarActa',12);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CERRARACTA;
    
END GE_BOCERTIFCONTRATISTA;