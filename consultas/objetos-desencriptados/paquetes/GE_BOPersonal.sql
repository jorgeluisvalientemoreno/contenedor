PACKAGE GE_BOPersonal AS









































    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2;

    FUNCTION VALIDIDENTIFICATION
    (ISBNUMBER_ID       IN  GE_PERSON.NUMBER_ID%TYPE,
     INUIDENT_TYPE_ID   IN  GE_PERSON.IDENT_TYPE_ID%TYPE,
     ONUPERSONAL_ID     OUT GE_PERSON.PERSON_ID%TYPE
    ) RETURN BOOLEAN;
    
    

























    FUNCTION FRFGETPERSONALFROMORGAAREA
    (
        INUORGAAREAID IN GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID%TYPE,
        ISBRECURSIVE  IN VARCHAR2 DEFAULT 'N'
    )
    RETURN CONSTANTS.TYREFCURSOR;
    
    





















    FUNCTION FRFGETPERSONALRECORD
    (
        INUPERSONID IN GE_PERSON.PERSON_ID%TYPE DEFAULT NULL
    )
    RETURN CONSTANTS.TYREFCURSOR;

    

















    FUNCTION FNUGETPERSONID RETURN NUMBER;

    

























    PROCEDURE REGISTER
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUPERSONALTYPE         IN GE_PERSON.PERSONAL_TYPE%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        IONUPERSONID            IN OUT GE_PERSON.PERSON_ID%TYPE
    );


    
























    PROCEDURE TECHNICALCONTACTREGISTER
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        IONUPERSONID            IN OUT GE_PERSON.PERSON_ID%TYPE
    );
    



























    FUNCTION VALIDCONTACTIDENTIFICATION
    (
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        OSBNAME                 OUT GE_PERSON.NAME_%TYPE,
        ONUADDRESS_ID           OUT GE_PERSON.ADDRESS_ID%TYPE,
        OSBADDRESS              OUT AB_ADDRESS.ADDRESS_PARSED%TYPE,
        OSBPHONENUMBER          OUT GE_PERSON.PHONE_NUMBER%TYPE,
        OSBEMAIL                OUT GE_PERSON.E_MAIL%TYPE,
        OSBBEEPER               OUT GE_PERSON.BEEPER%TYPE,
        ONUORGANIZATAREAID      OUT GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        ONUGEOGRAPLOCATIONID    OUT GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        ONUPERSONID             OUT GE_PERSON.PERSON_ID%TYPE
    ) RETURN BOOLEAN;

    




    PROCEDURE GETCURRENTCHANNEL
    (
        INUPERSONID IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        ONUCHANNEL  OUT CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE
    );

    



    PROCEDURE GETMAINOPERATINGUNIT
    (
        INUPERSONID             IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        ONUMAINOPERUNITID       OUT OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        ONUMAINOPERUNITNAME     OUT OR_OPERATING_UNIT.NAME%TYPE
    );

    



    FUNCTION FNUGETCURRENTCHANNEL
    (
        INUPERSONID     IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        IBORAISEERROR   IN  BOOLEAN DEFAULT TRUE
    )
    RETURN CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;
    
    



    PROCEDURE GETBANKSUCUCODES
    (
        INUPERSONID   IN  GE_PERSON.PERSON_ID%TYPE,
        ONUBANK       OUT GE_PERSON.BANK_ID%TYPE,
        ONUSUCUBANK   OUT GE_PERSON.BRANCH_ID%TYPE
    );
    
    



    PROCEDURE GETCURRENTPERSANDCHANN
    (
        ONUEMPLOYEEID           OUT    GE_PERSON.PERSON_ID%TYPE,
        OSBEMPLOYEENAME         OUT    GE_PERSON.NAME_%TYPE,
        ONUORGANIZATAREAID      OUT    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE,
        OSBORGANIZATAREADESC    OUT    GE_ORGANIZAT_AREA.DISPLAY_DESCRIPTION%TYPE
    );
    



    FUNCTION FSBGETPERSONNAME
    (
        INUPERSONID IN GE_PERSON.PERSON_ID%TYPE
    )
    RETURN VARCHAR;

    




    PROCEDURE GETPERSONSLOV
    (
        INUPERSONTYPEID     IN  GE_PERSON.PERSONAL_TYPE%TYPE,
        INUPERSONID         IN  GE_PERSON.PERSON_ID%TYPE,
        ISBPERSONNAME       IN  GE_PERSON.NAME_%TYPE,
        ORFREFCURSOR        OUT CONSTANTS.TYREFCURSOR
    );
    
    
