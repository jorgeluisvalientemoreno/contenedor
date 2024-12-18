CREATE OR REPLACE PACKAGE adm_person.ldc_boUbiGeografica IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    ****************************************************************/    

    FUNCTION FSBVERSION  RETURN VARCHAR2;

    FUNCTION FSBSECTOROPERATIVO( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2;

    FUNCTION FSBCICLE( INUCICLO IN NUMBER )
    RETURN VARCHAR2;

   FUNCTION FSBROUTE( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2;

   FUNCTION FSBCONTACTADDRESSPARSED( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2;

   FUNCTION FSBCONTACTNEIGHBOR( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2;


   FUNCTION FSBCHARGESTATE( INUDCCODEBC IN NUMBER )
    RETURN VARCHAR2;

   FUNCTION FSBCHARGECITY( INUDCCOLOBC IN NUMBER )
    RETURN VARCHAR2;

   FUNCTION FSBCHARGENEIGHBORTHOOD( INDCCOBADC IN NUMBER )
    RETURN VARCHAR2;

  procedure datoscontrato (inusubscription  number,
    inuciclo out number, inudir out number, isbdir out varchar2, inubarrio out number);


  PROCEDURE getUbiGeoInfo(inusubscription in suscripc.susccodi%type,
                         ocuQuotaInfo    out constants.tyrefcursor);

END ldc_boUbiGeografica;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_boUbiGeografica IS


    CSBVERSION CONSTANT VARCHAR2(250) := 'CA200192';

    SBSUBSCRIPTIONSQL           VARCHAR2(8000);

    --TBSUBSCRIPTIONATTRIBUTES    CC_TYTBATTRIBUTE;

    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    FUNCTION FSBSECTOROPERATIVO( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2
    IS
      SECTOROPERATIVO   VARCHAR2(115);
    BEGIN

      SELECT O.OPERATING_SECTOR_ID||' - '||O.DESCRIPTION INTO SECTOROPERATIVO
        FROM AB_SEGMENTS B, AB_ADDRESS A, OR_OPERATING_SECTOR O, SUSCRIPC S
       WHERE B.SEGMENTS_ID = A.SEGMENT_ID
         AND B.OPERATING_SECTOR_ID = O.OPERATING_SECTOR_ID
         AND A.ADDRESS_ID = S.SUSCIDDI
         AND S.SUSCCODI = INUSUBSCRIPTION;

      RETURN ( SECTOROPERATIVO );

    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
    END FSBSECTOROPERATIVO;

   FUNCTION FSBCICLE( INUCICLO IN NUMBER )
    RETURN VARCHAR2
    IS
      sbCiclo   varchar2(35);
    BEGIN
      SELECT ciclcodi ||' - '||ciclo.cicldesc into sbCiclo
        FROM CICLO
        WHERE ciclcodi = INUCICLO;

      RETURN ( sbCiclo );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;

   FUNCTION FSBROUTE( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2
    IS
      NUADDRESS_ID SUSCRIPC.SUSCIDDI%TYPE;
      NUSEGMENTID AB_ADDRESS.SEGMENT_ID%TYPE;
    BEGIN
      NUADDRESS_ID := PKTBLSUSCRIPC.FNUGETADDRESS_ID( INUSUBSCRIPTION );
      NUSEGMENTID := DAAB_ADDRESS.FNUGETSEGMENT_ID( NUADDRESS_ID, 0 );
      RETURN TO_CHAR( DAAB_SEGMENTS.FNUGETROUTE_ID( NUSEGMENTID, 0 ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;


   FUNCTION FSBCONTACTADDRESSPARSED( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2
    IS
      NUADDRESSID SUSCRIPC.SUSCIDDI%TYPE;
      SBADDRESSPARSED AB_ADDRESS.ADDRESS_PARSED%TYPE;
    BEGIN
      UT_TRACE.TRACE( ' Inicia cc_boossSubscription.fsbContactAddressParsed ', 5 );
      IF INUSUBSCRIPTION IS NULL THEN
         RETURN NULL;
      END IF;
      NUADDRESSID := PKTBLSUSCRIPC.FNUGETADDRESS_ID( INUSUBSCRIPTION );
      IF NUADDRESSID IS NULL THEN
         RETURN NULL;
      END IF;
      SBADDRESSPARSED := DAAB_ADDRESS.FSBGETADDRESS_PARSED( NUADDRESSID );
      UT_TRACE.TRACE( 'Contrato ' || INUSUBSCRIPTION || ' Direccion Parseada: ' || SBADDRESSPARSED, 5 );
      RETURN SBADDRESSPARSED;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;


   FUNCTION FSBCONTACTNEIGHBOR( INUSUBSCRIPTION IN NUMBER )
    RETURN VARCHAR2
    IS
      NUADDRESSID SUSCRIPC.SUSCIDDI%TYPE;
      NUNEIGHBORHOOD AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE;
      SBNEIGHBORHOOD VARCHAR2( 200 );
    BEGIN
      IF INUSUBSCRIPTION IS NULL THEN
         RETURN NULL;
      END IF;
      NUADDRESSID := PKTBLSUSCRIPC.FNUGETADDRESS_ID( INUSUBSCRIPTION );
      IF NUADDRESSID IS NULL THEN
         RETURN NULL;
      END IF;
      NUNEIGHBORHOOD := DAAB_ADDRESS.FNUGETNEIGHBORTHOOD_ID( NUADDRESSID );
      SBNEIGHBORHOOD := NUNEIGHBORHOOD || ' - ' || CC_BOOSSDESCRIPTION.FSBNEIGHBORTHOOD( NUNEIGHBORHOOD );
      RETURN SBNEIGHBORHOOD;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;



   FUNCTION FSBCHARGESTATE( INUDCCODEBC IN NUMBER )
    RETURN VARCHAR2
    IS
    BEGIN
      IF ( INUDCCODEBC IS NULL ) THEN
         RETURN NULL;
      END IF;
      RETURN ( DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION( INUDCCODEBC ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;


   FUNCTION FSBCHARGECITY( INUDCCOLOBC IN NUMBER )
    RETURN VARCHAR2
    IS
    BEGIN
      IF ( INUDCCOLOBC IS NULL ) THEN
         RETURN NULL;
      END IF;
      RETURN ( DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION( INUDCCOLOBC ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;



   FUNCTION FSBCHARGENEIGHBORTHOOD( INDCCOBADC IN NUMBER )
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN ( CC_BOOSSDESCRIPTION.FSBNEIGHBORTHOOD( INDCCOBADC ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;

  procedure datoscontrato (inusubscription  number,
    inuciclo out number, inudir out number, isbdir out varchar2, inubarrio out number)
  is
  begin

      select susccicl, susciddi, ab_address.address, ab_address.neighborthood_id
        into inuciclo, inudir, isbdir, inubarrio
        from suscripc, ab_address
       where suscripc.susccodi = inusubscription
         and suscripc.susciddi = ab_address.address_id;
    exception when others then
       inuciclo := null;
       inudir := null;
       isbdir := null;
       inubarrio := null;
  end datoscontrato;

  PROCEDURE getUbiGeoInfo(inusubscription in suscripc.susccodi%type,
                         ocuQuotaInfo    out constants.tyrefcursor) is

        sbQuery         varchar2(32000);
        sbSelect        varchar2(3200);
        sbFrom          varchar2(3200);
        SBCICLE               VARCHAR2(300):= '''Ninguna''';
        SBCHARGENEIGHBORTHOOD VARCHAR2(300):= '''Ninguna''';
        SBCHARGECITY          VARCHAR2(300):= '''Ninguna''';
        SBCHARGESTATE         VARCHAR2(300):= '''Ninguna''';
        SBSECTOROPERATIVO     VARCHAR2(500):= '''Ninguna''';
        SBRUTA                VARCHAR2(500):= '''Ninguna''';
        SBDIRECCIONCONTACTO   VARCHAR2(500):= '''Ninguna''';
        SBBARRIOCONTACTO      VARCHAR2(500):= '''Ninguna''';
        SBDIRECCIONCOBRO      VARCHAR2(500):= '''Ninguna''';
        nuciclo               number;
        nudir                 number;
        sbdir                 varchar2(300):= '''Ninguna''';
        nubarrio              number;

  BEGIN

    datoscontrato (inusubscription, nuciclo, nudir, sbdir, nubarrio);

    begin
        SBCICLE               := ldc_boUbiGeografica.fsbCicle (nuciclo);
        SBCICLE               :=  ''''||SBCICLE||'''';
    exception when others then
        SBCICLE := '''Ninguno''';
    end;

    begin
        SBSECTOROPERATIVO     := ldc_boUbiGeografica.FSBSECTOROPERATIVO(inusubscription);
        SBSECTOROPERATIVO     :=  ''''||SBSECTOROPERATIVO||'''';
    exception when others then
        SBSECTOROPERATIVO := '''Ninguno''';
    end;

    begin
        SBRUTA                := ldc_boUbiGeografica.fsbRoute (inusubscription);
        SBRUTA                :=  ''''||SBRUTA||'''';
    exception when others then
        SBRUTA := '''Ninguna''';
    end;

    begin
        SBDIRECCIONCONTACTO   := DAAB_ADDRESS.FSBGETADDRESS_PARSED( PKTBLSUSCRIPC.FNUGETADDRESS_ID(inusubscription) );
        SBDIRECCIONCONTACTO   :=  ''''||SBDIRECCIONCONTACTO||'''';
    exception when others then
        SBDIRECCIONCONTACTO := '''Ninguna''';
    end;

    begin
		    SBBARRIOCONTACTO      := ldc_boUbiGeografica.fsbContactNeighbor(inusubscription);
        SBBARRIOCONTACTO      :=  ''''||SBBARRIOCONTACTO||'''';
    exception when others then
        SBBARRIOCONTACTO := '''Ninguno''';
    end;

    begin
        SBDIRECCIONCOBRO      := sbdir;
        SBDIRECCIONCOBRO      :=  ''''||SBDIRECCIONCOBRO||'''';
    exception when others then
        SBDIRECCIONCOBRO := '''Ninguna''';
    end;

    begin
        SBCHARGENEIGHBORTHOOD := nubarrio||' - '|| ldc_boUbiGeografica.fsbChargeNeighborthood (nubarrio);
        SBCHARGENEIGHBORTHOOD :=  ''''||SBCHARGENEIGHBORTHOOD||'''';
    exception when others then
        SBCHARGENEIGHBORTHOOD := '''Ninguno''';
    end;

    begin
        SBCHARGECITY          := pkBCSubscription.fnuGetContractTown(inusubscription) ||' - '|| ldc_boUbiGeografica.FSBCHARGECITY(pkBCSubscription.fnuGetContractTown(inusubscription));
        SBCHARGECITY          :=  ''''||SBCHARGECITY||'''';
    exception when others then
        SBCHARGECITY := '''Ninguna''';
    end;

    begin
        SBCHARGESTATE         := pkBCSubscription.fnuGetContractState(inusubscription) ||' - '|| ldc_boUbiGeografica.FSBCHARGECITY(pkBCSubscription.fnuGetContractState(inusubscription));
        SBCHARGESTATE         :=  ''''||SBCHARGESTATE||'''';
    exception when others then
        SBCHARGESTATE := '''Ninguno''';
    end;

    sbSelect := 'select ' || SBCICLE || ' ciclo,' ||
                SBSECTOROPERATIVO || ' sector_operativo,' ||
                SBRUTA || ' ruta,' ||
                SBDIRECCIONCONTACTO || ' direccion_contacto,' ||
                SBBARRIOCONTACTO || ' barrio_contacto,' ||
                SBDIRECCIONCOBRO || ' direccion_cobro,' ||
                SBCHARGENEIGHBORTHOOD || ' barrio_cobro,' ||
                SBCHARGECITY || ' ciudad_cobro,' ||
                SBCHARGESTATE || ' departamento_cobro,' ||
                nvl(inusubscription, 1.1) || ' parent_id ';
    ut_trace.trace('Cadena de seleccion: ' || chr(10) || sbSelect, 10);

    sbFrom := ' from DUAL WHERE ' || nvl(inusubscription, 1.1) || ' != 1.1';
    ut_trace.trace('Cadena de producto cartesiano: ' || chr(10) || sbFrom,
                   10);

    sbQuery := sbSelect || sbFrom;
    ut_trace.trace(sbQuery, 10);

    dbms_output.put_line(sbQuery);

    OPEN ocuQuotaInfo FOR sbQuery;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getUbiGeoInfo;




BEGIN
    SBSUBSCRIPTIONSQL := NULL;
END ldc_boUbiGeografica;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOUBIGEOGRAFICA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOUBIGEOGRAFICA', 'ADM_PERSON');
END;
/