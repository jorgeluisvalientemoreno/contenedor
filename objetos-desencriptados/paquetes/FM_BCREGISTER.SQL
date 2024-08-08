
CREATE OR REPLACE PACKAGE BODY FM_BCREGISTER IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO180483';
   FUNCTION FNUPENDNTLBYPROD( INUPRODUCTID IN FM_POSSIBLE_NTL.PRODUCT_ID%TYPE )
    RETURN FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE
    IS
      NUID FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
    BEGIN
      SELECT possible_ntl_id INTO nuId
        FROM fm_possible_ntl
        WHERE product_id = inuProductId AND
              status in (fm_boconstants.csbPendingNTLStatus,
                         fm_boconstants.csbProjectNTLStatus) AND
              rownum = 1;
      RETURN NUID;
    EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
   END;
   FUNCTION FNUPENDNTLBYADDR( INUADDRESSID IN FM_POSSIBLE_NTL.ADDRESS_ID%TYPE, INUPRODUCTTYPE IN FM_POSSIBLE_NTL.PRODUCT_TYPE_ID%TYPE )
    RETURN FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE
    IS
      NUID FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
    BEGIN
      SELECT possible_ntl_id INTO nuId
        FROM fm_possible_ntl
        WHERE address_id = inuAddressId AND
              product_type_id = inuProductType AND
              status in (fm_boconstants.csbPendingNTLStatus,
                         fm_boconstants.csbProjectNTLStatus) AND
              rownum = 1;
      RETURN NUID;
    EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
   END;
   FUNCTION FNUPENDNTLBYGEOLOC( INUGEOGRAPHLOC IN FM_POSSIBLE_NTL.GEOGRAP_LOCATION_ID%TYPE, INUPRODUCTTYPE IN FM_POSSIBLE_NTL.PRODUCT_TYPE_ID%TYPE )
    RETURN FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE
    IS
      NUID FM_POSSIBLE_NTL.POSSIBLE_NTL_ID%TYPE;
    BEGIN
      SELECT possible_ntl_id INTO nuId
        FROM fm_possible_ntl
        WHERE geograp_location_id = inuGeographLoc AND
              product_type_id = inuProductType AND
              status in (fm_boconstants.csbPendingNTLStatus,
                         fm_boconstants.csbProjectNTLStatus) AND
              rownum = 1;
      RETURN NUID;
    EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
   END;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
END FM_BCREGISTER;
/


