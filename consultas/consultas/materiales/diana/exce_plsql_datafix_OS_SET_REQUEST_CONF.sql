/*
 * Propiedad Intelectual Gases de Occidente S.A. ESP
 *
 * Script  : exce_plsql_datafix_OS_SET_REQUEST_CONF.sql
 * Tiquete : OYM_CEV_92962_1
 * Autor   : OLSoftware / Carlos Virgen <carlos.virgen@olsoftware.com>
 * Fecha   : 07-03-2014
 * Descripcion : Libera el cupo de una unidad operativa, basado en una reserva de material que no sera despachada
 *
 * Historia de Modificaciones
 * Autor          Fecha  Descripcion
**/

/*SET LINESIZE 180;
SET DEFINE OFF;
SET PAGESIZE 999;
SET ECHO ON;
SET SERVEROUTPUT ON SIZE 10000;
COL HOST_NAME FOR A15;
COL INSTANCE_NAME FOR A15;
SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'), HOST_NAME, INSTANCE_NAME FROM V$INSTANCE;
SHOW USER;
SET TIMING ON;*/

declare 
	L_Payload             CLOB;
	Qryctx                DBMS_XMLGEN.CTXHANDLE;
	onuErrorCode          GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
	osbErrorMessage       GE_ERROR_LOG.DESCRIPTION%TYPE;
	--inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE := 25679  /*Reserva a anular: 3082*/;
	orfConsulta           Constants.tyRefCursor;
    cursor cuRequisiciones is
	select DOCU.ID_ITEMS_DOCUMENTO as "DOCUMENT_ID"
	  from GE_ITEMS_DOCUMENTO DOCU
	 where DOCU.ID_ITEMS_DOCUMENTO  in (25679,25680,25681,25682,25685,25685,25721,25743,25743,25743,25743,25743,
										27838,27839,27843,27843,44585,44611,44611,44612,44612,47380,47381,47382,47383,
										47395,47421,47423,47423,47424,47424,47433,47433,47437,47437,47439,47450,47450,
										47450,47450,47450,51662,51694,51694,51702,51702,51702,51702,51702,53086,55254,
										55254,55258,55258,55266,55270,55270,57462,57462,57523);
 -- excepciones  
 exce_getNumRowsProcessed	exception; 	-- Excepcion que valida si proceso registros la consulta
 exce_OS_SET_REQUEST_CONF exception;
begin
  for req in cuRequisiciones loop
	begin
	-- inicializa la variable de retorno
	onuErrorCode := 0;

	--Carga la consulta
	open orfConsulta for
	select DOCU.ID_ITEMS_DOCUMENTO as "DOCUMENT_ID",
	       DOCU.OPERATING_UNIT_ID  as "OPERATING_UNIT_ID", 
	       sysdate                 as "DELIVERYDATE",
	       cursor(select REQU.ITEMS_ID as "ITEM_CODE",
	       0             as "QUANTITY", 
	       0             as "COST" 
	                from GE_ITEMS_REQUEST REQU
	               where DOCU.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO) as "ITEMS"
	  from GE_ITEMS_DOCUMENTO DOCU
	 where DOCU.ID_ITEMS_DOCUMENTO = req.DOCUMENT_ID;
	 
	-- Genera el mensaje XML
	Qryctx :=  DBMS_XMLGEN.Newcontext (orfConsulta);
																																			
																																		
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
  exception
     when others then 
		rollback;
		dbms_output.put_line('Error requisicion: '||req.DOCUMENT_ID||' - '||sqlerrm);
  end;
  end loop;
exception
 when exce_OS_SET_REQUEST_CONF then
	rollback;
    raise_application_error(-20100, 'exce_OS_SET_REQUEST_CONF: Exepcion de API:' || chr(13) || ' onuErrorCode: ' || onuErrorCode
																																																																											|| chr(13) || ' osbErrorMessage: ' || osbErrorMessage);
 
 when exce_getNumRowsProcessed then
	rollback;
    raise_application_error(-20100, 'exce_getNumRowsProcessed: La consulta no proceso registros.');	  													
	   
  when others then
	rollback;
    raise_application_error(-20100, 'SQLERRM: ' || SQLERRM || ' ' || chr(13) || ' Trace: ' || DBMS_UTILITY.format_error_backtrace);	  									
end;
/
