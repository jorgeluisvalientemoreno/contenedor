CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKDATACREDITOPORTAL AS

  /*****************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       : LDCI_PKDATACREDITOPORTAL
     AUTOR         : Sincecomp/ Karem Baquero
     FECHA         : 20/05/2014
     REQUERIMIENTO : PETI-SMARTFLEX
     DESCRIPCION: Paquete que tiene el procedimiento para realizar consultas al sistema datacredito.

    Historia de Modificaciones
    Autor   Fecha           Descripcion.
   KARBAQ    20/05/2014     Creación <<PROCCONSULTDATA>>
   KARBAQ    21/05/2014     Creación <<PROCINSCONSULTDATA>>
  *******************************************************************************/

  PROCEDURE PROCCONSULTDATA(ISBTIIDENT        IN LD_Result_Consult.ident_type_id%TYPE,
                            ISBIDENTIFICACION IN LD_Result_Consult.Identification%TYPE,
                            ISBAPELLIDO       IN LD_Result_Consult.last_name%TYPE,
                            OSBRESPUESTA      OUT varchar2,
                            orfCursor         out Constants.tyRefCursor,
                            onuErrorCode      OUT NUMBER,
                            osbErrorMessage   OUT VARCHAR2);

  PROCEDURE PROCINSCONSULTDATA(ISBIN           LD_Result_Consult.Identification%TYPE, -- Numero de documento de identificacion del ciudadano.
                               INUDT           LD_Result_Consult.ident_type_id%TYPE, -- Tipo de documento en smartflex
                               INUGE           LD_Result_Consult.gender_id%TYPE, -- Identificador del genero del ciudadano
                               INUST           LD_Result_Consult.effective_state_id%TYPE, -- Identificador del estado de vigencia
                               INURA           LD_Result_Consult.age_range_id%TYPE, -- Identificador del rango de edad
                               ISBNA           LD_Result_Consult.subscribername%TYPE, -- Nombre del ciudadano
                               INULD           LD_Result_Consult.consult_codes_id%TYPE, -- Codigo de consulta retornado.
                               ISBRE           LD_Result_Consult.result_consult%TYPE, --Resultado de la operacion (Success/Fail)
                               INUNR           LD_Result_Consult.Number_Request%TYPE, --Numero de la solicitud de credito para la cual se realizo la consulta
                               ISBDI           LD_Result_Consult.Departament_Issued%TYPE, --Nombre del departamento de expedicion del documento
                               ISBCI           LD_Result_Consult.city_issued%TYPE, --Nombre de la ciudad de expedicion del documento
                               IDTDA           LD_Result_Consult.date_issued%TYPE, --Fecha de expedicion del documento
                               ISBLN           LD_Result_Consult.Second_Last_Name%TYPE, --Segundo apellido del ciudadano
                               ISBFN           LD_Result_Consult.last_name%TYPE, -- Primer apellido del ciudadano.
                               ONUID           out ld_result_consult.result_consult_id%type,
                               onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2);

