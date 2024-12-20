CREATE OR REPLACE PACKAGE adm_person.cc_boclaiminstancedata_pna
AS
    /*****************************************************************
    Propiedad intelectual de Gases de occidente.

    Nombre del Paquete: CC_BOCLAIMINSTANCEDATA_PNA
    Descripción: Para poder tomar el numero de factura dada una solicitud de reclamo.

    Autor  : Ing.Francisco José Romero Romero, Ludycom S.A.
    Fecha  : 15-10-2015 (Fecha Creación Paquete)  No Aranda 7492

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.        Modificación
    -----------  -------------------    -------------------------------------
    18/06/2024   Adrianavg       OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
    ******************************************************************/

    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    PROCEDURE LOADCLAIMDATA( INUPACKAGEID MO_PACKAGES.PACKAGE_ID%TYPE );

    FUNCTION FNUGETCLAIMEDVALUE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) RETURN NUMBER;

    FUNCTION FNUGETCLAIMEDBILL( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) RETURN FACTURA.FACTCODI%TYPE;

    FUNCTION FNUGETCLAIMEDBILLPREFI( INUPACKAGEID MO_PACKAGES.PACKAGE_ID%TYPE ) RETURN FACTURA.FACTPREF%TYPE;

    FUNCTION FNUGETCLAIMEDBILLFISCN( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) RETURN FACTURA.FACTNUFI%TYPE;

END CC_BOCLAIMINSTANCEDATA_PNA;
/
CREATE OR REPLACE PACKAGE BODY adm_person.CC_BOCLAIMINSTANCEDATA_PNA IS
   CURSOR CUCLAIMDATA( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE ) IS
SELECT  /*+ index(mo_motive, IDX_MO_MOTIVE_02) index(pagonoab, IX_PAGONOAB11)
                index(cuencobr, pk_cuencobr) index(factura, pk_factura) */
            --sum (decode (catrsign, 'CR', catrvare * -1, catrvare)) claimed_value,
            0 claimed_value,
            factcodi bill_number,
            factpref prefix,
            factnufi fiscal_number
    from    mo_motive, pagonoab, cuencobr, factura   /*+ CC_BOCLAIMINSTANCEDATA_PNA.cuClaimData */
    where   package_id = inuPackageId
    and     motive_id = panamoti
    and     panacuco = cucocodi
    and     cucofact = factcodi
    group by factcodi, factpref, factnufi, factsusc;
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO188999';
   GNUPACKAGEID MO_PACKAGES.PACKAGE_ID%TYPE;
   GRCCLAIMDATA CUCLAIMDATA%ROWTYPE;
   GRCCLAIMDATAEMPTY CUCLAIMDATA%ROWTYPE;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
   PROCEDURE LOADCLAIMDATA( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio [CC_BOCLAIMINSTANCEDATA_PNA.LoadClaimData]', 1 );
      IF ( GNUPACKAGEID = INUPACKAGEID ) THEN
         UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.LoadClaimData]. Claim data already loaded.', 1 );
         RETURN;
      END IF;
      IF ( CUCLAIMDATA%ISOPEN ) THEN
         CLOSE CUCLAIMDATA;
      END IF;
      GRCCLAIMDATA := GRCCLAIMDATAEMPTY;
      OPEN CUCLAIMDATA( INUPACKAGEID );
      FETCH CUCLAIMDATA
         INTO GRCCLAIMDATA;
      CLOSE CUCLAIMDATA;
      GNUPACKAGEID := INUPACKAGEID;
      UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.LoadClaimData]', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR [CC_BOCLAIMINSTANCEDATA_PNA.LoadClaimData]', 1 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( 'OTHERS [CC_BOCLAIMINSTANCEDATA_PNA.LoadClaimData]', 1 );
         RAISE EX.CONTROLLED_ERROR;
   END LOADCLAIMDATA;
   FUNCTION FNUGETCLAIMEDVALUE( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN NUMBER
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedValue]', 1 );
      LOADCLAIMDATA( INUPACKAGEID );
      UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedValue]', 1 );
      RETURN GRCCLAIMDATA.CLAIMED_VALUE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedValue]', 1 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( 'OTHERS [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedValue]', 1 );
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETCLAIMEDVALUE;
   FUNCTION FNUGETCLAIMEDBILL( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN FACTURA.FACTCODI%TYPE
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBill]', 1 );
      LOADCLAIMDATA( INUPACKAGEID );
      UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBill]', 1 );
      RETURN GRCCLAIMDATA.BILL_NUMBER;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBill]', 1 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( 'OTHERS [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBill]', 1 );
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETCLAIMEDBILL;
   FUNCTION FNUGETCLAIMEDBILLPREFI( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN FACTURA.FACTPREF%TYPE
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillPrefi]', 1 );
      LOADCLAIMDATA( INUPACKAGEID );
      UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillPrefi]', 1 );
      RETURN GRCCLAIMDATA.PREFIX;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillPrefi]', 1 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( 'OTHERS [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillPrefi]', 1 );
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETCLAIMEDBILLPREFI;
   FUNCTION FNUGETCLAIMEDBILLFISCN( INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN FACTURA.FACTNUFI%TYPE
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillFiscN]', 1 );
      LOADCLAIMDATA( INUPACKAGEID );
      UT_TRACE.TRACE( 'Fin [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillFiscN]', 1 );
      RETURN GRCCLAIMDATA.FISCAL_NUMBER;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'ex.CONTROLLED_ERROR [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillFiscN]', 1 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( 'OTHERS [CC_BOCLAIMINSTANCEDATA_PNA.fnuGetClaimedBillFiscN]', 1 );
         RAISE EX.CONTROLLED_ERROR;
   END FNUGETCLAIMEDBILLFISCN;
END CC_BOCLAIMINSTANCEDATA_PNA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre CC_BOCLAIMINSTANCEDATA_PNA
BEGIN
    pkg_utilidades.prAplicarPermisos('CC_BOCLAIMINSTANCEDATA_PNA', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre CC_BOCLAIMINSTANCEDATA_PNA
GRANT EXECUTE ON ADM_PERSON.CC_BOCLAIMINSTANCEDATA_PNA TO REXEREPORTES;
/ 