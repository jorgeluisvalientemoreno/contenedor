CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BODATACRED IS
	csbMethod CONSTANT VARCHAR2(20) := 'ws_add';


	FUNCTION fsbVersion return varchar2;



  PROCEDURE Insertresultconsult(ISBIN LD_Result_Consult.Identification%TYPE, -- Numero de documento de identificacion del ciudadano.
                                INUDT LD_Result_Consult.ident_type_id%TYPE, -- Tipo de documento en smartflex
                                INUGE LD_Result_Consult.gender_id%TYPE, -- Identificador del genero del ciudadano
                                INUST LD_Result_Consult.effective_state_id%TYPE, -- Identificador del estado de vigencia
                                INURA LD_Result_Consult.age_range_id%TYPE, -- Identificador del rango de edad
                                ISBNA LD_Result_Consult.subscribername%TYPE, -- Nombre del ciudadano
                                INULD LD_Result_Consult.consult_codes_id%TYPE, -- Codigo de consulta retornado.
                                ISBRE LD_Result_Consult.result_consult%TYPE, --Resultado de la operacion (Success/Fail)
                                INUNR LD_Result_Consult.Number_Request%TYPE, --Numero de la solicitud de credito para la cual se realizo la consulta
                                ISBDI LD_Result_Consult.Departament_Issued%TYPE, --Nombre del departamento de expedicion del documento
                                ISBCI LD_Result_Consult.city_issued%TYPE, --Nombre de la ciudad de expedicion del documento
                                IDTDA LD_Result_Consult.date_issued%TYPE, --Fecha de expedicion del documento
                                ISBLN LD_Result_Consult.Second_Last_Name%TYPE, --Segundo apellido del ciudadano
                                ISBFN LD_Result_Consult.last_name%TYPE, -- Primer apellido del ciudadano.
								ONUID out ld_result_consult.result_consult_id%type --ID asignado al registro
                                );

	/*****************************************************************
	Propiedad intelectual de Open International Systems (c).

	Unidad         : fboValidForSaleFNB
	Descripcion    : Obtiene el registro de consulta datacredito mas reciente,
	               que no supere  LD_MAX_DAYS_VAL_DATACRE dias.

	Autor          :
	Fecha          : 29/10/2012

	Parametros              Descripcion
	============         ===================

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================
	******************************************************************/

	FUNCTION fboValidForSaleFNB(inuIdentType      IN LD_Result_Consult.Ident_Type_Id%TYPE,
	                          isbIdentification IN LD_Result_Consult.Identification%TYPE,
	                          isbLastName       IN LD_Result_Consult.Last_Name%TYPE)
	RETURN BOOLEAN;

	/*****************************************************************
	Propiedad intelectual de Open International Systems (c).

	Unidad         : processResponse
	Descripcion    : procesa la salida de la operacion del web service.

	Autor          : Alex Valencia Ayola
	Fecha          : 07/11/2012

	Parametros              Descripcion
	============         ===================
	isbResponse          Respuesta del web service
	inuIdentType         Tipo de identificacion
	isbIdentification    Identificacion
	osbOutput            Mensaje de salida

	Historia de Modificaciones
	Fecha             Autor             Modificacion
	=========       =========           ====================
	******************************************************************/
	PROCEDURE processResponse(isbLastName       IN VARCHAR2,
	                        inuIdentType      IN LD_Result_Consult.Ident_Type_Id%TYPE,
	                        isbIdentification IN LD_Result_Consult.Identification%TYPE,
	                        osbOutput         OUT NOCOPY VARCHAR2,
	                        onuResConsId      OUT ld_result_consult.result_consult_id%type);
	/**********************************************************************
 	Propiedad intelectual de OPEN International Systems
 	Nombre              assignSale

 	Autor				Andr茅s Felipe Esguerra Restrepo

 	Fecha               16-ago-2013

 	Descripci贸n         Actualiza el registro en LD_RESULT_CONSULT con el ID
						de la venta

 	***Parametros***
 	Nombre				Descripci贸n
 	inuResultConsultId	PK del registro a actualizar
 	inuPackageId        ID de la venta
 ***********************************************************************/
    PROCEDURE assignSale(
		inuResultConsultId in ld_result_consult.result_consult_id%type,
		inuPackageId in ld_result_consult.package_id%type);

    FUNCTION fsbExtractXMLElement(isbCadena IN VARCHAR2,
                                  isbTag    IN VARCHAR2) RETURN VARCHAR2;

