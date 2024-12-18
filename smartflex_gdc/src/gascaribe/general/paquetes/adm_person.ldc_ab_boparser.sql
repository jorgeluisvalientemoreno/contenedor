CREATE OR REPLACE PACKAGE      adm_person.LDC_AB_Boparser
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : AB_Boparser  (Actualizado de BD_BOParser)
Descripcion    : Paquete que contiene los metodos necesarios para parsear una
                 cadena de direccion.
Autor          : Jhonathan Ramirez H.
Fecha          : 21/05/2009


Historia de Modificaciones
Fecha             Autor               Modificacion
=========         =========           ====================
19/06/2024        PAcosta             OSF-2845: Cambio de esquema ADM_PERSON  
16-05-2013        hcruz.SAO207994     Modificacion del metodo InsertAddress
15-05-2013        hcruz.SAO208014     Modificacion del metodo BuscarPrimeraVia
21-03-2013        hcruz.SAO204930      Modificacion del procedimiento CheckIfAddressExistsInDB
20-12-2012        amendezSAO198457    Estabilizacion SAOS 198268,198272
                                      Se modifica <obtieneDireccion>
                                      fsbformatoDir><retTokens>
18-12-2012        amendezSAO198254    Se elimina <ValidaRangosSimbolos><fblEsToken>
                                      Se modifica <fblEsTokenSinonimo><fsbTokenBase>
                                      <CheckSyntax>
                                      Nuevo  metodo <fblEsSinonimoPalabraVia>
12-12-2012        amendezSAO197917    Nuevos metodos  <fsbTokenBase><LoadTokens>
                                      <fblesComplemento><fblEsTokenSinonimo><fnuDomainId>
                                      Se modifica <proSimboloGrama><retTokens>
                                      <separaComplemento>
11-12-2012        amendezSAO195302    Se modifica <cargaGramatica>,<BuscaCoincidencia>
                                      <fsbAddressFather><fsbIsRootGrammar><fnuPreviousGrammarLevel>
14-11-2012        amendezSAO195930    Se modifica <BuscaCoincidencia>
06-10-2012        Juzuriaga.SAO191345 Se modifica el metodo <InsertAddress>
16-06-2012        cpantojaSAO186506   Se crea <<ObjCheckAddressExists>>
15-05-2012        hcruz.SAO181951     Se modifica el metodo CompletaRegisDir
14-05-2012        hcruz.SAO182280     Se modifica el metodo CompletaRegisDir
23-03-2012        hcruz.SAO177713     1 - Se modifica el metodo cargaGramatica y el tipo tyrcGramatica
                                      2 - Se incluye solucion al SAO179708. Se modifica el metodo CheckSyntax
                                      y se adiciona a tyrcDirParseada el campo nuGeoLocation para el manejo
                                      de la ubicacion geografica
14-03-2012        hcruz.SAO176067     Se crea el metodo fnuFindAddress
01-03-2012        hcruz.SAO174571     Se modifica el metodo InsAddressTransaction
19-01-2012        cocampo.SAO171487   1 - Se modifica el metodo <<buscaCoincidencia>>
16-01-2012        cocampo.SAO171139   1 - Se modifica el metodo ValidaCantVias.
                                      2 - Se modifica el nombre de la variable blGramaticaOK por blGramViasOK
                                          Se realiza impacto de cambio de nombre de variable en los metodos:
                                                    <<insertAddress>> <<validateRuralAddress>> <<ValidaCantVias>>
                                                    <<CheckSyntax>> <<ValDomainToken>> <<buscaCoincidencia>>
06-12-2011        cocampo.SAO153779   1 - Se a?ade tabla PL para ser utilizada por el trigger de validacion
                                          de ingreso de padres en la tabla AB_DOMAIN_VALUES.description
                                          (Evitar Tabla Mutante)
03-12-2011        caguilar.SAO167829  1 - Se modifica el procedimiento <ValidateRuralAddress>
01-12-2011        caguilar.SAO165655  1 - Estabilizacion amendezSAO166967. Se modifican las funciones
                                      <fsbFormatoDir> y <fsbAddressFather>.
                                      2 - Estabilizacion amendezSAO166967. Se crean las funciones
                                      <fnuGetGrammarIndexById> y <fnuPreviousGrammarLevel>.
                                      3 - Estabilizacion amendezSAO165262. Se modifica el procedimiento
                                      <ValidateRuralAddress> y el procedimiento <insertAddress>.
                                      4 - Estabilizacion amendezSAO166967. Se modifica el procedimiento
                                      <CargaGramatica>, el procedimiento <insertAddress> y el
                                      procedimiento <DespliegaGramatica>  y crea la funcion <fsbIsRootGrammar>
                                      5 - Estabilizacion amendezSAO166967. Se modifica el metodo <fsbDirSugerida>
                                      6 - Estabilizacion amendezSAO166967. Se modifica el metodo <fsbDirSugerida>
04-11-2011        cocampoSAO165227    Se modifica InsertAddress.
04-11-2011        cocampoSAO165166    Estabilizacion SAO164859. Se modifica InsertAddress.
25-10-2011        caguilarSAO163855   Se agrega la variable global blSymbols de
                                      tipo booleana. Ademas, se agrega en el procedimiento
                                      <GetSymbols> el flag de validacion para evitar que
                                      se realice la consulta si el cache esta vacio pero
                                      por que la consulta no arroja datos.
16-10-2011        cocampoSA162697     1 - Se modifica el metodo
                                            <ValDomainToken.ValConfigExpression>
30-09-2011        cocampoSAO148875    1 - Se crean los metodos:
                                             <ValDomainToken>
                                             <GetValueDomian>
                                      2 - Se modifica el metodo:
                                             <CheckSyntax>
                                             <BuscaCoincidencia>
                                             <validateRuralAddress>
22-09-2011        juzuriaga.SAO158497 Se modifica <ValidaCantVias>
12-07-2011        JgutierrezSAO158072 Se modifica <InsertAddress>
07-07-2011        JuzuriagaSAO153539  Estabilizacion.SAO150916 Se modifica <InsertAddress>
17-05-2011        cocampoSAO149457    Se modifica <InsertAddress>
13-05-2011        cocampoSAO148073    Estabilizacion SAO147913. Se modifica <ActualizaDireccion>
20-04-2011        amendezSAO146905    Estabilizacion Branch 146690
                                      Se adiciona <ValidaNulidadToken>
                                      y modifica <BuscaCoincidencia>,
                                      <CheckSyntax>,<retTokens>,
                                      <fsbDirSugerida>
18-04-2011        juzuriagaSAO146723  se modifica <ActualizaDireccion>
15-04-2011        amendezSAO146345    Se modifica <retTokens>
14-04-2011        juzuriagaSAO146083  Se modifican los metodos:
                                                         <BuscarPrimeraVia>
                                                         <obtieneDireccion>
                                                         <IdentificarSegundaVia>
12-04-2011        juzuriagaSAO145876  Se modifican los metodos retTokens y obtCasaLetraNum
06/04/2011        jflorezSAO143738    Se adiciona el metodo <InsAddressTransaction>
                                      (Ref. jmunozSAO142056)
08/01/2011        cocampoSAO139484    Se modifica  <obtCasaLetraNum>
13/01/2011        hcruzSAO138308      Se modifica  <InsertAddress>,<CompletaRegisDir>
11-11-2010        amendezSAO131516    Se modifica  <InsertAddress>,<fsbformatoDir>
                                      Nuevo metodo <FixSpaces>
15-10-2010        JuzuriagaSAO130953  Se modifica  <InsertAddress>
19-09-2010        amendezSAO122447    Nuevo metodo privado <GetSymbols>
                                      Se modifica <fsbformatoDir>,<CompletaRegisDir>
                                      <ActualizaDireccion>
                                      Se elimina variable global gsbLastParsedDir
                                      se maneja en su reemplazo variables nocopy.
                                      Se elimina el metodo ValidaActualizSeleccID
07-09-2010        JUzuriagaSAO127106 se modifica el metodo InsertAddress
12-08-2010        JUzuriagaSAO124482  se modifica   InsertAddress
30-07-2010        JUzuriagaSAO120903  se modifica CheckIfAddressExistsInDB
21-07-2010        jgutierrezSAO120379 Se modifica CompletaRegisDir.
23-06-2010        JSSanchezSAO119660  Se agrega el metodo fsbGetAddressTokenValue
28-05-2010        JSSanchezSAO115242  Se colocan publicos los metodos CompletaRegiDir y
                                      ValidateRuralAddress
18-05-2010        JuzuriagaSAO115230  se modifica   InsertAddress
27-04-2010        aavelezSAO115231    Se modifica el metodo fsbformatoDir y
                                      el metodo InsertAddress, se crea el
                                      procedimiento privado validateRuralAddress
09-04-2010        jgutierrezSAO115247 Se modifican los metodos por el
                                      Borrado de ge_neighborthood:
                                      <CheckSyntax>
                                      <InsertAddress>
                                      <CheckIfAddressExistsInDB>
                                      <ValidaActualizSeleccID>

26-02-2010        amendezSAO113173    Se modifica la funcion <fsbdirsugerida>
22-02-2010        amendezSAO112877    Se modifica el metodo <buscaCoincidencia>
                                      para que inicialice a NULL y no a cero
                                      la gramatica padre,  cuando no puede parsear
                                      la direccion.
                                      Se modifica <checksyntax>,<fsbdirsugerida>
                                      comparando con null y no con cero, cuando verifique
                                      gramaticas que no pudieron ser calculadas.

10-02-2010        amendezSAO109561    Se modifica:
                                      <BuscaCoincidencia>,<CheckSyntax>

04-02-2010        juzuriagaSAO109564  (Ref amendez) Se modifica
                                      <BuscaCoincidencia>,<ParticionarToken>

01-02-2010        amendezSAO109563    Se modifica <InsertAddress>,<CheckIfAddressExistsInDB>
                                      Nuevo metodo <ValidaNombreVia>

29-01-2010        juzuriagaSAO109562  (Ref amendez)
                                      Se Se modifica tipo tyrcDirParseada
									  Se modifica:
                                      <ValidaCantVias>,<CheckSyntax>

05-01-2009        amendezSAO109552    Se ajusta a partir de BD_BOParser
                                      para que soporte parseo contra vias y
                                      segmentos de la base de datos.

23-dic-2009       aavelez109557       Se estabiliza para version 7.2.000.00
21-05-2009        jhramirezSAO94872   Creacion.
                                      Se crean los sgtes metodos.
                                      <<retDireccionParseada>>
                                      <<
                                      >>
******************************************************************/

    -- Registro para validacion de ingreso de padres en la tabla AB_DOMAIN_VALUES por el TRIGGER de validacion..
    TYPE tyrcValuesDomainTrigger IS RECORD
	(
        nuDomainValueIdNew      ab_domain_values.domain_value_id%type,
        nuDomainCompIdNew       ab_domain_values.domain_comp_id%type,
        nuDomainValueFatherNew  ab_domain_values.father_id%type
	) ;

	TYPE tytbValuesDomainTrigger IS TABLE OF tyrcValuesDomainTrigger INDEX BY BINARY_INTEGER;

    tbValuesDomainTrigger tytbValuesDomainTrigger;

     TYPE tyrcDomainValues IS RECORD
    (
        nuDomainCompId       ab_domain_comp.domain_comp_id%type,
        sbDomainCompName     ab_domain_comp.name_%type,
        nuDomainCompFather   ab_domain_comp.father_id%type,
        nuDomainValueId      ab_domain_values.domain_value_id%type,
        nuDomainValueFather  ab_domain_values.father_id%type,
        sbValue              ab_domain_values.value%type
    );


    type tytbDomainValues IS table of tyrcDomainValues index BY binary_integer;

    TYPE tyrcDirParseada IS RECORD
    (
        sbDirFmtoLibre    ab_address.address%type,
        sbDirParseada     ab_address.address_parsed%type,
        sbComplemento     ab_address.address_complement%type,
        tbDireccion       UT_String.TyTb_StrParameters,                -- Tabla de tokens de direccion (solo tokens no complemento)
        tbDirePadre       UT_String.TyTb_StrParameters,
        tbComplemento     UT_String.TyTb_StrParameters,                -- tabla pl/sql de complementos de la direccion
        nuPrimeraVia      ab_way_by_location.way_by_location_id%type,  -- Codigo de la primera via si se encontro en la tabla de vias
        nuSegundaVia      ab_way_by_location.way_by_location_id%type,  -- Codigo de la segunda via si se encontro en la tabla de vias
        sbPrimeraVia      ab_way_by_location.description%type,         -- Descripcion de la primera via (La via existe si onuPrimeraVia es no nulo)
        sbSegundaVia      ab_way_by_location.description%type,         -- Descripcion de la segunda via (La via existe si onuSegundaVia es no nulo)
        nuViasEnGramatica number,                                      -- numero de vias de la gramatica
        nuIdGramaPadre    bd_gramatica.id_gramatica%type,              -- Gramatica padre de la gramatica que cumple con la direccion en formato libre
        nuIdGramaHja      bd_gramatica.id_gramatica_padre%type,        -- Gramatica hija que cumple con la direccion en formato libre
        nuCasa            ab_address.house_number%type,
        sbCasa            ab_address.house_letter%type,
        nuSegmento        ab_segments.segments_id%type,
        tbExitos          UT_String.TyTb_StrParameters,                -- tabla pl/sql con la que se logro mayor numero de exitos en la comparacion gramatical
        nuGramaExitos     bd_gramatica.id_gramatica%type,              -- gramatica con la que se obtuvo el mayor numero de exitos en la comparacion
        nuGeoLocation     ge_geogra_location.geograp_location_id%type
    );


    type tytbSymbols IS table of varchar2(1) index BY binary_integer;


	-- Declaracion de metodos publicos
    FUNCTION fsbVersion  return varchar2;

    /*****************************************************************
    Unidad      :   obtieneDireccion
    Descripcion	:   dada una tabla de tipo UT_String.TyTb_StrParameters
                    retorna la direccion como VARCHAR2. segun el orden en
                    que se encuentren los simbolos en la tabla.

    Parametros      Descripcion
    ============    ===================
    itbDirGrama     tabla pl/sql con los tokens de la direccion analizada
    itbComplemento  tabla pl/sql con los complementos de la direccion analizada
    osbDireccion    Direccion parseada
    osbComplemento  Complemento de la direccion parseada
    osbCasa         Altura o casa

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
	11-11-2010    amendezSAO131516      Optimizacion parametros OUT
    10-01-2010    amendezSAO109552      Se modifica para que no coloque
                                        el nombre del token VIA
                                        Recibe tabla pl/sql de complementos
                                        para completar la direccion parseada
                                        Retorna adiconalmente el parametro
                                        complemento
    29-05-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    PROCEDURE obtieneDireccion
    (
        itbDirGrama     IN  UT_String.TyTb_StrParameters,
        itbComplemento  IN  UT_String.TyTb_StrParameters,
        osbDireccion    OUT NOCOPY ab_address.address%type,
        osbComplemento  OUT NOCOPY ab_address.address_complement%type,
        onuCasa         OUT NOCOPY ab_address.house_number%type,
        osbCasa         OUT NOCOPY ab_address.house_letter%type
    );


    /*****************************************************************
    Unidad      :   fbldireccionValida
    Descripcion	:   retorna si una direccion es valida con respecto a la gramatica
                    para ese estandar.
    Parametros          Descripcion
    ============        ===================
    isbDireccion        Direccion en formato libre
    inuUbicGeograf      Ubicacion Geografica

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-01-2010    amendezSAO109552      Se adiciona parametro ubicacion Geografica
    09-06-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    FUNCTION fbldireccionValida
    (
        isbDireccion    IN ab_address.address%type,
        inuUbicGeograf  IN ge_geogra_location.geograp_location_id%type
    )
    RETURN BOOLEAN;


    --
    -- =========================================================================
    --
    PROCEDURE CheckSyntax
    (
        isbDireccion       in            ab_address.address%type,
        inuGeoLocation     in            ge_geogra_location.geograp_location_id%type,
        orcDirParseada     IN OUT nocopy tyrcDirParseada,
        isbuseCache        in            varchar2 default 'Y'
    );


    /*****************************************************************
    Unidad      :   CheckSyntax
    Descripcion	:   Calcula la direccion parseada
    ****************************************************************/
    PROCEDURE CheckSyntax
    (
        address           IN VARCHAR2,
        inuGeoLocation     IN NUMBER,
        addressParsed     OUT VARCHAR2,
        nuErrorCode       OUT NUMBER,
        sbErrorMessage    OUT VARCHAR2
    );


    /*****************************************************************
    Unidad      :   InsertAddress
    Descripcion	:   Parsea y almacena la direccion en ab_address
    ****************************************************************/
    PROCEDURE InsertAddress
    (
        inuGeoLocationId  in     ab_address.geograp_location_id%type,
        isbAddress        in     ab_address.address%type,
        inuNeighbortId    in     ab_address.neighborthood_id%type,
        isbIsUrban        in     ab_address.is_urban%type,
        ionuParser_id     in out nocopy ab_address.address_id%type,
        osbDirParseada    out nocopy  ab_address.address_parsed%type,
        onuFatherAdd_id   out nocopy ab_address.address_id%type,
        isChildAddress    in     varchar2 default 'Y',
        isbVerified       in     ab_address.verified%type default 'N'
    );


    /*****************************************************************
    Unidad      :   fsbDominioComplemento
    Descripcion	:   retorna dominio correspondiente a token complemento
    ******************************************************************/
    FUNCTION fsbDominioComplemento
    RETURN VARCHAR2;


    /*****************************************************************
    Unidad      :   fsbDirSugerida
    Descripcion	:   Arma una direccion sugerida, con base en la gramatica
                    con la que tuvo el mayor numero de coincidencias
    ****************************************************************/
    FUNCTION  fsbDirSugerida
    (
        inuGeoLocationId  in  ab_address.geograp_location_id%type,
        isbDirFmtoLibre   in ab_address.address%type
    )
    RETURN ab_address.address%type;


    /*****************************************************************
    Unidad      :   CheckIfAddressExistsInDB
    Descripcion	:   Funcion que retorna el codigo de una direccion
                    si existe en el Banco de direcciones, si no existe
                    o se encontro alguna inconsistencia en el parseo
                    y validez de la direccion retorna -1
    ****************************************************************/
    function CheckIfAddressExistsInDB
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type,
        nuErrorCode       OUT NOCOPY NUMBER,
        sbErrorMessage    OUT NOCOPY VARCHAR2
    )
    RETURN ab_address.address_id%type;

    /*****************************************************************
    Unidad      :   CheckIfAddressExistsInDB
    Descripcion	:   Funcion que retorna el codigo de una direccion
                    si existe en el Banco de direcciones, si no existe
                    o se encontro alguna inconsistencia en el parseo
                    y validez de la direccion retorna -1
    ****************************************************************/
    FUNCTION CheckIfAddressExistsInDB
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type
    )
    RETURN ab_address.address_id%type;

    /*****************************************************************
    Unidad      :   ValidaNombreVia
    Descripcion	:   Valida el nombre para una nueva via

    ****************************************************************/
    PROCEDURE ValidaNombreVia
    (
        isbNombreVia IN ab_address.description%type
    );

    /*****************************************************************
    Unidad      :   fsbObtValorTokensDomicilios
    Descripcion	:   Obtiene una cadena con los valores de los domicilios a sugerir

    ****************************************************************/
    FUNCTION fsbObtValorTokensDomicilios
    (
        inuIdGeoLoc         IN  ab_address.geograp_location_id%type,
        isbDireccion        IN  ab_address.address%type,
        isbTokenFiltro      IN  VARCHAR2
    )RETURN VARCHAR2;

    /*****************************************************************
    Unidad      :   CompletaRegisDir
    Descripcion	:   Llena algunos campos de la direccion a insertar
                    o actualizar
    ****************************************************************/
    PROCEDURE CompletaRegisDir
    (
        inuGeoLocationId IN ab_address.geograp_location_id%type,
        isbIsUrban       IN VARCHAR2,
        ionuParser_id    IN out nocopy ab_address.address_id%type,
        ircDirParseada   IN tyrcDirParseada,
        orcDir           IN out nocopy daab_address.styAB_address
    );

    /*****************************************************************
    Unidad      :   validateRuralAddress
    Descripcion	:   Parsea la direccion y retorna si la direccion es valida

    ****************************************************************/
    PROCEDURE validateRuralAddress
    (
        isbAddress          in  ab_address.address_parsed%type,
        inuGeoLocationId    in  ge_geogra_location.geograp_location_id%type,
        isbIsUrban          in  ab_address.is_urban%type,
        osbValid            out nocopy ab_address.is_valid%type,
        orcDirParseada      out nocopy tyrcDirParseada,
        isChildAddress      in  varchar2 default 'Y'
    );

    FUNCTION fsbGetAddressTokenValue
    (
        isbAddress      IN ab_address.address%type,
        isbToken        IN VARCHAR2

    ) RETURN VARCHAR2;


    PROCEDURE  FixSpaces
    (
        iosbText in out nocopy varchar2
    );

    /*****************************************************************
    Unidad      :   InsAddressTransaction
    Descripcion	:   Parsea y almacena la direccion en ab_address
    ****************************************************************/
    PROCEDURE InsAddressTransaction
    (
        inuGeoLocationId        in ab_address.geograp_location_id%type,
        isbAddress              in ab_address.address%type,
        inuNeighbortId          in ab_address.neighborthood_id%type,
        isbIsUrban              in ab_address.is_urban%type,
        inuPreviousValue        IN ab_address.previous_value%type,
        isbComment              IN ab_address.description%type,
        inuPremiseTypeId        IN ab_premise.premise_type_id%type,
        ionuParser_id           IN OUT nocopy ab_address.address_id%type
    );

    /*****************************************************************
    Unidad      :   GetValueDomain
    Descripcion	:   Obtiene valor especifico del dominio.
    ****************************************************************/
    PROCEDURE GetValueDomain
    (
        isbTagComposition   in   ab_domain_comp.name_%type,
        osbValue            out  ab_domain_values.value%type
    );

    /*****************************************************************
    Unidad      :   fnuFindAddress
    Descripcion	:   Metodo encargado retornar el ID para direccion recibida en formato libre.
                    Si no existe retorna -1.
    ****************************************************************/
    FUNCTION fnuFindAddress
    (
        isbAddress        in ab_address.address%type,
        inuGeoLocationId  in ab_address.geograp_location_id%type
    ) return ab_address.address_id%type;

    /*****************************************************************
    Unidad      :   ObjCheckAddressExists
    Descripcion	:   Metodo encargado retornar el ID para direccion recibida en formato libre.
                    Si no existe retorna -1.
    ****************************************************************/
    FUNCTION ObjCheckAddressExists
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type
    )
    RETURN ab_address.address_id%type;
END LDC_AB_Boparser;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.LDC_AB_Boparser
IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : AB_Boparser  (Actualizado de BD_BOParser)
Descripcion    : Paquete que contiene los metodos necesarios para parsear una
                 cadena de direccion.
Autor          : Jhonathan Ramirez H.
Fecha          : 21/05/2009


Historia de Modificaciones
Fecha             Autor               Modificacion
=========         =========           ====================
16-05-2013        hcruz.SAO207994     Modificacion del metodo InsertAddress
15-05-2013        hcruz.SAO208014     Modificacion del metodo BuscarPrimeraVia para
                                      que al particionar, el identificador de la via
                                      no se asignado inmediatamente a la primera via
                                      sino que se valida quien es realmente.
21-03-2013        hcruz.SAO204930     Modificacion del procedimiento CheckIfAddressExistsInDB
20-12-2012        amendezSAO198457    Estabilizacion SAOS 198268,198272
                                      Se modifica <obtieneDireccion>
                                      fsbformatoDir><retTokens>
18-12-2012        amendezSAO198254    Se elimina <ValidaRangosSimbolos><fblEsToken>
                                      Se modifica <fblEsTokenSinonimo><fsbTokenBase>
                                      <CheckSyntax>
                                      Nuevo  metodo <fblEsSinonimoPalabraVia>
12-12-2012        amendezSAO197917    Nuevos metodos  <fsbTokenBase><LoadTokens>
                                      <fblesComplemento><fblEsTokenSinonimo><fnuDomainId>
                                      Se modifica <proSimboloGrama><retTokens>
                                      <separaComplemento>
11-12-2012        amendezSAO195302    Se modifica <cargaGramatica>,<BuscaCoincidencia>
                                      <fsbAddressFather><fsbIsRootGrammar><fnuPreviousGrammarLevel>
14-11-2012        amendezSAO195930    Se modifica <BuscaCoincidencia>
06-10-2012        Juzuriaga.SAO191345 Se modifica el metodo <InsertAddress>
16-06-2012        cpantojaSAO186506   Se crea <<ObjCheckAddressExists>>
15-05-2012        hcruz.SAO181951     Se modifica el metodo CompletaRegisDir
14-05-2012        hcruz.SAO182280     Se modifica el metodo CompletaRegisDir
23-03-2012        hcruz.SAO177713     1 - Se modifica el metodo cargaGramatica y el tipo tyrcGramatica
                                      2 - Se incluye solucion al SAO179708. Se modifica el metodo CheckSyntax
                                      y se adiciona a tyrcDirParseada el campo nuGeoLocation para el manejo
                                      de la ubicacion geografica
14-03-2012        hcruz.SAO176067     Se crea el metodo fnuFindAddress
01-03-2012        hcruz.SAO174571     Se modifica el metodo InsAddressTransaction
19-01-2012        cocampo.SAO171487   1 - Se modifica el metodo <<buscaCoincidencia>>
16-01-2012        cocampo.SAO171139   1 - Se modifica el metodo ValidaCantVias.
                                      2 - Se modifica el nombre de la variable blGramaticaOK por blGramViasOK
                                          Se realiza impacto de cambio de nombre de variable en los metodos:
                                                    <<insertAddress>> <<validateRuralAddress>>
                                                    <<CheckSyntax>> <<ValDomainToken>> <<buscaCoincidencia>>
06-12-2011        cocampo.SAO153779   1 - Se a?ade tabla PL para ser utilizada por el trigger de validacion
                                          de ingreso de padres en la tabla AB_DOMAIN_VALUES.description
                                          (Evitar Tabla Mutante)
03-12-2011        caguilar.SAO167829  1 - Se modifica el procedimiento <ValidateRuralAddress>
01-12-2011        caguilar.SAO165655  1 - Estabilizacion amendezSAO166967. Se modifican las funciones
                                      <fsbFormatoDir> y <fsbAddressFather>.
                                      2 - Estabilizacion amendezSAO166967. Se crean las funciones
                                      <fnuGetGrammarIndexById> y <fnuPreviousGrammarLevel>.
                                      3 - Estabilizacion amendezSAO165262. Se modifica el procedimiento
                                      <ValidateRuralAddress> y el procedimiento <insertAddress>.
                                      4 - Estabilizacion amendezSAO166967. Se modifica el procedimiento
                                      <CargaGramatica>, el procedimiento <insertAddress> y el
                                      procedimiento <DespliegaGramatica>  y crea la funcion <fsbIsRootGrammar>
                                      5 - Estabilizacion amendezSAO166967. Se modifica el metodo <fsbDirSugerida>
                                      6 - Estabilizacion amendezSAO166967. Se modifica el metodo <fsbDirSugerida>
