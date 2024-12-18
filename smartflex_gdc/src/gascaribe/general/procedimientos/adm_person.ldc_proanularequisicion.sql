CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PROANULAREQUISICION
/*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : LDC_PROANULAREQUISICION
  Descripcion    : Proceso utilizado para anular una requisición

  Autor          : Iván Darío Cerón
  Fecha          : 26/02/2015

  Parametros              Descripcion
  ============         ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/

IS

    sbProcessInstance     ge_boinstancecontrol.stysbname;
    nuRequisicion         ge_items_documento.id_items_documento%type;

    nuLdlpcons            ldc_log_pb.ldlpcons%type;

    L_Payload             CLOB;
    Qryctx                DBMS_XMLGEN.CTXHANDLE;
	onuErrorCode          GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
	osbErrorMessage       GE_ERROR_LOG.DESCRIPTION%TYPE;
	inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE; -- Codigo de Reserva a anular

    -- excepciones
    exce_getNumRowsProcessed	exception; 	-- Excepcion que valida si proceso registros la consulta
    exce_OS_SET_REQUEST_CONF    exception;


    /*
        ProcessLog
        Inserta o Actualiza el log de PB
    */
    procedure ProcessLog
    (
        inuCons in out  ldc_log_pb.ldlpcons%type,
        isbProc in      ldc_log_pb.ldlpproc%type,
        idtFech in      ldc_log_pb.ldlpfech%type,
        isbInfo in      ldc_log_pb.ldlpinfo%type
    )
    is
        -- Session
        sbSession   varchar2(50);
        -- Usuario
        sbUser      varchar2(50);
        -- Info Aux
        sbInfoAux   ldc_log_pb.ldlpinfo%type;
    begin
        -- Obtiene valor de la session
        SELECT  USERENV('SESSIONID'),
                USER
        INTO    sbSession,
                sbUser
        FROM    dual;

        -- Insertamos o Actualizamos
        if(inuCons is null) then

            -- Obtiene CONS de log pb
            select  SEQ_LDC_LOG_PB.nextval
            into    inuCons
            from    dual;

            insert into ldc_log_pb
            (
                LDLPCONS, LDLPPROC, LDLPUSER, LDLPTERM, LDLPFECH, LDLPINFO
            )
            values
            (
                inuCons,
                isbProc,
                sbUser,
                sbSession,
                idtFech,
                isbInfo
            );

        else
            -- Obtiene Datos
            select  LDLPINFO
            into    sbInfoAux
            from    ldc_log_pb
            where   LDLPCONS = inuCons;

            -- Actualiza Datos
            update  ldc_log_pb
            set     LDLPINFO = LDLPINFO||' '||isbInfo
            where   LDLPCONS = inuCons;
        end if;

        commit;

    end ProcessLog;

BEGIN

    -- Codigo
    ge_boinstancecontrol.GetCurrentInstance(sbProcessInstance);

     -- Se obtiene el valor del orden desde la instancia
    GE_BOInstanceControl.GetAttributeNewValue(sbProcessInstance,
                                              null,
                                              'GE_ITEMS_DOCUMENTO',
                                              'ID_ITEMS_DOCUMENTO',
                                              nuRequisicion);

    inuID_ITEMS_DOCUMENTO := nuRequisicion;

    -- inicializa la variable de retorno
	onuErrorCode := 0;
    nuLdlpcons := null;
    onuErrorCode := null;

    ProcessLog
		(
        nuLdlpcons,
        'PBAREQ',
        sysdate,
        'INICIA PROCESO'
		);



	-- Genera el mensaje XML
	Qryctx :=  DBMS_XMLGEN.Newcontext ('
					select DOCU.ID_ITEMS_DOCUMENTO as "DOCUMENT_ID",
									DOCU.OPERATING_UNIT_ID  as "OPERATING_UNIT_ID",
									sysdate                 as "DELIVERYDATE",
									cursor(select REQU.ITEMS_ID as "ITEM_CODE",
												0             as "QUANTITY",
												0             as "COST"
							              from GE_ITEMS_REQUEST REQU
						                   where DOCU.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO) as "ITEMS"
								from GE_ITEMS_DOCUMENTO DOCU
							where DOCU.ID_ITEMS_DOCUMENTO = :inuID_ITEMS_DOCUMENTO
                        ');


    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuID_ITEMS_DOCUMENTO', inuID_ITEMS_DOCUMENTO);
		DBMS_XMLGEN.setRowSetTag(Qryctx, 'REQUEST_CONF');
		--DBMS_XMLGEN.setRowTag(qryCtx, '');
		DBMS_XMLGEN.setNullHandling(qryCtx, 0);

		l_payload := DBMS_XMLGEN.getXML(qryCtx);

		--Valida si proceso registros
		if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
							RAISE exce_getNumRowsProcessed;
		end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

		DBMS_XMLGEN.closeContext(qryCtx);

		L_Payload := Replace(L_Payload, '<ROW>', '<DOCUMENT>');
		L_Payload := Replace(L_Payload, '</DELIVERYDATE>', '</DELIVERYDATE>' ||chr(13) || '</DOCUMENT>');
		L_Payload := Replace(L_Payload, '</ROW>','');

		l_payload := replace(l_payload, '<ITEMS_ROW>',  '<ITEM>');
		l_payload := replace(l_payload, '</ITEMS_ROW>', '</ITEM>');
		L_Payload := Trim(L_Payload);

		-- hace el llamado al API
		OS_SET_REQUEST_CONF(L_Payload, onuErrorCode , osbErrorMessage);

		if (onuErrorCode <> 0) then
					raise exce_OS_SET_REQUEST_CONF;
		else
	       commit;
		end if;--if (onuErrorCode <> 0) then

    nuLdlpcons := null;

    ProcessLog
		(
        nuLdlpcons,
        'PBAREQ',
        sysdate,
        'TERMINA PROCESO'
		);


EXCEPTION
    when exce_OS_SET_REQUEST_CONF then
        raise_application_error(-20100, 'exce_OS_SET_REQUEST_CONF: Exepcion de API:' || chr(13) || ' onuErrorCode: ' || onuErrorCode|| chr(13) || ' osbErrorMessage: ' || osbErrorMessage);
    when OTHERS then
        Errors.seterror;
        raise ex.CONTROLLED_ERROR;

END LDC_PROANULAREQUISICION;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PROANULAREQUISICION', 'ADM_PERSON');
END;
/
