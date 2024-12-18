CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKBSSRECA AS
 /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PAQUETE : LDCI_PKBSSRECA
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 29/01/2013
         RICEF   : l019
    DESCRIPCION : Paquete de interfaz que contiene todas las funcionalidades referentes
               a las integraciones de recaudos



    Historia de Modificaciones

    Autor       Fecha       Descripcion.
    HECTORFDV   29/01/2013  Creacion del paquete
    jcatuche    13/08/2024  OSF-3122: Se ajusta el método
                                [proPaymentRegister]
************************************************************************/



TYPE tORFENTITY IS REF  CURSOR;

  PROCEDURE proCnltaPuntosRecaudo(inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE,
                                INUDISTANCE         in   NUMBER,
                                INUAMOUNT           in   NUMBER,
                                ORFENTITY           OUT SYS_REFCURSOR,
                                onuErrorCode        out  NUMBER,
                                osbErrorMessage     out  VARCHAR2) ;

  PROCEDURE proPaymentRegister(inuRefType       in number,
                               isbXmlReference  in clob,
                               isbXmlPayment    in clob,
                               osbxmlcoupons    in out clob,
                               onuErrorCode     in out number,
                               osbErrorMessage  in out varchar2);

  FUNCTION fsbGenAddress ( inuIdAddress IN NUMBER )  RETURN VARCHAR2;

  FUNCTION fsbGenComplement (sbComplement IN VARCHAR2) RETURN VARCHAR2;