04-11-2011        cocampoSAO165227    Se modifica InsertAddress.
04-11-2011        cocampoSAO165166    Estabilizacion SAO164859. Se modifica InsertAddress.
25-10-2011        caguilarSAO163855   Se agrega la variable global blSymbols de
                                      tipo booleana. Ademas, se agrega en el procedimiento
                                      <GetSymbols> el flag de validacion para evitar que
                                      se realice la consulta si el cache esta vacio pero
                                      por que la consulta no arroja datos.
16-10-2011        cocampoSA162697     1 - Se modifica el metodo
                                            <ValDomainToken.ValConfigExpression>
30-09-2011        cocampoSAO148875    1 - Se crean los metodos:
                                             <ValDomainToken>
                                             <GetValueDomain>
                                      2 - Se modifica el metodo:
                                             <CheckSyntax>
                                             <BuscaCoincidencia>
                                             <validateRuralAddress>
22-09-2011        juzuriaga.SAO158497 Se modifica <ValidaCantVias>
12-07-2011        JgutierrezSAO158072 Se modifica <InsertAddress>
07-07-2011        JuzuriagaSAO153539  Estabilizacion.SAO150916 Se modifica <InsertAddress>
17-05-2011        cocampoSAO149457    Se modifica <InsertAddress>
13-05-2011        cocampoSAO148073    Estabilizacion SAO147913. Se modifica <ActualizaDireccion>
20-04-2011        amendezSAO146905    Estabilizacion Branch 146690
                                      Se adiciona <ValidaNulidadToken>
                                      y modifica <BuscaCoincidencia>,
                                      <CheckSyntax>,<retTokens>,
                                      <fsbDirSugerida>
18-04-2011        juzuriagaSAO146723  se modifica <ActualizaDireccion>
15-04-2011        amendezSAO146345    Se modifica <retTokens>
14-04-2011        juzuriagaSAO146083  Se modifican los metodos:
                                                         <BuscarPrimeraVia>
                                                         <obtieneDireccion>
                                                         <IdentificarSegundaVia>
12-04-2011        juzuriagaSAO145876  Se modifican los metodos retTokens y obtCasaLetraNum
06/04/2011        jflorezSAO143738    Se adiciona el metodo <InsAddressTransaction>
                                      (Ref. jmunozSAO142056)
08/01/2011        cocampoSAO139484    Se modifica  <obtCasaLetraNum>
13/01/2011        hcruzSAO138308      Se modifica  <InsertAddress>,<CompletaRegisDir>
11-11-2010        amendezSAO131516    Se modifica  <InsertAddress>,<fsbformatoDir>
                                      Nuevo metodo <FixSpaces>
15-10-2010        JuzuriagaSAO130953  Se modifica  <InsertAddress>
19-09-2010        amendezSAO122447    Nuevo metodo privado <GetSymbols>
                                      Se modifica <fsbformatoDir>,<CompletaRegisDir>
                                      <ActualizaDireccion>
                                      Se elimina variable global gsbLastParsedDir
                                      se maneja en su reemplazo variables nocopy.
                                      Se elimina el metodo ValidaActualizSeleccID
07-09-2010        JUzuriagaSAO127106 se modifica el metodo InsertAddress
12-08-2010        JUzuriagaSAO124482  se modifica   InsertAddress
30-07-2010        JUzuriagaSAO120903  se modifica CheckIfAddressExistsInDB
21-07-2010        jgutierrezSAO120379 Se modifica CompletaRegisDir.
23-06-2010        JSSanchezSAO119660  Se agrega el metodo fsbGetAddressTokenValue
28-05-2010        JSSanchezSAO115242  Se colocan publicos los metodos CompletaRegiDir y
                                      ValidateRuralAddress
18-05-2010        JuzuriagaSAO115230  se modifica   InsertAddress
27-04-2010        aavelezSAO115231    Se modifica el metodo fsbformatoDir y
                                      el metodo InsertAddress, se crea el
                                      procedimiento privado validateRuralAddress
09-04-2010        jgutierrezSAO115247 Se modifican los metodos por el
                                      Borrado de ge_neighborthood:
                                      <CheckSyntax>
                                      <InsertAddress>
                                      <CheckIfAddressExistsInDB>
                                      <ValidaActualizSeleccID>

26-02-2010        amendezSAO113173    Se modifica la funcion <fsbdirsugerida>
22-02-2010        amendezSAO112877    Se modifica el metodo <buscaCoincidencia>
                                      para que inicialice a NULL y no a cero
                                      la gramatica padre,  cuando no puede parsear
                                      la direccion.
                                      Se modifica <checksyntax>,<fsbdirsugerida>
                                      comparando con null y no con cero, cuando verifique
                                      gramaticas que no pudieron ser calculadas.

10-02-2010        amendezSAO109561    Se modifica:
                                      <BuscaCoincidencia>,<CheckSyntax>

04-02-2010        juzuriagaSAO109564  (Ref amendez) Se modifica
                                      <BuscaCoincidencia>,<ParticionarToken>

01-02-2010        amendezSAO109563    Se modifica <InsertAddress>,<CheckIfAddressExistsInDB>
                                      Nuevo metodo <ValidaNombreVia>

29-01-2010        juzuriagaSAO109562  (Ref amendez)
                                      Se Se modifica tipo tyrcDirParseada
									  Se modifica:
                                      <ValidaCantVias>,<CheckSyntax>

05-01-2009        amendezSAO109552    Se ajusta a partir de BD_BOParser
                                      para que soporte parseo contra vias y
                                      segmentos de la base de datos.

23-dic-2009       aavelez109557       Se estabiliza para version 7.2.000.00
21-05-2009        jhramirezSAO94872   Creacion.
                                      Se crean los sgtes metodos.
                                      <<retDireccionParseada>>
                                      <<
                                      >>
