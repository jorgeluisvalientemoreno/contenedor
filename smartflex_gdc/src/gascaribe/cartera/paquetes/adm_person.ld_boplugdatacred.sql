CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BOPLUGDATACRED IS

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
                            inuResultado      in LD_Result_Consult.Consult_Codes_Id%TYPE,
                            isbXMLResponse    in CLOB,
                            osbOutput         OUT NOCOPY VARCHAR2,
                            osbResultTbl      out nocopy Ld_Result_Consult.result_consult%TYPE,
                            onuResConsId      OUT ld_result_consult.result_consult_id%type
							);


END LD_BOPLUGDATACRED;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BOPLUGDATACRED IS

    csbVersion constant varchar2(20) := 'SAO216509' ;

    FUNCTION fsbVersion return varchar2
    IS BEGIN return csbVersion;     END;


  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : processResponse
  Descripcion    : plugin para procesar la salida de la operacion del web service.
                    Debe retornar   osbOutput = "OK", para ser valido para la venta


  ******************************************************************/
  PROCEDURE processResponse(isbLastName       IN VARCHAR2,
                            inuIdentType      IN LD_Result_Consult.Ident_Type_Id%TYPE,
                            isbIdentification IN LD_Result_Consult.Identification%TYPE,
                            inuResultado      in LD_Result_Consult.Consult_Codes_Id%TYPE,
                            isbXMLResponse    in CLOB,
                            osbOutput         OUT NOCOPY VARCHAR2,
                            osbResultTbl      out nocopy Ld_Result_Consult.result_consult%TYPE,
                            onuResConsId      OUT ld_result_consult.result_consult_id%type
							) IS





    sbIsValid         CHAR(1);
    sbResult          Ld_Consult_Codes.Description%TYPE;
    nuEstadoIden      LD_Result_Consult.Effective_State_Id%TYPE;

  BEGIN
    ut_trace.trace('Inicio LD_BOplugDataCred.processResponse', 10);

    IF inuResultado IS NOT NULL THEN

        --Obtiene la información del estado de identificacion
        IF(inuResultado != 99) THEN
            nuEstadoIden      := ld_bodatacred.fsbExtractXMLElement(isbXMLResponse, '//estado');
        END IF;

        sbIsValid := nvl(dald_consult_codes.fsbGetValid_For_Sale(inuResultado, 0), ld_boconstans.csbNOFlag);

        IF (sbIsValid = ld_boconstans.csbYesFlag) THEN

            IF nuEstadoIden IS NOT NULL THEN
                IF DALD_Effective_State.fsbGetValid_For_Sale(nuEstadoIden, 0) = ld_boconstans.csbYesFlag THEN
                    sbResult := 'OK';
                    osbResultTbl := sbResult;
                ELSE
                    sbResult := 'El Estado de la Identificacón, '||nuEstadoIden||' no es Valido para la Venta';
                    osbResultTbl := 'INVALID';
                END IF;
            ELSE
                    sbResult := 'OK';
                    osbResultTbl := sbResult;
            END IF;

        ELSE
            sbResult := NVL(dald_consult_codes.fsbGetDescription(inuResultado, 0),'No existe resultado en códigos de consulta');
            osbResultTbl := 'INVALID';
        END IF;

    END if;

    osbOutput := sbResult;

    ut_trace.trace('Finaliza LD_BOplugDataCred.processResponse', 10);
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
  END processResponse;


END LD_BOPLUGDATACRED;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOPLUGDATACRED', 'ADM_PERSON'); 
END;
/
