PACKAGE pkBOInstancePrintingData AS









































































































































































    
    
    

    
    TYPE TYTBCONSUMPTION                   IS TABLE OF CONSSESU%ROWTYPE
                                           INDEX BY BINARY_INTEGER;
    
    
    TYPE TYTBCHARGES                       IS TABLE OF CARGOS%ROWTYPE
                                           INDEX BY BINARY_INTEGER;

    
    TYPE TYTBPRODUCTS                      IS TABLE OF SERVSUSC%ROWTYPE
                                           INDEX BY VARCHAR2(10);

    
    TYPE TYTBACCOUNTS                      IS TABLE OF CUENCOBR%ROWTYPE
                                           INDEX BY VARCHAR2(10);
                                           
    
    
    TYPE TYTBBILLS                         IS TABLE OF FACTURA%ROWTYPE
                                           INDEX BY VARCHAR2(13);

    
    TYPE TYTBGROUPS                        IS TABLE OF SESUASOC.SSASCONS%TYPE
                                           INDEX BY BINARY_INTEGER;
                                           
    TYPE TYTBCOUPONS                       IS TABLE OF CUPON.CUPONUME%TYPE
                                           INDEX BY BINARY_INTEGER;

    
    
    
    
    
    
    
    
    
    
    
    

    FUNCTION FSBVERSION RETURN VARCHAR2 ;
    
    PROCEDURE CLEARMEMORY;
    
    PROCEDURE INSTANCEDOCUMENTTYPE
        (
            INUDOCUMENTTYPE               IN  GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE
        );

    PROCEDURE INSTANCECURRENTACCOUNT
        (
            IRCACCOUNT                    IN  CUENCOBR%ROWTYPE
        );
        
    PROCEDURE INSTANCECURRENTPRODUCT
        (
            IRCPRODUCT                    IN  SERVSUSC%ROWTYPE
        );
        
    PROCEDURE INSTANCECURRCONSUMPTION
        (
            ITBRCCONSUMPTION              IN  TYTBCONSUMPTION
        );

    PROCEDURE INSTANCECOUPONNUMBER
        (
            INUCOUPON                     IN  CUPON.CUPONUME%TYPE
        );

    PROCEDURE INSTANCEBILLDATA
        (
            IRCBILL                       IN  FACTURA%ROWTYPE
        );
        
    PROCEDURE INSTANCEBILLDATA
        (
            INUCONTRACT                    IN SUSCRIPC.SUSCCODI%TYPE,
            IRCBILL                        IN  FACTURA%ROWTYPE
        );

    PROCEDURE INSTANCECHARGESDATA
        (
            ITBRCCHARGES                  IN  TYTBCHARGES
        );
        
    PROCEDURE INSTANCEADDITIONALDATA;

    PROCEDURE INSTANCEPROCESSBYGROUP
        (
            INUGROUP                      IN  SESUASOC.SSASCONS%TYPE
        );

    PROCEDURE GETCLIENT
        (
            ORCCLIENT                     OUT DAGE_SUBSCRIBER.STYGE_SUBSCRIBER
        );

    PROCEDURE GETCONTRACT
        (
            ORCCONTRACT                   OUT SUSCRIPC%ROWTYPE
        );

    PROCEDURE GETBILL
        (
            ORCBILL                       OUT FACTURA%ROWTYPE
        );
        
    PROCEDURE GETDOCUMENTTYPE
        (
            ONUDOCUMENTTYPE               OUT GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE
        );

    PROCEDURE GETCURRENTACCOUNT
        (
            ORCACCOUNT                    OUT CUENCOBR%ROWTYPE
        );

    PROCEDURE GETCURRENTPRODUCT
        (
            ORCPRODUCT                    OUT SERVSUSC%ROWTYPE
        );
        
    PROCEDURE GETCURRCONSUMPTION
        (
            OTBRCCONSUMPTION              OUT TYTBCONSUMPTION
        );

    PROCEDURE GETCOUPONNUMBER
        (
            ONUCOUPON                     OUT CUPON.CUPONUME%TYPE
        );

    PROCEDURE GETCHARGES
        (
            OTBCHARGES                    OUT TYTBCHARGES
        );
        
    PROCEDURE GETPRODUCTCHARGES
        (
            INUPRODUCT                    IN  SERVSUSC.SESUNUSE%TYPE,
            OTBCHARGES                    OUT TYTBCHARGES
        );

    PROCEDURE GETPRODUCTS
        (
            OTBPRODUCTS                   OUT TYTBPRODUCTS
        );
        
    PROCEDURE GETACCOUNTS
        (
            OTBACCOUNTS                   OUT TYTBACCOUNTS
        );

    PROCEDURE GETEXPIREDACCOUNTS
        (
            OTBACCOUNTS                   OUT TYTBACCOUNTS
        );

    PROCEDURE GETTOTALVALUE
        (
            ONUPAYMENTVALUE               OUT PKBCFACTURA.STYFACTVATO
        );
        
    PROCEDURE LOADFINANCIALPRODUCTBALANCE
        (
            INUPRODUCT                    IN  SERVSUSC.SESUNUSE%TYPE,
            ONUVALUE                      OUT DIFERIDO.DIFESAPE%TYPE
        );

    PROCEDURE GETTOTALLATEBALANCE
        (
            ONUTOTALLATE                  OUT CARGOS.CARGVALO%TYPE
        );

    PROCEDURE GETTOTALCLAIMBALANCE
        (
            ONUTOTALCLAIM                 OUT CARGOS.CARGVALO%TYPE
        );

    PROCEDURE GETCOMPANYVALUE
        (
            ONUCOMPANYVALUE               OUT PKBCFACTURA.STYFACTVATO
        );

    PROCEDURE GETTHIRDSVALUE
        (
            ONUTHIRDSVALUE                OUT PKBCFACTURA.STYFACTVATO
        );

    PROCEDURE GETPRODUCTRECORD
        (
            INUPRODUCTID                  IN  SERVSUSC.SESUNUSE%TYPE,
            ORCPRODUCT                    OUT SERVSUSC%ROWTYPE
        );

    PROCEDURE GETBILLINGCLAIM
        (
            ONUBILLINGCLAIM               OUT PKBCSERVSUSC.STYSESUVARE
        );

    PROCEDURE GETNOAPPPAYMENTCLAIM
        (
            ONUNOAPPPAYCLAIM              OUT PKBCSERVSUSC.STYSESUVRAP
        );

    PROCEDURE GETPOSITIVEBALANCE
        (
            ONUPOSITIVEBALANCE            OUT SERVSUSC.SESUSAFA%TYPE
        );

    PROCEDURE GETTOTALCHARGESVALUE
        (
            ONUCHARGESVALUE OUT CARGOS.CARGVALO%TYPE
        );

    PROCEDURE GETTOTALTAXESVALUE
        (
            ONUTAXESVALUE OUT CARGOS.CARGVALO%TYPE
        );

    PROCEDURE GETBILLIDENTIFIER
        (
            OSBBILLIDENTIFIER   OUT VARCHAR2
        );
        
    PROCEDURE INSTANCEBILLINGPERIOD
        (
            INUBILLINGPERIOD    IN PERIFACT.PEFACODI%TYPE
        );

    
    
    PROCEDURE GETDUEBALANCEAGE
    (
        ONUDUEBALANCEAGE        OUT     NUMBER
    );
    
    PROCEDURE INSTANCECOUPONTYPE
    (
        ISBCOUPONTYPE   IN  TIDICOBR.TDCOTICU%TYPE
    );
    
    PROCEDURE GETCOUPONTYPE
    (
        ONUCOUPONTYPE   OUT TIDICOBR.TDCOTICU%TYPE
    );

    PROCEDURE INSTANCEFINANCINGID
    (
        INUFINANCINGID  IN  CC_FINANCING_REQUEST.FINANCING_ID%TYPE
    );

    PROCEDURE GETFINANCINGREQUEST
    (
        ORCFINANCINGREQUEST OUT DACC_FINANCING_REQUEST.STYCC_FINANCING_REQUEST
    );

    PROCEDURE GETBILLVALUE
    (
        ONUBILLVALUE    OUT PKBCSERVSUSC.STYSESUSAPE
    );
    
    
    PROCEDURE GETBILLINGPERIOD
    (
        ONUBILLINGPERIOD   OUT PERIFACT.PEFACODI%TYPE
    );

    
    PROCEDURE INSTANCECONTRACTDATA
    (
        INUSUBSCRIPTION   IN  SUSCRIPC.SUSCCODI%TYPE
    );

    
    PROCEDURE INSTANCETOTALVALUE
    (
        INUTOTALVALUE   IN  NUMBER
    );

    
    
    PROCEDURE INSTANCEDATAFROMCHARGES;
    
    PROCEDURE GETPREVACCOUNTS
    (
        OTBPREVACCOUNTS OUT TYTBACCOUNTS
    );

    PROCEDURE GETPREVBALANCE
    (
        ONUTOTALPREVBAL OUT CARGOS.CARGVALO%TYPE
    );
    
       
    PROCEDURE GETTOTALCLAIMAPPLY
    (
        ONUTOTALCLAIMAPPLY      OUT     CARGOS.CARGVALO%TYPE
    );
    
    PROCEDURE GETGROUPNUMBER
    (
        ONUGROUP    OUT SESUASOC.SSASCONS%TYPE
    );

    PROCEDURE INSTANCECOUPONS
    (
        ITBCOUPONS  IN  TYTBCOUPONS
    );

    PROCEDURE INSTANCEINDEXCOUPONS
    (
        INUINDEXCOUPONS  IN  BINARY_INTEGER
    );

    PROCEDURE GETACCOUNTMISCELLANEOUS
    (
        ONUACCOUNTMISCELLANEOUSVALUE      OUT     NUMBER
    );
    
    PROCEDURE GETACCOUNTRECORD
    (
        INUACCOUNTID                IN  CUENCOBR.CUCOCODI%TYPE,
        ORCACCOUNT                  OUT CUENCOBR%ROWTYPE
    );
    
    PROCEDURE GETNUMBEREXPIREDBILLS
    (
        ONUNUMBEREXPIREDBILLS           OUT NUMBER
    );
    
    PROCEDURE GETBILLEXPIREDDATE
    (
        ODTBILLEXPIREDDATE              OUT DATE
    );
    
    PROCEDURE GETSYSTEM
    (
        ORCSYSTEM                       OUT SISTEMA%ROWTYPE
    );

    PROCEDURE INSTANCENOTE
    (
        IRCNOTE IN  NOTAS%ROWTYPE
    );

    PROCEDURE GETNOTE
    (
        ORCNOTE OUT NOTAS%ROWTYPE
    );

    PROCEDURE INSTANCECOUPONINFO
    (
        IRCCOUPON   IN  CUPON%ROWTYPE
    );

    PROCEDURE GETCOUPONINFO
    (
        ORCCOUPON   OUT NOCOPY CUPON%ROWTYPE
    );

END PKBOINSTANCEPRINTINGDATA;