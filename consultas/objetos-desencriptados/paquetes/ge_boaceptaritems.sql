PACKAGE BODY GE_BOAceptarItems
IS










































	
    
    
    
    
    CSBVERSION          CONSTANT VARCHAR2(20)   := 'SAO305183';

    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
    
    
    
















	PROCEDURE ACEPTARTODO
    (
        INUOPERATINGUNIT    IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUDOCUMENTO        IN  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE,
        ISBDOCUMENTORECEP   IN  GE_ITEMS_DOCUMENTO.DOCUMENTO_EXTERNO%TYPE
    )
    IS
        RFITEMSTRANSUO  CONSTANTS.TYREFCURSOR;
        NUITEMBALAMOVID OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;
        NUAMOUNT        OR_UNI_ITEM_BALA_MOV.AMOUNT%TYPE;
        NUDOCUMENT      OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO%TYPE;
        NUTARGETUNIT    OR_UNI_ITEM_BALA_MOV.TARGET_OPER_UNIT_ID%TYPE;
        NUDOCRECEPCION  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE;
        NUINDEX         NUMBER;
        
        TBITEMSDOCUMENTO DAGE_ITEMS_DOCUMENTO.TYTBID_ITEMS_DOCUMENTO;
        
        NUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        SBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;
    BEGIN
    
     OR_BCITEMSMOVE.GETTRANSITBYUNITDOC(INUOPERATINGUNIT,INUDOCUMENTO, RFITEMSTRANSUO);
     
     FETCH RFITEMSTRANSUO INTO NUITEMBALAMOVID, NUAMOUNT, NUDOCUMENT, NUTARGETUNIT;

     
     WHILE RFITEMSTRANSUO%FOUND LOOP

        
        IF NUDOCRECEPCION IS NULL THEN
            GE_BOITEMSDOCUMENTO.CREATEDOCRECEPCION
            (
                INUOPERATINGUNIT,
                ISBDOCUMENTORECEP,
                'Generado por aceptaci?n',
                NUDOCRECEPCION
            );
        END IF;
        
        
        OR_BOFWITEMSMOVE.TOACEPTARTRANSITO
        (
            NUITEMBALAMOVID,
            NUDOCRECEPCION ,
            0 ,
            NUAMOUNT,
            0,
            NUERRORCODE,
            SBERRORMESSAGE
        );

        
        

        TBITEMSDOCUMENTO(NUDOCUMENT) := NUDOCUMENT;
        FETCH RFITEMSTRANSUO INTO NUITEMBALAMOVID, NUAMOUNT, NUDOCUMENT, NUTARGETUNIT;
     END LOOP;

     
     NUINDEX := TBITEMSDOCUMENTO.FIRST;
     WHILE NUINDEX IS NOT NULL LOOP
        OR_BOFWITEMSMOVE.CERRARDOCUMENTO(TBITEMSDOCUMENTO(NUINDEX), INUOPERATINGUNIT);
        NUINDEX := TBITEMSDOCUMENTO.NEXT(NUINDEX);
     END LOOP;

    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACEPTARTODO;
    
    
    
    
















    PROCEDURE ACEPTACIONAUTOMCARGA
    (
        ISBOPERATINGUNITS   IN  VARCHAR2,
        ISBDOCUMENTORECEP   IN  GE_ITEMS_DOCUMENTO.DOCUMENTO_EXTERNO%TYPE
    )
    IS
        TBDOCUMENTS         GE_BOITEMSCARGUE.TYTBDOCUMENTS;
        NUDOCSINDEX         VARCHAR2(20);
        SBOPERATINGUNITS    VARCHAR2(2000);
        SBDOCUMENTORECEP    GE_ITEMS_DOCUMENTO.DOCUMENTO_EXTERNO%TYPE;
        NUSECUENCE          NUMBER := 1;
    BEGIN
    
        SBOPERATINGUNITS := '|'||ISBOPERATINGUNITS||'|';
        GE_BOITEMSCARGUE.OBTENERDOCSCARGA(TBDOCUMENTS);
        
        NUDOCSINDEX := TBDOCUMENTS.FIRST;
        WHILE NUDOCSINDEX IS NOT NULL LOOP

            
            IF  SBOPERATINGUNITS  LIKE '%|'||TBDOCUMENTS(NUDOCSINDEX).NUIDUNIDAD||'|%' THEN


                IF ISBDOCUMENTORECEP IS NULL THEN
                    SBDOCUMENTORECEP :='AUTO_'||TBDOCUMENTS(NUDOCSINDEX).NUIDDOCUMENTO||'_'||SUBSTR(TO_CHAR(SYSDATE),12,8);
                ELSE
                    SBDOCUMENTORECEP :=  SUBSTR(ISBDOCUMENTORECEP,0,20)||'_'||SUBSTR(TO_CHAR(SYSDATE),12,8)||'_'||NUSECUENCE;
                END IF;

                ACEPTARTODO
                (
                    TBDOCUMENTS(NUDOCSINDEX).NUIDUNIDAD,
                    TBDOCUMENTS(NUDOCSINDEX).NUIDDOCUMENTO,
                    SBDOCUMENTORECEP
                );
                NUSECUENCE := NUSECUENCE +1;
            END IF;
            
            NUDOCSINDEX := TBDOCUMENTS.NEXT(NUDOCSINDEX);
        END LOOP;
    
    
        GE_BOITEMSCARGUE.LIMPIARDOCSCARGA;
    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACEPTACIONAUTOMCARGA;
    
    

























    PROCEDURE VALACCEPTREJECTDATA
    (
        INUOPERUNITID  IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        INUITEMID      IN  GE_ITEMS.ITEMS_ID%TYPE,
        ISBITEMCODE    IN  GE_ITEMS.CODE%TYPE,
        ISBITEMSERIE   IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        INUQUANTITY    IN  NUMBER,
        INUIDITEMDOC   IN  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO%TYPE,
        ONUTRANSITID   OUT OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE
    )
    IS
        NUITEMID       GE_ITEMS.ITEMS_ID%TYPE;
        RCITEMSER      DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
        NUITEMSERIID   GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
        
        NUAMOUNT       OR_UNI_ITEM_BALA_MOV.AMOUNT%TYPE;
        
        SBWHERE         VARCHAR2(2000);
        RFQUERY         SYS_REFCURSOR;
    BEGIN

        UT_TRACE.TRACE('Inicio - GE_BOAceptarItems.valAcceptRejectData',5);

        
        DAOR_OPERATING_UNIT.ACCKEY(INUOPERUNITID);

        
        IF ( INUITEMID IS NULL) THEN

            
            NUITEMID := GE_BOITEMS.FNUGETITEMSID(ISBITEMCODE);

        ELSE

            NUITEMID := INUITEMID;

        END IF;

        
        
        DAGE_ITEMS.ACCKEY(NUITEMID);

        
        IF ( ISBITEMSERIE IS NOT NULL) THEN
        
            
            GE_BCITEMSSERIADO.GETIDBYSERIE( ISBITEMSERIE, NUITEMSERIID );
            
            UT_TRACE.TRACE('nuItemSeriId = '||NUITEMSERIID,10);
            
            DAGE_ITEMS_SERIADO.GETRECORD(NUITEMSERIID, RCITEMSER);
            
            IF (RCITEMSER.ITEMS_ID <> NUITEMID) THEN
            
                GE_BOERRORS.SETERRORCODE(6384);
                
            END IF;
            
            SBWHERE := SBWHERE || 'AND  or_uni_item_bala_mov.id_items_seriado = :nuItemSeriId'||CHR(10);

        ELSE
            
            NUITEMSERIID  := CC_BOCONSTANTS.CNUAPPLICATIONNULL;
            UT_TRACE.TRACE('nuItemSeriId: '||NUITEMSERIID, 15);
            
            SBWHERE := CHR(10) || 'AND     :nuItemSeriId = '||  NUITEMSERIID ||CHR(10);

        END IF;

        
        IF (INUQUANTITY < 1) THEN

            GE_BOERRORS.SETERRORCODEARGUMENT( 110523, 'Cantidad|'||INUQUANTITY );
            
        END IF;
        
        IF (INUIDITEMDOC IS NOT NULL) THEN

            UT_TRACE.TRACE('inuIdItemDoc: '||INUIDITEMDOC, 15);

            SBWHERE := SBWHERE || 'AND  or_uni_item_bala_mov.id_items_documento = '|| INUIDITEMDOC ||CHR(10);

        END IF;

        RFQUERY := GE_BCITEMSREQUEST.FRFGETTRANSITEMBYITEM(INUOPERUNITID,
                                NUITEMID,
                                NUITEMSERIID,
                                SBWHERE);
                                
        FETCH RFQUERY INTO ONUTRANSITID, NUAMOUNT;
        UT_TRACE.TRACE('nuAmount = '||NUAMOUNT,10);
        UT_TRACE.TRACE('onuTransitId = '||ONUTRANSITID,10);
                                
        IF RFQUERY%ISOPEN THEN
            CLOSE RFQUERY;
        END IF;

        
        
        NUAMOUNT := NVL(NUAMOUNT, 0);
        IF ( ABS(INUQUANTITY) > NUAMOUNT ) THEN

            GE_BOERRORS.SETERRORCODEARGUMENT( 110524, 'Cantidad|'||NUAMOUNT );

        END IF;
        
        UT_TRACE.TRACE('Fin - GE_BOAceptarItems.valAcceptRejectData',5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF RFQUERY%ISOPEN THEN
                CLOSE RFQUERY;
            END IF;

            RAISE;
        WHEN OTHERS THEN
            IF RFQUERY%ISOPEN THEN
                CLOSE RFQUERY;
            END IF;

            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END VALACCEPTREJECTDATA;
    
    



























    PROCEDURE ACCEPTITEM
    (
        ICLXMLACCEPTITEMS   IN          CLOB
    )
    IS
        
        CLXMLACCEPTITEMS    CLOB;
        DMDOCUMENT          XMLDOM.DOMDOCUMENT;
        NDNODE              XMLDOM.DOMNODE;
        SBNODENAME          VARCHAR2(100);
        SBNODEVALUE         VARCHAR2(100);

        
        NUOPERUNITID        OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        SBITEMCODE          GE_ITEMS.CODE%TYPE;
        SBITEMSERIE         GE_ITEMS_SERIADO.SERIE%TYPE;
        NUQUANTITY          NUMBER(10,4);
        SBSUPPODOCU         VARCHAR2(30);
        NUIDITEMDOC         OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO%TYPE;
        
        NUITEMSDOCUMENT     GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE;

        NUITEMID            GE_ITEMS.ITEMS_ID%TYPE;
        NUTRANSITID         OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;

        NUERRORCODE         GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      GE_MESSAGE.DESCRIPTION%TYPE;

        PROCEDURE CLEANMEMORY
        IS
        BEGIN
            UT_TRACE.TRACE('Inicio - GE_BOAceptarItems.GetTransitItems.CleanMemory',10);

            NUOPERUNITID := NULL;
            SBITEMCODE   := NULL;
            SBITEMSERIE  := NULL;
            NUQUANTITY   := NULL;
            SBSUPPODOCU  := NULL;
            NUIDITEMDOC  := NULL;

            UT_TRACE.TRACE('FIN - GE_BOAceptarItems.GetTransitItems.CleanMemory',10);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END CLEANMEMORY;

    BEGIN
        UT_TRACE.TRACE('Inicio - GE_BOAceptarItems.AcceptItem',5);

        CLEANMEMORY();

        
        CLXMLACCEPTITEMS := ICLXMLACCEPTITEMS;
        GE_BOITEMSCARGUE.DECUPXML(CLXMLACCEPTITEMS);

        
        DMDOCUMENT := UT_XMLPARSE.PARSE(CLXMLACCEPTITEMS);
        UT_TRACE.TRACE('dmDocument.id = '||DMDOCUMENT.ID,10);

        
        NDNODE.ID := DMDOCUMENT.ID;

        
        IF (NDNODE.ID = -1) THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;

        











        
        NDNODE := XMLDOM.GETFIRSTCHILD(NDNODE);

        
        SBNODENAME := XMLDOM.GETNODENAME(NDNODE);
        UT_TRACE.TRACE('sbNodeName = '||SBNODENAME,10);

        
        IF(UPPER(SBNODENAME) <> 'ACEPT_ITEM') THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;

        
        NDNODE := XMLDOM.GETFIRSTCHILD(NDNODE);

        
        SBNODENAME := XMLDOM.GETNODENAME(NDNODE);
        UT_TRACE.TRACE('sbNodeName = '||SBNODENAME,10);

        
        IF(UPPER(SBNODENAME) <> 'ITEM') THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;


        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'OPERATING_UNIT');
        NUOPERUNITID := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('OPERATING_UNIT = ' || NUOPERUNITID, 10);

        
        SBITEMCODE := MO_BODOM.FSBGETVALTAG(NDNODE, 'ITEM_CODE');
        UT_TRACE.TRACE('ITEM_CODE = ' || SBITEMCODE, 10);

        
        SBITEMSERIE := MO_BODOM.FSBGETVALTAG(NDNODE, 'SERIE');
        UT_TRACE.TRACE('SERIE = ' || SBITEMSERIE, 10);

        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'QUANTITY');
        NUQUANTITY := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('QUANTITY = ' || NUQUANTITY, 10);

        
        SBSUPPODOCU := MO_BODOM.FSBGETVALTAG(NDNODE, 'SUPPORT_DOCUMENT');
        UT_TRACE.TRACE('SUPPORT_DOCUMENT = ' || SBSUPPODOCU, 10);
        
        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'ID_ITEM_DOCUMENTO');
        NUIDITEMDOC := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('ID_ITEM_DOCUMENTO = ' || NUIDITEMDOC, 10);

        
        NUITEMID := GE_BOITEMS.FNUGETITEMSID(SBITEMCODE);

        
        VALACCEPTREJECTDATA(NUOPERUNITID, NUITEMID, SBITEMCODE, SBITEMSERIE, NUQUANTITY, NUIDITEMDOC, NUTRANSITID);
        
        
        NUITEMSDOCUMENT := GE_BCITEMSDOCUMENTO.FNUGETITEMSDOCBYDOCEXT
                                    (
                                        GE_BOITEMSCONSTANTS.CNUTIPORECEPCIONINTE,
                                        NUOPERUNITID,
                                        SBSUPPODOCU
                                    );
        UT_TRACE.TRACE('Existente nuItemsDocument := '||NUITEMSDOCUMENT,10);
        
        
        IF NUITEMSDOCUMENT IS NULL THEN

            UT_TRACE.TRACE('--Se registra el documento ',10);
            
            GE_BOITEMSDOCUMENTO.CREATEDOCRECEPCION(NUOPERUNITID, SBSUPPODOCU, NULL,  NUITEMSDOCUMENT, NULL);
            
            UT_TRACE.TRACE('Creado nuItemsDocument := '||NUITEMSDOCUMENT,10);
            
        END IF;

        
        OR_BOFWITEMSMOVE.TOACEPTARTRANSITO(NUTRANSITID, NUITEMSDOCUMENT, 0, NUQUANTITY, 0, NUERRORCODE, SBERRORMESSAGE);
        
        UT_TRACE.TRACE('--Aceptacion de transito ', 10);
        
        
        IF ( NUERRORCODE IS NOT NULL AND NUERRORCODE <> 0 ) THEN
        
            GW_BOERRORS.CHECKERROR(NUERRORCODE, SBERRORMESSAGE);
            
        END IF;

        CLEANMEMORY();


        UT_TRACE.TRACE('Fin - GE_BOAceptarItems.AcceptItem',5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACCEPTITEM;

    



























    PROCEDURE REJECTITEM
    (
        ICLXMLREJECTITEM    IN          CLOB
    )
    IS
        
        CLXMLREJECTITEM CLOB;
        DMDOCUMENT      XMLDOM.DOMDOCUMENT;
        NDNODE          XMLDOM.DOMNODE;
        SBNODENAME      VARCHAR2(100);
        SBNODEVALUE     VARCHAR2(100);

        
        NUOPERUNITID    OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
        SBITEMCODE      GE_ITEMS.CODE%TYPE;
        SBITEMSERIE     GE_ITEMS_SERIADO.SERIE%TYPE;
        NUQUANTITY      NUMBER(10,4);
        SBSUPPODOCU     VARCHAR2(30);
        NUIDITEMDOC     OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO%TYPE;
        
        NUITEMSDOCUMENT GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE;
        NUTIPODOCUMENTO GE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID%TYPE;
        NUOPERUNITCLASS OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE;


        NUITEMID        GE_ITEMS.ITEMS_ID%TYPE;
        NUTRANSITID     OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;

        NUERRORCODE     GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE  GE_MESSAGE.DESCRIPTION%TYPE;

        PROCEDURE CLEANMEMORY
        IS
        BEGIN
            UT_TRACE.TRACE('Inicio - GE_BOAceptarItems.RejectItem.CleanMemory',10);

            NUOPERUNITID := NULL;
            SBITEMCODE   := NULL;
            SBITEMSERIE  := NULL;
            NUQUANTITY   := NULL;
            SBSUPPODOCU  := NULL;
            NUIDITEMDOC  := NULL;

            UT_TRACE.TRACE('FIN - GE_BOAceptarItems.RejectItem.CleanMemory',10);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END CLEANMEMORY;

    BEGIN
        UT_TRACE.TRACE('Inicio - GE_BOAceptarItems.RejectItem',5);

        CLEANMEMORY();

        
        CLXMLREJECTITEM := ICLXMLREJECTITEM;
        GE_BOITEMSCARGUE.DECUPXML(CLXMLREJECTITEM);

        
        DMDOCUMENT := UT_XMLPARSE.PARSE(CLXMLREJECTITEM);
        UT_TRACE.TRACE('dmDocument.id = '||DMDOCUMENT.ID,10);

        
        NDNODE.ID := DMDOCUMENT.ID;

        
        IF (NDNODE.ID = -1) THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;

        











        
        NDNODE := XMLDOM.GETFIRSTCHILD(NDNODE);

        
        SBNODENAME := XMLDOM.GETNODENAME(NDNODE);
        UT_TRACE.TRACE('sbNodeName = '||SBNODENAME,10);

        
        IF(UPPER(SBNODENAME) <> 'REJECT_ITEM') THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;

        
        NDNODE := XMLDOM.GETFIRSTCHILD(NDNODE);

        
        SBNODENAME := XMLDOM.GETNODENAME(NDNODE);
        UT_TRACE.TRACE('sbNodeName = '||SBNODENAME,10);

        
        IF(UPPER(SBNODENAME) <> 'ITEM') THEN

            
            GE_BOERRORS.SETERRORCODE(6213);

        END IF;


        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'OPERATING_UNIT');
        NUOPERUNITID := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('OPERATING_UNIT = ' || NUOPERUNITID, 10);

        
        SBITEMCODE := MO_BODOM.FSBGETVALTAG(NDNODE, 'ITEM_CODE');
        UT_TRACE.TRACE('ITEM_CODE = ' || SBITEMCODE, 10);

        
        SBITEMSERIE := MO_BODOM.FSBGETVALTAG(NDNODE, 'SERIE');
        UT_TRACE.TRACE('SERIE = ' || SBITEMSERIE, 10);

        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'QUANTITY');
        NUQUANTITY := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('QUANTITY = ' || NUQUANTITY, 10);

        
        SBSUPPODOCU := MO_BODOM.FSBGETVALTAG(NDNODE, 'SUPPORT_DOCUMENT');
        UT_TRACE.TRACE('SUPPORT_DOCUMENT = ' || SBSUPPODOCU, 10);

        
        SBNODEVALUE := MO_BODOM.FSBGETVALTAG(NDNODE, 'ID_ITEM_DOCUMENTO');
        NUIDITEMDOC := TO_NUMBER(SBNODEVALUE);
        UT_TRACE.TRACE('ID_ITEM_DOCUMENTO = ' || NUIDITEMDOC, 10);

        
        NUITEMID := GE_BOITEMS.FNUGETITEMSID(SBITEMCODE);

        
        VALACCEPTREJECTDATA(NUOPERUNITID, NUITEMID, SBITEMCODE, SBITEMSERIE, NUQUANTITY, NUIDITEMDOC, NUTRANSITID);

        
        NUOPERUNITCLASS := DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(NUOPERUNITID);

        
        
        IF ( (NUOPERUNITCLASS = GE_BOITEMSCONSTANTS.CNUUNID_OP_PROVEEDORA)
            OR (NUOPERUNITCLASS = GE_BOITEMSCONSTANTS.CNUUNID_OP_CENTRO_REPARA) ) THEN
            
            NUTIPODOCUMENTO := GE_BOITEMSCONSTANTS.CNUTIPORECLAMOAPROVE;  
        ELSE
            
            NUTIPODOCUMENTO := GE_BOITEMSCONSTANTS.CNUTIPODEVTRASLADO; 
        END IF;

        
        NUITEMSDOCUMENT := GE_BCITEMSDOCUMENTO.FNUGETITEMSDOCBYDOCEXT
                                    (
                                        NUTIPODOCUMENTO,
                                        NUOPERUNITID,
                                        SBSUPPODOCU
                                    );
        UT_TRACE.TRACE('Existente nuItemsDocument := '||NUITEMSDOCUMENT,10);

        
        IF NUITEMSDOCUMENT IS NULL THEN

            UT_TRACE.TRACE('--Se registra el documento ',10);

            
            GE_BOITEMSDOCUMENTO.CREATEDOCRECLAMO(NUOPERUNITID, NUOPERUNITID, NULL,  NUITEMSDOCUMENT, NULL);
            UT_TRACE.TRACE('Existente nuItemsDocument := '||NUITEMSDOCUMENT,10);
            
        END IF;

        
         OR_BOFWITEMSMOVE.TOACEPTARTRANSITO(NUTRANSITID, 0, NUITEMSDOCUMENT, 0, NUQUANTITY, NUERRORCODE, SBERRORMESSAGE);
         
        
        IF (  NUERRORCODE IS NOT NULL AND NUERRORCODE <> 0 ) THEN

            GW_BOERRORS.CHECKERROR(NUERRORCODE, SBERRORMESSAGE);

        END IF;

        CLEANMEMORY();

        UT_TRACE.TRACE('Fin - GE_BOAceptarItems.RejectItem',5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END REJECTITEM;


END GE_BOACEPTARITEMS;