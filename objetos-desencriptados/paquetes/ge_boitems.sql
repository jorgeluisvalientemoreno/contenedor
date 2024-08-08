PACKAGE BODY GE_BOItems AS



































































    
    
    
    
    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO298395';

    CSBBASEITEM           CONSTANT VARCHAR2(1):='B';
    
    CNUNOHACARGADOITEMS   CONSTANT NUMBER := 2262;
    
    CNUERR_114714  CONSTANT NUMBER(6) :=114714;
    
    CNUERR_114716 CONSTANT NUMBER(6) := 114716;

    
    CNUITEM_IS_NULL_ERR         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900169;
    
    
    CNUITEM_IS_APP_NULL_ERR     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900170;
    
    
    CNUERR_10750 CONSTANT NUMBER := 10750;
    
    
    CNUERR_20203            CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 20203;
    
    
    CNUNO_SERVICE_CLASS     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 150004;

    
    
    
 
    
    
    NUSESSIONID NUMBER:=NULL;   
       
    
    
    BLCOMPUTEITEMS BOOLEAN:=FALSE;   
   
    
    
    
	
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    
    PROCEDURE DELETEISOMDIAGTECHCARD
    ( 
        INUTECH_CARD_ITEM_ID    GE_TECH_CARD_ITEM.TECH_CARD_ITEM_ID%TYPE
    ) 
	IS 
        CURSOR CUISOMDIAGITEM (TECH_CARD_ITEM NUMBER) 
        IS 
            SELECT ITEM_ISOM_DIAGRAM_ID
            FROM   GE_ITEM_ISOM_DIAGRAM
            WHERE  GE_ITEM_ISOM_DIAGRAM.TECH_CARD_ITEM_ID IN (TECH_CARD_ITEM);
    BEGIN
        FOR RCRECORD IN CUISOMDIAGITEM(INUTECH_CARD_ITEM_ID) LOOP
             DELETE FROM GE_ITEM_ISOM_DIAGRAM
             WHERE ITEM_ISOM_DIAGRAM_ID = RCRECORD.ITEM_ISOM_DIAGRAM_ID;
        END LOOP; 
 
		EXCEPTION 
	   		WHEN EX.CONTROLLED_ERROR THEN 
               IF CUISOMDIAGITEM%ISOPEN THEN 
        	        CLOSE CUISOMDIAGITEM; 
               END IF; 
				RAISE; 
	   		WHEN OTHERS THEN 
               IF CUISOMDIAGITEM%ISOPEN THEN 
        	        CLOSE CUISOMDIAGITEM; 
               END IF; 
				ERRORS.SETERROR; 
	   			RAISE EX.CONTROLLED_ERROR; 
 
    END DELETEISOMDIAGTECHCARD; 
    
    
	PROCEDURE DELETEPHOTOTECHCARD 
    ( 
        INUTECH_CARD_ITEM_ID    GE_TECH_CARD_ITEM.TECH_CARD_ITEM_ID%TYPE
    ) 
	IS 
        CURSOR CUPHOTOITEM (TECH_CARD_ITEM NUMBER) 
        IS 
            SELECT ITEM_PHOTO_ID
            FROM   GE_ITEM_PHOTO
            WHERE  GE_ITEM_PHOTO.TECH_CARD_ITEM_ID IN (TECH_CARD_ITEM);
    BEGIN
        FOR RCRECORD IN CUPHOTOITEM(INUTECH_CARD_ITEM_ID) LOOP
             DELETE FROM GE_ITEM_PHOTO
             WHERE ITEM_PHOTO_ID = RCRECORD.ITEM_PHOTO_ID;
        END LOOP; 
	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN 
            IF CUPHOTOITEM%ISOPEN THEN 
                CLOSE CUPHOTOITEM; 
            END IF; 
			RAISE; 
		WHEN OTHERS THEN 
            IF CUPHOTOITEM%ISOPEN THEN 
                CLOSE CUPHOTOITEM; 
            END IF; 
			ERRORS.SETERROR; 
			RAISE EX.CONTROLLED_ERROR; 
	END DELETEPHOTOTECHCARD;

    
    
    
	PROCEDURE GETMEASUREUNIT
	(
		INUITEMS_ID				IN  GE_ITEMS.ITEMS_ID%TYPE,
		ONUMEASURE_UNIT_ID 		OUT GE_ITEMS.MEASURE_UNIT_ID%TYPE
	) IS
    BEGIN
    
        
        ONUMEASURE_UNIT_ID := DAGE_ITEMS.FNUGETMEASURE_UNIT_ID(INUITEMS_ID);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETMEASUREUNIT;
    
    
    
    
    FUNCTION FNUGETITEMBYELEMENTCLASS
    (
      INUELEMENTTYPEID IN IF_ELEMENT_CLASS.CLASS_ID%TYPE,
      INUELEMENTCLASSID IN IF_ELEMENT_CLASS.ELEMENT_TYPE_ID%TYPE
    ) RETURN GE_ITEMS.ITEMS_ID%TYPE
    IS
    
        NUITEMS GE_ITEMS.ITEMS_ID%TYPE;
    
        CURSOR CUGETITEMS
        (
            INUELEMENTTYPE  IN IF_ELEMENT_CLASS.CLASS_ID%TYPE,
            INUELEMENTCLASS IN IF_ELEMENT_CLASS.ELEMENT_TYPE_ID%TYPE
        ) IS
        SELECT ITEMS_ID, USE_ FROM GE_ITEMS
            WHERE ELEMENT_CLASS_ID = INUELEMENTCLASS
                AND ELEMENT_TYPE_ID = INUELEMENTTYPE
                AND USE_ ='I'
                AND ROWNUM =1 ;
    BEGIN
        NUITEMS := NULL;
        FOR RGITEMS IN CUGETITEMS(INUELEMENTTYPEID,INUELEMENTCLASSID)  LOOP
            NUITEMS := RGITEMS.ITEMS_ID;
        END LOOP;
        RETURN NUITEMS;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUGETITEMS%ISOPEN THEN
                CLOSE CUGETITEMS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CUGETITEMS%ISOPEN THEN
                CLOSE CUGETITEMS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETITEMBYELEMENTCLASS;
    
    
    
    
    PROCEDURE VALIDISNORMALITEM
    (
      INUITEMSID  IN GE_ITEMS.ITEMS_ID%TYPE
    )
    IS
        NUITEMCLASSIFID GE_ITEMS.ITEM_CLASSIF_ID%TYPE;
    BEGIN

        NUITEMCLASSIFID := DAGE_ITEMS.FNUGETITEM_CLASSIF_ID(INUITEMSID);
        
        IF NUITEMCLASSIFID IN (OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY,
                               OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_INST,
                               OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ELEM_RET,
                               GE_BOITEMSCONSTANTS.CNUCLASIFICACION_EQUIPO
                              ) THEN
            ERRORS.SETERROR(CNUERR_114714);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDISNORMALITEM;


    FUNCTION FNUGETITEMBYUSE
    (
      INUELEMENTTYPEID  IN IF_ELEMENT_CLASS.CLASS_ID%TYPE,
      INUELEMENTCLASSID IN IF_ELEMENT_CLASS.ELEMENT_TYPE_ID%TYPE,
      ISBUSE            IN GE_ITEMS.USE_%TYPE
    ) RETURN GE_ITEMS.ITEMS_ID%TYPE
    IS
        NUITEMS GE_ITEMS.ITEMS_ID%TYPE;
        TBITEMS     DAGE_ITEMS.TYTBGE_ITEMS;
          NUINDEX         BINARY_INTEGER;
    BEGIN
        NUITEMS := NULL;
        
        GE_BCITEMS.GETITEMSBYUSE(INUELEMENTTYPEID, ISBUSE, TBITEMS);
        
        IF TBITEMS.COUNT = 0 THEN
            
            ERRORS.SETERROR(CNUERR_114716, INUELEMENTTYPEID||'|'||ISBUSE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        NUINDEX := TBITEMS.FIRST;
        LOOP
            
            IF TBITEMS(NUINDEX).ELEMENT_CLASS_ID = INUELEMENTCLASSID THEN
                RETURN  TBITEMS(NUINDEX).ITEMS_ID;
            END IF;

            IF TBITEMS(NUINDEX).ELEMENT_CLASS_ID IS NULL THEN
                NUITEMS :=   TBITEMS(NUINDEX).ITEMS_ID;
            END IF;

            EXIT WHEN (NUINDEX = TBITEMS.LAST);
            NUINDEX := TBITEMS.NEXT(NUINDEX);
        END LOOP;
        
        RETURN NUITEMS;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETITEMBYUSE;

    FUNCTION FNUGETELEMWARRANTYDAYS
    (
      INUITEMSID    IN GE_ITEMS.ITEMS_ID%TYPE,
      INUELEMENTID  IN IF_ASSIGNABLE.ID%TYPE
    )
    RETURN GE_ITEMS.WARRANTY_DAYS%TYPE
    IS
        NUWARRANTYDAYS  GE_ITEMS.WARRANTY_DAYS%TYPE;
    BEGIN
        UT_TRACE.TRACE('[GE_BOItems.fnuGetElemWarrantyDays] Inicio', 2);
        
        NUWARRANTYDAYS := DAGE_ITEMS.FNUGETWARRANTY_DAYS(INUITEMSID);
        IF NUWARRANTYDAYS = 0 THEN
            RETURN NUWARRANTYDAYS;
        END IF;
        IF INUELEMENTID IS NOT NULL THEN
            IF IF_BOELEMENTQUERY.FSBISCLIENTPROPERTY(INUITEMSID, INUELEMENTID) = GE_BOCONSTANTS.CSBYES THEN
                UT_TRACE.TRACE('El elemento es propiedad del Cliente - Fin', 2);
                RETURN 0;
            END IF;
        END IF;
        UT_TRACE.TRACE('[GE_BOItems.fnuGetElemWarrantyDays] Fin', 2);
        RETURN NUWARRANTYDAYS;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETELEMWARRANTYDAYS;

    













    FUNCTION FSBGETISITEMSERIADO
    (
        INUITEMSID      IN  GE_ITEMS.ITEMS_ID%TYPE
    )
    RETURN VARCHAR2
    IS
        NUITEMSTIPO     GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        SBTIPOSERIADO   GE_ITEMS_TIPO.SERIADO%TYPE;
    BEGIN
        SBTIPOSERIADO   := GE_BOCONSTANTS.CSBNO;
        
        NUITEMSTIPO := DAGE_ITEMS.FNUGETID_ITEMS_TIPO(INUITEMSID);
        

        IF ( NOT NUITEMSTIPO IS NULL ) THEN
            
            SBTIPOSERIADO := DAGE_ITEMS_TIPO.FSBGETSERIADO(NUITEMSTIPO);
        END IF;

        RETURN SBTIPOSERIADO;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

   





















    PROCEDURE GETITEMSLOV
    (
        INUOPERUNIT     IN  OR_OPERATING_UNIT.OPER_UNIT_CODE%TYPE,
        ORFDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        GE_BCITEMS.GETITEMSLOV(INUOPERUNIT,ORFDATACURSOR);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFDATACURSOR);
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFDATACURSOR);
            RAISE EX.CONTROLLED_ERROR;
    END GETITEMSLOV;

    



















    PROCEDURE GETITEMSBYSERIADO
    (
        INUITEMCLASSIFID        IN  GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%TYPE,
        ISBFLAGSERIADO          IN  GE_ITEMS_TIPO.SERIADO%TYPE,
        ORFDATACURSOR           OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('[GE_BOItems.GetItemsBySeriado] Inicio', 2);

        GE_BCITEMS.GETITEMSBYSERIADO(INUITEMCLASSIFID,ISBFLAGSERIADO,ORFDATACURSOR);

        UT_TRACE.TRACE('[GE_BOItems.GetItemsBySeriado] Fin', 2);
    EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			RAISE;
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			RAISE EX.CONTROLLED_ERROR;
    END;

    






































    PROCEDURE GETITEMSBYCRITERIA
    (
        INUOPERUNIT     IN  OR_OPERATING_UNIT.OPER_UNIT_CODE%TYPE,
        INUITEMID       IN  GE_ITEMS.ITEMS_ID%TYPE,
        ISBSERIE        IN  GE_ITEMS_SERIADO.SERIE%TYPE,
        ORFDATACURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBSELECTNOSER        VARCHAR2(2000);     
        SBFROMNOSER          VARCHAR2(1000);     
        SBWHERENOSER         VARCHAR2(2000);     
        
        SBSELECTSER        VARCHAR2(2000);       
        SBFROMSER          VARCHAR2(1000);       
        SBWHERESER         VARCHAR2(2000);       
        
        SBHINTFORSERIE     VARCHAR2(2000);       
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOItems.GetItemsByCriteria', 1);

        
        IF ISBSERIE IS NOT NULL THEN
            SBHINTFORSERIE := ' /*+ LEADING(c a)
                                    INDEX(c UNQ_SERIE)
                                    INDEX(a PK_GE_ITEMS)
                                */ ';
        END IF;

        
        
        SBSELECTNOSER := '
                     SELECT  a.items_id,
                             a.code,
                             null ID_ITEMS_SERIADO,
                             a.description,
                             b.seriado,
                             null serie,
                             null estado_inv,
                             null estado_tec,
                             b.id_items_tipo ';
                             
        SBSELECTSER := '
                    SELECT  '||SBHINTFORSERIE||'
                            a.items_id,
                            a.code,
                            c.ID_ITEMS_SERIADO,
                            a.description,
                            b.seriado,
                            c.serie,
                            c.id_items_estado_inv estado_inv,
                            c.ESTADO_TECNICO estado_tec,
                            b.id_items_tipo,
                            1 balance,
                            c.costo total_costs';

                            
        
        
        SBFROMNOSER := '
                    FROM    ge_items a,
                            ge_items_tipo b ';
                            
        SBFROMSER := '
                    FROM    ge_items a,
                            ge_items_tipo b,
                            ge_items_seriado c ';
                            
        
        
        SBWHERENOSER := '
                    WHERE   a.item_classif_id IN (
                               '|| GE_BOITEMSCONSTANTS.CNUCLASIFICACION_EQUIPO || ' ,
                               '|| GE_BOITEMSCONSTANTS.CNUCLASIFICACION_ACCESO || ' )
                    AND     a.id_items_tipo = b.id_items_tipo
                    AND     b.seriado = '''|| PKCONSTANTE.NO || '''';
                    
        SBWHERESER := '
                    WHERE   a.item_classif_id IN (
                               '|| GE_BOITEMSCONSTANTS.CNUCLASIFICACION_EQUIPO || ' ,
                               '|| GE_BOITEMSCONSTANTS.CNUCLASIFICACION_ACCESO || ' )
                    AND     a.id_items_tipo = b.id_items_tipo
                    AND     a.ITEMS_ID = c.ITEMS_ID
                    AND     b.seriado = '|| '''Y''' ||'
                    AND     c.id_items_estado_inv IN (
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE        || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_RECUPGARANTIA     || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_RECUPSEGURO       || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_RECUPSATISFACCION || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_RECUPUPGRADE      || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_DADO_BAJA         || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_DANNADO           || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_OBSOLETO          || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_RECUPERADO        || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_CHATARRA          || ' ,
                                '|| GE_BOITEMSCONSTANTS.CNUSTATUS_POR_RECUPERAR     ||' )
                    AND     GE_BOEmpaquetaEquipos.fsbValidarEmpaquetado( c.serie ) = '''|| PKCONSTANTE.NO || '''';



        
        
        IF (INUOPERUNIT IS NOT NULL) THEN

            SBSELECTNOSER := SBSELECTNOSER || ',
                             c.balance,
                             c.total_costs ';

            SBFROMNOSER :=  SBFROMNOSER || ',
                            or_ope_uni_item_bala c ';
            
            
            SBWHERENOSER := SBWHERENOSER || '
                   AND     c.operating_unit_id = ' || INUOPERUNIT || '
                   AND     a.items_id = c.items_id
                   AND     c.balance > 0 ';

            SBWHERESER := SBWHERESER || '
                        AND     c.operating_unit_id = ' || INUOPERUNIT;
        ELSE

            SBSELECTNOSER := SBSELECTNOSER || ',
                             NULL balance,
                             NULL total_costs ';
        
        SBWHERESER := SBWHERESER || '
                   AND       nvl(c.operating_unit_id, 0) = 0' ;
                        
        END IF;
        
        
        IF INUITEMID IS NOT NULL THEN
        
            SBWHERENOSER := SBWHERENOSER || '
                   AND     a.items_id = ' || INUITEMID;

            SBWHERESER := SBWHERESER || '
                   AND     a.items_id = ' || INUITEMID;

        END IF;

        
         IF ISBSERIE IS NOT NULL THEN

            SBWHERESER := SBWHERESER || '
                   AND     c.serie like ''' || ISBSERIE || '%''';

            SBSELECTNOSER := NULL;
            SBFROMNOSER   := NULL;
            SBWHERENOSER  := NULL;

        ELSE

            SBWHERENOSER := SBWHERENOSER || ' UNION ';

        END IF;
        GE_BCITEMS.GETITEMSBYCRITERIA(
                                        SBSELECTNOSER || ' ' || SBFROMNOSER,
                                        SBWHERENOSER  || ' ' || SBSELECTSER,
                                        SBFROMSER     || ' ' || SBWHERESER,
                                        ORFDATACURSOR);

        UT_TRACE.TRACE(SBSELECTNOSER || ' ' || SBFROMNOSER || CHR(10) ||
                       SBWHERENOSER  || ' ' || SBSELECTSER || CHR(10) ||
                       SBFROMSER     || ' ' || SBWHERESER, 2);
        UT_TRACE.TRACE('Fin GE_BOItems.GetItemsByCriteria', 1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR GE_BOItems.GetItemsByCriteria', 1);
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFDATACURSOR);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others GE_BOItems.GetItemsByCriteria', 1);
            ERRORS.SETERROR;
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(ORFDATACURSOR);
            RAISE EX.CONTROLLED_ERROR;
    END GETITEMSBYCRITERIA;
    
    



    PROCEDURE GETITEMSBYTYPE
    (
        INUITEMTYPE             IN  GE_ITEMS_TIPO.ID_ITEMS_TIPO%TYPE,
        INUITEMCLASSIFID        IN  GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%TYPE,
        ISBFLAGSERIADO          IN  GE_ITEMS_TIPO.SERIADO%TYPE,
        ORFCURSOR               OUT CONSTANTS.TYREFCURSOR
    )
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOItems.GetItemsByType',15);

        
        IF ORFCURSOR%ISOPEN THEN
            CLOSE ORFCURSOR;
        END IF;
        
        ORFCURSOR := GE_BCITEMS.FRFGETITEMSBYTYPE(INUITEMTYPE, INUITEMCLASSIFID,ISBFLAGSERIADO);

        UT_TRACE.TRACE('Finaliza GE_BOItems.GetItemsByType',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : OTHERS',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
    


















    PROCEDURE VALIDATENULL
    (
        INUITEMSID      IN      GE_ITEMS.ITEMS_ID%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE( 'Inicio: [GE_BOItems.ValidateNull]', 5 );

        
        IF ( INUITEMSID IS NULL ) THEN
        
            
            GE_BOERRORS.SETERRORCODE( CNUITEM_IS_NULL_ERR );
        
        END IF;

        UT_TRACE.TRACE( 'Fin: [GE_BOItems.ValidateNull]', 5 );

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END VALIDATENULL;
    
    
    



















    PROCEDURE VALIDATENULLAPP
    (
        INUITEMSID      IN      GE_ITEMS.ITEMS_ID%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE( 'Inicio: [GE_BOItems.ValidateNullApp]', 5 );

        
        IF ( INUITEMSID = PKCONSTANTE.NULLNUM ) THEN
        
            
            GE_BOERRORS.SETERRORCODE( CNUITEM_IS_APP_NULL_ERR );
        
        END IF;

        UT_TRACE.TRACE( 'Fin: [GE_BOItems.ValidateNullApp]', 5 );

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END VALIDATENULLAPP;
    
    
    



















    PROCEDURE VALBASICDATA
    (
        INUITEMSID      IN      GE_ITEMS.ITEMS_ID%TYPE
    )
    IS
    BEGIN
    
        UT_TRACE.TRACE( 'Inicio: [GE_BOItems.ValBasicData]', 5 );

        
        VALIDATENULL( INUITEMSID );
        
        
        VALIDATENULLAPP( INUITEMSID );

        
        DAGE_ITEMS.ACCKEY( INUITEMSID );

        UT_TRACE.TRACE( 'Fin: [GE_BOItems.ValBasicData]', 5 );

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END VALBASICDATA;
    
    



















    PROCEDURE GETITEMSBYTYPE
    (
        INUITEMTIPO     IN  GE_ITEMS.ID_ITEMS_TIPO%TYPE,
        ORFITEMCURSOR   OUT CONSTANTS.TYREFCURSOR
    )
    IS

    BEGIN
        UT_TRACE.TRACE('-- INICIO GE_BOItems.GetItemsByType',15);
        
        GE_BCITEMS.GETEQUIPITEMSBYTYPE(INUITEMTIPO, ORFITEMCURSOR);
        
        UT_TRACE.TRACE('-- FIN GE_BOItems.GetItemsByType',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END GETITEMSBYTYPE;

    




















    PROCEDURE GETITEMCLASSIFACT
    (
        ORFDATA          OUT    CONSTANTS.TYREFCURSOR
    )
    IS

    BEGIN
        UT_TRACE.TRACE('INICIO - GE_BOItems.getItemClassifAct',15);

        GE_BCITEMS.GETITEMCLASSIFACT(ORFDATA);

        UT_TRACE.TRACE('FIN - GE_BOItems.getItemClassifAct',15);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
        	RAISE;
        WHEN OTHERS THEN
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END GETITEMCLASSIFACT;
     
    




























    PROCEDURE GETITEMSBYEXPORT
    (
        INUITEMCLASSIF  IN      GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%TYPE,
        INUITEMID       IN      GE_ITEMS.ITEMS_ID%TYPE,
        INUTASKTYPEID   IN      OR_TASK_TYPE.TASK_TYPE_ID%TYPE,
        ISBDESCRIPTION  IN      GE_ITEMS.DESCRIPTION%TYPE,
        ORFREFCURSOR    OUT     CONSTANTS.TYREFCURSOR
    )
    IS

        SBWHERE         VARCHAR2(2000);
        SBSQL           VARCHAR2(8000);
        NUITEMCLASSIF   GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%TYPE;
        NUITEMID        GE_ITEMS.ITEMS_ID%TYPE;
        NUTASKTYPEID    OR_TASK_TYPE.TASK_TYPE_ID%TYPE;
        SBDESCRIPTION   GE_ITEMS.DESCRIPTION%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO - GE_BOItems.GetItemsByExport',1);

        NUITEMCLASSIF   := NVL(INUITEMCLASSIF, CC_BOCONSTANTS.CNUAPPLICATIONNULL );
        UT_TRACE.TRACE('nuItemClassif: '||NUITEMCLASSIF, 15);

        NUITEMID   := NVL(INUITEMID, CC_BOCONSTANTS.CNUAPPLICATIONNULL );
        UT_TRACE.TRACE('nuItemId: '||NUITEMID, 15);

        NUTASKTYPEID   := NVL(INUTASKTYPEID, CC_BOCONSTANTS.CNUAPPLICATIONNULL );
        UT_TRACE.TRACE('nuTaskTypeId: '||NUTASKTYPEID, 15);

        SBDESCRIPTION  := TRIM (UPPER (NVL (ISBDESCRIPTION, CC_BOCONSTANTS.CSBNULLSTRING)));
        UT_TRACE.TRACE('sbDescription: '||SBDESCRIPTION, 15);

        
        IF ( NUITEMCLASSIF <> CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN

            SBWHERE := 'AND     GE_ITEMS.item_classif_id = :nuItemClassif'||CHR(10);

        ELSE

            SBWHERE := 'AND     :nuItemClassif = '||  NUITEMCLASSIF ||CHR(10);

        END IF;
        
        
        IF ( NUITEMID <> CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN

            SBWHERE := SBWHERE || 'AND     GE_ITEMS.items_id = :nuItemId'||CHR(10);

        ELSE

            SBWHERE := SBWHERE || 'AND     :nuItemId = '||  NUITEMID ||CHR(10);

        END IF;

        
        IF ( NUTASKTYPEID <> CC_BOCONSTANTS.CNUAPPLICATIONNULL) THEN

            SBWHERE := SBWHERE || 'AND     or_task_types_items.task_type_id = :nuTaskTypeId'||CHR(10);

        ELSE

            SBWHERE := SBWHERE || 'AND     :nuTaskTypeId = '||  NUTASKTYPEID ||CHR(10);

        END IF;
        
        
        IF ( SBDESCRIPTION <> CC_BOCONSTANTS.CSBNULLSTRING) THEN

            SBWHERE := SBWHERE || 'AND     upper(ge_items.description) LIKE '
                       ||CHR(39)||'%'||CHR(39)||'||:sbDescription||'||CHR(39)||'%'||CHR(39)||CHR(10);

        ELSE

            SBWHERE := SBWHERE || 'AND     :sbDescription = '||  SBDESCRIPTION ||CHR(10);

        END IF;


        UT_TRACE.TRACE('Where: '||CHR(10)||SBWHERE, 5);

        SBSQL :=
            'SELECT  /*+ index(ge_items IDX_GE_ITEMS_02) '||CHR(10)||
            '            index(or_task_types_items IDX_OR_TASK_TYPES_ITEMS01)'||CHR(10)||
            '            leading(ge_items)'||CHR(10)||
            '            use_nl(ge_items, or_task_types_items)*/'||CHR(10)||
            '        unique ge_items.items_id,'||CHR(10)||
            '        ge_items.description'||CHR(10)||
            'FROM    ge_items,/*+ GE_BOItems.GetItemsByExport SAO193329 */'||CHR(10)||
            '        or_task_types_items'||CHR(10)||
            'WHERE   ge_items.items_id =  or_task_types_items.items_id(+)'||CHR(10)||
            SBWHERE;

        UT_TRACE.TRACE('Sentencia: '||CHR(10)||SBSQL, 5);

        OPEN ORFREFCURSOR FOR SBSQL USING NUITEMCLASSIF, NUITEMID, NUTASKTYPEID, SBDESCRIPTION;
        UT_TRACE.TRACE('FIN - GE_BOItems.GetItemsByExport',1);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END GETITEMSBYEXPORT;
    
     




















    FUNCTION FNUGETITEMSID
    (
        ISBCODE     IN  GE_ITEMS.CODE%TYPE
    ) RETURN GE_ITEMS.ITEMS_ID%TYPE

    IS
        NUITEMID  GE_ITEMS.ITEMS_ID%TYPE;
    BEGIN

        UT_TRACE.TRACE('Inicio - GE_BOItems.fnuGetItemsId',1);

        NUITEMID := GE_BCITEMS.FNUGETITEMSID(ISBCODE);
        
        IF (NUITEMID IS NULL) THEN
            ERRORS.SETERROR(CNUERR_10750,ISBCODE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        
        UT_TRACE.TRACE('Fin - GE_BOItems.fnuGetItemsId',1);

        RETURN NUITEMID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('CONTROLLED_ERROR - GE_BOItems.fnuGetItemsId',1);
        	RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('OTHERS - GE_BOItems.fnuGetItemsId',1);
        	ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
     END FNUGETITEMSID;
     
     



























































































    PROCEDURE PROCESSEQUIPMENTITEM
    (
        INUORDERID          IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUORDERACTID       IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUMOCOMPONENTID    IN  OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE,
        INUPACKAGEID        IN  OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
        INUOPERATINGUNITID  IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        ISBISUTILITIES      IN  STYLETTER,
        INUPRCOMPONENTID    IN  PR_COMPONENT.COMPONENT_ID%TYPE,
        INUADDRESSID        IN  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE,
        INUSUBSCRIBERID     IN  OR_ORDER_ACTIVITY.SUBSCRIBER_ID%TYPE,
        INUCOMPONENTTYPEID  IN  PR_COMPONENT.COMPONENT_TYPE_ID%TYPE,
        INUCLASSSERVICEID   IN  PR_COMPONENT.CLASS_SERVICE_ID%TYPE,
        INUPRODUCTID        IN  OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
        INUPRODUCTTYPEID    IN  PR_PRODUCT.PRODUCT_TYPE_ID%TYPE
    )
    IS
        TBEQUIPMENT         OR_BCORDERITEMS.TYTBEQUIPMENT;
        RCEQUIPMENT1        OR_BCORDERITEMS.TYRCEQUIPMENT;
        RCEQUIPMENT2        OR_BCORDERITEMS.TYRCEQUIPMENT;
        
        SBSERIE1            OR_ORDER_ITEMS.SERIE%TYPE;
        
        SBSERIE2            OR_ORDER_ITEMS.SERIE%TYPE;
        NUADDRESSID         OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        NUSUBSCRIBERID      OR_ORDER_ACTIVITY.SUBSCRIBER_ID%TYPE;
        NUCOMPPRODID        OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE;
        NUTMPCOMPPRODID     OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE;
        NUCOMPONENTTYPEID   PR_COMPONENT.COMPONENT_TYPE_ID%TYPE;
        NUCLASSSERVICEID    PR_COMPONENT.CLASS_SERVICE_ID%TYPE;
        NUPRODUCTID         OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        NUPRODUCTTYPEID      PR_PRODUCT.PRODUCT_TYPE_ID%TYPE;
        RCITEMSERIADO       DAGE_ITEMS_SERIADO.STYGE_ITEMS_SERIADO;
        TBITEMSERCAP        DAGE_ITEM_SERIADO_CAP.TYTBGE_ITEM_SERIADO_CAP;
        NUINDEX             BINARY_INTEGER;
        NUUNIITEMMOVID      OR_UNI_ITEM_BALA_MOV.UNI_ITEM_BALA_MOV_ID%TYPE;
        SBMOVETYPE          OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE%TYPE;
        NUORDERITEMID       OR_ORDER_ITEMS.ORDER_ITEMS_ID%TYPE;


        NUITEM              PS_CLASS_SERVICE.ITEM_ID%TYPE;
        TBSEALTOASSO        OR_BOINSTANCEACTIVITIES.TYTBASSOSEALTOEQUIP;
        NUINDEXSEALTOASSO   GE_ITEMS_SERIADO.SERIE%TYPE;
        NUIDSEAL            GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
        SBINSTANCEVALUE     GE_BOINSTANCECONTROL.STYSBVALUE;
        RCCOMPONENT         DAPR_COMPONENT.STYPR_COMPONENT;
        NUGAMAID            GE_ITEMS_GAMA.ID_ITEMS_GAMA%TYPE;
        NUITEMSID           GE_ITEMS_GAMA_ITEM.ITEMS_ID%TYPE;

        NUELEMENTID         ELEMMEDI.ELMEIDEM%TYPE;
        
        NUNEWELEMENTID      ELEMMEDI.ELMEIDEM%TYPE;
        NUSEALITEMSERIADO   GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
        BLITEMWIDRAW        BOOLEAN;

        
        SBRESPONSE                   FM_POSSIBLE_NTL .COMMENT_%TYPE;
        NUCODEFRAUDGENERATED   FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
        
        RCORDER                          DAOR_ORDER.STYOR_ORDER;
        NUERRORCODE             GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE          GE_MESSAGE.DESCRIPTION%TYPE;
        INUSTATEINV             GE_ITEMS_ESTADO_INV.ID_ITEMS_ESTADO_INV%TYPE;
        DTRETIREDATE            PR_COMPONENT.SERVICE_DATE%TYPE;
        
        
        
        CSBNOTFOUND_ITEMCAP GE_MESSAGE.MESSAGE_ID%TYPE := 18023;
        CSBINV_CLIE_ADDRESS GE_MESSAGE.MESSAGE_ID%TYPE := 18024;
        CSBINV_CAPACITY     GE_MESSAGE.MESSAGE_ID%TYPE := 18027;
        CSBINV_EQUIP_TYPE   GE_MESSAGE.MESSAGE_ID%TYPE := 18031;
    BEGIN

        UT_TRACE.TRACE('INICIO GE_BOItems.processEquipmentItem. '
            || 'inuOrderId: ['          || TO_CHAR(INUORDERID)           || '] - '
            || 'inuOrderActId: ['       || TO_CHAR(INUORDERACTID)        || '] - '
            || 'inuMoComponentId: ['    || TO_CHAR(INUMOCOMPONENTID)     || '] - '
            || 'inuPackageId: ['        || TO_CHAR(INUPACKAGEID)         || '] - '
            || 'inuOperatingUnitId: ['  || TO_CHAR(INUOPERATINGUNITID)   || '] - '
            || 'isbISUtilities:  ['     || ISBISUTILITIES                || '] - '
            || 'inuPrComponentId: ['    || TO_CHAR(INUPRCOMPONENTID)     || '] - '
            || 'inuAddressId: ['        || TO_CHAR(INUADDRESSID)         || '] - '
            || 'inuSubscriberId: ['     || TO_CHAR(INUSUBSCRIBERID)      || '] - '
            || 'inuComponentTypeId: ['  || TO_CHAR(INUCOMPONENTTYPEID)   || '] - '
            || 'inuClassServiceId: ['   || TO_CHAR(INUCLASSSERVICEID)    || '] - '
            || 'inuProductId: ['        || TO_CHAR(INUPRODUCTID)         || '] - '
            || 'inuProductTypeId: ['    || TO_CHAR(INUPRODUCTTYPEID)     || '] ', 10);

        NUADDRESSID         :=  INUADDRESSID;
        NUSUBSCRIBERID      :=  INUSUBSCRIBERID;
        NUCOMPPRODID        :=  INUPRCOMPONENTID;
        NUCOMPONENTTYPEID   :=  INUCOMPONENTTYPEID;
        NUCLASSSERVICEID    :=  INUCLASSSERVICEID;
        NUPRODUCTID         :=  INUPRODUCTID;
        NUPRODUCTTYPEID     :=  INUPRODUCTTYPEID;

        
        OR_BCORDERITEMS.GETEQUIPMENTBYACTIVI(INUORDERACTID, TBEQUIPMENT);

        NUINDEX := TBEQUIPMENT.FIRST;
        
        IF(NUCOMPPRODID IS NOT NULL) THEN
            RCCOMPONENT := DAPR_COMPONENT.FRCGETRECORD(NUCOMPPRODID);
        ELSE
            
            RCCOMPONENT := DAPR_COMPONENT.FRCGETRECORD(DAMO_COMPONENT.FNUGETCOMPONENT_ID_PROD(INUMOCOMPONENTID));
        END IF;

        UT_TRACE.TRACE('tbEquipment.count: '||TO_CHAR(TBEQUIPMENT.COUNT), 2 );
        
         
        IF (TBEQUIPMENT.COUNT = 2) THEN
            RCEQUIPMENT1 := TBEQUIPMENT(NUINDEX);
            NUINDEX := TBEQUIPMENT.NEXT(NUINDEX);
            RCEQUIPMENT2 := TBEQUIPMENT(NUINDEX);

            IF ( ( ( RCEQUIPMENT1.OUT_ = GE_BOCONSTANTS.CSBYES ) AND
                   ( RCEQUIPMENT2.OUT_ = GE_BOCONSTANTS.CSBNO  ) ) OR
                 ( ( RCEQUIPMENT1.OUT_ = GE_BOCONSTANTS.CSBNO  ) AND
                   ( RCEQUIPMENT2.OUT_ = GE_BOCONSTANTS.CSBYES ) ) ) THEN

                
                
                 UT_TRACE.TRACE('rcEquipment1.out_: '||RCEQUIPMENT1.OUT_||' Es un Cambio entre: ['
                    || TO_CHAR(RCEQUIPMENT1.ITEMSERIADOID) || '] y ['
                    || TO_CHAR(RCEQUIPMENT2.ITEMSERIADOID) || ']', 11);
                 
                IF ( RCEQUIPMENT1.OUT_ = GE_BOCONSTANTS.CSBYES ) THEN
                    OR_BOLEGALIZEACTIVITIES.EXCHANGEEQUIPMENT (
                        INUORDERID,
                        NUCOMPPRODID,
                        INUMOCOMPONENTID,
                        NUCOMPONENTTYPEID,
                        RCEQUIPMENT2.ITEMSERIADOID,
                        RCEQUIPMENT1.ITEMSERIADOID,
                        ISBISUTILITIES
                    );
                    
                    
                    OR_BOLEGALIZEACTIVITIES.RETIREPROCESS
                        (
                            RCEQUIPMENT2.SERIE,
                            NUPRODUCTID,
                            INUORDERID,
                            INUORDERACTID,
                            NUELEMENTID
                        );
                        
                    
                    OR_BOLEGALIZEACTIVITIES.INSTALLPROCESS
                        (
                            RCCOMPONENT,
                            INUORDERID,
                            ISBISUTILITIES,
                            RCEQUIPMENT1.SERIE,
                            RCEQUIPMENT1.ITEMSERIADOID,
                            NUSUBSCRIBERID,
                            NUNEWELEMENTID
                        );
                ELSE
                    OR_BOLEGALIZEACTIVITIES.EXCHANGEEQUIPMENT (
                        INUORDERID,
                        NUCOMPPRODID,
                        INUMOCOMPONENTID,
                        NUCOMPONENTTYPEID,
                        RCEQUIPMENT1.ITEMSERIADOID,
                        RCEQUIPMENT2.ITEMSERIADOID,
                        ISBISUTILITIES
                    );
                    
                    
                    OR_BOLEGALIZEACTIVITIES.RETIREPROCESS
                        (
                            RCEQUIPMENT1.SERIE,
                            NUPRODUCTID,
                            INUORDERID,
                            INUORDERACTID,
                            NUELEMENTID
                        );

                    
                    OR_BOLEGALIZEACTIVITIES.INSTALLPROCESS
                        (
                            RCCOMPONENT,
                            INUORDERID,
                            ISBISUTILITIES,
                            RCEQUIPMENT2.SERIE,
                            RCEQUIPMENT2.ITEMSERIADOID,
                            NUSUBSCRIBERID,
                            NUNEWELEMENTID
                        );
                END IF;

                NUINDEX := NULL;
            END IF;
        END IF;

        
        
        WHILE NUINDEX IS NOT NULL LOOP
            
            RCEQUIPMENT1 := TBEQUIPMENT(NUINDEX);

            
            BLITEMWIDRAW := RCEQUIPMENT1.ITEMAMOUNT = -1 AND RCEQUIPMENT1.OUT_ = GE_BOCONSTANTS.CSBNO;

            
            IF (BLITEMWIDRAW) THEN
                UT_TRACE.TRACE('Es un retiro, se actualiza la cantidad', 2 );
                RCEQUIPMENT1.ITEMAMOUNT := 1;
                OR_BCORDERITEMS.UPDLEGALITEMAMOUNT(INUORDERID, RCEQUIPMENT1.ITEMSERIADOID, RCEQUIPMENT1.ITEMAMOUNT);
            END IF;

            UT_TRACE.TRACE('rcEquipment1.itemAmount '||TO_CHAR(RCEQUIPMENT1.ITEMAMOUNT)||' nuCompProdId '||TO_CHAR(NUCOMPPRODID), 2 );

            IF (RCEQUIPMENT1.ITEMAMOUNT > 0) THEN

                NUUNIITEMMOVID := NULL;
                SBMOVETYPE := NULL;

                DAGE_ITEMS_SERIADO.GETRECORD(RCEQUIPMENT1.ITEMSERIADOID, RCITEMSERIADO);

                
                GE_BCITEMS_GAMA_ITEM.GETGAMMABYSERIE(RCEQUIPMENT1.SERIE, NUGAMAID, NUITEMSID);

                UT_TRACE.TRACE('rcComponent: '||TO_CHAR(RCCOMPONENT.COMPONENT_ID)||' nuGamaId: '||TO_CHAR(NUGAMAID), 2 );
                OR_BOLEGALIZEACTIVITIES.SETMEASURABLESEQUIP
                        (
                            RCCOMPONENT,
                            NUGAMAID,
                            INUORDERID,
                            NUSUBSCRIBERID,
                            NUELEMENTID
                        );

                UT_TRACE.TRACE('nuElementId: '||TO_CHAR(NUELEMENTID)||' rcEquipment1.out_ '||RCEQUIPMENT1.OUT_, 2 );
                
                
                IF RCEQUIPMENT1.OUT_ = GE_BOCONSTANTS.CSBYES THEN
                    
                    
                    IF (NUCOMPPRODID IS NULL AND INUPACKAGEID IS NOT NULL) THEN
                        PR_BOCOMPONENT.GETPRCOMPBYITEMANDPROD(
                                                                INUPACKAGEID,
                                                                RCITEMSERIADO.ITEMS_ID,
                                                                INUPRODUCTID,
                                                                NUCOMPPRODID
                                                                    );

                        OR_BCORDERACTIVITIES.GETPRODINFOBYACTPR(
                                        INUORDERACTID,
                                        NUCOMPPRODID,
                                        NUADDRESSID,
                                        NUSUBSCRIBERID,
                                        NUTMPCOMPPRODID,
                                        NUCOMPONENTTYPEID,
                                        NUCLASSSERVICEID,
                                        NUPRODUCTID,
                                        NUPRODUCTTYPEID
                                        );
                    END IF;
                    
                    UT_TRACE.TRACE('rcItemSeriado.id_items_estado_inv '||TO_CHAR(RCITEMSERIADO.ID_ITEMS_ESTADO_INV), 2 );

                    IF ( RCITEMSERIADO.ID_ITEMS_ESTADO_INV  =  GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE ) THEN
                        
                        SBMOVETYPE := OR_BOITEMSMOVE.CSBDECREASEMOVETYPE;
                     ELSIF RCITEMSERIADO.ID_ITEMS_ESTADO_INV  =   GE_BOITEMSCONSTANTS.CNUSTATUS_POR_RECUPERAR THEN
                         OR_BOORDERITEMS.INSERTORUPDATEORDERITEMS(
                                                                INUORDERID,
                                                                RCITEMSERIADO.ITEMS_ID,
                                                                0
                                                                );
                         SBMOVETYPE := OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE;
                    ELSIF RCITEMSERIADO.ID_ITEMS_ESTADO_INV  =   GE_BOITEMSCONSTANTS.CNUSTATUS_ENUSO THEN

                        TBITEMSERCAP := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM(
                                                                        RCITEMSERIADO.ID_ITEMS_SERIADO,
                                                                        NUPRODUCTTYPEID);

                        IF TBITEMSERCAP.COUNT  < 1 THEN
                            GE_BOERRORS.SETERRORCODEARGUMENT(CSBNOTFOUND_ITEMCAP,RCITEMSERIADO.SERIE||'|'||NUPRODUCTTYPEID);
                        END IF;


                        IF ( TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_TOTAL <=
                              TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_OCCUPIED ) THEN

                            GE_BOERRORS.SETERRORCODEARGUMENT(
                                                        CSBINV_CAPACITY,
                                                        RCITEMSERIADO.SERIE||'|'||
                                                        PKTBLSERVICIO.FSBGETDESCRIPTION(NUPRODUCTTYPEID) );
                        END IF;

                        IF PR_BCCOMPONENT.FBLEQUIPINSBYCLIADDR(
                                                    NUSUBSCRIBERID,
                                                    NUADDRESSID,
                                                    RCITEMSERIADO.SERIE,
                                                    NUCOMPONENTTYPEID )
                       THEN

                            GE_BOERRORS.SETERRORCODEARGUMENT(CSBINV_CLIE_ADDRESS,RCITEMSERIADO.SERIE);
                        END IF;

                    END IF;

                    IF ( DAGE_ITEMS.FSBGETSHARED(RCITEMSERIADO.ITEMS_ID ) = GE_BOCONSTANTS.CSBYES ) THEN

                        UT_TRACE.TRACE('Es compartido el item '||TO_CHAR(RCITEMSERIADO.ITEMS_ID), 2 );

                        IF TBITEMSERCAP.FIRST  IS NULL THEN
                            TBITEMSERCAP := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM(
                                                                            RCITEMSERIADO.ID_ITEMS_SERIADO,
                                                                            NUPRODUCTTYPEID );
                        END IF;

                        IF TBITEMSERCAP.COUNT  < 1 THEN
                            GE_BOERRORS.SETERRORCODEARGUMENT(CSBNOTFOUND_ITEMCAP,RCITEMSERIADO.SERIE||'|'||NUPRODUCTTYPEID);
                        END IF;
                        
                        DAGE_ITEM_SERIADO_CAP.UPDCAPACITY_OCCUPIED(TBITEMSERCAP(TBITEMSERCAP.FIRST).ITEM_SERIADO_CAP_ID,
                                                                TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_OCCUPIED + 1);

                    END IF;


                    
                    IF (INUMOCOMPONENTID IS NOT NULL AND NOT BLITEMWIDRAW  AND ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
                        DAMO_COMPONENT.UPDSERVICE_NUMBER ( INUMOCOMPONENTID,  RCITEMSERIADO.SERIE );
                    END IF;

                    IF (ISBISUTILITIES = GE_BOCONSTANTS.CSBNO) THEN
                        DAPR_COMPONENT.UPDSERVICE_NUMBER ( NUCOMPPRODID,  RCITEMSERIADO.SERIE );
                    END IF;

                ELSE  

                    IF ( DAGE_ITEMS.FSBGETSHARED(RCITEMSERIADO.ITEMS_ID ) = GE_BOCONSTANTS.CSBYES ) THEN

                        UT_TRACE.TRACE('es compartido de salida', 2 );

                        TBITEMSERCAP := GE_BCITEMCAPACITY.FTBGETCAPSSERBYITEM(
                                                                    RCITEMSERIADO.ID_ITEMS_SERIADO,
                                                                    NUPRODUCTTYPEID );

                        IF TBITEMSERCAP.COUNT  < 1 THEN
                            GE_BOERRORS.SETERRORCODEARGUMENT(CSBNOTFOUND_ITEMCAP,RCITEMSERIADO.SERIE||'|'||NUPRODUCTTYPEID);
                        END IF;
                        
                        DAGE_ITEM_SERIADO_CAP.UPDCAPACITY_OCCUPIED(
                                                            TBITEMSERCAP(TBITEMSERCAP.FIRST).ITEM_SERIADO_CAP_ID,
                                                            TBITEMSERCAP(TBITEMSERCAP.FIRST).CAPACITY_OCCUPIED - 1);

                        IF ( GE_BCITEMCAPACITY.FBLISFREEITEMSER(RCITEMSERIADO.ID_ITEMS_SERIADO) ) THEN
                            
                            SBMOVETYPE := OR_BOITEMSMOVE.CSBINCREASEMOVETYPE;
                            
                            RCITEMSERIADO.SUBSCRIBER_ID := NULL;
                        END IF;
                    ELSE
                        
                        SBMOVETYPE := OR_BOITEMSMOVE.CSBINCREASEMOVETYPE;
                        
                        RCITEMSERIADO.SUBSCRIBER_ID := NULL;
                    END IF;


                END IF;

                UT_TRACE.TRACE('sbMoveType '||SBMOVETYPE, 2 );

                
                IF SBMOVETYPE IS NOT NULL THEN
                    
                    IF SBMOVETYPE = OR_BOITEMSMOVE.CSBINCREASEMOVETYPE THEN
                        
                        IF DAGE_ITEMS.FSBGETRECOVERY(RCITEMSERIADO.ITEMS_ID,0) = GE_BOCONSTANTS.CSBYES THEN
                            UT_TRACE.TRACE('Es recuperable', 2 );
                            
                            OR_BOLEGALIZEACTIVITIES.PROCESSUPDRECEQU(INUORDERID, RCITEMSERIADO);
                        ELSE
                            SBMOVETYPE := OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE;
                        END IF;
                    END IF;
                    
                    IF (SBMOVETYPE = OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE) THEN
                        UT_TRACE.TRACE('El movimiento es neutral sbMoveType: '||SBMOVETYPE, 2 );
                        INUSTATEINV := GE_BOITEMSCONSTANTS.CNUSTATUS_ENUSO;
                    ELSE
                        UT_TRACE.TRACE('El movimiento no es neutral sbMoveType: '||SBMOVETYPE, 2 );
                        INUSTATEINV := NULL;
                    END IF;

                        OR_BOITEMSMOVE.CREATEMOVBYLEGALIZE
                            (
                                INUORDERID,
                                INUOPERATINGUNITID,
                                RCEQUIPMENT1.ITEMSID,
                                RCITEMSERIADO,
                                SBMOVETYPE,
                                1,
                                NULL,
                                NUUNIITEMMOVID,
                                INUSTATEINV
                            );
                END IF;

            END IF;
            NUINDEX := TBEQUIPMENT.NEXT(NUINDEX);
        END LOOP;


        
        
        IF (NUELEMENTID IS NOT NULL AND  NUNEWELEMENTID IS NOT NULL AND ISBISUTILITIES = GE_BOCONSTANTS.CSBYES) THEN
            SBSERIE1 := RCEQUIPMENT1.SERIE;
            SBSERIE2 := RCEQUIPMENT2.SERIE;
            GE_BOITEMS.UPDREAD (SBSERIE1, SBSERIE2, INUORDERID, NUELEMENTID, NUNEWELEMENTID);
        END IF;

        UT_TRACE.TRACE('FIN GE_BOItems.processEquipmentItem. ', 10);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSEQUIPMENTITEM;
    

    



















    PROCEDURE VALIDSERVCOMP
    (
        ISBPRODTYPETAGNAME  SERVICIO.SERVTXML%TYPE,
        ISBCOMPTYPETAGNAME  PS_COMPONENT_TYPE.TAG_NAME%TYPE,
        ISBSERIE            GE_ITEMS_SERIADO.SERIE%TYPE
    )
    IS
        NUPRODTYPEID        SERVICIO.SERVCODI %TYPE;
        NUCOMPTYPEID        PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%TYPE;
        
        NUCLASSSERVICE      MO_COMPONENT.CLASS_SERVICE_ID%TYPE;
        NUIDITEMSERIADO     GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;
        NUITEMID            GE_ITEMS.ITEMS_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOItems.ValidServComp',7);

        
        NUPRODTYPEID := PS_BOPRODUCTTYPE.FNUGETPRODUCTTYPEBYTAGNAME(ISBPRODTYPETAGNAME);

        
        NUCOMPTYPEID :=  PS_BOCOMPONENTTYPE.FNUGETCOMPTYPEBYTAG(ISBCOMPTYPETAGNAME);
        
        
        GE_BCITEMSSERIADO.GETIDBYSERIE(ISBSERIE,NUIDITEMSERIADO);

        
        NUITEMID := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(NUIDITEMSERIADO);

        
        NUCLASSSERVICE:= PS_BCCLASSSERVICE.FNUGETCLASSSERVBYITEMID(NUITEMID);
        
        IF NUCLASSSERVICE IS  NULL THEN
            ERRORS.SETERROR(CNUNO_SERVICE_CLASS);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        PS_BOPRODCOMPOSITION.VALIDATECLASS(NUPRODTYPEID,NUCOMPTYPEID,NUCLASSSERVICE);

        UT_TRACE.TRACE('Finaliza GE_BOItems.ValidServComp',7);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDSERVCOMP;

    






























    PROCEDURE UPDREAD
    (
        ISBSERIE1           IN  OR_ORDER_ITEMS.SERIE%TYPE,
        ISBSERIE2           IN  OR_ORDER_ITEMS.SERIE%TYPE,
        INUORDERID          IN  OR_ORDER_ITEMS.ORDER_ID%TYPE,
        INUELEMENTID        IN  ELEMMEDI.ELMEIDEM%TYPE,
        INUNEWELEMENTID     IN  ELEMMEDI.ELMEIDEM%TYPE
    )
    IS
        
        TBCONSUTYPES1       GE_BCCONSTYPEBYGAMA.TYTBCONSUMPTIONTYPE;
        
        TBCONSUTYPES2       GE_BCCONSTYPEBYGAMA.TYTBCONSUMPTIONTYPE;
        
        NUIDX1              NUMBER;
        
        NUIDX2              NUMBER;
        
        DTEXEFINDATE        OR_ORDER.EXECUTION_FINAL_DATE%TYPE;
        
        NULECTELME          LECTELME.LEEMCONS%TYPE;
        
        RFREADINGS          CONSTANTS.TYREFCURSOR ;
        
        RCORDER             DAOR_ORDER.STYOR_ORDER;
        
        NUPRODUCTO           CONSSESU.COSSSESU%TYPE;
        
        RCREAD             LECTELME%ROWTYPE;
        

    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOItems.UpdRead',7);
        
        
        GE_BCCONSTYPEBYGAMA.GETCONSUMPTYPEBYSERIE(ISBSERIE1,TBCONSUTYPES1);
        
        IF (TBCONSUTYPES1.COUNT = 0) THEN
           RETURN;
        END IF;
        
        GE_BCCONSTYPEBYGAMA.GETCONSUMPTYPEBYSERIE(ISBSERIE2,TBCONSUTYPES2);
        
        IF (TBCONSUTYPES2.COUNT = 0) THEN
           RETURN;
        END IF;

        NUIDX1 := TBCONSUTYPES1.FIRST;
        NUIDX2 := TBCONSUTYPES2.FIRST;

        WHILE (NUIDX1 IS NOT NULL OR NUIDX2 IS NOT NULL) LOOP
            IF TBCONSUTYPES1(NUIDX1).TCONCODI = TBCONSUTYPES2(NUIDX2).TCONCODI THEN
                NUIDX1 := TBCONSUTYPES1.NEXT(NUIDX1);
                NUIDX2 := TBCONSUTYPES2.NEXT(NUIDX2);
            ELSE
                RETURN;
           END IF;
        END LOOP;

        
        RCORDER := DAOR_ORDER.FRCGETRECORD(INUORDERID);
        
        DTEXEFINDATE := RCORDER.EXECUTION_FINAL_DATE;
        
        NUPRODUCTO := DAOR_EXTERN_SYSTEMS_ID.FNUGETPRODUCT_ID(RCORDER.ORDER_ID);
        UT_TRACE.TRACE('nuProducto: ' || NUPRODUCTO,7);

        GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFREADINGS);

        
        RFREADINGS := PKMEASUREMENTREADINGMGR.FRFGETREADING(INUELEMENTID,DTEXEFINDATE);

        LOOP
            FETCH RFREADINGS INTO NULECTELME;
            EXIT WHEN RFREADINGS%NOTFOUND;

            BEGIN

                
                RCREAD := PKTBLLECTELME.FRCGETRECORD(NULECTELME);

                
                PKTBLLECTELME.UPDLEEMELME (NULECTELME, INUNEWELEMENTID);
                
                UT_TRACE.TRACE('per�odo de la lectura a actualizar: ' || RCREAD.LEEMPECS,7);
                UT_TRACE.TRACE('Tipo de consumo                   : ' || RCREAD.LEEMTCON,7);
                UT_TRACE.TRACE('Elemento de medici�n anterior     : ' || RCREAD.LEEMELME,7);
                UT_TRACE.TRACE('Nuevo Elemento                    : ' || INUNEWELEMENTID,7);

                
                UPDCONS(
                         NUPRODUCTO,        
                         RCREAD.LEEMELME,      
                         RCREAD.LEEMTCON,      
                         RCREAD.LEEMPECS,      
                         INUNEWELEMENTID
                        );
                
                
            END ;

        END LOOP;
        

        
        GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFREADINGS);
        UT_TRACE.TRACE('Finaliza GE_BOItems.UpdRead',7);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFREADINGS);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            GE_BOGENERALUTIL.CLOSE_REFCURSOR(RFREADINGS);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDREAD;
    
    
























    PROCEDURE UPDCONS
    (
        INUPRODUCTID        IN  OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
        INUELEMENTID        IN  ELEMMEDI.ELMEIDEM%TYPE,
        INUCONSTYPE         IN  CONSSESU.COSSTCON%TYPE,
        INUCONSPERIOD       IN  CONSSESU.COSSPECS%TYPE,
        INUNEWELEMENTID     IN  ELEMMEDI.ELMEIDEM%TYPE
    )
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOItems.UpdCons',7);
        

        UPDATE CONSSESU
        SET    COSSELME = INUNEWELEMENTID
        WHERE  COSSSESU = INUPRODUCTID
        AND    COSSELME = INUELEMENTID
        AND    COSSTCON = INUCONSTYPE
        AND    COSSPECS = INUCONSPERIOD;
        
        UT_TRACE.TRACE('Finaliza GE_BOItems.UpdCons',7);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDCONS;


END GE_BOITEMS;