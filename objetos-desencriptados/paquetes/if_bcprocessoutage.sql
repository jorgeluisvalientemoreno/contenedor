CREATE OR REPLACE PACKAGE BODY IF_BCPROCESSOUTAGE IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO189797';
   CNUERROR_147162 CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 147162;
   CNUERROR_901483 CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901483;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FSBGETTIME( IDTESTIMATEDATE IN TT_DAMAGE.ESTIMAT_ATTENT_DATE%TYPE )
    RETURN VARCHAR2
    IS
      NUNUMBERHOURS NUMBER;
      NUHOURS NUMBER;
      NUMINUTES NUMBER;
    BEGIN
      UT_TRACE.TRACE( 'Inicia IF_BCAdditionalData.fsbGetTime', 15 );
      IF ( ( IDTESTIMATEDATE IS NULL ) OR ( IDTESTIMATEDATE = UT_DATE.FDTMAXDATE ) ) THEN
         RETURN 'ILIMITADO';
      END IF;
      NUNUMBERHOURS := ( IDTESTIMATEDATE - SYSDATE ) * 24;
      NUHOURS := TRUNC( NUNUMBERHOURS );
      NUMINUTES := ABS( ROUND( ( NUNUMBERHOURS - NUHOURS ) * 60 ) );
      UT_TRACE.TRACE( 'Finaliza IF_BCAdditionalData.fsbGetTime [' || TO_CHAR( NUHOURS, '0000' ) || ':' || TO_CHAR( NUMINUTES, '00' ) || ']', 15 );
      IF ( IDTESTIMATEDATE < SYSDATE AND NUHOURS = 0 ) THEN
         RETURN '-' || LTRIM( RTRIM( TO_CHAR( NUHOURS, '0000' ) || ':' || TO_CHAR( NUMINUTES, '00' ) ) );
       ELSE
         RETURN LTRIM( RTRIM( TO_CHAR( NUHOURS, '0000' ) || ':' || TO_CHAR( NUMINUTES, '00' ) ) );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'Error : ex.CONTROLLED_ERROR', 15 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'Error : others', 15 );
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FSBGETTIME;
   PROCEDURE VALIDATEPRODUCT( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
      CURSOR CUGETOPENOUTAGE IS
SELECT /*+ leading(tt_damage_product)
                       use_nl(tt_damage_product mo_packages)
                       use_nl(mo_packages tt_damage) */
                   tt_damage.package_id,
                   tt_damage.element_id,
                   tt_damage.estimat_attent_date,
                   tt_damage.reg_damage_type_id
            FROM   tt_damage,
                   mo_packages
                   /* IF_BOProcessOutage.ValidateProduct SAO186582 */
            WHERE  tt_damage.package_id = mo_packages.package_id
              AND  mo_packages.motive_status_id NOT IN (tt_bcconstants.cnuTTAttenStatus,
                                                        tt_bcconstants.cnuTTUnfoundedStatus)
              AND  EXISTS (SELECT /*+ INDEX(tt_damage_product IDX_TT_DAMAGE_PRODUCT_02) */
                                  'X'
                           FROM   tt_damage_product
                           WHERE tt_damage_product.product_id = inuProductId
                             AND tt_damage_product.package_id = mo_packages.package_id
                             AND tt_damage_product.damage_produ_status = tt_bcconstants.csbOpenDamageStatus);
      SBCODE IF_NODE.CODE%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'Inicia IF_BCProcessOutage.ValidateProduct [' || INUPRODUCTID || ']', 15 );
      FOR RCROW IN CUGETOPENOUTAGE
       LOOP
         IF ( RCROW.REG_DAMAGE_TYPE_ID = TT_BCCONSTANTS.CNUCONTROL_FAULT_TYPE ) THEN
            SBCODE := DAIF_NODE.FSBGETCODE( RCROW.ELEMENT_ID );
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUERROR_147162, 'interrupción controlada|' || SBCODE || '|' || FSBGETTIME( RCROW.ESTIMAT_ATTENT_DATE ) );
          ELSIF ( RCROW.ELEMENT_ID IS NOT NULL ) THEN
            SBCODE := DAIF_NODE.FSBGETCODE( RCROW.ELEMENT_ID );
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUERROR_147162, 'falla|' || SBCODE || '|' || FSBGETTIME( RCROW.ESTIMAT_ATTENT_DATE ) );
          ELSE
            GE_BOERRORS.SETERRORCODEARGUMENT( CNUERROR_901483, 'interrupción de servicio|' || FSBGETTIME( RCROW.ESTIMAT_ATTENT_DATE ) );
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza IF_BCProcessOutage.ValidateProduct', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'Error : ex.CONTROLLED_ERROR', 15 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'Error : others', 15 );
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END VALIDATEPRODUCT;
   PROCEDURE GETOUTAGEOPENBYELEMENT( INUELEMENTID IN TT_DAMAGE.ELEMENT_ID%TYPE, OTBPACKAGES OUT DATT_DAMAGE.TYTBPACKAGE_ID )
    IS
      CURSOR CUOUTAGEOPENBYELEMENT IS
SELECT /*+ leading(tt_damage)
                       use_nl(tt_damage mo_packages) */
                   tt_damage.package_id
            FROM   tt_damage,
                   mo_packages
                   /* IF_BOProcessOutage.GetOutageOpenByElement SAO181853 */
            WHERE  tt_damage.package_id = mo_packages.package_id
              AND  tt_damage.reg_damage_type_id = TT_BCConstants.cnuCONTROL_FAULT_TYPE
              AND  mo_packages.motive_status_id NOT IN (tt_bcconstants.cnuTTAttenStatus,
                                                        tt_bcconstants.cnuTTUnfoundedStatus)
              AND  tt_damage.element_id = inuElementId;
      PROCEDURE CLOSECURSORS
       IS
       BEGIN
         IF ( CUOUTAGEOPENBYELEMENT%ISOPEN ) THEN
            CLOSE CUOUTAGEOPENBYELEMENT;
         END IF;
      END;
    BEGIN
      CLOSECURSORS;
      OPEN CUOUTAGEOPENBYELEMENT;
      FETCH CUOUTAGEOPENBYELEMENT
         BULK COLLECT INTO OTBPACKAGES;
      CLOSE CUOUTAGEOPENBYELEMENT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSORS;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSORS;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETOUTAGEOPENBYELEMENT;
END IF_BCPROCESSOUTAGE;
/


