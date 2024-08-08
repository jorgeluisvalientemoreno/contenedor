CREATE OR REPLACE PACKAGE BODY GE_BCCONSULTAGARANTIAS IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO174421';
   CNUERROR_NETELEMENTS CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 51;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE CONSULTAGARANTIAITEMS( INUKEY IN GE_ITEM_WARRANTY.ITEM_WARRANTY_ID%TYPE, ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      NUPARENT NUMBER := NULL;
    BEGIN
      UT_TRACE.TRACE( 'INICIO - ge_bcConsultaGarantias.consultaGarantiaItems', 5 );
      OPEN ORFCURSOR FOR SELECT ge_item_warranty.item_warranty_id,
                   ge_items.items_id || ' - ' || ge_items.description items_id,
                   IF_BOElement.fsbGetElementTypeDesc(ge_item_warranty.element_id,0) element_type_id,
                   ge_item_warranty.element_code,
                   GE_BCItemWarranty.fsbGetSeriedDesc(ge_item_warranty.item_seried_id) id_items_seriado,
                   decode(ge_item_warranty.item_seried_id, null , null, dage_items_seriado.fsbgetserie(ge_item_warranty.item_seried_id, 0)) serie,
                   ge_item_warranty.order_id,
                   ge_item_warranty.final_warranty_date,
                   DECODE(ge_item_warranty.is_active,'Y','Si','No') is_active,
                   ge_item_warranty.product_id PARENT_ID
            FROM   ge_items, ge_item_warranty
            WHERE  ge_items.items_id = ge_item_warranty.item_id
            AND    ge_item_warranty.item_warranty_id = inuKey;
      UT_TRACE.TRACE( 'FIN - ge_bcConsultaGarantias.consultaGarantiaItems', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END CONSULTAGARANTIAITEMS;
   PROCEDURE BUSQUEDAGARANTIAITEMS( INUITEMWARRANTYID IN GE_ITEM_WARRANTY.ITEM_WARRANTY_ID%TYPE, INUITEMID IN GE_ITEMS.ITEMS_ID%TYPE, IDTFECHAINICIAL IN GE_ITEM_WARRANTY.FINAL_WARRANTY_DATE%TYPE, IDTFECHAFINAL IN GE_ITEM_WARRANTY.FINAL_WARRANTY_DATE%TYPE, ISBISACTIVE IN GE_ITEM_WARRANTY.IS_ACTIVE%TYPE, INUSERVICENUMBER IN GE_ITEM_WARRANTY.PRODUCT_ID%TYPE, INUELEMENTTYPE IN IF_ELEMENT_TYPE.ELEMENT_TYPE_ID%TYPE, ISBELEMENTCODE IN IF_NODE.CODE%TYPE, ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBSELECT GE_BOUTILITIES.STYSTATEMENT;
      SBATT GE_BOUTILITIES.STYSTATEMENT;
      SBFROM GE_BOUTILITIES.STYSTATEMENT;
      SBWHERE GE_BOUTILITIES.STYSTATEMENT;
    BEGIN
      UT_TRACE.TRACE( 'INICIO - ge_bcConsultaGarantias.busquedaGarantiaItems', 5 );
      IF ( INUITEMWARRANTYID IS NULL ) AND ( INUITEMID IS NULL ) AND ( INUSERVICENUMBER IS NULL ) AND ( INUELEMENTTYPE IS NULL ) AND ( ISBELEMENTCODE IS NULL ) THEN
         ERRORS.SETERROR( 2515 );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      IF ( ISBELEMENTCODE IS NOT NULL AND INUELEMENTTYPE IS NULL ) OR ( ISBELEMENTCODE IS NULL AND INUELEMENTTYPE IS NOT NULL ) THEN
         ERRORS.SETERROR( CNUERROR_NETELEMENTS );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      SBATT := 'SELECT ge_item_warranty.item_warranty_id, ' || CHR( 10 ) || '       ge_items.items_id || '' - '' || ge_items.description items_id, ' || CHR( 10 ) || '       IF_BOElement.fsbGetElementTypeDesc(ge_item_warranty.element_id,0) element_type_id, ' || CHR( 10 ) || '       ge_item_warranty.element_code, ' || CHR( 10 ) || '       ge_item_warranty.order_id, ' || CHR( 10 ) || '       ge_item_warranty.final_warranty_date, ' || CHR( 10 ) || '       DECODE(ge_item_warranty.is_active,''Y'',''Si'',''No'') is_active, ' || CHR( 10 ) || '       ge_item_warranty.product_id PARENT_ID ' || CHR( 10 );
      SBFROM := 'FROM   ge_items, ge_item_warranty';
      SBWHERE := CHR( 10 ) || 'WHERE  ge_items.items_id = ge_item_warranty.item_id ';
      IF ISBELEMENTCODE IS NOT NULL AND INUELEMENTTYPE IS NOT NULL THEN
         IF DAIF_ELEMENT_TYPE.FNUGETELEMENT_GROUP_ID( INUELEMENTTYPE ) = IF_BOCONSTANTS.CNUNODEELEMENT THEN
            SBFROM := SBFROM || ', IF_NODE ELEMENT';
          ELSE
            SBFROM := SBFROM || ', IF_ASSIGNABLE ELEMENT';
         END IF;
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  GE_ITEM_WARRANTY.ELEMENT_ID = ELEMENT.ID' || CHR( 10 ) || '  AND  ELEMENT.ELEMENT_TYPE_ID = ' || INUELEMENTTYPE || CHR( 10 ) || '  AND  ELEMENT.CODE = ' || CHR( 39 ) || ISBELEMENTCODE || CHR( 39 );
      END IF;
      IF ( INUSERVICENUMBER IS NOT NULL ) THEN
         SBFROM := SBFROM || ', PR_PRODUCT';
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.product_id = pr_product.product_id' || CHR( 10 ) || '  AND  pr_product.service_number = ' || INUSERVICENUMBER;
      END IF;
      IF ( INUITEMWARRANTYID IS NOT NULL ) THEN
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.item_warranty_id = ' || INUITEMWARRANTYID;
      END IF;
      IF ( INUITEMID IS NOT NULL ) THEN
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.item_id = ' || INUITEMID;
      END IF;
      IF ( IDTFECHAINICIAL IS NOT NULL ) THEN
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.final_warranty_date >= :FechaInicial ';
      END IF;
      IF ( IDTFECHAFINAL IS NOT NULL ) THEN
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.final_warranty_date <= :FechaFinal ';
      END IF;
      IF ( ISBISACTIVE IS NOT NULL ) THEN
         SBWHERE := SBWHERE || CHR( 10 ) || '  AND  ge_item_warranty.is_active = ' || CHR( 39 ) || ISBISACTIVE || CHR( 39 );
      END IF;
      SBSELECT := SBATT || SBFROM || SBWHERE;
      UT_TRACE.TRACE( 'sbSelect: ' );
      UT_TRACE.TRACE( SBSELECT );
      IF ( ( IDTFECHAINICIAL IS NOT NULL ) AND ( IDTFECHAFINAL IS NOT NULL ) ) THEN
         UT_TRACE.TRACE( '1' );
         OPEN ORFCURSOR
              FOR SBSELECT
              USING IN IDTFECHAINICIAL, IN IDTFECHAFINAL;
       ELSIF ( IDTFECHAINICIAL IS NOT NULL ) THEN
         UT_TRACE.TRACE( '2' );
         OPEN ORFCURSOR
              FOR SBSELECT
              USING IN IDTFECHAINICIAL;
       ELSIF ( IDTFECHAFINAL IS NOT NULL ) THEN
         UT_TRACE.TRACE( '3' );
         OPEN ORFCURSOR
              FOR SBSELECT
              USING IN IDTFECHAFINAL;
       ELSE
         UT_TRACE.TRACE( '4' );
         OPEN ORFCURSOR
              FOR SBSELECT;
      END IF;
      UT_TRACE.TRACE( 'FIN - ge_bcConsultaGarantias.busquedaGarantiaItems', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END BUSQUEDAGARANTIAITEMS;
   PROCEDURE GARANTIAITEMSPORPRODUCTO( INUPRODUCTID IN GE_ITEM_WARRANTY.PRODUCT_ID%TYPE, ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO - ge_bcConsultaGarantias.GarantiaItemsPorProducto', 5 );
      OPEN ORFCURSOR FOR SELECT /*+ INDEX (ge_item_warranty IDX_GE_ITEM_WARRANTY_02)*/
                   ge_item_warranty.item_warranty_id,
                   ge_items.items_id || ' - ' || ge_items.description items_id,
                   IF_BOElement.fsbGetElementTypeDesc(ge_item_warranty.element_id,0) element_type_id,
                   ge_item_warranty.element_code,
                   GE_BCItemWarranty.fsbGetSeriedDesc(ge_item_warranty.item_seried_id) id_items_seriado,
                   decode(ge_item_warranty.item_seried_id, null , null, dage_items_seriado.fsbgetserie(ge_item_warranty.item_seried_id, 0)) serie,
                   ge_item_warranty.order_id,
                   ge_item_warranty.final_warranty_date,
                   DECODE(ge_item_warranty.is_active,'Y','Si','No') is_active,
                   ge_item_warranty.product_id      PARENT_ID
            FROM   ge_items, ge_item_warranty
            WHERE  ge_items.items_id = ge_item_warranty.item_id
              AND  ge_item_warranty.product_id = inuProductId;
      UT_TRACE.TRACE( 'FIN - ge_bcConsultaGarantias.GarantiaItemsPorProducto', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GARANTIAITEMSPORPRODUCTO;
   PROCEDURE PRODUCTOPORGARANTIAITEMS( INUGARANTIAITEMID IN GE_ITEM_WARRANTY.ITEM_WARRANTY_ID%TYPE, ONUPRODUCTID OUT GE_ITEM_WARRANTY.PRODUCT_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO - ge_bcConsultaGarantias.ProductoPorGarantiaItems', 5 );
      ONUPRODUCTID := DAGE_ITEM_WARRANTY.FNUGETPRODUCT_ID( INUGARANTIAITEMID );
      UT_TRACE.TRACE( 'FIN - ge_bcConsultaGarantia.ProductoPorGarantiaItems', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END PRODUCTOPORGARANTIAITEMS;
END GE_BCCONSULTAGARANTIAS;
/