END LDCI_PKDATACREDITOPORTAL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKDATACREDITOPORTAL AS

  /*********************************************************
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

   PROCEDIMIENTO : PROCINSCONSULTDATA
     AUTOR : Sincecomp/ Karem Baquero
     FECHA : 20/05/2014

   DESCRIPCION : Procedimiento para insertar las respuestas del portal
               de datacredito en la tabla de resultados

   Parametros de Entrada

      ISBIN:  Numero de documento de identificacion del ciudadano.
      INUDT Tipo de documento en smartflex
                                INUGE  Identificador del genero del ciudadano
                                INUST  Identificador del estado de vigencia
                                INURA  Identificador del rango de edad
                                ISBNA  Nombre del ciudadano
                                INULD  Codigo de consulta retornado.
                                ISBRE Resultado de la operacion (Success/Fail)
                                INUNR Numero de la solicitud de credito para la cual se realizo la consulta
                                ISBDI Nombre del departamento de expedicion del documento
                                ISBCI Nombre de la ciudad de expedicion del documento
                                IDTDA Fecha de expedicion del documento
                                ISBLN Segundo apellido del ciudadano
                                ISBFN primer apellido del ciudadano


   Parametros de Salida

      ONUID ID asignado al registro

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
  ******************************************************/
  PROCEDURE PROCINSCONSULTDATA(ISBIN           LD_Result_Consult.Identification%TYPE, -- Numero de documento de identificacion del ciudadano.
                               INUDT           LD_Result_Consult.ident_type_id%TYPE, -- Tipo de documento en smartflex
                               INUGE           LD_Result_Consult.gender_id%TYPE, -- Identificador del genero del ciudadano
                               INUST           LD_Result_Consult.effective_state_id%TYPE, -- Identificador del estado de vigencia
                               INURA           LD_Result_Consult.age_range_id%TYPE, -- Identificador del rango de edad
                               ISBNA           LD_Result_Consult.subscribername%TYPE, -- Nombre del ciudadano
                               INULD           LD_Result_Consult.consult_codes_id%TYPE, -- Codigo de consulta retornado.
                               ISBRE           LD_Result_Consult.result_consult%TYPE, --Resultado de la operacion (Success/Fail)
                               INUNR           LD_Result_Consult.Number_Request%TYPE, --Numero de la solicitud de credito para la cual se realizo la consulta
                               ISBDI           LD_Result_Consult.Departament_Issued%TYPE, --Nombre del departamento de expedicion del documento
                               ISBCI           LD_Result_Consult.city_issued%TYPE, --Nombre de la ciudad de expedicion del documento
                               IDTDA           LD_Result_Consult.date_issued%TYPE, --Fecha de expedicion del documento
                               ISBLN           LD_Result_Consult.Second_Last_Name%TYPE, --Segundo apellido del ciudadano
                               ISBFN           LD_Result_Consult.last_name%TYPE, -- Primer apellido del ciudadano.
                               ONUID           out ld_result_consult.result_consult_id%type, --ID asignado al registro
                               onuErrorCode    OUT NUMBER,
                               osbErrorMessage OUT VARCHAR2) Is

    sbEfSt_ValiForSale LD_Effective_State.Valid_For_Sale%TYPE := ld_boconstans.csbNOFlag;
    sbCoCo_ValiForSale LD_Consult_Codes.Valid_For_Sale%TYPE := ld_boconstans.csbNOFlag;

  BEGIN
    ut_trace.trace('Inicio LDCI_PKDATACREDITO.PROCINSCONSULTDATA', 10);

    IF INUST IS NOT NULL AND INULD IS NOT NULL THEN
      /*Obtener el valor del campo Valid_For_Sale en LD_Effective_State*/
      sbEfSt_ValiForSale := DALD_Effective_State.fsbGetValid_For_Sale(inuEFFECTIVE_STATE_Id => INUST);

      /*Obtener el valor del campo Valid_For_Sale en LD_Consult_Codes*/
      sbCoCo_ValiForSale := DALD_Consult_Codes.fsbGetValid_For_Sale(INULD);
    END IF;

    if (sbEfSt_ValiForSale = ld_boconstans.csbYesFlag) AND
       (sbCoCo_ValiForSale = ld_boconstans.csbYesFlag) then

      onuErrorCode := 0;

    else

      onuErrorCode := 1;
    end if;

    ld_bodatacred.Insertresultconsult(ISBIN,
                                      INUDT,
                                      INUGE,
                                      INUST,
                                      INURA,
                                      ISBNA,
                                      INULD,
                                      ISBRE,
                                      INUNR,
                                      ISBDI,
                                      ISBCI,
                                      IDTDA,
                                      ISBLN,
                                      ISBFN,
                                      ONUID);

    ut_trace.trace('Inicio LDCI_PKDATACREDITO.PROCINSCONSULTDATA', 10);

  Exception
    WHEN ex.CONTROLLED_ERROR THEN
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      RAISE ex.CONTROLLED_ERROR;
      --         Dbms_Output.Put_Line(osbErrorMessage);
  END PROCINSCONSULTDATA;

  /*********************************************************
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A. E.S.P

   PROCEDIMIENTO : PROCONSULTADATA
     AUTOR : Sincecomp/ Karem Baquero
     FECHA : 20/05/2014

   DESCRIPCION : Procedimiento para consultar historia de datacredito en la
                tabla de resultados

   Parametros de Entrada

      ISBTIIDENT          tipo de identificación
      ISBIDENTIFICACION   identificación
      ISBAPELLIDO         Primer Apellido del ciudadano


   Parametros de Salida

      OSBRESPUESTA


   Historia de Modificaciones

   Autor        Fecha       Descripcion.
  ******************************************************/
  PROCEDURE PROCCONSULTDATA(ISBTIIDENT        IN LD_Result_Consult.ident_type_id%TYPE,
                            ISBIDENTIFICACION IN LD_Result_Consult.Identification%TYPE,
                            ISBAPELLIDO       IN LD_Result_Consult.last_name%TYPE,
                            OSBRESPUESTA      OUT varchar2, --out boolean,
                            orfCursor         out Constants.tyRefCursor,
                            onuErrorCode      OUT NUMBER,
                            osbErrorMessage   OUT VARCHAR2) Is

    OBRESPUESTA boolean;

  BEGIN
    ut_trace.trace('Inicio LDCI_PKDATACREDITO.PROCONSULTDATA', 10);

    OBRESPUESTA := LD_BODatacred.fboValidForSaleFNB(ISBTIIDENT,
                                                    ISBIDENTIFICACION,
                                                    ISBAPELLIDO);

    if OBRESPUESTA = false then

      OSBRESPUESTA := 1;
      If (orfCursor%ISOPEN = false) then
        OPEN orfCursor FOR
          SELECT -1      IDENT_TYPE_ID,
                 -1      LAST_NAME,
                 -1      SECOND_LAST_NAME,
                 -1      GENDER_ID,
                 -1      description,
                 -1      AGE_RANGE_ID,
                 -1      SUBSCRIBERNAME,
                 -1      CONSULT_CODES_ID,
                 -1      RESULT_CONSULT,
                 -1      USER_NAME,
                 -1      CONSULTATION_DATE,
                 -1      DEPARTAMENT_ISSUED,
                 -1      CITY_ISSUED,
                 sysdate DATE_ISSUED,
                 -1      PACKAGE_ID
            FROM DUAL
           WHERE 1 = 1;

        DBMS_OUTPUT.PUT_LINE('orfCursor%ISOPEN = false');

      end if; -- IF (orfCursor%ISOPEN = false) then

    ELSE
      OSBRESPUESTA := 0;

      open orfCursor for
        select IDENTIFICATION,
               IDENT_TYPE_ID,
               LAST_NAME,
               SECOND_LAST_NAME,
               GENDER_ID,
               l.description,
               AGE_RANGE_ID,
               SUBSCRIBERNAME,
               CONSULT_CODES_ID,
               RESULT_CONSULT,
               USER_NAME,
               CONSULTATION_DATE,
               DEPARTAMENT_ISSUED,
               CITY_ISSUED,
               DATE_ISSUED,
               PACKAGE_ID
          from LD_RESULT_CONSULT t, LD_EFFECTIVE_STATE l
         where l.effective_state_id = t.effective_state_id
           AND t.ident_type_id = ISBTIIDENT
           AND t.identification = ISBIDENTIFICACION
           AND UPPER(t.last_name) = UPPER(ISBAPELLIDO);

      If (orfCursor%ISOPEN = false) then
        OPEN orfCursor FOR
          SELECT -1      IDENT_TYPE_ID,
                 -1      LAST_NAME,
                 -1      SECOND_LAST_NAME,
                 -1      GENDER_ID,
                 -1      description,
                 -1      AGE_RANGE_ID,
                 -1      SUBSCRIBERNAME,
                 -1      CONSULT_CODES_ID,
                 -1      RESULT_CONSULT,
                 -1      USER_NAME,
                 -1      CONSULTATION_DATE,
                 -1      DEPARTAMENT_ISSUED,
                 -1      CITY_ISSUED,
                 sysdate DATE_ISSUED,
                 -1      PACKAGE_ID
            FROM DUAL
           WHERE 1 = 1;

        DBMS_OUTPUT.PUT_LINE('orfCursor%ISOPEN = false');

      end if; -- IF (orfCursor%ISOPEN = false) then

    end if;
    ut_trace.trace('Inicio LDCI_PKDATACREDITO.PROCONSULTDATA', 10);

  Exception
    WHEN ex.CONTROLLED_ERROR THEN
      onuErrorCode    := -1;
      osbErrorMessage := 'ERROR: <Consulta LOCAL Datacredito>: ' ||
                         Dbms_Utility.Format_Error_Backtrace;

    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := 'ERROR: <Consulta LOCAL Datacredito>: ' ||
                         Dbms_Utility.Format_Error_Backtrace;

    --         Dbms_Output.Put_Line(osbErrorMessage);
  END PROCCONSULTDATA;

END LDCI_PKDATACREDITOPORTAL;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKDATACREDITOPORTAL', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKDATACREDITOPORTAL to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKDATACREDITOPORTAL to INTEGRADESA;
/