END LDCI_PKBSSRECA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSRECA AS
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado

    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;



    PROCEDURE proCnltaPuntosRecaudo(inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE,
                                INUDISTANCE         in   NUMBER,
                                INUAMOUNT           in   NUMBER,
                                ORFENTITY           OUT SYS_REFCURSOR,
                                onuErrorCode        out  NUMBER,
                                osbErrorMessage     out  VARCHAR2)
    AS

     /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PROCEDURE : proCnltaPuntosRecaudo
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 29/01/2013
             RICEF   : l019
       DESCRIPCION : Paquete de interfaz que contiene todas las funcionalidades referentes
                   a las integraciones de bss recaudos


    Parametros de Entrada

        inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE
        INUDISTANCE         in   NUMBER
        INUAMOUNT           in   NUMBER


    Parametros de Salida

        ORFENTITY           OUT SYS_REFCURSOR,
        onuErrorCode        out  NUMBER,
        osbErrorMessage     out  VARCHAR2

    Historia de Modificaciones

     Autor        Fecha       Descripcion.
     HECTORFDV    29/01/2013  Creacion del paquete
    ************************************************************************/
        csbMT_NAME      CONSTANT VARCHAR2(100) := csbSP_NAME||'proCnltaPuntosRecaudo';
        
        SUBABANC  SUCUBANC.SUBABANC%TYPE;-- Identificador del Banco
        BANCO     VARCHAR2(200);-- Nombre del Banco
        SUBACODI  SUCUBANC.SUBACODI%TYPE;-- Punto de pago
        SUBANOMB  SUCUBANC.SUBANOMB%TYPE;-- Nombre de la sucursal
        SUBAADID  SUCUBANC.SUBAADID%TYPE;-- Identificador de la Dirección
        ADDRESS   VARCHAR2(200);-- Dirección Sucursal
        SUBACOPO  SUCUBANC.SUBACOPO%TYPE;-- Código Postal
        SUBATELE  SUCUBANC.SUBATELE%TYPE;-- Teléfono Sucursal de la Entidad
        SUBASIST  SUCUBANC.SUBASIST%TYPE;-- Empresa


        SUCURSALES SYS_REFCURSOR;
        sbQueryFilter VARCHAR2(5000);
        sbFlagNull VARCHAR2(200):='';

    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        pkg_error.prInicializaError(onuErrorCode,osbErrorMessage);
        /*
         * Se consulta la direccion del suscriptor
         *
         */
        SELECT SUSCIDDI INTO SUBAADID
        FROM SUSCRIPC
        WHERE SUSCCODI= inuSuscCodi;

        OS_GETBRANCHBYADDRESS( SUBAADID, INUDISTANCE => INUDISTANCE, INUAMOUNT => INUAMOUNT, ORFENTITY=>SUCURSALES, ONUERROR => onuErrorCode, OSBERROR => osbErrorMessage );
         /*
         * Se recorren las sucursales retornadas
         * y se crea un filtro para reutilizarlas
         *
         */
        LOOP
          FETCH SUCURSALES
          INTO  SUBABANC,BANCO,SUBACODI,SUBANOMB,SUBAADID,ADDRESS,SUBACOPO,SUBATELE,SUBASIST;
                DBMS_OUTPUT.PUT_LINE('SUBACODI = ' || SUBACODI);

          EXIT WHEN SUCURSALES%NOTFOUND;
          sbQueryFilter:=sbQueryFilter||'(SUCU.SUBABANC = '||SUBABANC||' AND SUCU.SUBACODI ='||SUBACODI||') OR ';
        END LOOP;
        CLOSE SUCURSALES;
        --  DBMS_OUTPUT.PUT_LINE('sbQueryFilter = ' || sbQueryFilter);

        IF sbQueryFilter IS NULL THEN
            sbQueryFilter:=' 1=2 OR ';
        END IF;


        /*
         * Se crea un select para traer la informacion
         * de las sucursales y agregarle la información
         * de la localidad
         *
         */
        sbQueryFilter:=replace('SELECT SUBABANC,
                               (SELECT BA.BANCNOMB FROM BANCO BA WHERE BA.BANCCODI=SUCU.SUBABANC) AS BANCO,
                               SUCU.SUBACODI,
                               SUCU.SUBANOMB,
                               SUCU.SUBAADID,
                               LDCI_PKBSSRECA.fsbGenAddress((SELECT ADDRESS_ID FROM AB_ADDRESS WHERE ADDRESS_ID=SUCU.SUBAADID)) AS ADDRESS,
                               SUBACOPO,
                               SUBATELE,
                               SUBASIST,
                               (SELECT gl.GEOGRAP_LOCATION_ID
                                FROM   sucubanc sucusub,ge_geogra_location gl,ab_address addr
                                WHERE  sucusub.subacodi = SUCU.SUBACODI   AND
                                       sucusub.SUBABANC=SUCU.SUBABANC     AND
                                       addr.GEOGRAP_LOCATION_ID = gl.GEOGRAP_LOCATION_ID AND
                                       sucusub.SUBAADID=addr.ADDRESS_ID) AS CODLOCALIDAD,
                               (SELECT gl.DESCRIPTION
                                FROM   sucubanc sucusub,ge_geogra_location gl,ab_address addr
                                WHERE  sucusub.subacodi = SUCU.SUBACODI   AND
                                       sucusub.SUBABANC=SUCU.SUBABANC     AND
                                       addr.GEOGRAP_LOCATION_ID = gl.GEOGRAP_LOCATION_ID AND
                                       sucusub.SUBAADID=addr.ADDRESS_ID) AS DESCLOCALIDAD
                              FROM   SUCUBANC SUCU
                              WHERE '||sbQueryFilter||';','OR ;','');

        OPEN ORFENTITY FOR  sbQueryFilter;

        IF NOT ORFENTITY%ISOPEN THEN
            OPEN ORFENTITY FOR SELECT * FROM dual where 1=2;
        END IF;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error then
            ROLLBACK;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            IF NOT ORFENTITY%ISOPEN THEN
                OPEN ORFENTITY FOR SELECT * FROM dual where 1=2;
            END IF;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            osbErrorMessage := 'Error consultando putos de pago: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            pkg_Error.seterror;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            IF NOT ORFENTITY%ISOPEN THEN
                OPEN ORFENTITY FOR SELECT * FROM dual where 1=2;
            END IF;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
    END;



    FUNCTION fsbGenAddress ( inuIdAddress IN NUMBER ) RETURN VARCHAR2 IS
     /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           FUNCION   : fsbGenAddress
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 29/01/2013
             RICEF   : l019
       DESCRIPCION : Funcion que se encargar de la generacion de la
                     descripcion de una direccion


    Parametros de Entrada

          inuIdAddress        IN      NUMBER


    Parametros de Salida


        RETORNO     VARCHAR2

    Historia de Modificaciones
        Autor        Fecha       Descripcion.
        HECTORFDV    29/01/2013  Creacion del paquete
    ************************************************************************/
        csbMT_NAME      CONSTANT VARCHAR2(100) := csbSP_NAME||'fsbGenAddress';
        
        sbAddres VARCHAR2(5000);
        onuErrorCode NUMBER;
        osbErrorMessage varchar2(2000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        /*
         * Se selecciona la direccion y
         * y se convierte la direccion a una descripcion
         * que se pueda entender facilmente
         */
        SELECT  DECODE
                (
                    wbl_a.way_by_location_id,
                    NULL,ADDRESS_PARSED,
                    wt_a.description||' '||wbl_a.way_number||' '||DECODE
                                                                (
                                                                    wbl_a.letters_way,
                                                                    NULL,'',
                                                                    wbl_a.letters_way||' '
                                                                )||wt_b.description||' '||wbl_b.way_number||' '||DECODE
                                                                                                                (
                                                                                                                    wbl_b.letters_way,
                                                                                                                    NULL,'',
                                                                                                                    wbl_b.letters_way||' '
                                                                                                                )||ab_address.house_number||' '||DECODE
                                                                                                                                                (
                                                                                                                                                    ab_address.house_letter,
                                                                                                                                                    NULL,'',
                                                                                                                                                    ab_address.house_letter||' '
                                                                                                                                                )||fsbGenComplement(ab_address.ADDRESS_COMPLEMENT)
                )
                INTO sbAddres
        FROM ab_address
                LEFT OUTER JOIN ab_way_by_location wbl_a  ON ab_address.way_id = wbl_a.way_by_location_id
                LEFT OUTER JOIN ab_way_by_location wbl_b  ON ab_address.CROSS_WAY_ID = wbl_b.way_by_location_id
                LEFT OUTER JOIN ab_way_type wt_a          ON ab_address.way_type = wt_a.way_type_id
                LEFT OUTER JOIN ab_way_type wt_b          ON ab_address.cross_way_type = wt_b.way_type_id
        WHERE ab_address.address_id = inuIdAddress;

        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
        
        RETURN sbAddres;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error then
            ROLLBACK;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RETURN sbAddres;
        WHEN OTHERS THEN
            osbErrorMessage := 'Error generando direccion: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            pkg_Error.seterror;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RETURN sbAddres;
    END fsbGenAddress;



    FUNCTION fsbGenComplement (sbComplement IN VARCHAR2) RETURN VARCHAR2 IS
    /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           FUNCION   : fsbGenComplement
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 29/01/2013
             RICEF   : l019
       DESCRIPCION :   funcion que se encarga de reemplazar los complementos de la
                       direccion para colocar la direccion completa

    Parametros de Entrada

          sbComplement IN VARCHAR2


    Parametros de Salida


        RETORNO     VARCHAR2

    Historia de Modificaciones
        Autor        Fecha       Descripcion.
        HECTORFDV    29/01/2013  Creacion del paquete
    ************************************************************************/
        csbMT_NAME      CONSTANT VARCHAR2(100) := csbSP_NAME||'fsbGenComplement';
        
        ret  VARCHAR2(4000);
        hold VARCHAR2(4000);
        cur  sys_refcursor;
        onuErrorCode NUMBER;
        osbErrorMessage VARCHAR2(2000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        OPEN cur FOR 
        SELECT NVL
        (
            (
                SELECT DESCRIPTION 
                FROM ab_token_hierarchy 
                WHERE TOKEN_HIERARCHY_ID=
                (
                    substr(main_string, position_from + 1, position_to - position_from - 1)
                )
            ),
            (
                substr(main_string, position_from + 1, position_to - position_from - 1)
            )
        )
        FROM 
        (
            SELECT main_string,
            decode(rownum - 1, 0, 0, instr(main_string, ' ', 1, rownum - 1)) position_from,
            instr(main_string, ' ', 1, rownum) position_to
            FROM 
            (
                SELECT RTRIM(LTRIM(sbComplement))||' ' main_string 
                FROM dual
            )
            CONNECT BY LEVEL <= length(main_string)
        )
        WHERE position_to > 0;

        /*
         * Se recorre se coloca cada dato encontrado de forma
         * horizontal, y separado por un espacio
         */
        LOOP
            FETCH cur INTO hold;
            EXIT WHEN cur%NOTFOUND;
            IF ret IS NULL THEN
                ret := hold;
            ELSE
                ret := ret || ' ' || hold;
            END IF;
        END LOOP;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
        
        RETURN ret;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error then
            ROLLBACK;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            osbErrorMessage := 'Error consultando complementos de direccion: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            pkg_Error.seterror;
            pkg_Error.geterror (onuErrorCode, osbErrorMessage);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
    END fsbGenComplement;

    Procedure proPaymentRegister(inuRefType        in number,
                               isbXmlReference  in clob,
                               isbXmlPayment    in clob,
                               osbxmlcoupons    in out clob,
                               onuErrorCode     in out number,
                               osbErrorMessage  in out varchar2) is
    /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        PROCEDURE : proCnltaPuntosRecaudo
         AUTOR   : Eduardo Aguera
         FECHA   : 29/01/2013
         RICEF         : l019
         DESCRIPCION   : Permite el registro de un pago

    Parametros de Entrada

        inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE
        INUDISTANCE         in   NUMBER
        INUAMOUNT           in   NUMBER

    Parametros de Salida

        ORFENTITY           OUT SYS_REFCURSOR,
        onuErrorCode        out  NUMBER,
        osbErrorMessage     out  VARCHAR2

    Historia de Modificaciones

    Autor             Fecha       Descripcion.
    Eduardo Aguera    29/01/2013  Creacion del paquete
    ************************************************************************/
        csbMT_NAME      CONSTANT VARCHAR2(100) := csbSP_NAME||'proPaymentRegister';
        nuLogId         ldci_logpaymentreg.logid%type;
    
    Begin
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        pkg_error.prInicializaError(onuErrorCode,osbErrorMessage);
        
        osbxmlcoupons:=null;
        
        pkg_ldci_logpaymentreg.prInsertaLogPago(inuRefType,isbXmlReference,isbXmlPayment,onuErrorCode,osbErrorMessage,nuLogId); 
        
        os_paymentsregister(inuRefType,isbXmlReference,isbXmlPayment,osbxmlcoupons,onuErrorCode,osbErrorMessage);
        
        IF NVL(onuErrorCode,0) != 0 then
           raise pkg_Error.Controlled_Error;
        END IF;
          
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
            
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkGeneralServices.RollBackTransaction;
            pkg_Error.getError(onuErrorCode,osbErrorMessage);
            pkg_traza.trace('sbError: '||osbErrorMessage, cnuNivelTraza);
            pkg_ldci_logpaymentreg.prActualizaLogPago(nuLogId,onuErrorCode,osbErrorMessage);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkGeneralServices.RollBackTransaction;
            pkg_Error.setError;
            pkg_Error.getError(onuErrorCode,osbErrorMessage);
            onuErrorCode  := -1;
            osbErrorMessage  := 'Error en proceso de registro de pagos: '||osbErrorMessage;
            pkg_traza.trace('sbError: '||osbErrorMessage, cnuNivelTraza);
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
    END proPaymentRegister;

END LDCI_PKBSSRECA;
/
PROMPT Otorgando permisos de ejecución sobre LDCI_PKBSSRECA
BEGIN
    pkg_utilidades.prAplicarPermisos( 'LDCI_PKBSSRECA', 'ADM_PERSON');
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSRECA to EXEBRILLAAPP;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSRECA to REXEINNOVA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSRECA to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSRECA to INTEGRADESA;
/