******************************************************************/

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion                 constant varchar2(20)  := 'SAO207994';
    cnuLongitudCasaNumero      constant NUMBER(2)     := 5;
    cnuLongitudDireccion       constant NUMBER(3)     := 200;
    cnuLongitudComplemento     constant NUMBER(3)     := 100;

    csbTOKEN_VIA               constant varchar2(10)  := 'VIA';

    csbSeparator               constant VARCHAR(1)    := ' ';   --Separador de token de la direccion
    csbSeparAbierto1           constant VARCHAR(1)    := '<';   -- Apertura obligatoria.
    csbSeparAbierto2           constant VARCHAR(1)    := '[';   -- Apertura Opcional.
    csbSeparCerrado1           constant VARCHAR(1)    := '>';   -- Cerradura Obligatoria.
    csbSeparCerrado2           constant VARCHAR(1)    := ']';   -- Ceraddura Opcional.

    cnuErrGramaNoDef           constant number(6)     := 4340 ; -- La gramatica [%s1] NO esta bien definida
    cnuErrGramNoSimbolo        constant number(6)     := 3797 ; -- La gramatica "%s1" contiene simbolos no definidos en la tabla de simbolos.
    cnuErrGramTokenComplemento constant number(6)     := 4313 ; -- Error, La gramatica "%s1" contiene simbolo de complemento "%s2"
    cnuErrDirNoGrama           constant number(6)     := 4321 ; -- Direccion [%s1] no coincide con la gramatica.
    cnuERRTokenViaObligatorio  constant number(6)     := 3868 ; -- La gramatica "%s1" define el token VIA como obligatorio
    cnuLongExcedNumAltura      constant NUMBER(6)     := 3961 ; -- Longitud numerica excedida para Casa o Altura [%s1]
    cnuLongExcedLetrAltura     constant NUMBER(6)     := 3996 ; -- Longitud alfanumerica excedida para Casa o Altura [%s1]
    cnuNoExisteVia             constant NUMBER(6)     := 4131 ; -- No existe la via [%s1]
    cnuSegmentoNoCalculado     constant NUMBER(6)     := 4314 ; -- El sistema no pudo calcular segmento para la direccion [%s1]
    cnuNoEncontroDir           constant NUMBER(6)     := 4167 ; -- No se encontro direccion [%s1] para la ubicacion geografica [%s2] y el barrio [%s3]
    cnuDireccionExiste         constant NUMBER(6)     := 4181 ; -- La direccion [%s1] ya existe para la localidad [%s2] y el barrio [%s3]
    cnuNombreViaToken          constant NUMBER(6)     := 4632 ; -- El nombre o descripcion de la via [%s1] contiene simbolos o palabras reservadas.
    cnuTokenNulo               constant NUMBER(6)     := 9742 ; -- El simbolo [%s1] no tiene valor
    cnuAddressNull             constant NUMBER(6)     :=10456 ; -- La direccion ingresada es nula
    cnuIsUrbanFlagNull         constant number(6)     :=11521 ; -- El indicador (Es Urbana) para la direccion (%s1), no puede ser nulo
    cnuLongitudViaExced        constant NUMBER(6)     := 9782 ; -- El nombre de la via no puede exceder %s1 caracteres
    cnuLongitudCompExced       constant NUMBER(6)     := 901924;-- Error analizando direccion, su complemento excede los (%s1) caracteres
    cnuLongitudDirExced        constant NUMBER(6)     := 901925;-- Error analizando direccion, su longitud excede los (%s1) caracteres
    csbDominioComplemento      constant varchar2(18)  := 'ADDRESS_COMPLEMENT';
    csbSINONIMO_PALABRA_DE_VIA constant VARCHAR2(30)  := 'WAY_WORD_SYNONYM';
    cnuLongMaxVia              constant number(6)     := 100;
    csbSemiNormalized          constant varchar2(3)   := 'M';   -- Estado intermedio de Normalizacion de Ubicaciones geograficas (SemiNormalizada)
    cnuErrComplement           constant NUMBER(6)     := 900352; --La gramatica [%s1] no admite complemeto.
    -- Errores para el manejo de dominios en la gramatica
    cnuErrLongDomain           constant NUMBER(6)     := 900348;
    cnuErrConfFather           constant NUMBER(6)     := 900349;
    cnuErrRange                constant NUMBER(6)     := 900350;
    cnuErrExpr                 constant NUMBER(6)     := 900351;
    cnuErrorFatherType         constant NUMBER(6)     := 900413;  -- No es posible crear la direccion ya que la direccion principal [%s1] ya existe y es de diferente tipo a la direccion actual
    cnuErrorAltern             constant NUMBER(6)     := 901737;  -- No es posible crear la direccion, debido a que la posible direccion principal [%s1] ya existe y es alterna de otra direccion.
    --
    csbYes                     constant varchar2(1)   := ge_boconstants.csbYES;
    csbNO                      constant varchar2(1)   := ge_boconstants.csbNO;

    -- Flag para no esperar en actualizaciones de DAO (for UPDATE nowait)
    cnuNoWait                  constant number(1)     := 1;
    cnuAddressNotExists        constant number(1)     := -1;

    cnuErrTokenNoExiste        constant number(6)     := 4367 ; -- Token [%s1] no existe.

    --------------------------------------------
    -- Declaracion de Tipos de datos
    --------------------------------------------
    TYPE tyrcSimboloGra IS RECORD
    (
        sbSimbolo           Varchar2(100),
        sbEsObligatorio     Varchar2(1)
    );

    TYPE tytbSimbolos IS TABLE OF tyrcSimboloGra INDEX BY binary_integer;

    TYPE tyrcGramatica IS RECORD
    (
        id_gramatica                bd_gramatica.id_gramatica%type,
        id_gramatica_padre          bd_gramatica.id_gramatica_padre%type,
        gramaticaEntera             bd_gramatica.gramatica%type,
        sbTbSimbolos                tytbSimbolos,
        nuCantidadVias              number,
        rootGrammar                 varchar2(1)
    );



    TYPE tytbGramatica IS TABLE OF tyrcGramatica INDEX BY binary_integer;
	-- Declaracion de variables publicas

    type tyrcToken IS record
    (
        sbRootToken                 ab_token_hierarchy.token_hierarchy_id%type,
        sbTokenDomain               ab_token_hierarchy.token_domain%type,
        nuHierarchy                 ab_token_hierarchy.hierarchy%type,
        nuDomainId                  ab_token_hierarchy.domain_id%type
    );
    -- Tabla indexada por token, cada posicion contiene el token base.
    type tytbTokens IS table of tyrcToken INDEX BY varchar2(100);


    --------------------------------------------
    -- Variables globales
    --------------------------------------------

    sbVALID_ADDRESS            varchar2(1);
    sbTOKEN_CASA               VARCHAR2(100);

    nuLastFatherAddressId   ab_address.address_id%type;

    -- Cache para gramatica
    tbgGramatica               tytbGramatica;
    blGramaticaCargada         BOOLEAN := FALSE;

    -- Cache para direccion parseada, solo se guarda en cache una direccion
    -- que supere todas las validaciones.
    rcCacheDirParseada         tyrcDirParseada;

    blParametros               BOOLEAN               := FALSE;

    -- Simbolos configurados como token o sinonimo
    gtbSymbols                 tytbSymbols;

    -- Flag de consulta de Simbolos configurados como token o sinonimo
    blSymbols                  BOOLEAN               := TRUE;

    -- Flag para indicar si la gramatica y las vias de una direccion son correcta
    blGramViasOK              BOOLEAN               := TRUE;

    -- Tabla para almacenar los valores de los dominios
    tbDomainValues             tytbDomainValues;

    -- Tabla que contiene todos los simbolos del banco de direcciones
    gtbAllTokens               tytbTokens;


	-- Definicion de metodos publicos y privados del paquete
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /***************************************************************************/
    --METODOS PRIVADOS.
    PROCEDURE get_parameters;
    PROCEDURE DespliegaTokens
    (
        itbTokens in UT_String.TyTb_StrParameters
    );
    PROCEDURE DespliegaGramatica
    (
        ircGramatica in tyrcGramatica
    );
    PROCEDURE ValidaCantVias
    (
        inuViasEnGramatica in number,
        isbDireccion       IN VARCHAR2,
        inuPrimeraVia      in ab_way_by_location.way_by_location_id%type,
        inuSegundaVia      in ab_way_by_location.way_by_location_id%type,
        isbPrimeraVia      IN ab_way_by_location.description%type,
        isbSegundaVia      IN ab_way_by_location.description%type,
        inuGeoLocation     IN ab_way_by_location.geograp_location_id%type
    );
    PROCEDURE ValSegmento
    (
        inuSegmento  IN ab_segments.segments_id%type,
        inuCantVias  IN NUMBER,
        isbDireccion IN ab_address.address%type
    );
    PROCEDURE separaComplemento
    (
        iotbDireccion   IN OUT nocopy UT_String.TyTb_StrParameters,
        otbComplemento  out nocopy UT_String.TyTb_StrParameters
    );

    PROCEDURE retTokens
    (
        isbDireccion    in  ab_address.address%type,
        otbDireccion    out nocopy UT_String.TyTb_StrParameters
    );
    PROCEDURE GetSymbols
    (
        otbSymbols out nocopy tytbSymbols
    );
    PROCEDURE ValidaNulidadToken
    (
        iotbTokens      IN OUT nocopy UT_String.TyTb_StrParameters
    );
    FUNCTION fsbIsRootGrammar( inuGrammarId in bd_gramatica.id_gramatica%type )
    return varchar2;

    FUNCTION fnuGetGrammarIndexById( inuGrammarId in bd_gramatica.id_gramatica%type)
    return binary_integer;

    FUNCTION fnuPreviousGrammarLevel( inuGrammarId in bd_gramatica.id_gramatica%type )
    return binary_integer;

    FUNCTION fsbTokenBase
    (
        isbToken    in varchar2
    )
    RETURN varchar2;

    PROCEDURE LoadTokens;

    FUNCTION fblesComplemento
    (
        isbSimbolo    in  ab_token_hierarchy.token_hierarchy_id%type,
        onuHierarchy  out ab_token_hierarchy.hierarchy%type
    ) RETURN BOOLEAN;

    FUNCTION fnuDomainId
    (
        isbSimbolo    in  ab_token_hierarchy.token_hierarchy_id%type
    )
    RETURN ab_token_hierarchy.domain_id%type;

    FUNCTION fblEsSinonimoPalabraVia
    (
        isbToken in VARCHAR2,
        osbTokenPpal out varchar2
    )
    RETURN BOOLEAN;



    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------



    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   fblEsToken
                    fblEsToken (Nombre Anterior)
    Descripcion	:   Retorna si una cadena de caracteres es un token

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha         Autor                 Modificacion
    ============  ===================   ====================
    18-12-2012    amendezSAO198254      Excluye los sinonimos de palabras
    12-12-2012    amendezSAO197917      Utiliza cache.
    21-05-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    FUNCTION fblEsToken
    (
        isbToken        in varchar2
    )
    RETURN BOOLEAN
    IS
    BEGIN
        LoadTokens;

        return gtbAllTokens.exists( isbToken )
               AND gtbAllTokens( isbToken ).sbTokenDomain != csbSINONIMO_PALABRA_DE_VIA;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblEsToken;


    /*****************************************************************
    Unidad      :   FixSpaces
    Descripcion	:   Ajusta a un espacio cualquier ocurrencia de multiples
                    espacios consecutivos en la cadena y elimina espacios
                    en los extremos

    Parametros          Descripcion
    ============        ===================
    iosbText            Cadena a modificar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    11-11-2010      amendezSAO131516    Creacion.
    ******************************************************************/
    PROCEDURE  FixSpaces
    (
        iosbText in out nocopy varchar2
    )
    IS
    BEGIN

        loop
            iosbText := ut_string.strreplace(iosbText,'  ',' ');
            exit when instr(iosbText,'  ') = 0;
        END loop;

        --Quita los espacios a los extremos
        iosbText := trim(iosbText);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   fsbformatoDir
    Descripcion	:   Se Analiza la cadena y se quitan espacios sobrantes
                    y caracteres extra?os como enter u otros.

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-12-2012      amendezSAO198457      Estabilizacion SAO198272
                                          Validacion de longitud maxima de
                                          direccion y complemento
    01-12-2011      caguilar.SAO165655    1 - Estabilizacion amendezSAO166967. Se genera espacios a
                                          los lados del token altura.
    11-11-2010      amendezSAO131516      Se encapsula en metodo a parte conversion
                                          de multiples espacios en uno solo.
    19-09-2010      amendezSAO122447      Se utiliza los simbolos configurados
                                          en token y sinonimos: (De longitud 1
                                          y que no son caracteres alfabeticos)
                                          para que sean interpretados como palabras
                                          individuales colocando a sus lados el
                                          caracter espacio.
                                          De esta manera ya no quedan "quemados"
                                          estos simbolos.
    27-04-2010      aavelezSAO115232      Se modifica el metodo de reemplazo de
                                          espacios dobles en la cadena
    29-05-2009      jhramirezSAO94872     Creacion.
    ******************************************************************/
    FUNCTION fsbformatoDir
    (
        isbFormatoPala      in  varchar2
    )
    RETURN varchar2
    IS
        sbFormatoPalabra  varchar2(2000);

        -- Simbolos configurados como token o sinonimo
        tbSymbols         tytbSymbols;
        nuIndex           binary_integer;
    BEGIN

        ut_trace.Trace('Inicia AB_BOParser.fsbformatoDir', 2);

        GetSymbols(tbSymbols);

        sbFormatoPalabra    := isbFormatoPala;

        nuIndex := tbSymbols.first;
        loop
            exit when nuIndex IS null;
            ut_trace.trace('Reemplazando {'||tbSymbols(nuIndex)||'} por { '||tbSymbols(nuIndex)||' }',2);
            sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,tbSymbols(nuIndex),' '||tbSymbols(nuIndex)||' ');

            nuIndex := tbSymbols.next(nuIndex);
        END loop;

        if sbTOKEN_CASA IS not null then
            ut_trace.trace('Reemplazando {'||sbTOKEN_CASA||'} por { '||sbTOKEN_CASA||' }',2);
            sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,sbTOKEN_CASA,' '||sbTOKEN_CASA||' ');
        END if;

        sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,chr(9) ,' ');   --Reemplaza los caracteres de tab por 1 espacio.
        sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,chr(10),' ');   --Quita los Enter.
        sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,chr(13),' ');   --Quita los Enter.

        for nuIdx in 1..10 loop
            sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,chr(32),' ');   --Reemplaza los caracteres doble espacio por 1 espacio.
        END loop;

        --Por si hay varios espacios consecutivos, deja solo 1 espacio.
        FixSpaces( sbFormatoPalabra );

        --CASOS ESPECIALES.
        sbFormatoPalabra    := ut_string.strreplace(sbFormatoPalabra,'PO BOX','PO_BOX');

        IF length(sbFormatoPalabra) > cnuLongitudDireccion then
            -- Error analizando direccion, su longitud excede los (%s1) caracteres
            errors.setError(cnuLongitudDirExced, cnuLongitudDireccion);
            raise ex.CONTROLLED_ERROR;
        END if;

        ut_trace.trace('Direccion con formato['||sbFormatoPalabra||']',2);
        ut_trace.Trace('END AB_BOParser.fsbformatoDir', 2);

        RETURN sbFormatoPalabra;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbformatoDir;


    /*****************************************************************
    Unidad      :   obtieneSeparador
    Descripcion	:   Obtiene el separador de apertura o de Cerrado
                    de la gramatica que esta mas proximo, ya sea  '<,['  o  '>,]'
    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
	11-11-2010    amendezSAO131516      Evita warning pl/sql retornando 0
    01-06-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    FUNCTION obtieneSeparador
    (
        nuIndiceSt1         in  number,
        sbGramatica         in  bd_gramatica.gramatica%type,
        sbAbiertoCerrado    in  varchar2,
        sbSeparator         out nocopy varchar2
    )
    RETURN  number
    IS
        nuId    number;
        nuId2   number;
    BEGIN
        ut_trace.trace('INICIA AB_Boparser.obtieneSeparador',10);

        --Si el Operador a buscar es de apertura.
        if (sbAbiertoCerrado = 'A') then
            --Obtiene el operador de apertura ya sea <  o  [
            nuId    := INSTR(sbGramatica,csbSeparAbierto1,nuIndiceSt1,1);
            nuId2   := INSTR(sbGramatica,csbSeparAbierto2,nuIndiceSt1,1);

            IF ( nuId > 0 AND (nuId < nuId2 OR nuId2 = 0) ) THEN
                sbSeparator := csbSeparAbierto1;
                return nuId;
            elsif ( nuId2 > 0 AND (nuId2 < nuId OR nuId = 0) ) THEN
                sbSeparator := csbSeparAbierto2;
                return nuId2;
            else
                --Es porque los 2 no se encontraron, se debe retornar error.
                --La gramatia no esta bien definida.
                Errors.setError(cnuErrGramaNoDef, sbGramatica);
                raise ex.CONTROLLED_ERROR;
            end if;
         elsif ( sbAbiertoCerrado = 'C' ) then
            --Obtiene el operador de cerrado ya sea >  o  ]
            nuId    := INSTR(sbGramatica,csbSeparCerrado1,nuIndiceSt1,1);
            nuId2   := INSTR(sbGramatica,csbSeparCerrado2,nuIndiceSt1,1);

            IF (nuId > 0 AND (nuId < nuId2 OR nuId2 = 0) ) THEN
                sbSeparator := csbSeparCerrado1;
                return nuId;
            elsif ( nuId2 > 0 AND (nuId2 < nuId OR nuId = 0) ) then
                sbSeparator := csbSeparCerrado2;
                return nuId2;
            else
                --Es porque los 2 no se encontraron, se debe retornar error.
                --La gramatia no esta bien definida.
                Errors.setError(cnuErrGramaNoDef, sbGramatica);
                raise ex.CONTROLLED_ERROR;
            END IF;
        END IF;

        RETURN 0;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtieneSeparador;

    /*****************************************************************
    Unidad      :   proSimboloGrama
    Descripcion	:   Procesa los simbolos de la gramatica para
                    colocarlos en una tabla,
                    Calcula el numero de vias de la gramatica
    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha         Autor               Modificacion
    ============  =================== ====================
    12-12-2012    amendezSAO197917      Utiliza cache en la busqueda de tokens
    10-01-2009    amendezSAO109552      Calcula el numero de vias en la gramatica
                                        Valida que la gramatica no posea tokens
                                        de complemento.

    27-05-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    PROCEDURE proSimboloGrama
    (
        isbGramatica     in  bd_gramatica.gramatica%type,
        otbTokensGrama   out nocopy tytbSimbolos,
        onuVias          out nocopy number
    )
    IS
        sbGramatica     bd_gramatica.gramatica%type;
        tbTokensGrama   tytbSimbolos;
        nuIndiceSt1     number  := 1;   --Indice Inici Token.
        nuIndiceSt2     number  := 1;   --Indice Inici Token.
        sbSeparator1    varchar2(1);    --Separador puede ser <,[
        sbSeparator2    varchar2(1);    --Separador puede ser >,]
        nuIndice        number := 1;    --Indice para la tabla
        sbSimbolo       ab_token_hierarchy.token_hierarchy_id%type;
        nuDummy         ab_token_hierarchy.hierarchy%type;

    BEGIN
        ut_trace.trace('INICIA AB_Boparser.proSimboloGrama',10);
        sbGramatica := trim(isbGramatica);

        onuVias     := 0;

        --Se debe suponer que la gramatica esta bien escrita. es decir
        --que las palabras que este ahi, sean tokens, o simbolos de la
        --tabla bd_simbolo_estandar, y que tengan los caracteres <> o []
        --los cuales indican que un simbolo es obligatorio o no.

        nuIndiceSt1  := obtieneSeparador(nuIndiceSt1,sbGramatica,'A',sbSeparator1); --Obtiene el operador de apertura. <,[
        nuIndiceSt2  := obtieneSeparador(nuIndiceSt1,sbGramatica,'C',sbSeparator2); --Obtiene separador de cerrado. >,]

        LOOP
            if (sbSeparator1 = csbSeparAbierto1 and sbSeparator2 = csbSeparCerrado1 ) then
                tbTokensGrama(nuIndice).sbEsObligatorio := 'Y'; --El Simbolo es obligatorio.
            elsif(sbSeparator1 = csbSeparAbierto2 and sbSeparator2 = csbSeparCerrado2 ) then
                tbTokensGrama(nuIndice).sbEsObligatorio := 'N'; --El Simbolo es Opcional.
            else
                --Se encontraron pero no son congruentes, puede ser que se tenga <SIMBOLO] o [SIMBOLO> o algo asi.
                --La gramatia no esta bien definida.
                Errors.setError(cnuErrGramaNoDef, sbGramatica);
                raise ex.CONTROLLED_ERROR;
            end if;

            --substrae el simbolo.
            sbSimbolo   := substr(sbGramatica,nuIndiceSt1 + 1, nuIndiceSt2 - nuIndiceSt1 - 1);

            --Valida si es token (Simbolo), si No lo es, lanza error, si no continua.
            -- Error, La gramatica "%s1" contiene simbolos no definidos en la tabla de simbolos.
            IF ( NOT fblEsToken(sbSimbolo)) THEN
                Errors.setError(cnuErrGramNoSimbolo, sbGramatica);
                raise ex.CONTROLLED_ERROR;
            END IF;

            --Valida que la gramatica no posea tokens de complemento
            IF (fblEsComplemento(sbSimbolo,nuDummy)) THEN
                -- Error, La gramatica "%s1" contiene simbolo de complemento "%s2"
                Errors.setError(cnuErrGramTokenComplemento, sbGramatica||'|'||sbSimbolo);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            tbTokensGrama(nuIndice).sbSimbolo   := sbSimbolo;

            IF sbSimbolo = csbTOKEN_VIA THEN
                IF  tbTokensGrama(nuIndice).sbEsObligatorio='Y' THEN
                    -- La gramatica "%s1" define el token VIA como obligatorio
                    Errors.setError(cnuERRTokenViaObligatorio,sbGramatica);
                    RAISE ex.CONTROLLED_ERROR;
                END IF;

                onuVias := onuVias + 1;
            END IF;

            --Sale
            EXIT WHEN nuIndiceSt2  >=  length(sbGramatica);
            nuIndiceSt1  := ObtieneSeparador(nuIndiceSt2,sbGramatica,'A',sbSeparator1);--Obtiene el operador de apertura. <,[
            nuIndiceSt2  := ObtieneSeparador(nuIndiceSt1,sbGramatica,'C',sbSeparator2);--Obtiene separador de cerrado. >,]
            nuIndice     := nuIndice + 1;
        END LOOP;
        otbTokensGrama  := tbTokensGrama;
        ut_trace.trace('TERMINA AB_Boparser.proSimboloGrama',10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END proSimboloGrama;



    /*****************************************************************
    Unidad      :   cargaGramatica
    Descripcion	:   Procedimiento que carga en cache, los datos de las gramaticas.
                    Como parte de los datos, identifica si una gramatica particular
                    es BASE.
                    Ej. Si se tiene las gramaticas ordenadas
                        gramatica1 = [VIA]</ALT/>
                        gramatica2 = [VIA]</ALT/><TORRE>
                        gramatica3 = [VIA]</ALT/><TORRE><CUERPO><PISO>
                    Solo la gramatica 1 es Base o raiz de las demas gramaticas
                    "similares".

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    11-12-2012      amendezSAO195302    Solo tiene en cuenta para establecer gramaticas base,
                                        las gramaticas "padre", es decir, solo las que definen
                                        como va a quedar registrada direccion.
    23-03-2012      hcruzSAO177713      Se elimina la referencia al campo ID_Tipo_Direccion
    01-12-2011      caguilarSAO165655   Estabilizacion amendezSAO166967. se identifica la
                                        gramatica Base mediante un flag, en el registro
                                        de la tabla pl de cada gramatica.
    10-01-2010      amendezSAO109552    Se coloca manejo de cache a la gramatica
                                        para mejorar el performance por SESSION.
    27-05-2009      jhramirezSAO94872   Creacion.
    ******************************************************************/
    PROCEDURE cargaGramatica
    IS
        tbGramatica     tytbGramatica;
        nuIndice        binary_integer;
        nuIndPrev       binary_integer;
        tbTokensGrama   tytbSimbolos;
        nuViasGrama     number;
        sbPrevGrammar   bd_gramatica.gramatica%type;
        --Solo utiliza las gramaticas que son hijas.
        --No Obtiene las gramaticas padres.
    BEGIN
        ut_trace.trace('INICIA AB_Boparser.cargaGramatica',10);

        nuIndice := 0;

        IF blGramaticaCargada THEN
            ut_trace.trace('Utilizando gramatica de cache',2);
            ut_trace.trace('FIN AB_Boparser.cargaGramatica',10);
            RETURN;
        END IF;

        ut_trace.trace('Cargando gramatica a cache',2);

        -- Recorre las gramaticas ORDENADAS
        FOR rcGramatica in ab_bcParser.cuGramatica LOOP
            nuIndice := nuIndice + 1;

            -- Elimina espacios en blanco en la gramatica
            rcGramatica.gramatica := replace(rcGramatica.gramatica,' ','');

            -- Solo podran ser gramaticas base las gramaticas padre
            IF rcGramatica.id_gramatica_padre IS NULL THEN
                -- Asume por defecto que la gramatica es base
                tbgGramatica(nuIndice).rootGrammar := csbYes;

                -- Busca una gramatica previa que este contenida en la actual.
                FOR nuIndPrev IN REVERSE 1..(nuIndice - 1) LOOP
                    IF tbgGramatica.exists(nuIndPrev)
                       AND tbgGramatica(nuIndPrev).id_gramatica_padre IS NULL
                    THEN
                        sbPrevGrammar := tbgGramatica(nuIndPrev).gramaticaEntera;

                        -- Si la gramatica previa esta contenida desde la PRIMERA posicion
                        -- en la gramatica actual, entonces la gramatica actual
                        -- NO es base, y finaliza la busqueda
                        IF instr(rcGramatica.gramatica,sbPrevGrammar,1) = 1 then
                            tbgGramatica(nuIndice).rootGrammar := csbNO;
                            EXIT;
                        END if;
                    END if;
                END LOOP;
            ELSE
                tbgGramatica(nuIndice).rootGrammar := csbNO;
            END IF;

            tbgGramatica(nuIndice).id_gramatica          := rcGramatica.id_gramatica;
            tbgGramatica(nuIndice).id_gramatica_padre    := rcGramatica.id_gramatica_padre;
            --Procesa los simbolos que aparecen en la gramatica y los translada
            --a una tabla para poder trabajar con ellos mas facilmente.
            proSimboloGrama(rcGramatica.gramatica , tbTokensGrama, nuViasGrama);
            tbgGramatica(nuIndice).sbTbSimbolos          := tbTokensGrama;
            tbgGramatica(nuIndice).gramaticaEntera       := rcGramatica.gramatica;
            tbgGramatica(nuIndice).nuCantidadVias        := nuViasGrama;

            DespliegaGramatica(tbgGramatica(nuIndice));

        END LOOP;

        blGramaticaCargada := TRUE;


        ut_trace.trace('FIN AB_Boparser.cargaGramatica',10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END cargaGramatica;

    /*****************************************************************
    Unidad      :   construyeDirPadre
    Descripcion	:   Devuelve la Direccion segun la Gramatica Padre,
                    dada el Id de la gramatica Padre y la tabla de Direccion

    Parametros          Descripcion
    ============        ===================
    inuid_gramaPadre    Codigo de la gramatica padre
    itbDirParseada      Tokens y valores ajustados de la direccion parseada
    otbDirGramaPadre    Tokens y valores ajustados de la direccion parseada en el orden de la gramatica padre

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
	11-11-2010     amendezSAO131516     Optimizacion parametro OUT
    10-01-2010     amendezSAO109552     Se ajusta para que acepte un mismo
                                        token repetido en la gramatica
    03-06-2009     jhramirezSAO94872    Creacion.
    ******************************************************************/
    PROCEDURE construyeDirPadre
    (
        inuid_gramaPadre     in  bd_gramatica.id_gramatica_padre%type,
        itbDirParseada       in  UT_String.TyTb_StrParameters,
        otbDirGramaPadre     out nocopy UT_String.TyTb_StrParameters
    )
    IS
        sbGramatica         bd_gramatica.gramatica%type;
        tbTokensGramaPadre  tytbSimbolos;
        tbDirGramaPadre     UT_String.TyTb_StrParameters;
        nuViasGrama         number;

        tbAuxDirGrama       UT_String.TyTb_StrParameters;
        n                   BINARY_INTEGER;
        j                   BINARY_INTEGER;
    BEGIN
        sbGramatica := dabd_gramatica.fsbGetGramatica(inuid_gramaPadre);
        proSimboloGrama(sbGramatica,tbTokensGramaPadre,nuViasGrama);

        tbAuxDirGrama  :=  itbDirParseada;

        IF tbTokensGramaPadre.first IS NOT NULL THEN
            n := tbTokensGramaPadre.first;
            LOOP
                EXIT WHEN n IS NULL;

                --Recorre la direccion, segun la gramatica, para encontrar en donde esta el valor tbTokensGramaPadre(n).
                j := tbAuxDirGrama.first;
                LOOP
                    EXIT WHEN j IS NULL;

                    IF( tbAuxDirGrama(j).sbParameter = tbTokensGramaPadre(n).sbSimbolo ) THEN

                        tbDirGramaPadre(n).sbParameter  := tbTokensGramaPadre(n).sbSimbolo;
                        tbDirGramaPadre(n).sbValue      := tbAuxDirGrama(j).sbValue;

                        tbAuxDirGrama.delete(j);
                        EXIT;
                    END IF;

                    j := tbAuxDirGrama.next(j);
                END LOOP;

                n:= tbTokensGramaPadre.next(n);
            END LOOP;
        END IF;
        otbDirGramaPadre    := tbDirGramaPadre;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END construyeDirPadre;




    /*****************************************************************
    Unidad      :   fblIniciaNumero
    Descripcion	:   Retorna TRUE si la cadena ingresada empieza por numero
                    o es nula

    Parametros          Descripcion
    ============        ===================
    isbPalabra          Cadena a analizar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-01-2010     amendezSAO109552     Creacion
    ******************************************************************/
    FUNCTION fblIniciaNumero
    (
        isbPalabra IN VARCHAR2
    )
    RETURN BOOLEAN
    IS
        blOk BOOLEAN;
    BEGIN
        ut_trace.trace('Verificando si ['||isbPalabra||'] empieza por numero',10);
        IF isbPalabra IS NOT NULL THEN
            blOk := substr(isbPalabra,1,1) IN ('0','1','2','3','4','5','6','7','8','9');
        ELSE
            blOK := TRUE;
        END IF;

        RETURN blOk;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   ParticionarToken
    Descripcion	:   Intenta particionar el valor de un token buscando
                    una via en la cadena que corresponda a la
                    descripcion de una VIA en la base de datos

    Parametros          Descripcion
    ============        ===================
    inuUbiGeogra        Ubicacion geografica
    isbValorToken       Valor del token que intentara particionar
    osbValor1           Primera parte del valor del token particionado
    osbValor2           Segunda parte del valor del token particionado
    onuFirstWay         Primera via identificada en la particion de valor del
                        token
    oblDerecha          Si onuFirstWay es no nulo, indica si encontro la via
                        en la parte derecha de la cadena ingresada

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
	11-11-2010     amendezSAO131516     Optimizacion parametros OUT
    04-02-2010     juzuriagaSAO109564   (Ref amendez) Se ajusta mecanismo de particionar token
                                        utilizando subcadenas y no reemplazos
    10-01-2010     amendezSAO109552     Creacion
    ******************************************************************/
    PROCEDURE ParticionarToken
    (
        inuUbiGeogra  in  ge_geogra_location.geograp_location_id%type,
        isbValorToken in  varchar2,
        osbValor1     out nocopy varchar2,
        osbValor2     out nocopy varchar2,
        onuFirstWay   out nocopy ab_way_by_location.way_by_location_id%type,
        oblDerecha    out nocopy boolean
    )
    IS
        sbValor            ab_address.address%type;
		tbValues           UT_String.TyTb_String;
		blEncontroVia      boolean := FALSE;
		nuFirstIndex       NUMBER      ;
		sbAux              VARCHAR2(1000);
		sbValorToken       ab_address.address%type;
		sbValorPpal        ab_address.address%type;
		nuPosIniValor1     NUMBER;

    BEGIN
        sbValorToken := isbValorToken;

        ut_trace.trace('Intenta particionar token_value: ['||sbValorToken||']',4);

        -- Parte el valor en palabras
        ut_string.ExtString(sbValorToken,' ',tbValues);

        IF tbValues.count=0 THEN
            RETURN;
        END IF;

        -- Busca la via en la parte izquierda de la cadena
        FOR i in reverse tbValues.first..tbValues.last LOOP
            sbValor := NULL;
            FOR j in tbValues.first..i LOOP
                sbValor := sbValor || ' ' || tbValues(j);
            END LOOP;

            sbValor := trim(sbValor);

            ut_trace.trace('Izquierda: Buscando en vias y/o sinonimos : ['||sbValor||']',4);

            onuFirstWay := ab_bcParser.fnuBuscaVia(sbValor,inuUbiGeogra,sbValorPpal);

            -- Si lo que encontro es un sinonimo, reemplaza por el valor de la via principal
            IF onuFirstWay IS NOT NULL AND sbValor||'a' != sbValorPpal||'a' THEN
                ut_trace.Trace('a) Reemplazando en ['||sbValorToken||'] sinonimo ['||sbValor||'] por ['||trim(sbValorPpal)||']',4);
                sbValorToken := trim(replace(sbValorToken, sbValor, sbValorPpal));
                sbValor := sbValorPpal;
            END IF;

            EXIT WHEN onuFirstWay IS NOT null;
        END LOOP;

        oblDerecha := FALSE;
        -- Busca la via en la parte derecha de la cadena
        IF onuFirstWay IS NULL THEN
            -- Evita buscar la frase completa porque el ciclo anterior
            -- ya la proceso
            nuFirstIndex := tbValues.next(tbValues.first);

            oblDerecha :=true;

            IF nuFirstIndex IS NOT NULL then
                FOR i in nuFirstIndex..tbValues.last LOOP
                    sbValor := NULL;
                    FOR j in i..tbValues.last LOOP
                        sbValor := sbValor || ' ' || tbValues(j);
                    END LOOP;

                    sbValor := trim(sbValor);

                    ut_trace.trace('Derecha: Buscando en vias y/o sinonimos : ['||sbValor||']',4);

                    onuFirstWay := AB_BCParser.fnuBuscaVia(sbValor,inuUbiGeogra,sbValorPpal);

                    EXIT WHEN onuFirstWay IS NOT null;
                END LOOP;
            END IF;

            -- Si lo que encontro es un sinonimo, reemplaza por el valor de la via principal
            IF onuFirstWay IS NOT NULL AND sbValor||'a' != sbValorPpal||'a' THEN
                ut_trace.Trace('b) Reemplazando en ['||sbValorToken||']['||sbValor||'] por ['||sbValorPpal||']',4);
                sbValorToken := replace(sbValorToken, sbValor, sbValorPpal);
                sbValor := sbValorPpal;
            END IF;

        END IF;

        -- Si encuentra establece la particion del valor
        IF onuFirstWay IS NOT NULL THEN

            nuPosIniValor1 := instr(sbValorToken,sbValor);

            IF  nuPosIniValor1 = 1 THEN
                osbValor1 := substr(sbValorToken,nuPosIniValor1,length(sbValor));
                osbValor2 := substr(sbValorToken,nuPosIniValor1+length(sbValor));
            ELSIF nuPosIniValor1 > 1 then
                osbValor1 := substr(sbValorToken,1,nuPosIniValor1-1);
                osbValor2 := substr(sbValorToken,nuPosIniValor1);
            END IF;

            osbValor1 := trim(osbValor1);
            osbValor2 := trim(osbValor2);

            ut_trace.trace('Particiona valor via ['||osbValor1||']['||osbValor2||']',4);

        ELSE
            osbValor1 := sbValorToken;
        END IF;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   InsertarToken
    Descripcion	:   Inserta token en la tabla itbDireccion
                    en la posicion nuIndexDir con nombre nulo
                    y valor ingresado como parametro

    Parametros          Descripcion
    ============        ===================
    itbDireccion        Tabla de tokens de direccion
    nuIndexDir          Indice de la tabla donde se insertara el token
    sbValor1            Valor del token a insertar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
	11-11-2010     amendezSAO131516     Optimizacion parametros OUT
    10-01-2010     amendezSAO109552     Creacion
    ******************************************************************/
    PROCEDURE InsertarToken
    (
        itbDireccion        in  out nocopy UT_String.TyTb_StrParameters,
        nuIndexDir          in  number,
        sbParametro         in  varchar2,
        sbValor             in  varchar2
    )
    IS
    BEGIN
        ut_trace.trace('Insertando token ['||sbParametro||'='||sbValor||']',4);
        IF itbDireccion.count>0 THEN
            IF nuIndexDir>0 AND nuIndexDir<=itbDireccion.last THEN
                FOR nuIndex in reverse nuIndexDir..itbDireccion.last  LOOP
                    IF itbDireccion.exists(nuIndex) then
                        -- Si es el ultimo le adiciona una posicion a la tabla
                        IF nuIndex = itbDireccion.last then
                            itbDireccion(nuIndex+1) := itbDireccion(nuIndex);
                        ELSE
                            itbDireccion(itbDireccion.next(nuIndex)) := itbDireccion(nuIndex);
                        END IF;
                    END IF;
                END LOOP;
                itbDireccion(nuIndexDir).sbParameter := sbParametro;
                itbDireccion(nuIndexDir).sbValue := sbValor;
            END IF;
        END IF;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   fsbCompletarVia
    Descripcion	:   Para las direcciones de dos vias de la forma CL 4 # 30-13
                    completa el nombre de la via de cruce  siempre y cuando,
                    el token recibido (sbValorSimbolDir) se numerico, para el
                    ejemplo sbValorSimbolDir = 30.
                    Utiliza para ello la descripcion del tipo de via configurada
                    como cruce por defecto para el tipo de via de la via conocida.

    Parametros          Descripcion
    ============        ===================

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-01-2010      amendezSAO109552    Creacion.
    ******************************************************************/
    FUNCTION fsbCompletarVia
    (
        inuGeoLoc         in ge_geogra_location.geograp_location_id%type,
        inuFirstWay       in ab_way_by_location.way_by_location_id%type,
        isbValorSimbolDir in varchar2
    )
    RETURN varchar2
    IS
         sbDesc ab_way_type.description%type;
    BEGIN
        ut_trace.trace('INICIO AB_Boparser.fsbCompletarVia('||inuGeoLoc||','||inuFirstWay||','''||isbValorSimbolDir||''')',10);

        IF inuFirstWay IS NOT NULL THEN --AND ut_convert.IS_number(isbValorSimbolDir) THEN

            FOR rc in AB_BCParser.cuCruces( inuGeoLoc, inuFirstWay ) LOOP
                sbDesc := rc.description||' ';
            END LOOP;
        END IF;

        ut_trace.trace('Resultado completar via:['||trim(sbDesc||isbValorSimbolDir)||']',5);

        ut_trace.trace('FIN AB_Boparser.fsbCompletarVia',10);
        RETURN trim(sbDesc||isbValorSimbolDir);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;
    /*****************************************************************
    Unidad      :   AdicionaTokenExitoso
    Descripcion	:   Analiza y adiciona token que se asume exitoso
                    en la comparacion gramatical

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha         Autor               Modificacion
    ============  =================== ====================
	11-11-2010    amendezSAO131516    Optimizacion parametros OUT
    10-01-2010    amendezSAO109552    Creacion
    ******************************************************************/
    PROCEDURE AdicionaTokenExitoso
    (
        isbParameter IN varchar2,
        isbValue     IN VARCHAR2,
        iotbExitos   IN OUT nocopy UT_String.TyTb_StrParameters
    )
    IS
        nuIndex BINARY_INTEGER;
    BEGIN
        nuIndex := iotbExitos.count;
        -- Adicionando token con valor no nulo
        IF isbValue IS NOT NULL THEN
            nuIndex := nuIndex + 1;
            iotbExitos(nuIndex).sbParameter := isbParameter;
            iotbExitos(nuIndex).sbValue     := isbValue;
        ELSE
        -- Evita almacenar dos token exitosos sin valor adyacentes
        -- Adicionando token con valor nulo
            IF nuIndex>0 THEN
                -- Si el token anterior tiene valor
                IF iotbExitos(nuIndex).sbValue IS NOT NULL THEN
                    nuIndex := nuIndex + 1;
                    iotbExitos(nuIndex).sbParameter := isbParameter;
                    iotbExitos(nuIndex).sbValue     := isbValue;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   buscaCoincidencia
    Descripcion	:   Busca las Coincidencias de la direccion en las gramaticas
                    cargadas, si encuentra una coincidencia, retorna el id de
                    la gramatica padre, para poderla procesar y generar la
                    direccion parseada.
                    Procesa tokens VIA, contra ab-way-by-location cuando
                    la gramatica tiene via, con la posibilidad de particionar
                    tokens VIA, modificando la tabla pl de direcciones.

    Parametros          Descripcion
    ============        ===================
    inuUbicGeo          Ubicacion Geografica
    isbDireccion        Direccion en formato libre
    orcDirParseada      Estructura de memoria con toda la info de direccion parseada

    Historia de Modificaciones
    Fecha         Autor               Modificacion
    ============  =================== ====================
    11-12-2012    amendezSAO195302    Procesa contra la direccion, solo las gramaticas hijas
    14-11-2012    amendezSAO195930    Se corrige error de excepcion inesperada cuando accede a la primera
                                      posicion del arreglo de simbolos de direccion, tras haber eliminado
                                      simbolos de complemento, en este caso la primera posicion no es 1,
                                      este SAO complementa la solucion al SAO171487
    19-01-2012    cocampo.SAO171487   1 - Se a?ade validacion para que si no existen simbolos en la
                                          tabla orcDirParseada.tbDireccion no se valide contra la tabla
                                          de tokens principales.
    16-01-2012    cocampo.SAO171139   1 - Se modifica nombre de variable blGramaticaOK por blGramViasOK
    29-09-2011    cocampoSAO148875    1 - Se asigina FALSE a la variable blGramaticaOK cuando
                                      ocurre un error.
                                      2 - Se a?ade validacion para que se eleve error cuando
                                      la gramatica no soporta complemento y la direccion tenga
                                      token complemento.
    20-04-2011    amendezSAO146905    Estabilizacion SAO146690
                                      Valida que todos los tokens complemento
                                      tengan valor.
                                      Valida que el nombre de la via no tenga
                                      mas de 100 caracteres
    22-02-2010    amendezSAO112877    Se ajusta para que inicialice a NULL
                                      la gramatica padre, cuando no puede
                                      parsear la direccion
    10-02-2010    amendezSAO109561    Se modifica la logica
                                      redistribuyendo el codigo en multiples
                                      procedimientos para mayor legibilidad.
                                      Se adiciona logica para reemplazo "ortografico"
                                      de palabras dentro de un token via o un
                                      token indeterminado, esto se hace solo luego de
                                      intentar buscar en vias y la busqueda no fue exitosa.
    04-02-2010    juzuriagaSAO109564  (Ref amendez)
                                      Se ajusta manejo de indices de la gramatica
                                      y la direccion, considerando que pueden no
                                      ser consecutivos y que cualquiera de los
                                      dos puede agotarse primero.

    10-01-2010    amendezSAO109552    Creacion.
    ******************************************************************/
    PROCEDURE BuscaCoincidencia
    (
        inuUbicGeo          in              ge_geogra_location.geograp_location_id%type,
        isbDireccion        IN              ab_address.address%type,
        orcDirParseada      IN OUT nocopy   tyrcDirParseada
    )
    IS
        sbTbSimboGrama      tytbSimbolos;
        blCoincidencia      BOOLEAN := FALSE;
        tbDirGramaNull      UT_String.TyTb_StrParameters;
        tbConincidencias    UT_String.TyTb_String;

        tbAuxExitos         UT_String.TyTb_StrParameters;
        tbNullExitos        UT_String.TyTb_StrParameters;

        nuViasProcesadas    number;

        sbSimbolDir         varchar2(100);
        nuIndexDir          number;

        nuCoincide          number  := 0;

        sbValor1            ab_address.address%type;
        sbValor2            ab_address.address%type;

        sbValorViaPpal      ab_way_by_location.description%type;

        -- Indica si en una particion de token, la via encontrada esta
        -- a la derecha o a la izquierda de la particion
        blDerecha           BOOLEAN;

        n                   BINARY_INTEGER;
        j                   BINARY_INTEGER;

        -- En el procesamiento paralelo de los indices de direccion
        -- y gramatica, indica cuando el indice de alguno de los dos
        -- arreglos ha alcanzado su final
        blFinArray          BOOLEAN;


        -- =====================================================================
        PROCEDURE BuscarPrimeraVia
        IS
            nuWayFoundId    ab_way_by_location.way_by_location_id%type;
        BEGIN
            -- Si el numero de vias en la gramatica es mayor que uno
            -- y es la primera VIA procesada
            -- intenta particionar el token, buscando vias en la BD.
            ut_trace.trace('Numero de vias en la gramatica : '||orcDirParseada.nuViasEnGramatica, 4);
            ut_trace.trace('Token Gramatical               : '||sbTbSimboGrama(j).sbSimbolo, 4);
            ut_trace.trace('Token Direccion                : '||nvl(trim(sbSimbolDir),'?'),4);
            ut_trace.trace('Valor token Direccion          : '||orcDirParseada.tbDireccion(nuIndexDir).sbValue,4);
            ut_trace.trace('Vias procesadas                : '||nuViasProcesadas, 4);
            IF (
                 --sbTbSimboGrama(j).sbSimbolo = csbTOKEN_VIA AND
                 orcDirParseada.nuViasEnGramatica > 0 AND
                 --sbSimbolDir = ' ' AND
                 nuViasProcesadas = 0 AND
                 orcDirParseada.nuPrimeraVia IS NULL
               )
            THEN
                -- Intenta Particionar Token sin Nombre, si logra particionar es porque identifico una Via.
                ParticionarToken
                (
                    inuUbicGeo,
                    orcDirParseada.tbDireccion(nuIndexDir).sbValue,
                    sbValor1,
                    sbValor2,
                    nuWayFoundId,
                    blDerecha
                );

                -- Si hubo particion de token ajusta la tabla de tokens de direccion
                IF sbValor2 IS NOT NULL THEN
                    -- Hacer el valor actual del Token de direccion = sbValor2, tanto en la tabla/pl como en las variables locales
                    --tbDirGramaAux(j).sbValue         := sbValor1;
                    orcDirParseada.tbDireccion(nuIndexDir).sbValue := sbValor2;
                    -- Insertar el Token de nombre nulo y valor sbValor1 en la tabla de tokens de direccion.
                    IF blDerecha then
                        orcDirParseada.tbDireccion(nuIndexDir).sbParameter := csbTOKEN_VIA;
                        InsertarToken(orcDirParseada.tbDireccion,nuIndexDir,null,sbValor1);
                        ut_trace.trace('1) primera VIA.['||sbValor1||']=>['||orcDirParseada.nuPrimeraVia||']',4);
                        -- Descripcion de via que puede o no existir en ab_way_by_location
                        orcDirParseada.sbPrimeraVia := sbValor1;
                    ELSE
                        orcDirParseada.nuPrimeraVia := nuWayFoundId;
                        InsertarToken(orcDirParseada.tbDireccion,nuIndexDir,csbTOKEN_VIA,sbValor1);
                        -- Actualiza el nombre del token de direccion que se comparara con la gramatica
                        sbSimbolDir  := orcDirParseada.tbDireccion(nuIndexDir).sbParameter;
                        ut_trace.trace('2) primera VIA.['||sbValor1||']=>['||orcDirParseada.nuPrimeraVia||']',4);
                        -- Descripcion de via que puede o no existir en ab_way_by_location
                        orcDirParseada.sbPrimeraVia := sbValor1;
                    END IF;
                ELSIF nuWayFoundId IS NOT NULL THEN
                    orcDirParseada.nuPrimeraVia := nuWayFoundId;
                    -- No pudo particionar el token, sinembargo encontro la VIA
                    orcDirParseada.tbDireccion(nuIndexDir).sbParameter := csbTOKEN_VIA;
                    IF orcDirParseada.tbDireccion(nuIndexDir).sbValue||'a' != sbValor1||'a' THEN
                        orcDirParseada.tbDireccion(nuIndexDir).sbValue := sbValor1;
                    END IF;

                    ut_trace.trace('3) primera VIA.['||orcDirParseada.tbDireccion(nuIndexDir).sbValue||']=>['||orcDirParseada.nuPrimeraVia||']',4);
                    orcDirParseada.sbPrimeraVia := orcDirParseada.tbDireccion(nuIndexDir).sbValue;
                END IF;

            END IF;

            -- Intenta identificar primer VIA
            IF  sbTbSimboGrama(j).sbSimbolo = csbTOKEN_VIA AND
                nuViasProcesadas = 0 AND
                orcDirParseada.nuPrimeraVia IS NULL
            THEN
                orcDirParseada.nuPrimeraVia := AB_BCParser.fnuBuscaVia(orcDirParseada.tbDireccion(nuIndexDir).sbValue,inuUbicGeo,sbValorViaPpal);
                -- Cambia el valor del token via sinonimo por el de la via principal
                IF orcDirParseada.nuPrimeraVia IS NOT NULL AND (orcDirParseada.tbDireccion(nuIndexDir).sbValue||'a' != sbValorViaPpal||'a') THEN
                    orcDirParseada.tbDireccion(nuIndexDir).sbValue := sbValorViaPpal;
                END IF;

                ut_trace.trace('primera VIA.['||orcDirParseada.tbDireccion(nuIndexDir).sbValue||']=>['||orcDirParseada.nuPrimeraVia||']',4);
                --se valida que la via no contenga mas de 100 caracteres.
                IF (length(orcDirParseada.tbDireccion(nuIndexDir).sbValue) > cnuLongMaxVia) THEN
                    errors.SetError(cnuLongitudViaExced,cnuLongMaxVia);
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
                orcDirParseada.sbPrimeravia := orcDirParseada.tbDireccion(nuIndexDir).sbValue;
            END IF;

        END BuscarPrimeraVia;
        -- =====================================================================
        PROCEDURE CompletarSegundaVia
        IS
        BEGIN
            -- Si se trata de una gramatica de dos vias
            -- y la via1 fue identificada
            -- y la via2 no ha sido identificada, y su valor inicia con numero
            -- y esta analizando un token VIA en la gramatica
            -- intenta completar la segunda via por la descripcion
            -- del tipo de via ab_way_type de la via de cruce por defecto
            -- para la primer via
            IF orcDirParseada.nuViasEnGramatica > 1
               AND orcDirParseada.nuPrimeraVia IS NOT NULL
               AND orcDirParseada.nuSegundaVia IS NULL
               AND nuViasProcesadas = 1
               AND sbTbSimboGrama(j).sbSimbolo = csbTOKEN_VIA
               AND ( sbSimbolDir = ' ' OR sbSimbolDir = csbTOKEN_VIA)
               AND fblIniciaNumero(trim(replace(orcDirParseada.tbDireccion(nuIndexDir).sbValue,'#','')))
               --AND ut_convert.IS_number(trim(replace(itbDireccion(nuIndexDir).sbValue,'#','')))
            THEN
                orcDirParseada.tbDireccion(nuIndexDir).sbValue := fsbCompletarVia
                                                                  (
                                                                      inuUbicGeo,
                                                                      orcDirParseada.nuPrimeraVia,
                                                                      trim(replace(orcDirParseada.tbDireccion(nuIndexDir).sbValue,'#',''))
                                                                  );
            END IF;
        END;
        -- =====================================================================
        PROCEDURE IdentificarSegundaVia
        IS
        BEGIN
            -- Intenta identificar segunda VIA
            IF  orcDirParseada.nuViasEnGramatica > 1
                AND sbTbSimboGrama(j).sbSimbolo = csbTOKEN_VIA
                AND nuViasProcesadas = 1
                AND orcDirParseada.nuSegundaVia IS NULL
                AND ( sbSimbolDir = ' ' OR sbSimbolDir = csbTOKEN_VIA )
            THEN
                orcDirParseada.nuSegundaVia := AB_BCParser.fnuBuscaVia(orcDirParseada.tbDireccion(nuIndexDir).sbValue,inuUbicGeo,sbValorViaPpal);
                -- Cambia el valor del token via sinonimo por el de la via principal
                IF orcDirParseada.nuSegundaVia IS NOT NULL AND (orcDirParseada.tbDireccion(nuIndexDir).sbValue||'a' != sbValorViaPpal||'a') THEN
                    orcDirParseada.tbDireccion(nuIndexDir).sbValue := sbValorViaPpal;
                END IF;

                ut_trace.trace('segunda VIA.['||orcDirParseada.tbDireccion(nuIndexDir).sbValue||']=>['||orcDirParseada.nuSegundaVia||']',4);
                IF (length(orcDirParseada.tbDireccion(nuIndexDir).sbValue) > cnuLongMaxVia) THEN
                    errors.SetError(cnuLongitudViaExced,cnuLongMaxVia);
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
                orcDirParseada.sbSegundaVia := orcDirParseada.tbDireccion(nuIndexDir).sbValue;
            END IF;
        END;
        -- =====================================================================
        PROCEDURE ComparacionGramatical
        IS
        BEGIN
            ut_trace.trace('Comparacion gramatical ['||sbTbSimboGrama(j).sbSimbolo||']['||sbSimbolDir||']',4);
            -- Analisis de SIMBOLOS congruentes
            -- Si los simbolos son iguales o
            -- no hay simbolo en la direccion y en la gramatica indica que no es obligatorio
            -- y adicionalmente el token de direccion tiene valor
            -- Hay coincidencia
            IF(
                 ( sbTbSimboGrama(j).sbSimbolo = sbSimbolDir ) OR ( sbSimbolDir = ' ' and sbTbSimboGrama(j).sbEsObligatorio = 'N')
              )
            THEN
                -- Se almacenara solo un token de valor nulo para gramatica OK, para efectos de autocompletar
                AdicionaTokenExitoso(sbTbSimboGrama(j).sbSimbolo,orcDirParseada.tbDireccion(nuIndexDir).sbValue,tbAuxExitos);

                -- Gramaticalmente se deduce que no es exitosa la comparacion
                IF orcDirParseada.tbDireccion(nuIndexDir).sbValue IS NULL THEN
                    blCoincidencia  := FALSE;
                    ut_trace.trace('Comparacion Gramatical NO exitosa!! El Token '||orcDirParseada.tbDireccion(nuIndexDir).sbParameter||' no tiene valor!! ',4);
                END IF;

                ut_trace.trace('Comparacion Gramatical Exitosa!!',4);

            ELSE
                blCoincidencia  := FALSE;
                ut_trace.trace('Comparacion Gramatical NO exitosa!!',4);
            END IF;

        END ComparacionGramatical;
        -- =====================================================================
        PROCEDURE ActualizaIndices
        IS
        BEGIN
            IF sbTbSimboGrama(j).sbSimbolo = csbTOKEN_VIA THEN
                nuViasProcesadas := nuViasProcesadas + 1;
            END IF;

            nuIndexDir := orcDirParseada.tbDireccion.next(nuIndexDir);
            j          := sbTbSimboGrama.next(j);

            -- Si ya proceso todos los tokens de la direccion o de la gramatica
            IF nuIndexDir IS null OR j IS NULL THEN

                -- Si no ha procesado todos los simbolos de la direccion
                IF  j IS null AND nuIndexDir IS NOT NULL then
                    blCoincidencia := FALSE;
                    ut_trace.trace('Comparacion Gramatical No exitosa, la direccion tiene mas tokens que la gramatica!!',4);
                END IF;

                -- Si no ha procesado todos los simbolos gramaticales
                IF j IS NOT NULL AND nuIndexDir IS NULL THEN
                    blCoincidencia := FALSE;
                    ut_trace.trace('Comparacion Gramatical No exitosa, la gramatica tiene mas tokens que la direccion!!',4);
                END IF;

                blFinArray := true;
            END IF;

        END;
        -- =====================================================================
        PROCEDURE ReemplazoPalabras
        IS
            nuIndPalVia      BINARY_INTEGER;
       		tbPalabrasVia    UT_String.TyTb_String;
       		sbPalabra        VARCHAR2(32767);
       		sbReemplazo      VARCHAR2(32767);
       		sbNuevoValorVia  VARCHAR2(32767);
        BEGIN
            ut_trace.trace('BEGIN AB_BOParser.BuscaCoincidencia.ReemplazoPalabras',4);
            ut_string.ExtString(orcDirParseada.tbDireccion(nuIndexDir).sbValue,' ',tbPalabrasVia);
            nuIndPalVia := tbPalabrasVia.first;
            sbNuevoValorVia := '';

            LOOP
                EXIT WHEN nuIndPalVia IS NULL;

                sbPalabra := tbPalabrasVia(nuIndPalVia);

                IF fblEsSinonimoPalabraVia( sbPalabra, sbReemplazo ) THEN
                    ut_trace.trace('Reemplazo de palabras en token [VIA] o en token indeterminado ['|| orcDirParseada.tbDireccion(nuIndexDir).sbValue||']'||
                                   ' ['||sbPalabra||'] por-> ['||sbReemplazo||']',4);

                    sbPalabra := upper(sbReemplazo);
                END IF;

                sbNuevoValorVia := sbNuevoValorVia||' '||sbPalabra;

                nuIndPalVia := tbPalabrasVia.next(nuIndPalVia);
            END LOOP;

            sbNuevoValorVia := trim(sbNuevoValorVia);
            orcDirParseada.tbDireccion(nuIndexDir).sbValue := sbNuevoValorVia;
            ut_trace.trace('END AB_BOParser.BuscaCoincidencia.ReemplazoPalabras',4);
        END;
        -- =====================================================================
        PROCEDURE ReemplazoPalabrasPrimeraVia
        IS

        BEGIN
             ut_trace.trace('BEGIN AB_BOParser.BuscaCoincidencia.ReemplazoPalabrasPrimeraVia',4);
            -- Si se trata de una gramatica de al menos una via
            -- Y no han sido procesados simbolos gramaticales [VIA]
            -- Y el simbolo analizado es aun indeterminado o es el token VIA
            IF (
                 orcDirParseada.nuViasEnGramatica > 0 AND
                 nuViasProcesadas = 0 AND
                 orcDirParseada.nuPrimeraVia IS NULL
                 AND ( sbSimbolDir = ' ' OR sbSimbolDir = csbTOKEN_VIA  )
                 AND orcDirParseada.tbDireccion.count>0
               )
            THEN
               ReemplazoPalabras;
            END IF;
             ut_trace.trace('END AB_BOParser.BuscaCoincidencia.ReemplazoPalabrasPrimeraVia',4);
        END;
        -- =====================================================================
        PROCEDURE ReemplazoPalabrasSegundaVia
        IS
        BEGIN
            ut_trace.trace('BEGIN AB_BOParser.BuscaCoincidencia.ReemplazoPalabrasSegundaVia',4);
            -- Si se trata de una gramatica de al menos una via
            -- Y no han sido procesados simbolos gramaticales [VIA]
            -- Y el simbolo analizado es aun indeterminado o es el token VIA
            IF (
                 orcDirParseada.nuViasEnGramatica > 1 AND
                 nuViasProcesadas = 1 AND
                 orcDirParseada.nuSegundaVia IS NULL
                 AND ( sbSimbolDir = ' ' OR sbSimbolDir = csbTOKEN_VIA  )
                 AND orcDirParseada.tbDireccion.count>0
               )
            THEN
                ReemplazoPalabras;
            END IF;
            ut_trace.trace('END AB_BOParser.BuscaCoincidencia.ReemplazoPalabrasSegundaVia',4);
        END;
        -- =====================================================================

    BEGIN
        ut_trace.trace('INICIO AB_Boparser.BuscaCoincidencia',2);

        get_parameters;

        --llama al metodo que retorna la direccion descompuesta en lexemas.
        retTokens(isbDireccion,orcDirParseada.tbDireccion);

        --Carga la gramatica para luego poder comparar la cadena dividida en lexemas
        --y determinar si esta bien escrita.
        cargaGramatica;
        ut_trace.trace('Registros en la gramatica:'||tbgGramatica.count,3);

        -- Elimina de la direccion los tokens complemento y los separa en otra tabla
        separaComplemento(orcDirParseada.tbDireccion,orcDirParseada.tbComplemento);

        -- Valida que todos los tokens complemento tengan valor
        ValidaNulidadToken(orcDirParseada.tbComplemento);
        ut_trace.trace('Tokens Direccion luego de separar complemento.',3);
        DespliegaTokens(orcDirParseada.tbDireccion);

        ut_trace.trace('Tokens Complemento de Direccion.',3);
        DespliegaTokens(orcDirParseada.tbComplemento);
        -- Recorre todas las gramaticas
        n := tbgGramatica.first;
        LOOP
            EXIT WHEN n IS NULL;

            tbAuxExitos := tbNullExitos;

            orcDirParseada.nuPrimeraVia      := NULL;
            orcDirParseada.nuSegundaVia      := NULL;
            orcDirParseada.nuViasEnGramatica := tbgGramatica(n).nuCantidadVias;

            ut_trace.trace('GRAMATICA {'||tbgGramatica(n).id_gramatica||'} = {'||tbgGramatica(n).gramaticaEntera||'}',3);
            sbTbSimboGrama  := tbgGramatica(n).sbTbSimbolos;

            nuViasProcesadas := 0;

            -- Selecciona solo las gramaticas HIJAS con mayor o igual numero
            -- de tokens (PRINCIPALES).
            IF ( sbTbSimboGrama.count  >= orcDirParseada.tbDireccion.count
                 AND orcDirParseada.tbDireccion.count > 0
                 AND tbgGramatica(n).id_gramatica_padre IS NOT NULL
               )
            THEN
                blCoincidencia  := TRUE;

                nuIndexDir := orcDirParseada.tbDireccion.first;

                -- Recorre los simbolos de la gramatica de izquierda a derecha

                -- Presupone que los indices de los arreglos de gramatica
                -- y direccion no han alcanzado su limite
                blFinArray := FALSE;

                j := sbTbSimboGrama.first;
                LOOP
                    EXIT WHEN j IS NULL;

                    ut_trace.trace('-----------------------------------------------', 4);

                    -- Nombre del token de la direccion a procesar
                    sbSimbolDir  := orcDirParseada.tbDireccion(nuIndexDir).sbParameter;

                    -- Facilita comparacion con nulo
                    sbSimbolDir := nvl( sbSimbolDir, ' ');

                    -- Particiona tokens e intenta encontrar la primera via
                    BuscarPrimeraVia;

                    -- Intenta reemplazo "ortografico" en las palabras de la via
                    -- Si aun no ha sido encontrada para una gramatica de al menos una via
                    ReemplazoPalabrasPrimeraVia;

                    -- Busca nuevamente primera via luego del intento de reemplazo de palabras en la misma
                    BuscarPrimeraVia;

                    -- Intenta completar la segunda via (para gramaticas de dos vias)
                    CompletarSegundaVia;

                    -- Intenta identificar la segunda via (para gramatica de dos vias)
                    IdentificarSegundaVia;

                    -- Intenta reemplazo "ortografico en las palabras de la 2 via
                    -- Si aun no ha sido encontrada para una gramatica de mas de una via
                    ReemplazopalabrasSegundaVia;

                    -- Intenta identificar la segunda via (para gramatica de dos vias)
                    IdentificarSegundaVia;

                    -- Confronta la gramatica contra la simbologia de la direccion
                    ComparacionGramatical;

                    EXIT WHEN blCoincidencia = FALSE;

                    -- Actualiza indices de gramatica, direccion y contador de vias
                    -- controla cuando se alcanza el fin de alguno de los dos arreglos.
                    ActualizaIndices;

                    EXIT WHEN blFinArray;

                END LOOP;  -- Simbolos Gramatica

                IF orcDirParseada.tbExitos.count < tbAuxExitos.count THEN

                    orcDirParseada.tbExitos := tbAuxExitos;
                    orcDirParseada.nuGramaExitos := tbgGramatica(n).id_gramatica_padre;
                END IF;

                --Se encontro 1 coincidencia.
                IF (blCoincidencia AND tbgGramatica(n).id_gramatica_padre IS NOT NULL) THEN
                    nuCoincide  := nuCoincide + 1;

                    tbConincidencias(nuCoincide) := tbgGramatica(n).id_gramatica_padre;

                    orcDirParseada.nuIdGramaHja  := tbgGramatica(n).id_gramatica;

                    EXIT;
                END IF;

            END IF;

            n:= tbgGramatica.next(n);

        END LOOP;  -- Gramatica


        IF( tbConincidencias.count > 0 ) THEN
            orcDirParseada.nuIdGramaPadre := tbConincidencias(nuCoincide);

            ut_trace.trace('Gramatica hija ok=['||orcDirParseada.nuIdGramaHja||']',3);
            ut_trace.trace('Se encontro coincidencia con la gramatica padre ['||orcDirParseada.nuIdGramaPadre||']',3);

            -- Si la gramatica no admite complemento y la direccion tiene complemeto se levanta error.
            if ((dabd_gramatica.fsbGetComplement(orcDirParseada.nuIdGramaPadre) = csbNO) AND
               orcDirParseada.tbComplemento.count > 0) then
                 ut_trace.trace('La gramatica no soporta complemento',3);
                -- La gramatica no soporta complemento
                errors.SetError(cnuErrComplement, dabd_gramatica.fsbGetGramatica(orcDirParseada.nuIdGramaPadre));
                RAISE ex.CONTROLLED_ERROR;
            END if;
        ELSE
            orcDirParseada.nuIdGramaPadre := NULL;
        END IF;

        ut_trace.trace('Tokens de la direccion al finalizar Busca Coincidencia.',3);
        DespliegaTokens(orcDirParseada.tbDireccion);
        ut_trace.trace('Tokens Exitosos al finalizar Busca Coincidencia.',3);
        DespliegaTokens(orcDirParseada.tbExitos);

        ut_trace.trace('FIN AB_Boparser.BuscaCoincidencia',2);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('CONTROLLED_ERROR:AB_Boparser.BuscaCoincidencia',2);
            -- Se indica que hubo error en la gramatica.
            blGramViasOK := FALSE;
            raise ex.CONTROLLED_ERROR;
        when others then
            ut_trace.trace('OTHERS:AB_Boparser.BuscaCoincidencia ||'||sqlerrm,2);
            -- Se indica que hubo error en la gramatica.
            blGramViasOK := FALSE;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END BuscaCoincidencia;

    /*****************************************************************
    Unidad      :   trazaTokens
    Descripcion	:   Permite visualizar en la traza el contenido de un
                    arreglo token-valor

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    27-05-2009      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE DespliegaTokens
    (
        itbTokens in UT_String.TyTb_StrParameters
    )
    IS
        nuIndex       number;         --Indice para la tabla que se recorre.
    BEGIN
        -- Traza para visualizar los tokens obtenidos:
        nuIndex := itbTokens.first;
        ut_trace.trace('--- Parejas Token Valor ---------------------',3);
        LOOP
            EXIT WHEN nuIndex IS NULL;
            ut_trace.trace('['||lpad(nvl(itbTokens(nuIndex).sbParameter,'?'),20,' ')||'='||itbTokens(nuIndex).sbValue||']',3);

            nuIndex := itbTokens.next(nuIndex);
        END LOOP;
        ut_trace.trace('--- Fin Parejas Token Valor -----------------',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   obtCasaLetraNum
    Descripcion	:   A partir del valor del token Casa o Altura, retorna
                    el valor numerico y el valor en letras del mismo,
                    elevando excepcion si se exceden las longitudes
                    maximas permitidas.

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    12-04-2011      juzuriagaSAO145876  se amplia el tama?o de la variable sbcasa
    08-01-2011      cocampoSAO139484    Se verifican numeros negativos.

    11-11-2010      amendezSAO131516    Optimizacion parametros OUT
    27-05-2009      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE obtCasaLetraNum
    (
        isbCasa IN  VARCHAR2,
        onuCasa out nocopy ab_address.house_number%type,
        osbCasa out nocopy ab_address.house_letter%type
    )
    IS
        nuIndex  binary_integer;
        sbChar   CHAR;
        sbNumero ab_address.house_letter%type;
        sbLetras ab_address.house_letter%type;
        sbcasa   VARCHAR2(200);
    BEGIN
        ut_trace.trace('Inicio: obtCasaLetraNum('||isbCasa||',onuCasa,osbCasa)',4);

        sbcasa := trim(isbCasa);

        IF sbcasa IS NULL THEN
            RETURN;
        END IF;

        nuIndex :=1;

        LOOP
            EXIT WHEN nuIndex>length(sbCasa);

            sbChar := substr(sbCasa,nuIndex,1);
            IF sbChar IN ('0','1','2','3','4','5','6','7','8','9')  OR (nuIndex = 1 AND sbChar = '-') THEN
                IF nvl(length(sbNumero),0) < cnuLongitudCasaNumero then
                    sbNumero := sbNumero||sbChar;
                ELSE
                    -- Longitud numerica excedida para Casa o Altura [%s1]
                    errors.SetError(cnuLongExcedNumAltura,isbCasa);
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
            ELSIF nvl(length(trim(substr(sbCasa,nuIndex))),0) <= cnuLongitudCasaNumero THEN
                sbLetras := trim(substr(sbCasa,nuIndex));
                EXIT;
            ELSE
                -- Longitud alfanumerica exedida para Casa o Altura [%s1]
                errors.SetError(cnuLongExcedLetrAltura,isbCasa);
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            nuIndex := nuIndex + 1;

        END LOOP;

        IF sbNumero IS NOT NULL then
            onuCasa := to_number(sbNumero);
        END IF;

        osbCasa := sbLetras;

        ut_trace.trace('Fin: obtCasaLetraNum('||isbCasa||','||onuCasa||','||osbCasa||')',4);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   DespliegaGramatica
    Descripcion	:   Visualiza la informacion de una gramatica.

    Parametros      Descripcion
    ============    ===================
    ircGramatica    Registro de gramatica

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    01-12-2011      caguilarSAO165655   Estabilizacion amendezSAO166967. Visualiza en la traza si la
                                        gramatica es BASE
    27-05-2009      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE DespliegaGramatica
    (
        ircGramatica in tyrcGramatica
    )
    IS
        nuIndex       number;         --Indice para la tabla que se recorre.
    BEGIN
        -- Traza para visualizar los tokens obtenidos:
        nuIndex := ircGramatica.sbTbSimbolos.first;
        ut_trace.trace('--- << Simbolos Gramaticales de {'||ircGramatica.gramaticaEntera||'} --BASE:'||ircGramatica.rootGrammar||'-- >>',3);
        LOOP
            EXIT WHEN nuIndex IS NULL;
            ut_trace.trace('['||rpad(ircGramatica.sbTbSimbolos(nuIndex).sbSimbolo,30,' ')||'|'||ircGramatica.sbTbSimbolos(nuIndex).sbEsObligatorio||']',3);

            nuIndex := ircGramatica.sbTbSimbolos.next(nuIndex);
        END LOOP;
        ut_trace.trace('--- Fin Simbolos Gramaticales ---------------->>',3);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END DespliegaGramatica;


    /**************************************************************************/
    --METODOS PUBLICOS.
    /**************************************************************************/

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   obtieneDireccion
    Descripcion	:   dada una tabla de tipo UT_String.TyTb_StrParameters
                    retorna la direccion como VARCHAR2. segun el orden en
                    que se encuentren los simbolos en la tabla.

    Parametros      Descripcion
    ============    ===================
    itbDirGrama     tabla pl/sql con los tokens de la direccion analizada
    itbComplemento  tabla pl/sql con los complementos de la direccion analizada
    osbDireccion    Direccion parseada
    osbComplemento  Complemento de la direccion parseada
    osbCasa         Altura o casa

    Historia de Modificaciones
    Fecha         Autor                 Modificacion
    ============  ===================   ====================
    20-12-2012    amendezSAO198457      Estabilizacion SAOS 198368,198272
                                        Validacion de longitud maxima de
                                        direccion y complemento
    14-04-2011    juzuriagaSAO146083    Se valida que el complemento no sea mayor
                                        de 100 caracteres.
	11-11-2010    amendezSAO131516      Optimizacion parametros OUT
    10-01-2010    amendezSAO109552      Se modifica para que no coloque
                                        el nombre del token VIA
                                        Recibe tabla pl/sql de complementos
                                        para completar la direccion parseada
                                        Retorna adiconalmente el parametro
                                        complemento
    29-05-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    PROCEDURE obtieneDireccion
    (
        itbDirGrama     in  UT_String.TyTb_StrParameters,
        itbComplemento  in  UT_String.TyTb_StrParameters,
        osbDireccion    out nocopy ab_address.address%type,
        osbComplemento  out nocopy ab_address.address_complement%type,
        onuCasa         out nocopy ab_address.house_number%type,
        osbCasa         out nocopy ab_address.house_letter%type
    )
    IS
        sbDireccion     varchar2(4000);
        sbParameter     varchar2(32767);
        nuIndexComp     number;
        nuIndex         BINARY_INTEGER;
        sbComplemento   varchar2(4000);
    BEGIN
        ut_trace.trace('INICIO: ab_boparser.obtienedireccion',2);
        IF itbDirGrama.count > 0 THEN
            nuIndex :=  itbDirGrama.first;
            LOOP
                EXIT WHEN nuIndex IS NULL;
                IF itbDirGrama(nuIndex).sbParameter = csbTOKEN_VIA THEN
                    sbParameter := NULL;
                ELSE
                    sbParameter := itbDirGrama(nuIndex).sbParameter|| ' ';
                END IF;

                -- Extrae el valor del token principal (CASA)
                IF itbDirGrama(nuIndex).sbParameter = sbTOKEN_CASA THEN
                    --Separa el token casa en numero y letras
                    obtCasaLetraNum(itbDirGrama(nuIndex).sbValue, onuCasa, osbCasa );

                    sbDireccion := sbDireccion || rtrim( ' ' || sbParameter || trim( onuCasa || ' ' ||osbCasa) );
                ELSE
                    sbDireccion := sbDireccion || ' ' || sbParameter || itbDirGrama(nuIndex).sbValue;
                END IF;

                nuIndex := itbDirGrama.next(nuIndex);
            END LOOP;
        END IF;

        sbComplemento  := NULL;
        -- Adiciona complementos a la direccion
        nuIndexComp := itbComplemento.first;
        LOOP
            EXIT WHEN nuIndexComp IS NULL;

            sbDireccion := sbDireccion  || ' ' || itbComplemento(nuIndexComp).sbParameter || ' ' || itbComplemento(nuIndexComp).sbValue;

            sbComplemento := sbComplemento || ' ' || itbComplemento(nuIndexComp).sbParameter || ' ' || itbComplemento(nuIndexComp).sbValue;

            nuIndexComp := itbComplemento.next(nuIndexComp);
        END LOOP;
        ut_trace.trace('Complemento de direccion {'||sbComplemento||'}',2);
        -- se valida que el complemento no contenga mas de cnuLongitudComplemento caracteres
        IF (Length(sbComplemento) > cnuLongitudComplemento ) THEN
            errors.SetError(cnuLongitudCompExced, cnuLongitudComplemento);
            RAISE ex.CONTROLLED_ERROR;
        END IF ;
        osbComplemento := NULL;

        IF Length(sbDireccion) > cnuLongitudDireccion then
            -- Error analizando direccion, su longitud excede los (%s1) caracteres
            errors.setError(cnuLongitudDirExced, cnuLongitudDireccion);
            raise ex.CONTROLLED_ERROR;
        END IF;

        osbComplemento := trim(sbComplemento);
        osbDireccion    := trim(sbDireccion);

        ut_trace.trace('FIN: ab_boparser.obtienedireccion',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END obtieneDireccion;
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   retTokens
                    getTokens (Nombre Anterior)
    Descripcion	:   Descompone la direccion en lexemas.
                    La cadena de entrada se descompone en lexemas que equivalen a
                    posibles datos validos de la cadena, es decir que la direccion
                    que entra como parametro se descompone en cadenas que son
                    equivalentes a tokens o valores

    Parametros      Descripcion
    ============    ===================
    isbDireccion    Direccion en formato libre
    OtbDireccion    tabla pl de tokens direccion principal
    otbComplemento  tabla pl de tokens complemento

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    20-12-2012      amendezSAO198457    Estabilizacion SAO198272
                                        Validacion de longitud maxima de
                                        direccion y complemento
    12-12-2012      amendezSAO197917    Utiliza cache en la busqueda de tokens
    15-04-2011      amendezSAO146345    Se corrige la sincronia de asignacion
                                        de valores a tokens, cuando la direccion
                                        empieza por token ej. PO_BOX.
    11-11-2010      amendezSAO131516    Optimizacion parametros OUT

    10-01-2010      amendezSAO109552

    Se realizo ajuste para que ignore en la direccion ingresada la palabra VIA
    a pesar de que este definido como token. EJ "VIA KM 18." no sera dividido
    en {VIA}{KM 18}
    Sin embargo VIA si se analiza como parte de la gramatica,
    en caso de que la gramatica la incluya.

    Se apaga que palabras numericas forcen rompimiento en token.
    Como estaba antes partia {VIA KM}{18}, con el ajuste queda asi: {VIA KM 18}

    Arma tokens aunque no se reciba su valor Ej. #- => [VIA][CASA], esto
    evita que el parser arme tokens como VIA=-

    21-05-2009    jhramirezSAO94872     Creacion.
    ******************************************************************/
    PROCEDURE retTokens
    (
        isbDireccion    in  ab_address.address%type,
        otbDireccion    out nocopy UT_String.TyTb_StrParameters
    )
	IS
		-- Declaracion de variables.
		tbValues            UT_String.TyTb_String;
        nuIndexActual       number;         --Indice para la tabla que se recorre.
        --Puede ser Token Valor)
        sbToken             ab_address.address_parsed%type;
        sbTokenValor        varchar2(2000);
        nuIndiceParam       number  :=  1;  --Indice para la tabla parametros.
        --Guarda el token Anterior.
        sbTokenLast         ab_address.address_parsed%type  := '';
        sbdirecccion        ab_address.address_parsed%type;
	BEGIN
		-- Logica
        ut_trace.trace('INICIO retTokens ('''||isbDireccion||''',. . .)',2);

        --Ajuste de caracteres en la direccion de entrada para facilitar
        --la division en tokens.
        --El separador natural de lexemas o palabras es el espacio ' '
        sbdirecccion    := fsbformatoDir(isbDireccion);
        ut_string.ExtString(sbdirecccion,' ',tbValues);

        nuIndexActual   := tbValues.first; --El primer indice.
        sbTokenValor    := '';
        nuIndiceParam   := 0;

        --Recorre toda la tabla para extraer los token y los valores.
        LOOP
            -- Es una palabra, pero no se si es token-base o token-valor.
            sbToken := trim(upper(tbValues(nuIndexActual)));

            ut_trace.trace('Analizando token ('||sbToken||')',3);

            -- Cualquier valor que no sea un simbolo gramatical o
            -- la palabra configurada como via son considerados valores de
            -- un token y son acumulados para el proximo simbolo.
            -- La palabra configurada como via puede formar parte de la via
            -- por eso es tratada como valor Ej. CAMINO A LA VIA KM 18
            -- no debe partir en dos tokens por tener la palabra "VIA"

            IF sbToken = csbTOKEN_VIA OR not fblEsToken (sbToken) THEN
                -- Acumula los valores de un token
                ut_trace.trace('Concatenando token ['||sbToken||']',3);
                sbTokenValor := sbTokenValor || ' ' || sbToken ;

                IF length(sbTokenValor) > cnuLongitudDireccion then
                    -- Error analizando direccion, su longitud excede los (%s1) caracteres
                    errors.setError(cnuLongitudDirExced, cnuLongitudDireccion);
                    raise ex.controlled_error;
                END IF;

                --Si es el ultimo token, y como es valor, se tiene que adicionar al token anterior.
                IF (nuIndexActual = tbValues.last AND trim(sbTokenValor) IS NOT null) then
                    nuIndiceParam := nuIndiceParam + 1;
                    otbDireccion(nuIndiceParam).sbValue := trim(sbTokenValor);
                END IF;

            ELSE  --Si es Token
                sbTokenValor    := trim(sbTokenValor);
                ut_trace.trace('Es token ['||sbToken||'] Valor anterior ['||sbTokenValor||'] palabra anterior ['||sbTokenLast||']',3);
                -- Asigna el valor del token anterior
                -- Si el valor del token acumulado anterior es no nulo, o existe una palabra anterior tokens consecutivos sin valor
                -- Esto seria un error que se valida mas adelante.
                if sbTokenValor IS not null OR trim(sbTokenLast) IS not null  then
                    nuIndiceParam := nuIndiceParam + 1;
                    otbDireccion(nuIndiceParam).sbValue := sbTokenValor;
                    --Se reinicia el token valor.
                    sbTokenValor    := '';
                END if;
                -- Asigna el token Base sin incrementar el indice porque
                -- aun no tengo el valor
                sbToken         := fsbTokenBase(sbToken);
                otbDireccion(nuIndiceParam + 1).sbParameter := sbToken;
            END IF;

            if (nuIndexActual = tbValues.last ) then
                exit;
            end if;

            sbTokenLast     := sbToken; --Guarda el valor del token anterior.
            nuIndexActual   := tbValues.next(nuIndexActual);
        END LOOP;

        DespliegaTokens(otbDireccion);

        ut_trace.trace('FIN retTokens',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END retTokens;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   ValidaNulidadToken
    Descripcion	:   Valida que los tokens de la tabla pl/sql recibida
                    como parametro, tengan valor

    Parametros      Descripcion
    ============    ===================
    iotbTokens      tabla pl/sql con tokens a validar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    19-04-2011      amendezSAO146690
    Creacion.
    ****************************************************************/
    PROCEDURE ValidaNulidadToken
    (
        iotbTokens      IN OUT nocopy UT_String.TyTb_StrParameters
    )
    IS
       nuIndex        number;
    BEGIN
       ut_trace.trace('Inicio: AB_BOParser.ValidaNulidadToken',4);
       nuIndex := iotbTokens.first;
       LOOP
          EXIT WHEN nuIndex IS NULL;
           IF iotbTokens(nuIndex).sbParameter IS NOT NULL AND
              iotbTokens(nuIndex).sbValue IS null
           THEN
              -- El simbolo [%s1] no tiene valor
              errors.setError(cnuTokenNulo,iotbTokens(nuIndex).sbParameter);
              raise ex.Controlled_error;
           END if;
           nuIndex := iotbTokens.next(nuIndex);
        END LOOP;
        ut_trace.trace('Fin: AB_BOParser.ValidaNulidadToken',4);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
             raise ex.CONTROLLED_ERROR;
    END ValidaNulidadToken;

/*****************************************************************
    Unidad      :   separaComplemento
    Descripcion	:   Busca en la tabla pl/sql de direccion, los tokens
                    complemento, los elimina de la tabla de direccion y
                    los inserta en una tabla pl de complementos,
                    Esta tabla de complementos tiene indices de acuerdo al
                    ordenamiento en ab_token_hierarchy, OJO, no necesariamente
                    secuenciales.
                    La idea es que cuando se recorra la tabla de complementos,
                    esta este en el orden en que se encuentra en
                    ab_token_hierarchy

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    12-12-2012      amendezSAO197917    Utiliza cache en la busqueda de tokens
	11-11-2010	    amendezSAO131516    Optimizacion parametros OUT
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE separaComplemento
    (
        iotbDireccion   IN OUT nocopy UT_String.TyTb_StrParameters,
        otbComplemento  out nocopy    UT_String.TyTb_StrParameters
    )
    IS
        nuIndex        number;
        nuIndexComp    number;
        nuIndexProximo number;
        nuTokenOrder   ab_token_hierarchy.hierarchy%type;
    BEGIN
        ut_trace.trace('Inicio: AB_BOParser.separaComplemento',10);
        nuIndex := iotbDireccion.first;
        LOOP
            EXIT WHEN nuIndex IS NULL;

            IF iotbDireccion(nuIndex).sbParameter IS NOT NULL THEN
                -- La idea es almacenar en la tabla pl/sql de complementos de tal manera que
                -- quede ordenada. Sabemos que el orden esta en ab_token_hierarchy
                -- podemos utilizar ese ordenamiento como parte del indice para almacenar en la tabla.
                -- aprovechando ademas que en una tabla pl/sql, los indices no necesariamente
                -- son secuenciales.
                -- Se debe resolver el problema, que en el ordenamiento haya indices
                -- repetidos.
                IF fblesComplemento(iotbDireccion(nuIndex).sbParameter,nuTokenOrder) THEN
                    ut_trace.trace('Separando token '||iotbDireccion(nuIndex).sbParameter||' por ser complemento',3);

                    -- Busca un lugar disponible en la tabla de complementos
                    nuIndexComp := nvl(nuTokenOrder,0);
                    LOOP
                        EXIT WHEN NOT otbComplemento.exists(nuIndexComp);
                        nuIndexComp := nuIndexComp + 1;
                    END LOOP;

                    otbComplemento(nuIndexComp).sbParameter:= iotbDireccion(nuIndex).sbParameter;
                    otbComplemento(nuIndexComp).sbValue := iotbDireccion(nuIndex).sbValue;
                    nuIndexProximo := iotbDireccion.next(nuIndex);
                    iotbDireccion.delete(nuIndex);
                    nuIndex := nuIndexProximo;
                ELSE
                    nuIndex := iotbDireccion.next(nuIndex);
                END IF;
            ELSE
                nuIndex := iotbDireccion.next(nuIndex);
            END IF;

        END LOOP;

        ut_trace.trace('Fin: AB_BOParser.separaComplemento',10);


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END separaComplemento;


    /*****************************************************************
    Unidad      :   GetValueDomain
    Descripcion	:   Obtiene valor especifico del dominio.

    Parametros          Descripcion
    ============        ===================
    isbTagComposition   Nombre de la Composicion de dominio

    osbValue            Valor de dominio

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    29-09-2011      cocampoSAO148875    Creacion.
    ****************************************************************/
    PROCEDURE GetValueDomain
    (
        isbTagComposition   in   ab_domain_comp.name_%type,
        osbValue            out  ab_domain_values.value%type
    )
    IS

        nuDomainCompId         ab_domain_comp.domain_comp_id%type;
        tbResultDomainComp     daab_domain_comp.tytbAB_domain_comp;

    BEGIN
        ut_trace.trace('Inicio: AB_BOParser.GetValueDomain',15);

        osbValue := NULL;

        -- Se busca el valor asociado al nombre de la composicion de dominio en la tabla global de valores de dominio
        IF tbDomainValues.first IS NOT NULL THEN
            FOR i IN tbDomainValues.first .. tbDomainValues.last LOOP
                if tbDomainValues(i).sbDomainCompName  = isbTagComposition then
                    osbValue := tbDomainValues(i).sbValue;
                    ut_trace.Trace('Tag de Composicion de Dominio [' || osbValue || ']',20);
                    exit;
                END if;
            END LOOP;
        END if;

        ut_trace.trace('Fin: AB_BOParser.GetValueDomain',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('CONTROLLED_ERROR: AB_BOParser.GetValueDomain',15);
            raise ex.CONTROLLED_ERROR;
        when others then
            ut_trace.trace('others: AB_BOParser.GetValueDomain',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   GetIndexValueDomain
    Descripcion	:   Obtiene el indice en la tabla de valores de dominio dado un
                    identificador de composcion de dominio

    Parametros          Descripcion
    ============        ===================
    inuDomainCompId     Id de la Composicion de dominio

    onuIndex            Indice

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    29-09-2011      cocampoSAO148875    Creacion.
    ****************************************************************/
    PROCEDURE GetIndexValueDomain
    (
        inuDomainCompId    in   ab_domain_comp.domain_comp_id%type,
        onuIndex          out  number
    )
    IS

    BEGIN
        ut_trace.trace('Inicio: AB_BOParser.GetIndexValueDomain',15);

        onuIndex := -1;

        -- Se busca el valor asociado al identificador de la composicion de dominio en la tabla global de valores de dominio
        IF tbDomainValues.first IS NOT NULL THEN
            FOR i IN tbDomainValues.first .. tbDomainValues.last LOOP
                if inuDomainCompId = tbDomainValues(i).nuDomainCompId then
                    onuIndex := i;
                    exit;
                END if;
            END LOOP;
        END if;

        ut_trace.trace('Fin: AB_BOParser.GetIndexValueDomain',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('CONTROLLED_ERROR: AB_BOParser.GetIndexValueDomain',15);
            raise ex.CONTROLLED_ERROR;
        when others then
            ut_trace.trace('others: AB_BOParser.GetIndexValueDomain',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   ValDomainToken
    Descripcion	:   Ejecuta las validaciones del dominio.

    Parametros      Descripcion
    ============    ===================
    itbTokens       Tabla con simbolo de token de dominio y el valor respectivo

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    16-01-2012      cocampo.SAO171139   1 - Se modifica nombre de variable blGramaticaOK
                                            por blGramViasOK
    16-10-2011      cocampoSA162697     Se modifica el metodo
                                            <ValDomainToken.ValConfigExpression>
    30-09-2011      cocampoSAO148875    Creacion.
    ****************************************************************/
    PROCEDURE ValDomainToken
    (
        itbTokens      IN UT_String.TyTb_StrParameters
    )
    IS

        nuIndex         BINARY_INTEGER;                                 -- Indice
        nuDomainId      ab_domain.domain_id%type;                       -- Identificador del dominio asociado al token
        rfComposition   constants.tyRefCursor;                          -- CURSOR para obtener la Informacion de la composicion de un dominio dado
        tbComposition   daab_domain_comp.tytbAB_domain_comp;            -- Informacion de la composicion de un dominio dado
        nuPosition      number;                                         -- Variable utilizada para almacenar la posicion definida en la composicion de dominio
        sbValue         varchar(32000);                                 -- Variable utilziada para almacena cada valor individual del valor dado
        nuLength        ab_domain.length%type;                          -- Tama?o del dominio

        /*****************************************************************
        Unidad      :   ValConfFather
        Descripcion	:   Ejecuta la validacion sobre la configuracion de PAdre-Hijo

        Parametros        Descripcion
        ============      ===================
        inuDomainCompId   Identificador de Composicion de dominio
        isbValue          Valor de dominio

        Historia de Modificaciones
        Fecha           Autor               Modificacion
        ============    =================== ====================
        30-09-2011      cocampoSAO148875    Creacion.
        ****************************************************************/
        PROCEDURE ValConfFather
        (
           inuDomainCompId   ab_domain_comp.domain_comp_id%type,
           isbValue           varchar2
        )
        IS

            blResult                  boolean;
            nuDomainValueId           ab_domain_values.domain_value_id%type;          -- Identificador de el valor de dominio (Utilizado para cada token el valor dado)
            tbAllDomainValues         daab_domain_values.tytbAB_domain_values;      -- Informacion de el valor de dominio (Utilizado para cada token el valor dado)
            nuFatherDomainValueId     ab_domain_values.father_id%type;
            nuIndexDomainValue        number;
            nuIndexFatherDomainValue  number;
            rfDomainValues            constants.tyRefCursor;

        BEGIN
            ut_trace.trace('INICIO: ValDomainToken.ValConfFather',15);

            blResult := FALSE;

            GetIndexValueDomain(inuDomainCompId,nuIndexDomainValue);

            rfDomainValues := ab_bcparser.frfDomainValues(inuDomainCompId,isbValue);

            fetch rfDomainValues bulk collect INTO tbAllDomainValues;

            IF rfDomainValues%isOpen then
                CLOSE rfDomainValues;
            END IF;

            -- Se verifica que la consistencia de los datos, es decir que
            -- la configuracion de Padre e Hijo para cada valor sea correcta.
            if tbAllDomainValues.first IS not null then
                FOR i IN tbAllDomainValues.first .. tbAllDomainValues.last LOOP

                    -- Se obtiene el identificador del valor de dominio
                    nuDomainValueId := tbAllDomainValues(i).domain_value_id;
                    ut_trace.trace('Id Valor del Dominio [nuDomainValueId: ' || nuDomainValueId || ']',20);

                    -- Se obtiene el padre del valor de dominio
                    nuFatherDomainValueId := daab_domain_values.fnuGetFather_Id(nuDomainValueId);
                    ut_trace.trace('Padre del Valor del Dominio [nuFatherDomainValueId: ' || nuFatherDomainValueId || ']',20);

                    -- Si el padre es nulo indica que el registro es unico y los datos son correctos.
                    -- Si el padre no es nulo, se verifica que la configuracion padre e hijo sea correcta.
                    IF nuFatherDomainValueId IS NULL THEN
                        tbDomainValues(nuIndexDomainValue).nuDomainValueId     := nuDomainValueId;
                        tbDomainValues(nuIndexDomainValue).nuDomainValueFather := null;
                        blResult := true;
                        exit;
                    else
                        -- Se obtiene el indice del record con la informacion del papa
                        GetIndexValueDomain(tbDomainValues(nuIndexDomainValue).nuDomainCompFather,nuIndexFatherDomainValue);
                        ut_trace.trace('Padre Real: ' || tbDomainValues(nuIndexFatherDomainValue).nuDomainValueId || ']',20);

                        -- Se valida si el papa del valor de dominio es el correcto se asigna TRUE al resultado, es decir que los datos son correctos.
                        if nuFatherDomainValueId = tbDomainValues(nuIndexFatherDomainValue).nuDomainValueId then
                            tbDomainValues(nuIndexDomainValue).nuDomainValueId     := nuDomainValueId;
                            tbDomainValues(nuIndexDomainValue).nuDomainValueFather := nuFatherDomainValueId;
                            blResult := true;
                            exit;
                        END if;
                    END if;
                END loop;
            END if;

            -- Si la variable blResult continua en FALSE significa que el valor digitado para la composicion de dominio no exite.
            if not blResult then
                -- La configuracion Padre-Hijo es incorrecta
                ut_trace.trace('No existe el valor de dominio indicado para la composicion de dominio',20);
                errors.setError(cnuErrConfFather, daab_domain_comp.fsbGetName_(inuDomainCompId));
                raise ex.Controlled_error;
            END if;

            ut_trace.trace('FIN: ValDomainToken.ValConfFather',15);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR: ValDomainToken.ValConfFather',15);
                IF rfDomainValues%isOpen then
                    CLOSE rfDomainValues;
                END IF;
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others: ValDomainToken.ValConfFather',15);
                IF rfDomainValues%isOpen then
                    CLOSE rfDomainValues;
                END IF;
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END ValConfFather;

        /*****************************************************************
        Unidad      :   ValRange
        Descripcion	:   Ejecuta la validacion del rango permitido para una
                        valor de dominio

        Parametros        Descripcion
        ============      ===================
        inuDomainCompId   Identificador de Composicion de dominio
        isbValue          Valor de dominio

        Historia de Modificaciones
        Fecha           Autor               Modificacion
        ============    =================== ====================
        30-09-2011      cocampoSAO148875    Creacion.
        ****************************************************************/
        PROCEDURE ValRange
        (
            inuDomainCompId   in ab_domain_comp.domain_comp_id%type,
            isbValue          in varchar2
        )
        IS
            sbValidRange      ab_domain_comp.valid_range%type;
            tbValidRange      UT_String.TyTb_String;
            nuValue           number;
            nuInitial         number;
            nuFinal           number;
        BEGIN
            ut_trace.trace('INICIO: ValDomainToken.ValRange',15);

            -- Se obtiene el rango valido para la composicion de dominio dada.
            sbValidRange := daab_domain_comp.fsbGetValid_Range(inuDomainCompId);

            if  sbValidRange IS not null then

                -- Se elimina los espacios del string
                sbValidRange := REPLACE(sbValidRange, ' ', '');

                ut_trace.trace('Rango ['|| sbValidRange || ']', 20);

                -- Convierte el rango en campos de una tabla (numInicial, numFinal)
                UT_String.ExtString(sbValidRange, '-', tbValidRange);

                if tbValidRange.count = 2 then

                    ut_trace.trace('Numero Inicial: ' || tbValidRange(1), 20);
                    ut_trace.trace('Numero Final: ' || tbValidRange(2), 20);

                    -- Se convierte los valores en string a numeros
                    nuValue   :=  ut_convert.fnuChartoNumber(isbValue);
                    nuInitial :=  ut_convert.fnuChartoNumber(tbValidRange(1));
                    nuFinal   :=  ut_convert.fnuChartoNumber(tbValidRange(2));

                    -- Se valida que si el valor no esta dentro del rango valido se eleve error
                    if (nuValue < nuInitial) OR (nuValue > nuFinal) then
                        -- El valor no esta dentro del rango valido definido para la composicion de dominio
                        ut_trace.trace('El valor no esta dentro del rango valido definido para la composicion de dominio',15);
                        errors.setError(cnuErrRange,daab_domain_comp.fsbGetName_(inuDomainCompId));
                        raise ex.Controlled_error;
                    END if;
                else
                    -- Error en el rango definido en la BD
                     ut_trace.trace('Error en el rango definido en la BD ',15);
                    errors.setError(cnuErrRange,daab_domain_comp.fsbGetName_(inuDomainCompId));
                    raise ex.Controlled_error;
                END if;
            END if;

            ut_trace.trace('FIN: ValDomainToken.ValRange',15);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR: ValDomainToken.ValRange',15);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others: ValDomainToken.ValRange',15);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END ValRange;


        /*****************************************************************
        Unidad      :   ValConfigExpression
        Descripcion	:   Ejecuta la regla de expresion de validacion definida
                        por composicion de dominio

        Parametros        Descripcion
        ============      ===================
        inuDomainCompId   Identificador de Composicion de dominio

        Historia de Modificaciones
        Fecha           Autor               Modificacion
        ============    =================== ====================
        18-10-2011      cocampoSAO162697    Se a?ade la ejecucion de la regla en un bloque
                                            independiente para que se eleve el codigo de error
                                            correcto.
        30-09-2011      cocampoSAO148875    Creacion.
        ****************************************************************/
        PROCEDURE  ValConfigExpression
        (
            inuDomainCompId   ab_domain_comp.domain_comp_id%type
        )
        IS
            nuConfigExpression  ab_domain_comp.config_expression_id%type;
            nuErrCode           ge_error_log.error_log_id%type;
            sbErrMsg            ge_error_log.message_id%type;
        BEGIN
            ut_trace.trace('INICIO: ValDomainToken.ValConfigExpression',15);

            nuConfigExpression := daab_domain_comp.fnuGetConfig_Expression_Id(inuDomainCompId);

            ut_trace.trace('nuConfigExpression: ' || nuConfigExpression,15);

            if nuConfigExpression IS not null then

                BEGIN
                    gr_boconfig_expression.Execute(nuConfigExpression, nuErrCode, sbErrMsg);
                EXCEPTION
                   when ex.CONTROLLED_ERROR then
                        ut_trace.trace('CONTROLLED_ERROR Error en Validacion de Regla: ValDomainToken.ValConfigExpression',15);
                   when others then
                        ut_trace.trace('others Error en Validacion de Regla: ValDomainToken.ValConfigExpression',15);
                END;

                if nuErrCode <> 0 then
                    -- No cumple con la expresion de validacion
                    ut_trace.trace('No cumple con la expresion de validacion',15);
                    raise ex.Controlled_error;
                END if;

            END if;

            ut_trace.trace('FIN: ValDomainToken.ValConfigExpression',15);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                ut_trace.trace('CONTROLLED_ERROR: ValDomainToken.ValConfigExpression',15);
                raise ex.CONTROLLED_ERROR;
            when others then
                ut_trace.trace('others: ValDomainToken.ValConfigExpression',15);
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END ValConfigExpression;

    BEGIN
        ut_trace.trace('Inicio: AB_BOParser.ValDomainToken',10);

        nuPosition := 1;
        nuIndex := 1;


        /* Se verifica que solo existan un solo simbolo de dominio
        Por arquitectura si una direccion tiene un simbolo (Token) de dominio no puede tener mas simbolos*/
        if itbTokens.count = 1 then

            -- Se obtiene el dominio definido en el token
            nuDomainId := fnuDomainId(itbTokens(itbTokens.first).sbParameter);

            -- Se obtiene el tama?o que debe tener el dominio
            nuLength   := daab_domain.fnuGetLength(nuDomainId);

            -- Se verifica que el tama?o del valor ingresado es igual al tama?o definido para el dominio
            if LENGTH(itbTokens(1).sbValue) = nuLength then

                -- Se obtiene la informacion completa de la composicion del dominio.
                rfComposition := ab_bcparser.frfCompositionDomain(nuDomainId);

                fetch rfComposition bulk collect INTO tbComposition;

                IF rfComposition%isOpen then
                    CLOSE rfComposition;
                END IF;

                -- Se almancena en tabla global la informacion de forma separada de los valores de dominio ingresados
                IF tbComposition.first IS NOT NULL THEN
                    FOR i IN tbComposition.first .. tbComposition.last LOOP

                        sbValue := substr(itbTokens(1).sbValue,nuPosition, tbComposition(i).length);

                        tbDomainValues(nuIndex).nuDomainCompId      := tbComposition(i).domain_comp_id;
                        tbDomainValues(nuIndex).sbDomainCompName    := tbComposition(i).name_;
                        tbDomainValues(nuIndex).nuDomainCompFather  := tbComposition(i).father_id;
                        tbDomainValues(nuIndex).sbValue             := sbValue;

                        nuPosition := nuPosition + tbComposition(i).length;
                        nuIndex    := nuIndex + 1;

                    END LOOP;
                END if;

                -- Se realizan las validaciones de cada valor ingresado
                 IF tbDomainValues.first IS NOT NULL THEN
                    FOR i IN tbDomainValues.first .. tbDomainValues.last LOOP

                        ut_trace.trace('Id Composicion de Dominio : ' || tbDomainValues(i).nuDomainCompId,15);
                        ut_trace.trace('Valor del Token: ' || tbDomainValues(i).sbValue,15);

                        ValConfFather (tbDomainValues(i).nuDomainCompId,tbDomainValues(i).sbValue);

                        ValRange (tbDomainValues(i).nuDomainCompId, tbDomainValues(i).sbValue);

                        ValConfigExpression(tbDomainValues(i).nuDomainCompId);

                    END LOOP;
                END if;


            else
               -- Longitud no coincide con la definida en el dominio
               ut_trace.trace('Longitud no coincide con la definida en el dominio',10);
                errors.setError(cnuErrLongDomain, daab_domain.fsbGetName_(nuDomainId));
                raise ex.Controlled_error;
            END if;

        else
            -- Solo debe existir un simbolo de dominio
            ut_trace.trace('Solo debe existir un simbolo de dominio',10);
            errors.setError(cnuErrDirNoGrama);
            raise ex.Controlled_error;
        END if;

        ut_trace.trace('Fin: AB_BOParser.ValDomainToken',10);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('CONTROLLED_ERROR: AB_BOParser.ValDomainToken',10);
            -- Se indica que hubo error en la gramatica.
            blGramViasOK := FALSE;
            IF rfComposition%isOpen then
                CLOSE rfComposition;
            END IF;
            raise ex.CONTROLLED_ERROR;
        when others then
            ut_trace.trace('others: AB_BOParser.ValDomainToken',10);
            -- Se indica que hubo error en la gramatica.
            blGramViasOK := FALSE;
            IF rfComposition%isOpen then
                CLOSE rfComposition;
            END IF;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   CheckSyntax
    Descripcion	:   Parsea direccion para una ubicacion geografica

    Parametros          Descripcion
    ============        ===================
    isbDireccion       Direccion en formato libre a parsear
    inuGeoLocation     Codigo de la ubicacion geografica
    orcDirParseada     Estructura de memoria con los datos de la direccion
                       a parsear

    Historia de Modificaciones
    Fecha           Autor            Modificacion
    ============    ================ ====================
    18-12-2012      amendezSAO198254 Se elimina validacion de valores simbolos
                                     esta funcionalidad es absorvida por dominios Ej. codificacion IGAC
    12-12-2012      amendezSAO197917 Utiliza cache para obtener el dominio del token
    11-04-2012      hcruzSAO177713   Se incluye correcion al SAO179708.
                                     Se debe adicionar a la condicion que retorna la direccion que esta en cache,
                                     que ademas de tener en cuenta la direccion en formato libre
                                     tambien tenga en cuenta la ubicacion geografica.
                                     Se adiciona tambien la instruccion que coloca la ubicacion en el record
    16-01-2012      cocampoSAO171139 1 - Se modifica nombre de variable blGramaticaOK por blGramViasOK
    30-09-2011      cocampoSAO148875 1 - Se asigina FALSE a la variable blGramaticaOK cuando
                                     ocurre un error en la gramatica o vias.
                                     2 -  Se modifica para validar si la direccion tiene
                                     token de domino y asi hacer el llamado al metodo
                                     AB_BOPARSER.ValDomianToken para realizar las validaciones.
    20-04-2011      amendezSAO146905 Estabilizacion SAO146690
                                     Se valida que la direccion no sea nula
    21-09-2010      amendezSAO122447 Se elimina variable global gsbLastParsedDir
                                     se manejara a traves de parametro nocopy
                                     Se sube a mayusculas la direccion, para
                                     que el resto de los procesos trabajen
                                     siempre con mayusculas y evitar tener que
                                     realizar posteriores conversiones.
                                     se adiciona parametro isbUseCache por defecto 'Y'
                                     indicando si el parser debe utilizar el cache.
    22-02-2010      amendezSAO112877 Se ajusta para que compare con NULL
                                     para identificar que se trata de una gramatica
                                     que no pudo ser calculada

    10-02-2010      amendezSAO109561 Se deja nocopy el parametro orcDirParseada
                                     para que aun en caso de excepcion,
                                     actualizar los campos que pudo identificar
                                     como por ej. una via.
    29-01-2010      juzuriagaSAO109562 (ref amendez)
                                     Se asigna direccion en formato libre
                                     a registro de direccion.
    10-01-2010      amendezSAO109552 Creacion
    ******************************************************************/
    PROCEDURE CheckSyntax
    (
        isbDireccion       in            ab_address.address%type,
        inuGeoLocation     in            ge_geogra_location.geograp_location_id%type,
        orcDirParseada     IN OUT nocopy tyrcDirParseada,
        isbuseCache        in            varchar2 default 'Y'
    )
	IS
		-- Declaracion de variables.
        tbDirGramaPadre    UT_String.TyTb_StrParameters;
        nuIndexGram        BINARY_INTEGER;
        sbDireccion        ab_address.address%type;


    BEGIN
        ut_trace.trace('Inicio: AB_BOParser.CheckSyntax',2);

        sbDireccion := trim(upper(isbDireccion));

        if sbDireccion IS null then
            errors.setError(cnuAddressNull);
            raise ex.CONTROLLED_ERROR;
        end if;

        if isbuseCache = csbYES and sbDireccion = rcCacheDirParseada.sbDirFmtoLibre and inuGeoLocation = rcCacheDirParseada.nuGeoLocation then
            orcDirParseada := rcCacheDirParseada;
            ut_trace.trace('Retornando de Cache estructura de direccion parseada ['||orcDirParseada.sbDirParseada||']',2);
            ut_trace.trace('Fin: AB_BOParser.CheckSyntax',2);
            RETURN;
        end if;

        orcDirParseada.sbDirFmtoLibre := sbDireccion;
        orcDirParseada.nuGeoLocation  := inuGeoLocation;

        --Busca en la gramatica la direccion que le entro (tbDireccion tiene solo tokens principales)
        buscaCoincidencia
        (
            inuGeoLocation,
            sbDireccion,
            orcDirParseada
        );

        ut_trace.trace('Tokens de tbDireccion.',3);
        DespliegaTokens(orcDirParseada.tbDireccion);

        IF (orcDirParseada.nuIdGramaPadre IS NULL) THEN
            -- Se indica que hubo error en la gramatica.
            blGramViasOK := FALSE;
            -- Direccion [%s1] no coincide con la gramatica.
            Errors.setError(cnuErrDirNoGrama, sbDireccion);
            raise ex.CONTROLLED_ERROR;
        END IF;

        construyeDirPadre(orcDirParseada.nuIdGramaPadre, orcDirParseada.tbExitos, tbDirGramaPadre);

        obtieneDireccion
        (
            tbDirGramaPadre,
            orcDirParseada.tbComplemento,
            orcDirParseada.sbDirParseada,
            orcDirParseada.sbComplemento,
            orcDirParseada.nuCasa,
            orcDirParseada.sbCasa
        );

        ut_trace.trace('Tokens de tbDirGramaPadre.',3);
        DespliegaTokens(tbDirGramaPadre);

        -- Si el simbolo es token de dominio se realizan las validaciones respectivas.
        if (tbDirGramaPadre.first IS not null)
           AND  ( fnuDomainId(  tbDirGramaPadre(tbDirGramaPadre.first).sbParameter) IS not null ) then

           -- Se ejecuta las validaciones
            ValDomainToken(tbDirGramaPadre);

        else

            orcDirParseada.tbDirePadre    := tbDirGramaPadre;
            orcDirParseada.tbDireccion    := orcDirParseada.tbDireccion;

            -- Valida las vias obtenidas de acuerdo al numero de vias de la
            -- gramatica
            ValidaCantVias
            (
            orcDirParseada.nuViasEnGramatica,
            orcDirParseada.sbDirParseada,
            orcDirParseada.nuPrimeraVia,
            orcDirParseada.nuSegundaVia,
            orcDirParseada.sbPrimeraVia,
            orcDirParseada.sbSegundaVia,
            inuGeoLocation
            );

            -- Calcula el segmento solo si la gramatica contiene [VIA]
            IF orcDirParseada.nuViasEnGramatica > 0 then

                ut_trace.trace('inuGeoLocation['||inuGeoLocation||']',1);
                    ut_trace.trace('nuPrimeraVia['||orcDirParseada.nuPrimeraVia||']',1);
                ut_trace.trace('nuSegundaVia['||orcDirParseada.nuSegundaVia||']',1);
                ut_trace.trace('nuCasa['||orcDirParseada.nuCasa||']',1);
                ab_bosegment.CalculaSegmento
                (
                inuGeoLocation,
                orcDirParseada.nuPrimeraVia,
                orcDirParseada.nuSegundaVia,
                orcDirParseada.nuCasa,
                orcDirParseada.nuSegmento
                );
                ut_trace.trace('nuSegmento['||orcDirParseada.nuSegmento||']',1);
            END IF;

            ValSegmento
            (
             orcDirParseada.nuSegmento,
             orcDirParseada.nuViasEnGramatica,
             orcDirParseada.sbDirParseada
            );


        END if;

        ut_trace.trace('Guardando Info de direccion parseada ['||orcDirParseada.sbDirParseada||'] en cache ',2);

        -- En este punto la direccion paso todas las validaciones
        -- Se almacena en cache
        if isbuseCache = csbYES then
            rcCacheDirParseada                := orcDirParseada;
            rcCacheDirParseada.sbDirFmtoLibre := sbDireccion;
        END if;

        ut_trace.trace('Fin: AB_BOParser.CheckSyntax',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ut_trace.trace('Fin: AB_BOParser.CheckSyntax : Excepcion !! : :{'||errors.nuErrorCode||'-'||errors.sbErrorMessage||'}',2);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ut_trace.trace('Fin: AB_BOParser.CheckSyntax : Excepcion !! : :{'||errors.nuErrorCode||'-'||errors.sbErrorMessage||'}',2);
            raise ex.CONTROLLED_ERROR;
    END CheckSyntax;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    FUNCTION fbldireccionValida
    (
        isbDireccion    in ab_address.address%type,
        inuUbicGeograf  in ge_geogra_location.geograp_location_id%type
    ) RETURN BOOLEAN
    IS
        rcDirParseada     tyrcDirParseada;
    BEGIN

        CheckSyntax
        (
            isbDireccion,
            inuUbicGeograf,
            rcDirParseada
        );

        RETURN TRUE;

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            RETURN FALSE;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   get_parameters
    Descripcion	:   Parametros operativos para el parseo de direcciones.

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    27-05-2009      jhramirezSAO94872   Creacion.
    ****************************************************************/
    PROCEDURE get_parameters
    IS
    BEGIN
        IF blParametros THEN
            RETURN;
        END IF;

        sbTOKEN_CASA    := ge_boparameter.fsbGet('TOKEN_CASA');

        ut_trace.trace('Parametros del sistema:',2);
        ut_trace.trace('TOKEN_CASA=['||sbTOKEN_CASA||']',2);


        blParametros := TRUE;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   ValidaCantVias
    Descripcion	:   Valida que las vias definidas en la gramatica
                    y parseadas en la direccion, existan en la tabla de vias

    Parametros         Descripcion
    ============       ===================
    inuViasEnGramatica Numero de vias en la gramatica
    isbDireccion       Direccion parseada
    inuPrimeraVia      Codigo de primera via en la tabla de vias
    inuSegundaVia      Codigo de segunda via en la tabla de vias
    isbPrimeraVia      Descripcion de primera via, exista o no en la tabla de vias
    isbSegundaVia      Descripcion de segunda via, exista o no en la tabla de vias

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    16-01-2012      cocampo.SAO171139   Se modifica para que asigne FALSE a la variable
                                        blGramViasOK cuando haya un error de vias o cruces
    22-09-2011      juzuriaga.SAO158497 Se adicionan las siguientes validaciones:
                                        1. Valido si la primera via tiene vias de cruce
                                        2. Valido que la segunda via sea un cruce valido
    21-09-2010      amendezSAO122447    Se despliega la direccion completa
                                        en el mensaje de error.
    01-29-2010      jusuriagaSAO109562  (ref amendez)
                                        Se ajusta parametro para elevar error
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE ValidaCantVias
    (
        inuViasEnGramatica in number,
        isbDireccion       IN VARCHAR2,
        inuPrimeraVia      in ab_way_by_location.way_by_location_id%type,
        inuSegundaVia      in ab_way_by_location.way_by_location_id%type,
        isbPrimeraVia      IN ab_way_by_location.description%type,
        isbSegundaVia      IN ab_way_by_location.description%type,
        inuGeoLocation     IN ab_way_by_location.geograp_location_id%type
    )
    IS
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.ValidaCantVias',2);

        IF nvl(inuViasEnGramatica,0) > 0 AND inuPrimeraVia IS NULL THEN
            -- No se encontro la via [%s1] en direccion normalizada [%s2]
            errors.SetError(cnuNoExisteVia,isbPrimeraVia||'|'||isbDireccion);
            RAISE ex.CONTROLLED_ERROR;
        END IF;
        IF nvl(inuViasEnGramatica,0) > 1 AND inuSegundaVia IS NULL THEN
            -- No se encontro la via [%s1] en direccion normalizada [%s2]
            errors.SetError(cnuNoExisteVia,isbSegundaVia||'|'||isbDireccion);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        --Valido si la primera via tiene vias de cruce
        IF inuPrimeraVia IS NOT NULL AND inuSegundaVia IS NULL THEN
           AB_BOValidCross.ValWayHaveCross(inuGeoLocation, inuPrimeraVia);
        END IF;

        --Valido que la segunda via sea un cruce valido
        IF inuPrimeraVia IS NOT NULL AND inuSegundaVia IS NOT NULL THEN
            AB_BOValidCross.ValCrossWay(inuGeoLocation,inuPrimeraVia, inuSegundaVia );
        END IF;

        ut_trace.trace('Fin: ab_boParser.ValidaCantVias',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            -- Se indica que hubo error en la validacion de vias y cruces.
            blGramViasOK := FALSE;
            raise ex.CONTROLLED_ERROR;
        when others then
            -- Se indica que hubo error en la validacion de vias y cruces.
            blGramViasOK := FALSE;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   ValSegmento
    Descripcion	:   Valida que el segmento no sea nulo si la gramatica
                    tiene al menos una via

    Parametros         Descripcion
    ============       ===================
    inuSegmento        Segmento
    inuCantVias        Numero de vias en la gramatica
    isbDireccion       Direccion parseada

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE ValSegmento
    (
        inuSegmento  IN ab_segments.segments_id%type,
        inuCantVias  IN NUMBER,
        isbDireccion IN ab_address.address%type
    )
    IS
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.ValidaSegmento',2);

        IF nvl(inuCantVias,0)>0 AND inuSegmento IS NULL then
            -- No se pudo calcular segmento para la direccion [%s1]
            errors.SetError(cnuSegmentoNoCalculado,isbDireccion);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        ut_trace.trace('Fin: ab_boParser.ValidaSegmento',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------

    PROCEDURE CHECKSYNTAX
    (
        address           IN  VARCHAR2,
        inuGeoLocation    IN  NUMBER,
        addressParsed     out nocopy VARCHAR2,
        nuErrorCode       out nocopy NUMBER,
        sbErrorMessage    out nocopy VARCHAR2
    )
    IS

        rcDirParseada     tyrcDirParseada;

    BEGIN
        errors.Initialize;

        CheckSyntax
        (
            address,
            inuGeoLocation,
            rcDirParseada
        );

        addressParsed := rcDirParseada.sbDirParseada;

        -- Retorna exito
        nuErrorCode    := 0;
        sbErrorMessage := '';

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            errors.GetError(nuerrorcode,sberrormessage);
        when others then
            Errors.setError;
            errors.GetError(nuerrorcode,sberrormessage);
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   fsbDominioComplemento
    Descripcion	:   Retorna valor constante que indica cual es el dominio
                    de cualquier simbolo complemento

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    FUNCTION fsbDominioComplemento
    RETURN   varchar2
    IS
    BEGIN
        RETURN csbDominioComplemento;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


    /*****************************************************************
    Unidad      :   CompletaRegisDir
    Descripcion	:   Llena algunos campos de la direccion a insertar
                    o actualizar

    Parametros      Descripcion
    ============    ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    15-05-2012      hcruz.SAO181951     Se modifica para que de ahora en adelante
                                        se realice la asignacion de barrio y el codigo postal en
                                        las direcciones inconsitentes y rurales.
                                        El caso del barrio funciona al reves de las direcciones
                                        urbanas consistentes ya que siempre se le dara prioridad
                                        al barrio que ingresa y no al barrio del segmento.
    14-05-2012      hcruzSAO182280      Se modifica para que al valor del campo IS_main
                                        no siempre se le asigne YES. Se valida si la direccion
                                        ya tiene un valor definido en este campo, si lo tiene se
                                        asigna el valor que trae sino se asigna YES.
    13-01-2011      hcruzSAO138308      Se adiciona condicion bajo la cual solo se asigna el
                                        barrio del segmento en caso que se obtenga un valor
                                        diferente de nulo.
	11-11-2010      amendezSAO131516    Optimizacion parametros OUT
	27-09-2010      amendezSAO122447    Se modifica los nombres de
                                        los parametros de entrada/salida
                                        segun el estandard
    21-07-2010      jgutierrezSAO120379 Se modifica para insertar el segmento inconsistente.
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE CompletaRegisDir
    (
        inuGeoLocationId IN ab_address.geograp_location_id%type,
        isbIsUrban       IN VARCHAR2,
        ionuParser_id    IN out nocopy ab_address.address_id%type,
        ircDirParseada   IN tyrcDirParseada,
        orcDir           IN OUT nocopy daab_address.styAB_address
    )
    IS
        nuNeighborthood number;
    BEGIN
        ut_trace.trace('INICIO CompletaRegisDir',3);

        -- Completa el registro de la direccion a insertar
        IF ionuParser_id IS NULL then
            orcDir.address_id        := AB_BOSequence.fnuNextADDRESS;
            ionuParser_id            := orcDir.address_id;
            orcDir.is_main           := csbYES;
        ELSE
            orcDir.address_id        := ionuParser_id;
            orcDir.is_main           := daab_address.fsbGetIs_Main(ionuParser_id,0);
        END IF;

        orcDir.geograp_location_id   := inuGeoLocationId;
        orcDir.is_urban              := isbIsUrban;
        orcDir.installed_lines       := 0;
        orcDir.transact_lines        := 0;
        orcDir.installed_air_lines   := 0;
        orcDir.transact_air_lines    := 0;
        orcDir.grammar_id            := ircDirParseada.nuIdGramaPadre;
        orcDir.way_id                := ircDirParseada.nuPrimeraVia;
        IF orcDir.way_id IS NOT NULL then
            orcDir.way_type          := daab_way_by_location.fnugetway_type_id( orcDir.way_id );
        END IF;
        orcDir.cross_way_id          := ircDirParseada.nuSegundaVia;
        IF orcDir.cross_way_id IS NOT NULL THEN
            orcDir.cross_way_type    := daab_way_by_location.fnugetway_type_id( orcDir.cross_way_id );
        END IF;
        orcDir.house_number          := ircDirParseada.nuCasa;
        orcDir.house_letter          := ircDirParseada.sbCasa;
        orcDir.address_complement    := ircDirParseada.sbComplemento;

        IF ircDirParseada.nuSegmento IS NOT NULL THEN
            orcDir.segment_id        := ircDirParseada.nuSegmento;
                -- Asigna el barrio a partir del Segmento
            nuNeighborthood := daab_segments.fnuGetNeighborhood_id(ircDirParseada.nuSegmento);
            IF nuNeighborthood IS NOT NULL then
                ut_trace.trace('Se reemplaza el barrio con el del segmento ['||nuNeighborthood||']',2);
                orcDir.neighborthood_id  := nuNeighborthood;
            END IF;
            orcDir.zip_code_id       := daab_segments.fnuGetZip_code_id(ircDirParseada.nuSegmento);
        ELSE
            IF isbIsUrban = csbyes THEN
                orcDir.segment_id    := AB_BOSegment.fnuGetGenericSegment(inuGeoLocationId, AB_BOSegment.csbSegTypePorRev);
            ELSE
                orcDir.segment_id    := AB_BOSegment.fnuGetGenericSegment(inuGeoLocationId, AB_BOSegment.csbSegTypeRural);
            END IF;

            -- Asigna el barrio siempre y cuando ya venga nulo. En otro caso no se asigna porque se le da prioridad
            -- al barrio asignado desde la insercion que el barrio del segmento rural o inconsistente
            if orcDir.neighborthood_id IS NULL then
                nuNeighborthood := daab_segments.fnuGetNeighborhood_id(orcDir.segment_id);
                ut_trace.trace('Se reemplaza el barrio con el del segmento['||orcDir.segment_id||'] (Rural/Inconsitente) ['||nuNeighborthood||']',3);
                orcDir.neighborthood_id  := nuNeighborthood;
            end if;
            orcDir.zip_code_id       := daab_segments.fnuGetZip_code_id(orcDir.segment_id);
        end if;

        IF ircDirParseada.nuCasa IS NOT NULL THEN
            orcDir.Shape             := ab_bogeometria.fsgGeocodificarDireccion(ircDirParseada.nuSegmento, ircDirParseada.nuCasa);
        END IF;

        ut_trace.trace('FIN CompletaRegisDir',3);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   ActualizaDireccion
    Descripcion	:   Actualiza los campos que el parser pudo haber resuelto
                    en una direccion que pasa de inconsistente a consistente

    Parametros      Descripcion
    ============    ===================
    ircNew          Registro de direccion con los datos a actualizar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    13-05-2011      cocampoSAO148073    Estabilizacion SAO147913
                                        Se modifica para que la actualizacion
                                        eleve excepcion si el registro esta
                                        bloqueado por otra sesion.
    18-04-2011      juzuriagaSAO146723  Se modifica para que actualize el campo
                                        SHAPE.
    21-09-2010      amendezSAO122447    Se modifica tambien la direccion padre
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE ActualizaDireccion
    (
        ircNew daab_address.styAB_address
    )
    IS
        rcOld   daab_address.styAB_address;
    BEGIN
        rcOld                       := daab_address.frcGetRecord( ircNew.address_id );

        rcOld.is_valid              := ircNew.is_valid;
        rcOld.active                := ircNew.active;
        rcOld.address_parsed        := ircNew.address_parsed;
        rcOld.address               := ircNew.address;
        rcOld.segment_id            := ircNew.segment_id;
        rcOld.neighborthood_id      := ircNew.neighborthood_id;
        rcOld.geograp_location_id   := ircNew.geograp_location_id;
        rcOld.is_urban              := ircNew.is_urban;
        rcOld.grammar_id            := ircNew.grammar_id;
        rcOld.way_id                := ircNew.way_id;
        rcOld.way_type              := ircNew.way_type;
        rcOld.cross_way_id          := ircNew.cross_way_id;
        rcOld.cross_way_type        := ircNew.cross_way_type;
        rcOld.house_number          := ircNew.house_number;
        rcOld.house_letter          := ircNew.house_letter;
        rcOld.address_complement    := ircNew.address_complement;
        rcOld.father_address_id     := ircNew.father_address_id;
        rcOld.shape                 := ircNew.shape;

         daab_address.updRecord( rcOld , cnuNoWait);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /**************************************************************
        Propiedad intelectual de Open International Systems (c).
        Unidad      :  validateRuralAddress
        Descripcion :  Verifica si la direccion es rural o urbana, si es urbana
                       realiza las validaciones de sintaxis necesarias y retorna
                       la direccion parseada si se puede, si la direccion esta
                       valida y si queda activa, si la direccion es rural no
                       hace ninguna validacion

        Autor       :  Alvaro Andres Velez Diaz
        Fecha       :  29-04-2010
        Parametros  :
                    Entrada:
                        isbAddress          Direccion en formato libre
                        inuGeoLocationId    Ubicacion geografica
                        isbIsUrban          la direccion es urbana[Y] o rural[N]

                    Salida:
                        isbValid            La direccion es valida
                        isbActive           La direccion queda activa
                        rcDirParseada       Direccion parseada

        Historia de Modificaciones
        Fecha        Autor              Modificacion
        =========    =========          ===================
        16-01-2012  cocampoSAO171139    1 - Se modifica nombre de variable blGramaticaOK por blGramViasOK
        03-12-2011  caguilarSAO167829   Se corrige error de estabilizacion. Se completa
                                        la validacion para que lance excepcion cuando
                                        la ubicacion geografica es M - SemiNormalizada
                                        solo si hay error con la gramatica.
        01-12-2011  caguilarSAO165655   Estabilizacion SAO165262. Se agrega la
                                        validacion del caso en que la direccion
                                        sea nula y la validacion del caso en que
                                        el flag IS_URBANde sea nulo. Ademas, Solo
                                        se eleva excepciones para direcciones
                                        normalizadas, cuando se trate de direcciones
                                        hijas.
        22-09-2011  cocampoSAO148875    Se a?ade validacion para que si la normalicacion de
                                        la ubicacion geografica es M - SemiNormalizada, lance excepcion
                                        solo si hay error con la gramatica.
		11-11-2010  amendezSAO131516    Optimizacion parametros OUT
        21-09-2010  amendezSAO122447    Se define como nocopy parametro
                                        rcDirParseada.
                                        Asume como direccion parseada la direccion
                                        en formato libre, cuando la direccion
                                        parseada resultante es nula.
                                        Se elimina el parametro IS_active,
                                        porque hace exactamente lo mismo que isValid
                                        Se adiciona parametro isChildAddress
                                        para indicar si esta validando una direccion
                                        hija o una direccion padre(recursivamente)
        29-04-2010  aavelezSAO115231    Creacion
    ***************************************************************/
    PROCEDURE validateRuralAddress
    (
        isbAddress          in  ab_address.address_parsed%type,
        inuGeoLocationId    in  ge_geogra_location.geograp_location_id%type,
        isbIsUrban          in  ab_address.is_urban%type,
        osbValid            out nocopy ab_address.is_valid%type,
        orcDirParseada      out nocopy tyrcDirParseada,
        isChildAddress      in  varchar2 default 'Y'
    )
    IS
        nuErrorCode       ge_error_log.error_log_id%type;
	    sbErrorMessage    ge_error_log.description%type;
    BEGIN
        ut_Trace.Trace('Inicio ab_boparser.validateRuralAddress', 3);
        if isbAddress IS null then
            -- La direccion ingresada es nula
            errors.seterror(cnuAddressNull);
            raise ex.controlled_error;
        END if;

        IF isbIsUrban IS null then
            -- El indicador (Es Urbana) para la direccion (%s1), no puede ser nulo
            errors.seterror(cnuIsUrbanFlagNull,isbAddress);
            raise ex.controlled_error;
        END if;


        --validad si hay direccion y si es rural
        IF isbAddress IS NOT NULL AND isbIsUrban = csbNo THEN
        --la direccion es Rural
            osbValid    := csbYES;
            orcDirParseada.sbDirFmtoLibre := nvl(orcDirParseada.sbDirParseada,isbAddress);
            orcDirParseada.sbDirParseada  := orcDirParseada.sbDirFmtoLibre;
        ELSE
        --la direccion es Urbana
            CheckSyntax
            (
                isbAddress,
                inuGeoLocationId,
                orcDirParseada,
                isChildAddress  -- Usar cache solo en direcciones hijas
            );
            ut_Trace.Trace('rcDirParseada: '||orcDirParseada.sbDirParseada, 3);
            osbValid    := csbyes;
        END if;

        ut_Trace.Trace('END ab_boparser.validateRuralAddress', 3);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            ut_Trace.Trace('END ex.CONTROLLED_ERROR:ab_boparser.validateRuralAddress', 3);
            orcDirParseada.sbDirFmtoLibre := nvl(orcDirParseada.sbDirParseada,isbAddress);
            orcDirParseada.sbDirParseada  := orcDirParseada.sbDirFmtoLibre;
            IF isChildAddress = csbYES AND (sbVALID_ADDRESS = csbYES OR   (sbVALID_ADDRESS = csbSemiNormalized AND not blGramViasOK))
            THEN
               ut_Trace.Trace('RAISE ab_boparser.validateRuralAddress', 3);
                RAISE;
            END IF;
            osbValid    := csbNO;
        WHEN OTHERS THEN
            errors.SetError;
            ut_Trace.Trace('END OTHERS:ab_boparser.validateRuralAddress', 3);
            orcDirParseada.sbDirFmtoLibre := nvl(orcDirParseada.sbDirParseada,isbAddress);
            orcDirParseada.sbDirParseada  := orcDirParseada.sbDirFmtoLibre;
            IF isChildAddress = csbYES AND (sbVALID_ADDRESS = csbYES OR   (sbVALID_ADDRESS = csbSemiNormalized AND not blGramViasOK))
            THEN
               ut_Trace.Trace('RAISE ab_boparser.validateRuralAddress', 3);
                RAISE ex.CONTROLLED_ERROR;
            END IF;
            osbValid    := csbNO;

     END validateRuralAddress;

    /*****************************************************************
    Unidad      :   insertAddress
    Descripcion	:   Inserta una direccion en Banco de Direcciones
                    Si VALID_ADDRESS = 'Y' y la direccion es inconsistente
                    todos los campos calculados a partir del parseo y validacion
                    de la direccion seran almacenados como nulo, la direccion
                    sera almacenada tal como se ingreso.
                    Si la direccion existe como inconsistente, y el parseo y
                    validacion son exitosos, la actualiza como consistente
                    recalculando todos sus valores


    Parametros      Descripcion
    ============    ===================
    inuGeoLocationId  Ubicacion geografica
    isbAddress        Direccion en formato libre
    inuNeighbortId    Barrio
    isbIsUrban        Flag Urbano
    ionuParser_id     Id de la direccion, si es nula, internamente se
                      asigna la secuencia, si no es nula intenta asignar el
                      id enviado.
    osbDirParseada    Direccion parseada
    isChildAddress    Ingresa direcciones padres
    isbVerified       Direccion verificada


    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    16-05-2013      hcruzSAO207994      Adicion del campo isbVerified para
                                        insercion del valor en la nueva columna
                                        AB_Address.Verified
    06-10-2012      Juzuriaga.SAO191345 1 - Se modifica la logica para que no permita el
                                            ingreso de direcciones cuyo padre calculado
                                            exista y este sea una direccion altena.
    16-01-2012      cocampoSAO171139    1 - Se modifica nombre de variable blGramaticaOK por blGramViasOK
    01-12-2011      caguilarSAO165655   1 - Estabilizacion amendezSAO166967. Se valida el mismo tipo
                                        urbano/rural) de direcciones padre-hija solo cuando
                                        la direccion analizada no cumple con una gramatica
                                        BASE.
                                        2 - Estabilizacion amendezSAO165262. Se agrega la
                                        validacion del tipo(Urbana-Rural) de la direccion,
                                        solo para direcciones existentes es decir address_id <> -1
    04-11-2011      cocampoSAO165227    Se a?ade validacion para que levante excepcion si algunos de
                                        los padres falla si seria hijo de rural.
    04-11-2011      cocampoSAO165166    Estabilizacion SAO164859.
                                        Se modifica para que valide si la direccion Padre
                                        es diferente tipo (Urbana-Rural), de ser asi eleva excepcion.
    12-07-2011      jgutierezSAO158072  Se modifica para actualizar la categoria y subcategoria en el predio
    07-07-2011      juzuriagaSAO153539  Estabilizacion.SAO149532 Se modifica para
                                        que la actualizacion del barrio eleve
                                        excepcion si el registro esta bloqueado por otra sesion.
    17-05-2011      cocampoSAO149457    Se modifica para que la actualizacion del barrio
                                        solo se realice cuando el segmento no tenga barrio y
                                        el barrio ingresado es diferente al barrio actual.
    13/01/2011      hcruzSAO138308      Se modifica para que asigne correctamente el padre de la
                                        direccion cuando se tienen gramaticas hijas
                                        que no son consecutivas con la gramatica padre.
                                        1 = <VIA><-><T><C><P><D>
                                        2 = <VIA><-><T>
                                        Bajo este caso,no era capaz de indentificar el padre de la
                                        direccion con gramatica 1.
                                        Se adiciona variable global nuLastFatherAddressId para identificar
                                        el ultimo padre ingresado correctamente.
    05-12-2101      juzuriagaSAO135939  se modifica para que actualize barrio si
                                        la direccion ya existe y se debe actualizar el barrio
    01-12-2010      amendezSAO135442    Se detecto error oracle cuando se usa parametro local
                                        en una llamada recursiva y hay definidos parametros nocopy.
                                        evitando enviar como argumento directamente la variable local.
	11-11-2010      amendezSAO131516    Optimizacion parametros OUT
									    Continua insertando direcciones padres, en niveles
                                        superiores, aun cuando en el nivel actual el proceso falle,
									    siempre y cuando haya tokens que procesar.
    15-10-2010      JuzuriagaSAO130953  Se modifica para que inserte la direccion completa
                                        y despues corte el complemento.
    21-09-2010      amendezSAO122447    Se modifica la logica que inserta direcciones padre
                                        para que funcione de manera recursiva.
                                        Corrige el error de que no inserta direcciones rurales
                                        si no existe al menos un token definido.
                                        Se adiciona parametro isChildAddress por defecto Y
                                        para indicar si esta insertando una direccion padre(recursiva)
                                        o una direccion hija.
                                        Las direcciones hijas son las recibidas mediante
                                        la invocacion externa de este metodo.
                                        Las direcciones padres son las invocadas por este metodo
                                        recursivamente.
    07-09-2010      juzuriagaSAO127106  Se modifica para que limpie la cache cuando
                                        termine el proceso de insercion.
    12-08-2010      juzuriagaSAO124482  se modifica para que cuando la direccion
                                        es rural no tome el cache.
    18-05-2010      juzuriagaSAO115230  se modifica para que permita actualizar la
                                        direccion en la recuperacion.
    01-02-2010      amendezSAO109563    Si se puede calcular el segmento
                                        ingresa en la direccion el zip_code
                                        Asigna el barrio ingresado como parametro
                                        si no puede ser calculado mediante
                                        el segmento.
										En la busqueda de direcciones en la BD,
										primero busca la direccion original y si no encuentra
										busca por la direccion parseada

    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    PROCEDURE InsertAddress
    (
        inuGeoLocationId  in     ab_address.geograp_location_id%type,
        isbAddress        in     ab_address.address%type,
        inuNeighbortId    in     ab_address.neighborthood_id%type,
        isbIsUrban        in     ab_address.is_urban%type,
        ionuParser_id     IN out nocopy ab_address.address_id%type,
        osbDirParseada    out nocopy ab_address.address_parsed%type,
        onuFatherAdd_id   out nocopy ab_address.address_id%type,
        isChildAddress    in     varchar2 default 'Y',
        isbVerified       in     ab_address.verified%type default 'N'
    )
    IS

        --Variables locales
        rc                daab_address.styAB_address;
        rcDirParseada     tyrcDirParseada;
        nuResultFindAddr  ab_address.address_id%type;
        sbValid           ab_address.is_valid%type;
        ----------
        nuFatherAddressId ab_address.address_id%type;
        sbFatherAddress   ab_address.address_parsed%type;
        sbAddress         ab_address.address_parsed%type;
        sbSavedAddressIsValid ab_address.is_valid%type;
        ---------
        nuSegmentId       ab_segments.segments_id%type;
        nuNeighborthood   ab_address.neighborthood_id%type;

        nuPremiseId   ab_premise.premise_id%type;
        nuCategory    ab_premise.category_%type;
        nuSubCategory ab_premise.subcategory_%type;
        nuTmpFatherAddressId      ab_address.address_id%type;
        ---------
        nuTmpError        ge_message.message_id%type;
        sbTmpError        ge_error_log.description%type;
        ----------
        nutmpFatherAddId  ab_address.address_id%type;
        nuFlagFather      number;


        /*****************************************************************
        Unidad      :   fsbAddressFather
        Descripcion	:   Calcula la direccion padre

        Parametros           Descripcion
        ============         ===================
        isbChildAddress      Indica si la direccion actual es Hija
        rcChildParsedAddress Estructura con los datos de la direccion actual

        Historia de Modificaciones
        Fecha       Autor             Modificacion
        ========== =================  ===================
        11-12-2012 amendezSAO195302   Se basa en la gramatica padre para
                                      obtener una direccion base.
        01-12-2011 caguilar.SAO165655 1 - Estabilizacion amendezSAO166967. Calcula la
                                      direccion padre, con base en  los simbolos
                                      de la gramatica predecesora de de la direccion
                                      hija, evitando la comparacion con simbolos
                                      intermedios que no van a existir.
        21-09-2010 amendezSAO122447   Creacion
        *****************************************************************/
        FUNCTION fsbAddressFather
        (
            rcChildParsedAddress tyrcDirParseada
        )
                return ab_address.address_parsed%type
        IS
            sbAddressFather     ab_address.address_parsed%type;
            tbTokens            ut_string.TyTb_String;
            nuGramaticaIndex    binary_Integer;

            nuIndexAddress      binary_integer;
            nuGramaFatherIndex  binary_integer;
        BEGIN
            ut_trace.trace('Inicio: ab_boParser.insertAddress.fsbAddressFather ['||rcChildParsedAddress.sbDirParseada||']',5);

            --separa la direccion de su complemento
            IF rcChildParsedAddress.sbComplemento IS NOT NULL THEN
                ut_trace.trace('rcChildParsedAddress.sbComplemento>>['||rcChildParsedAddress.sbComplemento||']',5);
                sbAddressFather := trim(substr(rcChildParsedAddress.sbDirParseada,1,instr(rcChildParsedAddress.sbDirParseada, rcChildParsedAddress.sbComplemento, -1, 1) -1));
                ut_trace.trace('Fin : ab_boParser.insertAddress.fsbAddressFather =>'||sbAddressFather,5);
                RETURN sbAddressFather;
            END IF;

            -- Obtiene el indice de la gramatica PADRE que cumple con la sintaxis
            nuGramaticaIndex := fnuGetGrammarIndexById( rcChildParsedAddress.nuIdGramaPadre );

            -- Obtiene el indice de la gramatica de un nivel superior.
            nuGramaFatherIndex := fnuPreviousGrammarLevel( nuGramaticaIndex );


            -- Si el numero de tokens es mayor que uno, armo direccion hasta tokens - 1
            IF rcChildParsedAddress.nuViasEnGramatica > 0
               AND nuGramaFatherIndex IS not null
               AND tbgGramatica(nuGramaFatherIndex).sbTbSimbolos.first IS not null
               AND rcChildParsedAddress.tbDirePadre.first IS not null
               AND rcChildParsedAddress.tbDirePadre.count >= tbgGramatica(nuGramaFatherIndex).sbTbSimbolos.count
            THEN
                nuIndexAddress := rcChildParsedAddress.tbDirePadre.first;
                -- "Construye" la direccion con la cantidad de simbolos de la gramatica padre
                for nuIndexSimbolGrama in 1..tbgGramatica(nuGramaFatherIndex).sbTbSimbolos.count loop
                    IF nuIndexSimbolGrama>1 THEN
                        sbAddressFather := sbAddressFather ||' ';
                    END IF;

                    IF  rcChildParsedAddress.tbDirePadre(nuIndexAddress).sbParameter = csbTOKEN_VIA THEN
                        sbAddressFather := sbAddressFather ||
                                           rcChildParsedAddress.tbDirePadre(nuIndexAddress).sbValue;
                    ELSE
                        sbAddressFather := sbAddressFather ||
                                           rcChildParsedAddress.tbDirePadre(nuIndexAddress).sbParameter||' '||
                                           rcChildParsedAddress.tbDirePadre(nuIndexAddress).sbValue;
                    END if;

                    nuIndexAddress := rcChildParsedAddress.tbDirePadre.next(nuIndexAddress);
                END loop;
            END if;

            ut_trace.trace('Fin : ab_boParser.insertAddress.fsbAddressFather =>'||sbAddressFather,5);
            RETURN sbAddressFather;
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END fsbAddressFather;
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.insertAddress  inuGeoLocationId ['||inuGeoLocationId||']  isbAddress ['||isbAddress||'] '||
        'inuNeighbortId ['||inuNeighbortId||']  isbIsUrban ['||isbIsUrban||']  ionuParser_id  ['||ionuParser_id||'] '||
        'osbDirParseada ['||osbDirParseada||']  isChildAddress ['||isChildAddress||']',2);

        get_parameters;

        blGramViasOK := TRUE;

        --Define si elevara excepcion en caso de no poder insertar la direccion [sbVALID_ADDRESS=?]
        IF  inuGeoLocationId IS not null then
            sbVALID_ADDRESS :=  dage_geogra_location.fsbGetNormalized(inuGeoLocationId);
        END if;
        ut_trace.trace('Elevar Excepcion si direccion no es valida ? ['||sbVALID_ADDRESS||']',2);

        --Parsea Direccion Solo si es Urbana (Define si la direccion es valida)
        validateRuralAddress
        (
            isbAddress,
            inuGeoLocationId,
            isbIsUrban,
            rc.is_valid,
            rcDirParseada,
            isChildAddress  -- Usa cache solo si se trata de direcciones hijas
        );

        rc.active := rc.is_valid;
        ut_trace.trace('direccion Valida['||rc.is_valid||']',2);

        --Calcula la direccion parseada a retornar (En mayusculas para facilitar su posterior busqueda)
        rc.address_parsed        := rcDirParseada.sbDirParseada;
        rc.address               := rc.address_parsed;
        osbDirParseada           := rc.address_parsed;
        ut_trace.trace('Direccion['||rc.address||'],direccion Valida['||rc.is_valid||']',2);

        --Asigna el barrio ingresado como parametro si aun no ha podido ser calculado
        IF inuNeighbortId IS NOT NULL AND rc.neighborthood_id IS NULL then
            ut_trace.trace('Asigno el barrio ingresado ['||inuNeighbortId||']',2);
            rc.neighborthood_id  := inuNeighbortId;
        END IF;

        --Calcula e Inserta posible Direccion Padre solo si la direccion actual es valida, es Urbana
        --y la gramatica de la direccion actual no es BASE.
        if ( rc.is_valid = csbYES OR isChildAddress = csbNO)
           AND isbIsUrban = csbYES
           AND fsbIsRootGrammar(rcDirParseada.nuIdGramaHja) = csbNO
        then
            ut_trace.trace('Verificando si existe direccion padre',2);
            sbFatherAddress := fsbAddressFather(rcDirParseada);

            --Si la posible Direccion Padre es no nula intenta insertarla no eleva excepcion si no puede insertarla
            --Si eleva excepcion si el error consiste en que la direccion padre es de diferente caracteristica (URBANO/RURAL) que la hija.
            if sbFatherAddress is not null then
            ut_trace.trace('Verificando si encuentra/inserta direccion padre ['||sbFatherAddress||']',2);

                nuTmpFatherAddressId  :=  CheckIfAddressExistsInDB(sbFatherAddress, inuGeoLocationId);

                if nuTmpFatherAddressId > 0 then
                    nuFlagFather    := 1;  -- si tiene direccion padre
                end if;

                if  nvl(nuTmpFatherAddressId,cnuAddressNotExists) <> cnuAddressNotExists
                    AND isbIsUrban <> daab_address.fsbGetIs_Urban(nuTmpFatherAddressId,0)
                then
                    --La direccion padre es de diferente tipo
                     ut_trace.trace('-La direccion padre es de diferente tipo ['||sbFatherAddress||']',2);
                    Errors.setError(cnuErrorFatherType,sbFatherAddress);
                    raise ex.CONTROLLED_ERROR;
                elsif nvl(nuTmpFatherAddressId,cnuAddressNotExists) <> cnuAddressNotExists
                      AND csbYes <> daab_address.fsbGetIs_Main(nuTmpFatherAddressId,0)
                then
                    ut_trace.trace('-La direccion no debe puede tener como direccion padre una direccion alterna existente ['||sbFatherAddress||']',2);
                    Errors.setError(cnuErrorAltern,sbFatherAddress);
                    raise ex.CONTROLLED_ERROR;
                else
                    BEGIN
                        -- Por algun error de oracle, cuando en una funcion recursiva, se define parametros no copy
                        -- y se envia parametro local en la llamada recursiva, este es inicializado en nulo al interior
                        -- de la llamada recursiva, por ello se forza a que esto no ocurra evitando
                        -- parsarle la variable local directamente y acambio, se envia una expresion,
                        -- en este caso sbFatherAddress||''
                        InsertAddress
                        (
                            inuGeoLocationId,
                            sbFatherAddress||'',
                            inuNeighbortId,
                            isbIsUrban,
                            nuFatherAddressId,
                            sbFatherAddress,
                            nutmpFatherAddId,
                            csbNO,   -- No usar cache para parsear direcciones padres.
                            csbNO --La direccion padre siempre va con 'N'
                        );

                        ut_trace.trace('Direccion padre ['||nuFatherAddressId||']['||sbFatherAddress||']',2);
                        ut_trace.trace('Ultimo    padre ['||nuLastFatherAddressId||']',2);

                    EXCEPTION
                        when ex.CONTROLLED_ERROR then
                            nuTmpError := null;
                            sbTmpError := '';
                            Errors.geterror(nuTmpError, sbTmpError);
                            if nuTmpError = cnuErrorFatherType then
                                ut_trace.trace('Fallo una direccion padre por ser hijo de Rural',2);
                                raise;
                            elsif nuTmpError = cnuErrorAltern then
                                ut_trace.trace('La direccion no debe puede tener como direccion padre una direccion alterna existente',2);
                                raise;
                            END if;

                        when others then
                            null;
                    END;
                END if;
            end if;

            --Asigna ID de direccion padre procesada para que se tenga en cuenta en caso de que posteriormente se inserte o actualice
            if nuFatherAddressId is not null then
                rc.father_address_id := nuFatherAddressId;
                nuLastFatherAddressId    := nuFatherAddressId;
            elsif nuLastFatherAddressId is not null then
                rc.father_address_id := nuLastFatherAddressId;
            end if;
        end if;

        --Busca la direccion parseada
        nuResultFindAddr := ab_bcParser.fnuFindAddress( rc.address_parsed, inuGeoLocationId );
        ut_trace.trace('Buscando en Banco de direcciones ['||rc.address_parsed||'] ug=['||inuGeoLocationId||'] => '||nuResultFindAddr,2);

        --Direccion Encontrada [nuResultFindAddr]
        IF  nuResultFindAddr > 0 THEN
            ut_trace.trace('ACTUALIZAR',1);

            -- Retorna el ID encontrado
            ionuParser_id := nuResultFindAddr;
            ut_trace.trace('Direccion ['||rc.address||'] ya existe para localidad ['||inuGeoLocationId||']',2);

            --Actualiza solo si la direccion encontrada es valida y estaba inconsistente en Banco de direcciones
            sbSavedAddressIsValid := DAAB_address.fsbGetIs_valid(nuResultFindAddr);
            IF rc.is_valid = csbyes and sbSavedAddressIsValid = csbNO then
                ut_trace.trace('Actualizando direccion en banco de direcciones => Consistente',2);
                -- Actualizar direccion
                CompletaRegisDir
                (
                    inuGeoLocationId,
                    isbIsUrban,
                    ionuParser_id,
                    rcDirParseada,
                    rc
                );
                ActualizaDireccion ( rc );
            ELSE
                ut_trace.trace('Direccion NO sera actualizada Valida['||rc.is_valid||']=Y AND Consistente['||sbSavedAddressIsValid||']=N =>FALSE',2);

                --Obtiene el identificador del segmento
                nuSegmentId := DAAB_address.fnuGetSegment_id(nuResultFindAddr);

                --Obtiene los datos a actualizar
                IF nuSegmentId IS NOT NULL THEN
                    nuNeighborthood := DAAB_segments.fnugetneighborhood_id(nuSegmentId);
                    nuCategory := DAAB_segments.fnuGetCategory_(nuSegmentId);
                    nuSubCategory := DAAB_segments.fnuGetSubCategory_(nuSegmentId);
                END IF;

                --Se verifica si se actualiza el barrio
                IF nuNeighborthood IS NOT NULL  THEN
                    IF  nuNeighborthood !=  inuNeighbortId THEN
                        ut_trace.trace('Actualizo el Barrio con el Barrio del Segmento['||nuNeighborthood||']',2);
                        DAAB_address.updNeighborthood_id(nuResultFindAddr, nuNeighborthood, cnuNoWait);
                    END IF;
                ELSE
                    nuNeighborthood := daab_address.fnugetneighborthood_id(nuResultFindAddr);
                    ut_trace.trace('Barrios a comparar ['||nuNeighborthood||'a] <> ['||inuNeighbortId||'a]',2);
                    IF  nuNeighborthood||'a' <>  inuNeighbortId||'a' THEN
                        ut_trace.trace('Actualizo el Barrio con el Barrio Ingresado['||inuNeighbortId||']',2);
                        DAAB_address.updNeighborthood_id(nuResultFindAddr, inuNeighbortId, cnuNoWait);
                    END IF;
                END IF;

                --Obtiene el idenficador del predio
                nuPremiseId := DAAB_address.fnuGetEstate_Number(nuResultFindAddr);

                --Actualiza la informacion del predio
                IF nuPremiseId IS NOT NULL THEN
                    AB_BOPremise.updPremise(nuPremiseId, nuCategory, nuSubCategory);
                END IF;

            END IF;

            -- Si la direccion fue encontrada actualizo AB_ADDRESS.Verified SOLO si
            -- el parametro de entrada isbVerified es 'Y'
            IF isbVerified = csbYes THEN
                ut_trace.trace('Actualizar Verified',3);
                daab_address.updVerified(nuResultFindAddr, isbVerified);
            END IF;

        --Direccion No Encontrada  [nuResultFindAddr!=0 o nula]
        ELSE
            ut_trace.trace('Direccion ['||rc.address_parsed||'] no encontrada en Banco de Direcciones',2);

            -- Si es una direccion hija o es una direccion padre valida inserta la direccion
            if ( isChildAddress = csbYES OR (isChildAddress = csbNO AND rc.is_valid=csbYES)) then
                --Completar registro de direccion
                CompletaRegisDir
                (
                    inuGeoLocationId,
                    isbIsUrban,
                    ionuParser_id,
                    rcDirParseada,
                    rc
                );

                -- Actualizo el campo verificada
                rc.verified := isbVerified;
                --Inserta registro de Direccion
                ut_trace.trace('Insertando direccion en banco de direcciones',2);
                DAAB_address.insRecord ( rc );
                UT_Trace.Trace('Id Nueva Direccion:['||ionuParser_id||'] osbAddressParsed['||rcDirParseada.sbDirParseada||']',3);

                --Si se inserta una direccion se crea el predio
                IF ionuParser_id IS NOT NULL THEN
                    --Se obtiene el segmento
                    nuSegmentId := DAAB_address.fnuGetSegment_id(ionuParser_id);

                    IF nuSegmentId IS NOT NULL THEN
                        --Se obtiene la categoria y sub-categoria de segmento
                        nuCategory := DAAB_segments.fnuGetCategory_(nuSegmentId);
                        nuSubCategory := DAAB_segments.fnuGetSubCategory_(nuSegmentId);

                        --Se inserta el predio
                        nuPremiseId := AB_BOPremise.fnuInsertInicialPremise(nuCategory, nuSubCategory);

                        --Se actualiza el predio a la direccion
                        DAAB_address.updEstate_Number(ionuParser_id, nuPremiseId);
                    END IF;
                END IF;
            END if;

        END IF;

        sbVALID_ADDRESS     := csbNo;

        if nuFlagFather <> 1 then
            onuFatherAdd_id     := nuFatherAddressId;
        end if;

        --Siempre que llama a insertAddress en forma no recursiva limpia cache (Del parser CheckSyntax)
        if isChildAddress = csbyes then
            rcCacheDirParseada := NULL;
            nuLastFatherAddressId := NULL;
            ut_trace.trace('Borrando el cache',2);
        end if;

        ut_trace.trace('Fin: ab_boParser.insertAddress ** Ultimo_Padre ['||nuLastFatherAddressId||']',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
             ut_trace.trace('EX.CONTROLLED_ERROR AB_boParser.InsertAddress',2);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ut_trace.trace('OTHERS AB_boParser.InsertAddress',2);
            raise ex.CONTROLLED_ERROR;
    END InsertAddress;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    /*****************************************************************
    Unidad      :   fsbDirSugerida
    Descripcion	:   Metodo para facilitar al componente de direcciones
                    sugerir al usuario direcciones a partir de una parte
                    de la direccion en formato libre digitada.

    Parametros        Descripcion
    ============      ===================
    inuGeoLocationId  Ubicacion Geografica
    isbDirFmtoLibre   Direccion en formato libre

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    25-11-2011      caguilarSAO165655   Estabilizacion amendezSAO166967. Al presentarse
                                        una excepcion en el analisis de la direccion,
                                        se retorna la direccion ingresada inicialmente.
    20-04-2011      amendezSAO146905    Para excepciones controladas, retorna
                                        la direccion original.
    26-02-2010      amendezSAO113173    Se ajusta para que retorne la direccion
                                        ingresada, si la direccion sugerida
                                        no pudo ser calculada

    22-02-2010      amendezSAO112877    Se ajusta para que compare con NULL
                                        para identificar que se trata de una gramatica
                                        que no pudo ser calculada

    10-01-2010      amendezSAO109552    Creacion.
    */
    FUNCTION  fsbDirSugerida
    (
        inuGeoLocationId  in  ab_address.geograp_location_id%type,
        isbDirFmtoLibre   IN  ab_address.address%type
    )
    RETURN ab_address.address%type
    IS
        sbDireccion           ab_address.address_parsed%type;
        sbComplemento         ab_address.address_complement%type;
        nuCasa                ab_address.house_number%type;
        sbCasa                ab_address.house_letter%type;

        tbDirGramaPadre       UT_String.TyTb_StrParameters;

        rcDirParseada         tyRcDirParseada;
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.fsbDirSugerida',2);

        --Busca en la gramatica la direccion que le entro (tbDireccion tiene solo tokens principales)
        buscaCoincidencia
        (
            inuGeoLocationId,
            isbDirFmtoLibre,
            rcDirParseada
        );

        IF (rcDirParseada.nuIdGramaPadre IS NULL) THEN
            -- No hubo coincidencia Arma la direccion parseada con la gramatica con la que tuvo el mayor numero de exitos
            IF rcDirParseada.nuGramaExitos != 0 THEN
                construyeDirPadre(rcDirParseada.nuGramaExitos, rcDirParseada.tbExitos, tbDirGramaPadre);
                obtieneDireccion(tbDirGramaPadre,rcDirParseada.tbComplemento,sbDireccion,sbComplemento,nuCasa,sbCasa);
            ELSE
                sbDireccion := NULL;
            END IF;
        ELSE
            -- Si hubo coincidencia Arma la direccion parseada con la gramatica encontrada
            construyeDirPadre(rcDirParseada.nuIdGramaPadre, rcDirParseada.tbExitos, tbDirGramaPadre);
            obtieneDireccion(tbDirGramaPadre,rcDirParseada.tbComplemento,sbDireccion,sbComplemento,nuCasa,sbCasa);
        END IF;

        IF trim(sbDireccion) IS NULL THEN
            sbDireccion := isbDirFmtoLibre;
        END IF;

        ut_trace.trace('Fin: ab_boParser.fsbDirSugerida',2);
        RETURN sbDireccion;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            return isbDirFmtoLibre;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbDirSugerida;

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
	-- 10-02-2010 amendezSAO109563
	-- Parsea solo si no encuentra la direccion original.
    /*****************************************************************
    Unidad      :   CheckIfAddressExistsInDB
    Descripcion	:   Funcion que retorna el codigo de una direccion
                    si existe en el Banco de direcciones, si no existe
                    o se encontro alguna inconsistencia en el parseo
                    y validez de la direccion retorna -1

    Parametros      Descripcion
    ============    ===================
    isbaddress        Direccion en formato libre
    inuGeoLocation    Ubicacion geografica
    nuErrorCode       error en caso de direccion no valida o no existe
    sbErrorMessage    Texto del error

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    21-03-2013      hcruzSAO204930      Modificacion de la direccion desplegada en
                                        el mensaje de error cuando la direccion no
                                        existe.
	11-11-2010      amendezSAO131516    Optimizacion parametros OUT
    10-01-2010      amendezSAO109552    Creacion.
    ****************************************************************/
    FUNCTION CheckIfAddressExistsInDB
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type
    )
    RETURN ab_address.address_id%type
    IS
        nuDireccion       ab_address.address_id%type;
        nuErrorCode       NUMBER;
        sbErrorMessage    VARCHAR2(10000);
        sbAddressParsed   ab_address.address_parsed%type;
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.CheckIfAddressExistsInDB('||isbaddress||')',2);

        -- Busca la direccion en la base de datos
        ut_trace.trace('Busca la direccion antes de parsear',2);
        nuDireccion := nvl(ab_bcparser.fnuFindAddress(isbaddress, inuGeoLocation ),-1);
        ut_trace.trace('Direccion ID antes de parsear ['||nuDireccion||']',2);

        IF nuDireccion = -1 THEN

            CheckSyntax
            (
                isbAddress,
                inuGeoLocation,
                sbAddressParsed,
                nuErrorCode,
                sbErrorMessage
            );

            IF sbAddressParsed IS NOT NULL THEN
                ut_trace.trace('Busca la direccion despues de parsear',2);
                nuDireccion := ab_bcparser.fnuFindAddress(sbAddressParsed, inuGeoLocation);
                ut_trace.trace('Direccion ID despues de parsear ['||nuDireccion||']',2);
            END IF;

        END IF;

        IF nuDireccion = -1 THEN
            -- No se encontro direccion [%s1] para la ubicacion geografica [%s2] y el barrio [%s3]
            errors.setError(cnuNoEncontroDir,isbaddress||'|'||inuGeoLocation);
            RAISE ex.controlled_error;
        END IF;

        ut_trace.trace('Fin: ab_boParser.CheckIfAddressExistsInDB',2);

        RETURN nvl(nuDireccion,-1);

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Fin ex.CONTROLLED_ERROR ab_boParser.CheckIfAddressExistsInDB',2);
            RETURN nvl(nuDireccion,-1);
        when others then
            UT_TRACE.TRACE('Fin OTHERS ab_boParser.CheckIfAddressExistsInDB',2);
            RETURN nvl(nuDireccion,-1);

    END;


    FUNCTION CheckIfAddressExistsInDB
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type,
        nuErrorCode       out nocopy NUMBER,
        sbErrorMessage    out nocopy VARCHAR2
    )
    RETURN ab_address.address_id%type
    IS
        nuDireccion       ab_address.address_id%type;
        rcDirParseada     tyrcDirParseada;
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.CheckIfAddressExistsInDB',2);

        nuDireccion :=  CheckIfAddressExistsInDB
                            (
                                isbaddress,
                                inuGeoLocation
                            );

        RETURN nvl(nuDireccion,-1);

        ut_trace.trace('Fin: ab_boParser.CheckIfAddressExistsInDB',2);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Fin: ab_boParser.CheckIfAddressExistsInDB (ex.CONTROLLED_ERROR)',2);
            RETURN -1;
        when others then
            ut_trace.trace('Fin: ab_boParser.CheckIfAddressExistsInDB (others)',2);
            RETURN -1;
    END;


    /*****************************************************************
    Unidad      :   ValidaNombreVia
    Descripcion	:   Valida el nombre para una nueva via

    Parametros      Descripcion
    ============    ===================
    isbNombreVia    nombre de la via

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    01-02-2010      amendezSAO109563    Creacion.
    ****************************************************************/
    PROCEDURE ValidaNombreVia
    (
        isbNombreVia IN ab_address.description%type
    )
    IS
        sbNombreVia ab_address.description%type;
        tbDireccion UT_String.TyTb_StrParameters;
        nuIndex     BINARY_INTEGER;

        blHaveToken BOOLEAN;
    BEGIN
        ut_trace.trace('Inicio: ab_boParser.ValidaNombreVia',5);

        get_parameters;

        blHaveToken := FALSE;

        -- Reemplazar simbolos
        sbNombreVia := fsbformatoDir( isbNombreVia );

        -- Descompone el nombre de via en lexemas
        retTokens(isbNombreVia,tbDireccion);

        -- Validar que la via no contenga tokens
        IF tbDireccion.count>0 THEN
            nuIndex := tbDireccion.first;
            LOOP
                EXIT WHEN nuIndex IS NULL;

                IF tbDireccion(nuIndex).sbparameter IS NOT NULL THEN
                    blHaveToken := TRUE;
                    EXIT;
                END IF;

                nuIndex:= tbDireccion.next(nuIndex);
            END LOOP;
        END IF;

        -- retornar el nombre de la via sin espacios en blanco
        IF blHaveToken THEN
            -- El nombre o descripcion de la via [%s1] contiene simbolos o palabras reservadas.
            errors.SetError(cnuNombreViaToken,isbNombreVia);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        ut_trace.trace('Fin: ab_boParser.ValidaNombreVia',5);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            RAISE;
        when others then
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   fsbGetAddressTokenValue
    Descripcion	:   Obtiene el valor de un token de una direccion
                    sin parsearla previamente
    Parametros      Descripcion
    ============    ===================
    isbAddress      texto de la direccion
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    23-06-2010      JSSanchezSAO119660  Creacion.
    ****************************************************************/
    FUNCTION fsbGetAddressTokenValue
    (
        isbAddress      IN ab_address.address%type,
        isbToken        IN VARCHAR2

    ) RETURN VARCHAR2
    IS
        tbTokens        UT_String.TyTb_StrParameters;
        sbTokenValue    VARCHAR2(100);
    BEGIN

        retTokens(isbAddress, tbTokens);
        IF tbTokens.COUNT > 0 THEN
            FOR i IN tbTokens.FIRST .. tbTokens.LAST LOOP
                -- Si encuentra el token, retorna su valor
                IF TRIM(tbTokens(i).sbParameter) = TRIM(isbToken) THEN
                   sbTokenValue := tbTokens(i).sbValue;
                   EXIT;
                END IF;
            END LOOP;
        END IF;

        RETURN sbTokenValue;

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            RAISE;
        when others then
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   fsbObtValorTokensDomicilios
    Descripcion	:   Obtiene una cadena con los valores de los
                    domicilios a sugerir
    Parametros  Descripcion
    ============    ===================
    isbNombreVia    nombre de la via

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    03-05-2010      JSSanchezSAO115242  Creacion.
****************************************************************/
    FUNCTION fsbObtValorTokensDomicilios
    (
        inuIdGeoLoc         IN  ab_address.geograp_location_id%type,
        isbDireccion        IN  ab_address.address%type,
        isbTokenFiltro      IN  VARCHAR2
    )RETURN VARCHAR2
    IS
        sbDomicilios    VARCHAR2(1000);
        sbValorToken    VARCHAR2(500);
        sbTokenFiltro   VARCHAR2(100);
    BEGIN
        sbTokenFiltro := UPPER(isbTokenFiltro);
        FOR rcDomicilio IN ab_bcaddress.cuChildAddressSuggest(inuIdGeoLoc, isbDireccion, sbTokenFiltro) LOOP
            sbValorToken:= fsbGetAddressTokenValue(rcDomicilio.address_parsed, sbTokenFiltro);
            -- Se agrega a la lista si no se encuentra
            -- Se incluyen las comas en la comparacion para buscar el token no la cadena
            IF instr(',' ||sbDomicilios ,','||sbValorToken||',') = 0 OR sbDomicilios IS NULL THEN
                sbDomicilios := sbValorToken || ',' || sbDomicilios;
            END IF;
        END LOOP;
        sbDomicilios := TRIM(',' FROM sbDomicilios);
        RETURN sbDomicilios;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbObtValorTokensDomicilios;

    /*****************************************************************
    Unidad      :   GetSymbols
    Descripcion	:   Obtiene todos los simbolos o caracteres no alfabeticos
                    configurados como token principal o sinonimo.
                    Utiliza cache para que la consulta solo vaya 1 vez a BD
                    por session.

    Parametros      Descripcion
    ============    ===================
    otbSymbols      Tabla PL con simbolos

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    25-10-2011      caguilarSAO163855   Se agrega el flag de validacion para
                                        evitar que se realice la consulta si el
                                        cache esta vacio pero por que la consulta
                                        no arroja datos.
    19-09-2010      amendezSAO122447    Creacion.
    ****************************************************************/
    PROCEDURE GetSymbols
    (
        otbSymbols out nocopy tytbSymbols
    )
    IS
        rfSymbol constants.tyRefCursor;
    BEGIN
        if gtbSymbols.count = 0 AND blSymbols then
            rfSymbol := ab_bcparser.frfSymbols;
            fetch rfSymbol bulk Collect INTO gtbSymbols;
            -- Apago el flag para que no consulte mas
            blSymbols := FALSE;
            close rfSymbol;
        END if;

        otbSymbols := gtbSymbols;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ge_bogeneralutil.Close_RefCursor(rfSymbol);
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            ge_bogeneralutil.Close_RefCursor(rfSymbol);
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   InsAddressTransaction
    Descripcion	:   Parsea y almacena la direccion en ab_address

    Autor       :   Jaime Florez (jflorez)
    Fecha       :   06-04-2011 (SAO143738)

    Parametros              Descripcion
    ==================      ===============================
    inuGeoLocationId        ID de la ubicacion geografica
    isbAddress              Direccion sin parsear
    inuNeighbortId          ID del barrio
    isbIsUrban              Flag de direccion urbana
    inuPreviousValue        Valor previo
    isbComment              Comentario
    inuPremiseTypeId        ID del tipo de premisa
    ionuParser_id           ID de la direccion parseada

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    01-03-2012      hcruzSAO174571      Se modifica el llamado a InsAddressAdditionalInfo
                                        quitando los parametros inuFloorNumber e
                                        inuApartmentNumber
    17-03-2011      jmunozSAO142056     Creacion.
    ****************************************************************/
    PROCEDURE InsAddressTransaction
    (
        inuGeoLocationId        in ab_address.geograp_location_id%type,
        isbAddress              in ab_address.address%type,
        inuNeighbortId          in ab_address.neighborthood_id%type,
        isbIsUrban              in ab_address.is_urban%type,
        inuPreviousValue        IN ab_address.previous_value%type,
        isbComment              IN ab_address.description%type,
        inuPremiseTypeId        IN ab_premise.premise_type_id%type,
        ionuParser_id           IN OUT nocopy ab_address.address_id%type
    )
    IS
        -- Direccion parseada
        sbDirParseada    ab_address.address_parsed%type;

        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        ut_trace.trace('Inicio AB_Boparser.InsAddressTransaction', 1);

        --Parsea y almacena la direccion en ab_address
        AB_Boparser.InsertAddress
        (
            inuGeoLocationId,
            isbAddress,
            inuNeighbortId,
            isbIsUrban,
            ionuParser_id,
            sbDirParseada,
            csbYES
        );

        IF ionuParser_id IS NOT null THEN

            --Inserta la informacion adicional de la direccion
            BEGIN

                AB_BOAddress.InsAddressAdditionalInfo
                (
                    ionuParser_id,
                    inuPreviousValue,
                    isbComment,
                    inuPremiseTypeId
                );

            EXCEPTION
                when ex.CONTROLLED_ERROR then
                    NULL;
                when others then
                    NULL;
            END;

        END IF;

        COMMIT;
        ut_trace.trace('Fin AB_Boparser.InsAddressTransaction', 1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ROLLBACK;
            raise ex.CONTROLLED_ERROR;
        when others then
            ROLLBACK;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END InsAddressTransaction;

    /*****************************************************************
    Unidad      :   fsbIsRootGrammar
    Descripcion	:   Retorna valor (Y/N) que indica si la gramatica
                    recibida como parametro es base
                    Ej. Si se tiene las gramaticas ordenadas
                        gramatica1 = [VIA]</ALT/>
                        gramatica2 = [VIA]</ALT/><TORRE>
                        gramatica3 = [VIA]</ALT/><TORRE><CUERPO><PISO>
                    Solo la gramatica 1 es Base o raiz de las demas gramaticas
                    "similares".
                    El concepto de gramatica base solo aplica para gramaticas
                    padre, es decir solo para estructuras que definen como
                    se registra finalmente la direccion.

    Parametros      Descripcion
    ============    ===================
    inuGrammarId    Identificador de la gramatica

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    11-12-2012      amendezSAO195302    Se modifica para que solo tenga en cuenta
                                        gramaticas padre.
    01-12-2011      caguilar.SAO165655  Estabilizacion amendezSAO166967. Creacion.
    ****************************************************************/
    FUNCTION fsbIsRootGrammar( inuGrammarId in bd_gramatica.id_gramatica%type )
    return varchar2
    IS
        nuIndex       binary_integer;
        sbRootGrammar varchar2(1);
    BEGIN
        ut_trace.trace('Inicio AB_Boparser.fblIsRootGrammar('||inuGrammarId||')', 5);
        sbRootGrammar := csbNO;

        nuIndex := tbgGramatica.first;
        loop
            EXIT when nuIndex IS null;

            IF tbgGramatica(nuIndex).id_gramatica = inuGrammarId
               AND tbgGramatica(nuIndex).id_gramatica_padre IS null
               AND tbgGramatica(nuIndex).rootGrammar = csbYES
            THEN
                sbRootGrammar := csbYES;
                EXIT;
            END if;

            nuIndex := tbgGramatica.next(nuIndex);
        END loop;

        ut_trace.trace('Fin AB_Boparser.fblIsRootGrammar => '||sbRootGrammar, 5);
        return sbRootGrammar;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbIsRootGrammar;


    /*****************************************************************
    Unidad      :   fnuGetGrammarIndexById
    Descripcion	:   Obtiene el indice en la tabla pl/sql, de gramaticas
                    dado su identificador.

    Parametros      Descripcion
    ============    ===================
    inuGrammarId    Identificador de la gramatica

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    01-12-2011      caguilar SAO165655  1 - Estabilizacion amendezSAO167312. Creacion.
    ****************************************************************/
    FUNCTION fnuGetGrammarIndexById( inuGrammarId in bd_gramatica.id_gramatica%type)
    return binary_integer
    IS
        nuIndex binary_integer;
    BEGIN
        ut_trace.trace('Inicio AB_Boparser.fnuGetGrammarIndexById ('||inuGrammarId||')', 5);
        nuIndex := tbgGramatica.first;
        loop
            exit when nuIndex IS null;
            if tbgGramatica(nuIndex).id_gramatica = inuGrammarId then
                ut_trace.trace('Fin AB_Boparser.fnuGetGrammarIndexById indice => '||nuIndex, 5);
                return nuIndex;
            END if;
            nuIndex := tbgGramatica.next(nuIndex);
        END loop;
        ut_trace.trace('Fin AB_Boparser.fnuGetGrammarIndexById indice => '||nuIndex, 5);
        return nuIndex;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetGrammarIndexById;

    /*****************************************************************
    Unidad      :   fnuPreviousGrammarLevel
    Descripcion	:   Teniendo en cuenta que en la estructura de memoria,
                    las gramaticas estan ordenadas de menor a mayor
                    obtiene el indice de dicha estructura de la
                    gramatica de un nivel superior a una gramatica dada.
                    Solo se consideran las gramaticas padre.

    Parametros      Descripcion
    ============    ===================
    inuGrammarId    Identificador de la gramatica

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    11-12-2012      amendezSAO195302    Solo se consideran gramaticas padre
                                        en la busqueda de contenencia gramatical.
    01-12-2011      caguilar SAO165655  1 - Estabilizacion amendezSAO167312. Creacion.
    ****************************************************************/
    FUNCTION fnuPreviousGrammarLevel
    (
        inuGrammarId in bd_gramatica.id_gramatica%type
    )
    return binary_integer
    IS
        nuIndPrev          binary_integer;
        sbPrevGrammar    bd_gramatica.gramatica%type;
        sbCurrentGrammar bd_gramatica.gramatica%type;
    BEGIN
        ut_trace.trace('Inicio AB_Boparser.fnuPreviousGrammarLevel ('||inuGrammarId||')', 5);
        nuIndPrev := null;
        IF tbgGramatica.exists( inuGrammarId )
           AND tbgGramatica(inuGrammarId).id_gramatica_padre IS null
        THEN
            sbCurrentGrammar := tbgGramatica(inuGrammarId).gramaticaEntera;
            FOR nuIndPrev IN REVERSE 1..(inuGrammarId - 1) LOOP
               IF tbgGramatica.exists(nuIndPrev)
                  AND tbgGramatica( nuIndPrev ).id_gramatica_padre IS NULL
               THEN
                    sbPrevGrammar := tbgGramatica(nuIndPrev).gramaticaEntera;
                    -- Si la gramatica previa esta contenida desde la PRIMERA posicion
                    -- en la gramatica actual, es su gramatica "padre"
                    IF instr(sbCurrentGrammar,sbPrevGrammar,1) = 1 then
                        ut_trace.trace('Fin AB_Boparser.fnuPreviousGrammarLevel indice=>'||nuIndPrev, 5);
                        return nuIndPrev;
                    END if;
               END IF;
            END LOOP;
        END IF;
        ut_trace.trace('Fin AB_Boparser.fnuPreviousGrammarLevel indice=>'||nuIndPrev, 5);
        return nuIndPrev;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuPreviousGrammarLevel;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuFindAddress
    Descripcion :  Metodo encargado retornar el ID para direccion recibida en formato libre.
                   Si no existe retorna -1.

    Autor       :  Hector Cruz
    Fecha       :  14-03-2012
    Parametros  :  isbAddress           Texto de la direccion
                   inuGeoLocationId     Identificador de la ubicacion geografica

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    14-03-2012   hcruzSAO176067     Creacion
                                    Estabilizacion del SAO158031
    ***************************************************************/
    FUNCTION fnuFindAddress
    (
        isbAddress        in ab_address.address%type,
        inuGeoLocationId  in ab_address.geograp_location_id%type
    )
    RETURN ab_address.address_id%type
    IS
        nuAddressId Number;
    BEGIN
        ut_trace.trace('INICIO AB_Boparser.fnuFindAddress isbAddress ['||isbAddress||'] inuGeoLocationId ['||inuGeoLocationId||']' , 5);
        nuAddressId := AB_BCParser.fnuFindAddress( isbAddress, inuGeoLocationId );
        ut_trace.trace('FIN AB_Boparser.fnuFindAddress ['||nuAddressId||']' , 5);

        RETURN nuAddressId;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuFindAddress;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ObjCheckAddressExists
    Descripcion :  Metodo encargado retornar el ID para direccion recibida en formato libre.
                   Si no existe retorna -1.

    Autor       :  Cesar Pantoja
    Fecha       :  16-07-2012
    Parametros  :  isbAddress           Texto de la direccion
                   inuGeoLocationId     Identificador de la ubicacion geografica

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    16-07-2012   cpantojaSAO186506  Creacion
    ***************************************************************/
    FUNCTION ObjCheckAddressExists
    (
        isbaddress        IN  ab_address.address%type,
        inuGeoLocation    IN  ab_address.geograp_location_id%type
    )
    RETURN ab_address.address_id%type
    IS
    BEGIN

        return CheckIfAddressExistsInDB(isbaddress, inuGeoLocation);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad      :   LoadTokens
    Descripcion	:   Carga en cache los tokens permitidos para gramaticas
                    del banco de direcciones

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============  ===================   ====================
    12-12-2012    amendezSAO197917      Creacion.
    ******************************************************************/
    PROCEDURE LoadTokens
    IS
        cuMainTokens  constants.tyRefCursor;
        sbToken       ab_token_hierarchy.token_hierarchy_id%type;
        sbRootToken   ab_token_hierarchy.token_hierarchy_id%type;
        sbTokenDomain ab_token_hierarchy.token_domain%type;
        nuHierarchy   ab_token_hierarchy.hierarchy%type;
        nuDomainId    ab_token_hierarchy.domain_id%type;
    BEGIN
        IF gtbAllTokens.first IS not NULL THEN
            return;
        END IF;
        ut_trace.trace('Cargando tokens principales' , 5);

        cuMainTokens := AB_BCParser.frfTokens;
        LOOP
            FETCH cuMainTokens INTO sbToken, sbRootToken, sbTokenDomain, nuHierarchy, nuDomainId;
            EXIT WHEN cuMainTokens%NOTFOUND;

            IF NOT gtbAllTokens.exists(sbToken) THEN
                -- Adiciona token al cache
                gtbAllTokens(sbToken).sbRootToken   := sbRootToken;
                gtbAllTokens(sbToken).sbTokenDomain := sbTokenDomain;
                gtbAllTokens(sbToken).nuHierarchy   := nuHierarchy;
                gtbAllTokens(sbToken).nuDomainId    := nuDomainId;
            END IF;
        END LOOP;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END LoadTokens;


    /*****************************************************************
    Unidad      :   fsbTokenBase
    Descripcion	:   Retorna el simbolo base de un token dado,
                    el token dado puede o no ser sinonimo.
                    Valida que el token dado no sea nulo.

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============  ===================   ====================
    18-12-2012    amendezSAO198254      Excluye los sinonimos de palabras
    12-12-2012    amendezSAO197917      Creacion.
    ******************************************************************/
    FUNCTION fsbTokenBase
    (
        isbToken    in varchar2
    )
    RETURN varchar2
    IS
        sbToken     ab_token_hierarchy.token_hierarchy_id%type;
    BEGIN
        -- Carga en cache todos los tokens.
        LoadTokens;

        -- Obtiene el token base
        IF  gtbAllTokens.exists(isbToken)
            AND gtbAllTokens(isbToken).sbTokenDomain != csbSINONIMO_PALABRA_DE_VIA
        THEN
            sbToken := gtbAllTokens(isbToken).sbRootToken;
        ELSE
        -- Eleva error si el token no existe
            Errors.setError(cnuErrTokenNoExiste, isbToken);
            raise ex.CONTROLLED_ERROR;
        END IF;

        return sbToken;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbTokenBase;


    /*****************************************************************
    Unidad      :   fblEsTokenSinonimo
    Descripcion	:   Retorna valor logico que indica si el token dado
                    es sinonimo.

    Parametros          Descripcion
    ============        ===================
    isbToken            Simbolo a verificar

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============  ===================== ====================
    18-12-2012    amendezSAO198254      Excluye los sinonimos de palabras
    12-12-2011    amendezSAO197917      Creacion.
    ******************************************************************/
    FUNCTION fblEsTokenSinonimo
    (
        isbToken in varchar2
    )
    RETURN BOOLEAN
    IS
    BEGIN
        IF ( isbToken IS NULL ) THEN
            RETURN FALSE;
        END IF;

        -- Carga en cache todos los tokens.
        LoadTokens;

        -- Obtiene el token base
        IF  gtbAllTokens.exists(isbToken)
            AND gtbAllTokens(isbToken).sbRootToken != isbToken
            AND gtbAllTokens(isbToken).sbTokenDomain != csbSINONIMO_PALABRA_DE_VIA
        THEN
            return TRUE;
        ELSE
            return FALSE;
        END IF;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others THEN
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblEsTokenSinonimo;


    /*****************************************************************
    Unidad      :   fblesComplemento
    Descripcion	:   Indica si simbolo de una direccion es
                    de tipo complemento

    Parametros          Descripcion
    ============        ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    12-12-2012      amendezSAO197917    Creacion.
    ******************************************************************/
    FUNCTION fblesComplemento
    (
        isbSimbolo    in  ab_token_hierarchy.token_hierarchy_id%type,
        onuHierarchy  out ab_token_hierarchy.hierarchy%type
    )
    RETURN BOOLEAN
    IS
    BEGIN
        IF isbSimbolo IS null THEN
            return FALSE;
        END IF;

        -- Carga en cache todos los tokens.
        LoadTokens;

        -- Obtiene el token base
        IF  gtbAllTokens.exists( isbSimbolo )
            AND gtbAllTokens( isbSimbolo ).sbTokenDomain = csbDominioComplemento
        THEN
            ut_trace.trace('fblesComplemento('||isbSimbolo||') is TRUE',10);
            onuHierarchy := gtbAllTokens(isbSimbolo).nuHierarchy;
            return TRUE;
        ELSE
            return FALSE;
        END IF;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblesComplemento;


    /*****************************************************************
    Unidad      :   fnuDomainId
    Descripcion	:   Obtiene el identificador de dominio de un token

    Parametros          Descripcion
    ============        ===================
    isbSimbolo          Token

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    12-12-2012      amendezSAO197917    Creacion.
    ******************************************************************/
    FUNCTION fnuDomainId
    (
        isbSimbolo    in  ab_token_hierarchy.token_hierarchy_id%type
    )
    RETURN ab_token_hierarchy.domain_id%type
    IS
    BEGIN
        IF isbSimbolo IS null THEN
            return null;
        END IF;

        -- Carga en cache todos los tokens.
        LoadTokens;

        -- Obtiene el token base
        IF  gtbAllTokens.exists( isbSimbolo )  THEN
            return gtbAllTokens( isbSimbolo ).nuDomainId;
        END IF;

        return null;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuDomainId;


    /*****************************************************************
    Unidad      :   fblEsSinonimoPalabraVia

    Descripcion	:   Indica si el token ingresado como parametro corresponde
                    a un sinonimo de via, en caso tal retorna su valor ppal.
    Parametros          Descripcion
    ============        ===================
    isbToken            Palabra a analizar dentro del texto en formato
                        libre de una via
    osbTokenPpal        Palabra estandarizada dentro del texto de la via

    Historia de Modificaciones
    Fecha      Autor            Modificacion
    ========== ================ =======================================
    18-12-2012 amendezSAO198254 Creacion.
    ******************************************************************/
    FUNCTION fblEsSinonimoPalabraVia
    (
        isbToken in VARCHAR2,
        osbTokenPpal out varchar2
    )
    RETURN BOOLEAN
    IS
    BEGIN
        IF ( isbToken IS NULL ) THEN
            RETURN FALSE;
        END IF;

        -- Carga en cache todos los tokens.
        LoadTokens;

        -- Obtiene el token base
        IF  gtbAllTokens.exists(isbToken)
            AND gtbAllTokens(isbToken).sbRootToken != isbToken
            AND gtbAllTokens(isbToken).sbTokenDomain = csbSINONIMO_PALABRA_DE_VIA
        THEN
            osbTokenPpal := gtbAllTokens(isbToken).sbRootToken;
            return TRUE;
        ELSE
            return FALSE;
        END IF;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblEsSinonimoPalabraVia;


BEGIN
    -- Enciende cache en el DAO de gramatica
    dabd_gramatica.SetUseCache(TRUE);
END LDC_AB_Boparser;
/
PROMPT Otorgando permisos de ejecucion a LDC_AB_BOPARSER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_AB_BOPARSER', 'ADM_PERSON');
END;
/