END LD_BODATACRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BODATACRED IS

    csbVersion constant varchar2(20) := 'SAO216509' ;

    FUNCTION fsbVersion return varchar2
    IS BEGIN return csbVersion;     END;
  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : Insertresultconsult
  Descripcion    : Procedimiento que Inserta el registro luego de consumir el Web Service de DataCredito
                   y obtener los datos que este devuelve.

  Autor          :
  Fecha          : 29/10/2012

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE Insertresultconsult(ISBIN LD_Result_Consult.Identification%TYPE, -- Numero de documento de identificacion del ciudadano.
                                INUDT LD_Result_Consult.ident_type_id%TYPE, -- Tipo de documento en smartflex
                                INUGE LD_Result_Consult.gender_id%TYPE, -- Identificador del genero del ciudadano
                                INUST LD_Result_Consult.effective_state_id%TYPE, -- Identificador del estado de vigencia
                                INURA LD_Result_Consult.age_range_id%TYPE, -- Identificador del rango de edad
                                ISBNA LD_Result_Consult.subscribername%TYPE, -- Nombre del ciudadano
                                INULD LD_Result_Consult.consult_codes_id%TYPE, -- Codigo de consulta retornado.
                                ISBRE LD_Result_Consult.result_consult%TYPE, --Resultado de la operacion (Success/Fail)
                                INUNR LD_Result_Consult.Number_Request%TYPE, --Numero de la solicitud de credito para la cual se realizo la consulta
                                ISBDI LD_Result_Consult.Departament_Issued%TYPE, --Nombre del departamento de expedicion del documento
                                ISBCI LD_Result_Consult.city_issued%TYPE, --Nombre de la ciudad de expedicion del documento
                                IDTDA LD_Result_Consult.date_issued%TYPE, --Fecha de expedicion del documento
                                ISBLN LD_Result_Consult.Second_Last_Name%TYPE, --Segundo apellido del ciudadano
                                ISBFN LD_Result_Consult.last_name%TYPE, -- Primer apellido del ciudadano.
								ONUID out ld_result_consult.result_consult_id%type --ID asignado al registro
                                ) IS
    ---Variable tipo registro
    styLdResult_Consult DALD_Result_Consult.styLD_result_consult;
    nuNextSeq           NUMBER;
    --Variables para obtener usuario y terminal
    sbUser     VARCHAR2(200);
    sbTerminal VARCHAR2(200);
  BEGIN

    ut_trace.trace('Inicio LD_BODatacred.Insertresultconsult', 10);

    sbUser     := GE_BOPersonal.fnuGetPersonId;
    sbTerminal := userenv('TERMINAL');

    /*Obtiene el valor de la secuencia de la tabla*/
    nuNextSeq := pkgeneralservices.fnuGetNextSequenceVal(sbSequenceName => 'SEQ_LD_RESULT_CONSULT');
    ONUID := nuNextSeq;

    /*Registro los datos en la entidad DALD_RESULT_CONSULT*/
    styLdResult_Consult.result_consult_id  := nuNextSeq;
    styLdResult_Consult.identification     := ISBIN;
    styLdResult_Consult.ident_type_id      := INUDT;
    styLdResult_Consult.gender_id          := INUGE;
    styLdResult_Consult.effective_state_id := INUST;
    styLdResult_Consult.age_range_id       := INURA;
    styLdResult_Consult.subscribername     := ISBNA;
    styLdResult_Consult.consult_codes_id   := INULD;
    styLdResult_Consult.result_consult     := ISBRE;
    styLdResult_Consult.number_request     := INUNR;
    styLdResult_Consult.terminal           := sbTerminal;
    styLdResult_Consult.user_name          := sbUser;
    styLdResult_Consult.consultation_date  := SYSDATE;
    styLdResult_Consult.departament_issued := ISBDI;
    styLdResult_Consult.city_issued        := ISBCI;
    styLdResult_Consult.date_issued        := IDTDA;
    styLdResult_Consult.second_last_name   := ISBLN;
    styLdResult_Consult.last_name          := ISBFN;

    ut_trace.trace('result_consult_id:    ' || nuNextSeq ||
                   '. identification:     ' || ISBIN ||
                   '. ident_type_id:      ' || INUDT ||
                   '. gender_id:          ' || INUGE ||
                   '. effective_state_id: ' || INUST ||
                   '. age_range_id:       ' || INURA ||
                   '. subscribername:     ' || ISBNA ||
                   '. consult_codes_id:   ' || INUNR ||
                   '. result_consult:     ' || ISBRE ||
                   '. number_request:     ' || INULD ||
                   '. Terminal:           ' || sbTerminal ||
                   '. User:               ' || sbUser ||
                   '. consultation_date:  ' || SYSDATE ||
                   '. departament_issued: ' || ISBDI ||
                   '. city_issued:        ' || ISBCI ||
                   '. date_issued:        ' || IDTDA ||
                   '. second_last_name:   ' || ISBLN ||
                   '. last_name:          ' || ISBFN,
                   10);

    DALD_Result_Consult.insRecord(styLdResult_Consult);

    commit;

    ut_trace.trace('Finaliza LD_BODatacred.Insertresultconsult', 10);

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;

  END Insertresultconsult;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fboValidForSaleFNB
  Descripcion    : Obtiene el registro de consulta datacredito mas reciente,
                   que no supere  LD_MAX_DAYS_VAL_DATACRE dias.

  Autor          :
  Fecha          : 29/10/2012

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

    FUNCTION fboValidForSaleFNB(inuIdentType      IN LD_Result_Consult.Ident_Type_Id%TYPE,
                              isbIdentification IN LD_Result_Consult.Identification%TYPE,
                              isbLastName       IN LD_Result_Consult.Last_Name%TYPE)
    RETURN BOOLEAN IS

        /*Declaracion de variables*/
        nuMaxDays          PLS_INTEGER;
        nuEffectiveState   LD_Effective_State.Effective_State_Id%TYPE;
        nuConsultCode      LD_Consult_Codes.Consult_Codes_Id%TYPE;
        sbEfSt_ValiForSale LD_Effective_State.Valid_For_Sale%TYPE := ld_boconstans.csbNOFlag;
        sbCoCo_ValiForSale LD_Consult_Codes.Valid_For_Sale%TYPE   := ld_boconstans.csbNOFlag;
    BEGIN

        ut_trace.trace('Inicio LD_BODatacred.fboValidForSaleFNB', 10);

        /*Obtiene el valor del parametro */
        nuMaxDays := DALD_PARAMETER.fnuGetNumeric_Value('LD_MAX_DAYS_VAL_DATACRE', 0);

        /*Obtiene el registro de consulta datacredito mas reciente, que no supere LD_MAX_DAYS_VAL_DATACRE dias. */
        LD_BCDatacred.setEffectiveStateConsultCode(nuMaxDays, inuIdentType, isbIdentification, isbLastName,nuEffectiveState, nuConsultCode);

        IF nuEffectiveState IS NOT NULL AND nuConsultCode IS NOT NULL THEN
          /*Obtener el valor del campo Valid_For_Sale en LD_Effective_State*/
          sbEfSt_ValiForSale := DALD_Effective_State.fsbGetValid_For_Sale(inuEFFECTIVE_STATE_Id => nuEffectiveState);

          /*Obtener el valor del campo Valid_For_Sale en LD_Consult_Codes*/
          sbCoCo_ValiForSale := DALD_Consult_Codes.fsbGetValid_For_Sale(nuConsultCode);
        END IF;

        RETURN (sbEfSt_ValiForSale = ld_boconstans.csbYesFlag) AND
               (sbCoCo_ValiForSale = ld_boconstans.csbYesFlag);

        ut_trace.trace('Finaliza LD_BODatacred.fboValidForSaleFNB', 10);

    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
    END fboValidForSaleFNB;


    FUNCTION fsbExtractXMLElement(isbCadena IN VARCHAR2,
                                  isbTag    IN VARCHAR2) RETURN VARCHAR2 IS

      xml xmltype;
    BEGIN
      -- convert to XML from char type
      xml := xmltype.createxml(isbCadena);
      IF xml.EXISTSNODE(isbTag) = 1 THEN
        CASE WHEN xml.EXTRACT(isbTag || '/text()') IS NOT NULL THEN
          RETURN xml.EXTRACT(isbTag || '/text()').getstringval();
        ELSE
          RETURN NULL;
        END CASE;
      END IF;

      RETURN NULL;
    END fsbExtractXMLElement;

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : processResponse
  Descripcion    : procesa la salida de la operacion del web service.

  Autor          : Alex Valencia Ayola
  Fecha          : 25/04/2013

  Parametros              Descripcion
  ============         ===================
  isbLastName          Apellido
  inuIdentType         Tipo de identificacion
  isbIdentification    Identificacion
  osbOutput            Mensaje de salida
  onuResConsId         ID del registro creado

  Historia de Modificaciones
  Fecha             Autor               Modificacion
  =========       =========             ====================
  04-Oct-2013   jllanoSAO218930         Se modifica para guardar el apellido si no es retornado por el webservice
  10-10-2013    emontenegro SAO218771   Se modifica para obtener la informaci贸n cuando el c贸digo de
                                        consulta sea diferente a 99, ya que es el que indica que
                                        no hubo conexi贸n a datacr茅dito.
  06-09-2013    llopezSAO.216509        Se modifica para almacenar siempre el resultado de datacredito
  02-08-2013    AEcheverrySAO213712     Se modifica primer parametro de entrada, ya que este representara el apellido
                                        Se adiciona llamado a validacion de Datacredito y
                                        Se modifica forma de parcear TAGS en XML
  16-08-2013    aesguerra SAO213740     Se a帽ade par谩metro que retorna el ID del registro creado en LD_RESULT_CONSULT
  ******************************************************************/
  PROCEDURE processResponse(isbLastName       IN VARCHAR2,
                            inuIdentType      IN LD_Result_Consult.Ident_Type_Id%TYPE,
                            isbIdentification IN LD_Result_Consult.Identification%TYPE,
                            osbOutput         OUT NOCOPY VARCHAR2,
                            onuResConsId      OUT ld_result_consult.result_consult_id%type
							) IS

	PRAGMA autonomous_transaction;


    nuResultado       LD_Result_Consult.Consult_Codes_Id%TYPE;
    sbXMLResponse   CLOB;
    sbNombre          LD_Result_Consult.Subscribername%TYPE;
    sbPrimerApellido  LD_Result_Consult.Last_Name%TYPE;
    sbSegundoApellido LD_Result_Consult.Second_Last_Name%TYPE;
    sbCiudad          LD_Result_Consult.City_Issued%TYPE;
    sbDepartam        LD_Result_Consult.Departament_Issued%TYPE;
    nuGenero          LD_Result_Consult.Gender_Id%TYPE;
    nuRangoEdad       LD_Result_Consult.Age_Range_Id%TYPE;
    nuSolicitud       Ld_Result_Consult.Number_Request%TYPE;
    nuEstadoIden      LD_Result_Consult.Effective_State_Id%TYPE;
    sbResultTbl     Ld_Result_Consult.result_consult%TYPE;
    dtFechaExp      VARCHAR2(40);
    sbEdadMin       VARCHAR2(3);
    sbEdadMax       VARCHAR2(3);


    nuErrorCode     GE_ERROR_LOG.ERROR_LOG_ID%type;
    sbErrorMessage  GE_ERROR_LOG.DESCRIPTION%type;

  BEGIN
    ut_trace.trace('Inicio LD_BODatacred.processResponse', 10);

    LDCI_PKDATACREDITO.PROCONSULTADATACREDITO
    (
        inuIdentType,
        isbIdentification,
        isbLastName,
        sbXMLResponse,
        nuErrorCode,
        sbErrorMessage
    );

    if (nuErrorCode <> 0) then
        gw_boerrors.checkerror(nuErrorCode, sbErrorMessage);
    END if;


    IF (sbXMLResponse IS NOT NULL) THEN
      nuResultado := fsbExtractXMLElement(sbXMLResponse, '//respuesta');
    END IF;


    IF (nuResultado IS NOT NULL) THEN
        --Obtiene la informaci贸n si el c贸digo es diferente de 99-SIN CONEXI每N A DATACR每�DITO
        IF(nuResultado != 99) THEN

          sbNombre          := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//nombres');
          sbPrimerApellido  := nvl(ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//priApell'), isbLastName);
          sbSegundoApellido := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//segApell');
          nuGenero          := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//genero');

          nuEstadoIden      := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//estado');
          dtFechaExp        := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//feExped');
          sbCiudad          := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//ciudad');
          sbDepartam        := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//depart');
          nuSolicitud       := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//numero');

          sbEdadMin         := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//min');
          sbEdadMax         := ld_bodatacred.fsbExtractXMLElement(sbXMLResponse, '//max');

          IF sbEdadMin IS NOT NULL AND sbEdadMax IS NOT NULL THEN
            nuRangoEdad := LD_BCDatacred.fnuGetAgeRangeByAge(sbedadMin, sbedadMax);
          END IF;

          /* se convierte de milisegundos a fecha con formato dd-mm-yyyy */
          dtfechaexp := to_char(to_date('01/01/1970', 'DD/mm/YYYY') +
                          (to_number(dtfechaexp) * (1 / 24 / 60 / 60 / 1000)), 'DD/mm/YYYY');

        END IF;
    END if;

    --  plugin de procesamiento de la informacion en datacredito
    LD_BOplugDataCred.processResponse
    (
        isbLastName,
        inuIdentType,
        isbIdentification,
        nuResultado,
        sbXMLResponse,
        osbOutput,
        sbResultTbl,
        onuResConsId
    );

    -- se actualiza la tabla de consultas en datacredito
    IF(nuResultado IS NOT NULL) THEN

        sbPrimerApellido:= nvl(sbPrimerApellido,isbLastName);
        -- SAO216509: Solicitado por Nhora Renteria
        ld_bodatacred.Insertresultconsult(isbIdentification, inuIdentType, nuGenero,
                    nuEstadoIden, nuRangoEdad, sbNombre,
                    nuResultado, sbResultTbl, nuSolicitud, sbDepartam,
                    sbCiudad, to_date(dtfechaexp, 'dd/mm/yyyy'),
                    sbSegundoApellido, sbPrimerApellido,onuResConsId);

    END if;


    ut_trace.trace('Finaliza LD_BODatacred.processResponse', 10);
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END processResponse;


	PROCEDURE assignSale(
		inuResultConsultId in ld_result_consult.result_consult_id%type,
		inuPackageId in ld_result_consult.package_id%type) IS
	BEGIN
        DALD_Result_Consult.updPACKAGE_ID(inuResultConsultId,inuPackageId);
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR THEN
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
    END assignSale;

END LD_BODatacred;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCVISIT', 'ADM_PERSON'); 
END;
/
