
 PACKAGE cc_bcorga_area_seller
IS






















	

	

     












    CURSOR CUGETCHANNELCURRENT
    (
        INUPERSONID IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE
    )
    IS
        SELECT A.ORGANIZAT_AREA_ID
        FROM CC_ORGA_AREA_SELLER A
        WHERE A.PERSON_ID = INUPERSONID
            AND A.IS_CURRENT = GE_BOCONSTANTS.CSBYES;
            
    











    CURSOR CUGETORGAREASELLERID
    (
        INUPERSONID     IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        INUORGAREAID    IN  CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE
    )
    IS
        SELECT ORGA_AREA_SELLER_ID
        FROM CC_ORGA_AREA_SELLER
        WHERE PERSON_ID = INUPERSONID
        AND ORGANIZAT_AREA_ID = INUORGAREAID;

	
	
	



    FUNCTION FSBVERSION  RETURN VARCHAR2;
END CC_BCORGA_AREA_SELLER;

PACKAGE BODY cc_bcorga_area_seller
IS
	

    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO203600';

	
	
	
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

END CC_BCORGA_AREA_SELLER;