END GE_BOPERSONAL;

PACKAGE BODY GE_BOPersonal AS









































    
    
    
    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO221668';
    
    CNUNAMEISNULL           CONSTANT NUMBER := 117360;
    
    CNUIDENTIFICATIONEXIST  CONSTANT NUMBER := 117361;
    
    CNUIDENTIFICATIONNULL   CONSTANT NUMBER := 4065;
    
    CNUUNIT_IS_NO_POS       CONSTANT NUMBER := 901770;
     
    CNUNO_CURRENT_POS       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902094;
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;


    FUNCTION VALIDIDENTIFICATION
    (
        ISBNUMBER_ID     IN  GE_PERSON.NUMBER_ID%TYPE,
        INUIDENT_TYPE_ID IN  GE_PERSON.IDENT_TYPE_ID%TYPE,
        ONUPERSONAL_ID   OUT GE_PERSON.PERSON_ID%TYPE
    )
    RETURN BOOLEAN
    IS
        BLEXISTE BOOLEAN := FALSE;
        CURSOR CUIDENTIFICATION
             (ISBNUMBER_ID GE_PERSON.NUMBER_ID%TYPE,
             INUIDENT_TYPE_ID GE_PERSON.IDENT_TYPE_ID%TYPE
             ) IS
            SELECT PERSON_ID
            FROM GE_PERSON
            WHERE NUMBER_ID = ISBNUMBER_ID
            AND   IDENT_TYPE_ID = INUIDENT_TYPE_ID;
    BEGIN
        OPEN CUIDENTIFICATION(ISBNUMBER_ID,INUIDENT_TYPE_ID);
        FETCH CUIDENTIFICATION INTO ONUPERSONAL_ID;
        CLOSE CUIDENTIFICATION;
        IF ONUPERSONAL_ID IS NOT NULL THEN
            BLEXISTE := TRUE;
        END IF;
        RETURN BLEXISTE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUIDENTIFICATION%ISOPEN THEN
                CLOSE CUIDENTIFICATION;
            END IF;
            RAISE;

        WHEN OTHERS THEN
            IF CUIDENTIFICATION%ISOPEN THEN
                CLOSE CUIDENTIFICATION;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
    FUNCTION FRFGETPERSONALRECORD
    (
        INUPERSONID IN GE_PERSON.PERSON_ID%TYPE DEFAULT NULL
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        
        
        
        RFCURSOR CONSTANTS.TYREFCURSOR;
        SBSQL    VARCHAR2(2000);
    BEGIN
        SBSQL := ' SELECT a.*, a.rowid ' ||
                 ' FROM   Ge_Person a ';
        IF (INUPERSONID IS NULL) THEN
            OPEN RFCURSOR FOR SBSQL;
            RETURN RFCURSOR;
        END IF;
        SBSQL := SBSQL || ' WHERE a.PERSON_ID = :inuPersonId';
        OPEN RFCURSOR FOR SBSQL USING IN INUPERSONID;
        RETURN RFCURSOR;
    EXCEPTION
        WHEN OTHERS THEN
            IF (RFCURSOR%ISOPEN) THEN
                CLOSE RFCURSOR;
            END IF;
    END FRFGETPERSONALRECORD;
    
    
    FUNCTION FRFGETPERSONALFROMORGAAREA
    (
        INUORGAAREAID IN GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID%TYPE,
        ISBRECURSIVE  IN VARCHAR2 DEFAULT 'N'
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        
        
        
        RFPERSONCURSOR   CONSTANTS.TYREFCURSOR;
        RFORGAAREACURSOR DAGE_ORGANIZAT_AREA.TYREFCURSOR;
        RCORGAAREA       DAGE_ORGANIZAT_AREA.STYGE_ORGANIZAT_AREA;
        SBSQL            VARCHAR2(4000) := NULL;
        SBORGAAREAS      VARCHAR2(4000) := NULL;
    BEGIN
        
        
        IF (ISBRECURSIVE = 'N') THEN
            OPEN RFPERSONCURSOR FOR SELECT A.*, A.ROWID
                                    FROM   GE_PERSON A
                                    WHERE  ORGANIZAT_AREA_ID = INUORGAAREAID;
            RETURN RFPERSONCURSOR;
        END IF;
        
        
        
        RFORGAAREACURSOR := GE_BOORGANIZAT_AREA.FRFGETALLCHILDREN(INUORGAAREAID);
        FETCH RFORGAAREACURSOR INTO RCORGAAREA;
        WHILE (RFORGAAREACURSOR%FOUND) LOOP
            SBORGAAREAS := SBORGAAREAS || RCORGAAREA.ORGANIZAT_AREA_ID || ',';
            FETCH RFORGAAREACURSOR INTO RCORGAAREA;
        END LOOP;
        
        SBORGAAREAS := SUBSTR(SBORGAAREAS, 0, LENGTH(SBORGAAREAS)-1);
        
        
        SBSQL := ' SELECT a.*, a.rowid '||
                 ' FROM   Ge_Person a ' ||
                 ' WHERE  Organizat_Area_Id in ('||SBORGAAREAS||') ';
        OPEN RFPERSONCURSOR FOR SBSQL;
        RETURN RFPERSONCURSOR;
    EXCEPTION
        WHEN OTHERS THEN
            IF (RFPERSONCURSOR%ISOPEN) THEN
               CLOSE RFPERSONCURSOR;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FRFGETPERSONALFROMORGAAREA;

    FUNCTION FNUGETPERSONID
    RETURN NUMBER
    IS
        SBUSERMASK    SA_USER.MASK%TYPE;
        NUUSERID      SA_USER.USER_ID%TYPE;
        NUPERSON_ID   GE_PERSON.PERSON_ID%TYPE;
    BEGIN

        SBUSERMASK  := UT_SESSION.GETUSER;

        NUUSERID    := SA_BOUSER.FNUGETUSERID(SBUSERMASK);

        NUPERSON_ID := GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID(NUUSERID);

        RETURN NUPERSON_ID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETPERSONID;
    PROCEDURE SETPERSONRC
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUPERSONALTYPE         IN GE_PERSON.PERSONAL_TYPE%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        INUPERSONID             IN GE_PERSON.PERSON_ID%TYPE,
        IORCPERSON    IN OUT NOCOPY DAGE_PERSON.STYGE_PERSON
    )
    IS

    BEGIN
        IORCPERSON.NAME_ := ISBNAME;
        IORCPERSON.NUMBER_ID := ISBNUMBERID;
        IORCPERSON.IDENT_TYPE_ID := INUIDENTTYPEID;
        IORCPERSON.ADDRESS_ID := INUADDRESS;
        IORCPERSON.PHONE_NUMBER := ISBPHONENUMBER;
        IORCPERSON.E_MAIL := ISBEMAIL;
        IORCPERSON.BEEPER := ISBBEEPER;
        IORCPERSON.PERSONAL_TYPE := INUPERSONALTYPE;
        IORCPERSON.ORGANIZAT_AREA_ID := INUORGANIZATAREAID;
        IORCPERSON.GEOGRAP_LOCATION_ID := INUGEOGRAPLOCATIONID;
        IORCPERSON.USER_ID := INUUSERID;
        IORCPERSON.PERSON_ID := INUPERSONID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETPERSONRC;

    PROCEDURE UPDATERECORD
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        INUPERSONID             IN GE_PERSON.PERSON_ID%TYPE
    )
    IS
      RCPERSON    DAGE_PERSON.STYGE_PERSON;
    BEGIN
        DAGE_PERSON.LOCKBYPK(INUPERSONID, RCPERSON);
        
        SETPERSONRC
        (
            ISBNAME,
            ISBNUMBERID,
            INUIDENTTYPEID,
            INUADDRESS,
            ISBPHONENUMBER,
            ISBEMAIL,
            ISBBEEPER,
            RCPERSON.PERSONAL_TYPE,
            INUORGANIZATAREAID,
            INUGEOGRAPLOCATIONID,
            INUUSERID,
            INUPERSONID,
            RCPERSON
        );
        
        DAGE_PERSON.UPDRECORD(RCPERSON);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDATERECORD;



    PROCEDURE REGISTER
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUPERSONALTYPE         IN GE_PERSON.PERSONAL_TYPE%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        IONUPERSONID            IN OUT GE_PERSON.PERSON_ID%TYPE
    )
    IS
        RCPERSON    DAGE_PERSON.STYGE_PERSON;
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOPersonal.Register. Nombre:['||ISBNAME||']Tipo Per['||INUPERSONALTYPE||']',15);
        UT_TRACE.TRACE('Ident:['||ISBNUMBERID||']Tipo:['||INUIDENTTYPEID||']Dir:['||INUADDRESS||']Tel:['||ISBPHONENUMBER||']',16);
        
        IF (ISBNAME IS NULL) THEN
            ERRORS.SETERROR(CNUNAMEISNULL);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        IF (ISBNUMBERID IS NULL) THEN
            ERRORS.SETERROR(CNUIDENTIFICATIONNULL);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        DAGE_PERSONAL_TYPE.ACCKEY(INUPERSONALTYPE);

        
        DAGE_IDENTIFICA_TYPE.ACCKEY(INUIDENTTYPEID);

        
        IF (INUGEOGRAPLOCATIONID IS NOT NULL) THEN
            DAGE_GEOGRA_LOCATION.ACCKEY(INUGEOGRAPLOCATIONID);
        END IF;

        
        IF (INUUSERID IS NOT NULL) THEN
            DASA_USER.ACCKEY(INUUSERID);
        END IF;

        
        IF (INUORGANIZATAREAID IS NOT NULL) THEN
            DAGE_ORGANIZAT_AREA.ACCKEY(INUORGANIZATAREAID);
        END IF;

        
        FOR REC IN GE_BCPERSON.CUPERSONBYIDENT(ISBNUMBERID, INUIDENTTYPEID) LOOP
            ERRORS.SETERROR (CNUIDENTIFICATIONEXIST, TO_CHAR(ISBNUMBERID) || '|' || TO_CHAR(INUIDENTTYPEID));
            RAISE EX.CONTROLLED_ERROR;
        END LOOP;

        
        IONUPERSONID := GE_BOSEQUENCE.FNUGETSEQGE_PERSON;

        
        SETPERSONRC
        (
            ISBNAME,
            ISBNUMBERID,
            INUIDENTTYPEID,
            INUADDRESS,
            ISBPHONENUMBER,
            ISBEMAIL,
            ISBBEEPER,
            INUPERSONALTYPE,
            INUORGANIZATAREAID,
            INUGEOGRAPLOCATIONID,
            INUUSERID,
            IONUPERSONID,
            RCPERSON
        );
        
        DAGE_PERSON.INSRECORD(RCPERSON);
        UT_TRACE.TRACE('Persona Creada:['||IONUPERSONID||']',16);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGISTER;


    PROCEDURE TECHNICALCONTACTREGISTER
    (
        ISBNAME                 IN GE_PERSON.NAME_%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        INUADDRESS              IN GE_PERSON.ADDRESS_ID%TYPE,
        ISBPHONENUMBER          IN GE_PERSON.PHONE_NUMBER%TYPE,
        ISBEMAIL                IN GE_PERSON.E_MAIL%TYPE,
        ISBBEEPER               IN GE_PERSON.BEEPER%TYPE,
        INUORGANIZATAREAID      IN GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        INUGEOGRAPLOCATIONID    IN GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        INUUSERID               IN GE_PERSON.USER_ID%TYPE,
        IONUPERSONID            IN OUT GE_PERSON.PERSON_ID%TYPE
    )
    IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        IF DAGE_PERSON.FBLEXIST(IONUPERSONID) THEN
            UPDATERECORD
            (
                ISBNAME,
                ISBNUMBERID,
                INUIDENTTYPEID,
                INUADDRESS,
                ISBPHONENUMBER,
                ISBEMAIL,
                ISBBEEPER,
                INUORGANIZATAREAID,
                INUGEOGRAPLOCATIONID,
                NULL, 
                IONUPERSONID
            );
        ELSE
            REGISTER(
                    ISBNAME,
                    ISBNUMBERID,
                    INUIDENTTYPEID,
                    INUADDRESS,
                    ISBPHONENUMBER,
                    ISBEMAIL,
                    ISBBEEPER,
                    GE_BOPARAMETER.FNUGET('CONTACT_PERSON_TYPE'),
                    INUORGANIZATAREAID,
                    INUGEOGRAPLOCATIONID,
                    NULL, 
                    IONUPERSONID
                    );
        END IF;
        COMMIT;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ROLLBACK;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END TECHNICALCONTACTREGISTER;
    FUNCTION VALIDCONTACTIDENTIFICATION
    (
        INUIDENTTYPEID          IN GE_PERSON.IDENT_TYPE_ID%TYPE,
        ISBNUMBERID             IN GE_PERSON.NUMBER_ID%TYPE,
        OSBNAME                 OUT GE_PERSON.NAME_%TYPE,
        ONUADDRESS_ID           OUT GE_PERSON.ADDRESS_ID%TYPE,
        OSBADDRESS              OUT AB_ADDRESS.ADDRESS_PARSED%TYPE,
        OSBPHONENUMBER          OUT GE_PERSON.PHONE_NUMBER%TYPE,
        OSBEMAIL                OUT GE_PERSON.E_MAIL%TYPE,
        OSBBEEPER               OUT GE_PERSON.BEEPER%TYPE,
        ONUORGANIZATAREAID      OUT GE_PERSON.ORGANIZAT_AREA_ID%TYPE,
        ONUGEOGRAPLOCATIONID    OUT GE_PERSON.GEOGRAP_LOCATION_ID%TYPE,
        ONUPERSONID             OUT GE_PERSON.PERSON_ID%TYPE
    ) RETURN BOOLEAN
    IS
    BLEXISTIDENTIFICATION BOOLEAN;
    RCPERSON DAGE_PERSON.STYGE_PERSON;
    BEGIN
        BLEXISTIDENTIFICATION := VALIDIDENTIFICATION(ISBNUMBERID, INUIDENTTYPEID,ONUPERSONID);
        IF NOT BLEXISTIDENTIFICATION THEN
            RETURN BLEXISTIDENTIFICATION;
        END IF;
        





        DAGE_PERSON.GETRECORD(ONUPERSONID, RCPERSON);
        OSBNAME                 := RCPERSON.NAME_;
        ONUADDRESS_ID           := RCPERSON.ADDRESS_ID;
        OSBADDRESS              := DAAB_ADDRESS.FSBGETADDRESS_PARSED(RCPERSON.ADDRESS_ID, 0);
        OSBPHONENUMBER          := RCPERSON.PHONE_NUMBER;
        OSBEMAIL                := RCPERSON.E_MAIL;
        OSBBEEPER               := RCPERSON.BEEPER;
        ONUORGANIZATAREAID      := RCPERSON.ORGANIZAT_AREA_ID;
        ONUGEOGRAPLOCATIONID    := RCPERSON.GEOGRAP_LOCATION_ID;
        ONUPERSONID             := RCPERSON.PERSON_ID;
        RETURN  BLEXISTIDENTIFICATION;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDCONTACTIDENTIFICATION;

    
















    PROCEDURE GETMAINOPERATINGUNIT
    (
        INUPERSONID             IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        ONUMAINOPERUNITID       OUT OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        ONUMAINOPERUNITNAME     OUT OR_OPERATING_UNIT.NAME%TYPE
    )
    IS

    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOPersonal.GetMainOperatingUnit', 2);

        
        GETCURRENTCHANNEL(INUPERSONID, ONUMAINOPERUNITID);

        
        IF(ONUMAINOPERUNITID IS NOT NULL) THEN

            
            ONUMAINOPERUNITNAME := DAOR_OPERATING_UNIT.FSBGETNAME(ONUMAINOPERUNITID);

        END IF;

        UT_TRACE.TRACE('Fin GE_BOPersonal.GetMainOperatingUnit['|| ONUMAINOPERUNITID ||']', 2);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%ISOPEN THEN
            CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT; END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%ISOPEN THEN
            CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT; END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETMAINOPERATINGUNIT;

    




























    PROCEDURE GETCURRENTCHANNEL
    (
        INUPERSONID IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        ONUCHANNEL  OUT CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE
    )
    IS
        NUPERSONID              CC_ORGA_AREA_SELLER.PERSON_ID%TYPE;
        SBUSERCONNECTED         VARCHAR2(500) := NULL;
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOPersonal.GetCurrentChannel', 2);

        
        NUPERSONID :=  INUPERSONID;
        IF ( INUPERSONID IS NULL) THEN
            NUPERSONID := FNUGETPERSONID;
        END IF;

        
        SBUSERCONNECTED := NUPERSONID||' - '||DAGE_PERSON.FSBGETNAME_(NUPERSONID);

        UT_TRACE.TRACE('Ejecutivo Conectado: ['||SBUSERCONNECTED||']', 5);

        
        IF ( CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%ISOPEN ) THEN
            CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT;
        END IF;

        
        OPEN CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT(NUPERSONID);
        FETCH CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT INTO ONUCHANNEL;

        
        IF(CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%NOTFOUND) THEN
            ERRORS.SETERROR(CNUNO_CURRENT_POS, SBUSERCONNECTED);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT;

        
        CC_BOSALESCHANNEL.VALIDATECHANNEL(ONUCHANNEL);

        UT_TRACE.TRACE('Fin GE_BOPersonal.GetCurrentChannel', 2);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF ( CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%ISOPEN ) THEN
                CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF ( CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT%ISOPEN ) THEN
                CLOSE CC_BCORGA_AREA_SELLER.CUGETCHANNELCURRENT;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCURRENTCHANNEL;

    





























    FUNCTION FNUGETCURRENTCHANNEL
    (
        INUPERSONID     IN  CC_ORGA_AREA_SELLER.PERSON_ID%TYPE,
        IBORAISEERROR   IN  BOOLEAN DEFAULT TRUE
    )
    RETURN CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE
    IS
        NUCHANNELID         CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOPersonal.fnuGetCurrentChannel', 2);

        
        GE_BOPERSONAL.GETCURRENTCHANNEL(INUPERSONID, NUCHANNELID);

        UT_TRACE.TRACE('Fin GE_BOPersonal.fnuGetCurrentChannel', 2);

        RETURN NUCHANNELID;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF  (IBORAISEERROR) THEN
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            RETURN NULL;
        WHEN OTHERS THEN
            IF  (IBORAISEERROR) THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            RETURN NULL;
    END FNUGETCURRENTCHANNEL;
    
    













    PROCEDURE GETBANKSUCUCODES
    (
        INUPERSONID   IN  GE_PERSON.PERSON_ID%TYPE,
        ONUBANK       OUT GE_PERSON.BANK_ID%TYPE,
        ONUSUCUBANK   OUT GE_PERSON.BRANCH_ID%TYPE
    )
    IS
        RCPERSON    DAGE_PERSON.STYGE_PERSON;
    BEGIN

        
        IF (INUPERSONID IS NOT NULL) THEN

            
            RCPERSON := DAGE_PERSON.FRCGETRCDATA(INUPERSONID);

            
            ONUBANK     := RCPERSON.BANK_ID;
            ONUSUCUBANK := RCPERSON.BRANCH_ID;

        END IF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETBANKSUCUCODES;
    
    




















    PROCEDURE GETCURRENTPERSANDCHANN
    (
        ONUEMPLOYEEID           OUT    GE_PERSON.PERSON_ID%TYPE,
        OSBEMPLOYEENAME         OUT    GE_PERSON.NAME_%TYPE,
        ONUORGANIZATAREAID      OUT    CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE,
        OSBORGANIZATAREADESC    OUT    GE_ORGANIZAT_AREA.DISPLAY_DESCRIPTION%TYPE
    )
    IS
        
        RCPERSON    DAGE_PERSON.STYGE_PERSON;
    
    BEGIN
    
        UT_TRACE.TRACE('Inicio GE_BOPersonal.GetCurrentPersAndChann', 3);
    
        
        RCPERSON := DAGE_PERSON.FRCGETRECORD( GE_BOPERSONAL.FNUGETPERSONID );
        ONUEMPLOYEEID := RCPERSON.PERSON_ID;
        OSBEMPLOYEENAME := RCPERSON.NAME_;
        
        UT_TRACE.TRACE('Identificador del Empleado['||ONUEMPLOYEEID||']', 3);

        
        ONUORGANIZATAREAID := GE_BOPERSONAL.FNUGETCURRENTCHANNEL( ONUEMPLOYEEID );
        
        UT_TRACE.TRACE('Identificador del Punto de Atenci�n['||ONUORGANIZATAREAID||']', 3);

        
        IF ( DAGE_ORGANIZAT_AREA.FBLEXIST( ONUORGANIZATAREAID )) THEN
        
            OSBORGANIZATAREADESC := DAGE_ORGANIZAT_AREA.FSBGETDISPLAY_DESCRIPTION(ONUORGANIZATAREAID);
        
        END IF;
        
        UT_TRACE.TRACE('Fin GE_BOPersonal.GetCurrentPersAndChann', 3);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCURRENTPERSANDCHANN;
    
    



















    FUNCTION FSBGETPERSONNAME
    (
        INUPERSONID IN GE_PERSON.PERSON_ID%TYPE
    )
    RETURN VARCHAR
    IS
    BEGIN

        RETURN DAGE_PERSON.FSBGETNAME_(INUPERSONID,0);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETPERSONNAME;

    





























    PROCEDURE GETPERSONSLOV
    (
        INUPERSONTYPEID     IN  GE_PERSON.PERSONAL_TYPE%TYPE,
        INUPERSONID         IN  GE_PERSON.PERSON_ID%TYPE,
        ISBPERSONNAME       IN  GE_PERSON.NAME_%TYPE,
        ORFREFCURSOR        OUT CONSTANTS.TYREFCURSOR
    )
    IS
        SBWHERE             VARCHAR2(2000);
        SBSQL               VARCHAR2(8000);
        NUPERSONTYPEID      GE_PERSON.PERSONAL_TYPE%TYPE;
        NUPERSONID          GE_PERSON.PERSON_ID%TYPE;
        SBPERSONNAME        GE_PERSON.NAME_%TYPE;
        SBORDERBY           VARCHAR2(100);
    BEGIN

        UT_TRACE.TRACE('INICIO - GE_BOPersonal.GetPersonsLov',1);

        NUPERSONTYPEID   := NVL(INUPERSONTYPEID, GE_BOCONSTANTS.CNUAPPLICATIONNULL );

        NUPERSONID  := NVL (INUPERSONID, GE_BOCONSTANTS.CNUAPPLICATIONNULL);

        SBPERSONNAME  := TRIM (UPPER (NVL (ISBPERSONNAME, GE_BOCONSTANTS.CSBNULLSTRING)));

        
        IF ( NUPERSONTYPEID <> GE_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
             SBWHERE := 'WHERE personal_type = :nuPersonTypeId '||CHR(10);
        ELSE
             SBWHERE := 'WHERE :nuPersonTypeId = '||  NUPERSONTYPEID ||CHR(10);
        END IF;

        
        IF ( NUPERSONID <> GE_BOCONSTANTS.CNUAPPLICATIONNULL) THEN
             SBWHERE := SBWHERE ||' AND person_id like :nuPersonId||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
             SBWHERE := SBWHERE ||' AND :nuPersonId = '||  NUPERSONID ||CHR(10);
        END IF;

        
        IF ( SBPERSONNAME <> GE_BOCONSTANTS.CSBNULLSTRING) THEN
            SBWHERE := SBWHERE || ' AND UPPER(name_) LIKE :description||'||CHR(39)||'%'||CHR(39)||CHR(10);
        ELSE
            SBWHERE := SBWHERE || ' AND :sbPersonName = '||SBPERSONNAME||CHR(10);
        END IF;
        
        
        IF  NUPERSONID <> GE_BOCONSTANTS.CNUAPPLICATIONNULL THEN
            SBORDERBY :=  CHR(10)||'ORDER BY person_id';
        END IF;

        UT_TRACE.TRACE('Where: '||CHR(10)||SBWHERE, 5);

        SBSQL := 'SELECT personal_type,'|| CHR(10) ||
                 '       person_id id,' || CHR(10) ||
                 '       UPPER(name_) description' || CHR(10) ||
                 '       /*+ GE_BOPersonal.GetPersonsLov SAO203463 */' || CHR(10) ||
                 'FROM ge_person'|| CHR(10)||SBWHERE||SBORDERBY;
                 

        OPEN ORFREFCURSOR FOR SBSQL USING NUPERSONTYPEID, NUPERSONID, SBPERSONNAME;
        UT_TRACE.TRACE('FIN - GE_BOPersonal.GetPersonsLov',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETPERSONSLOV;
    
    
END GE_BOPERSONAL;