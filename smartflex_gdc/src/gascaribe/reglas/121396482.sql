/******************************************************************
Propiedad intelectual de Open International Systems Copyright 2001
Archivo     insGR_CONFIG_EXPRESSION_<AAAAMMDD>.sql
Autor       <Nombre autor>
Fecha       <AAAAMMDD>

Descripci¿n
Observaciones

Historia de Modificaciones
Fecha         Autor               Modificaci¿n
<AAAAMMDD>  <Nombre Autor>              Creaci¿n
******************************************************************/
declare
    CURSOR cuData(nuIdConfExpre in gr_config_expression.config_expression_id%type) is
    -- Se obtiene la lista de expresiones a regenerar
    SELECT rowid,config_expression_id, configura_type_id, object_name, expression, object_type,
           description, status
    FROM gr_config_expression
    WHERE config_expression_id in (nuIdConfExpre);

    onuExprId gr_config_expression.config_expression_id%type := NULL;

    nuCountErr number := 0;
    nuProc number := 0;
    nuErrorCode          NUMBER(15);
    sbErrorMsg           VARCHAR2(2000);

    IdConfExpre GR_CONFIG_EXPRESSION.config_expression_id%type;
    
    	CURSOR cuRef is
		SELECT a.table_name, b.column_name
		from   all_constraints a, all_cons_columns b
		where  R_CONSTRAINT_NAME = (
								   SELECT unique(f.constraint_name)
								   FROM   all_constraints f, all_cons_columns s
								   WHERE  f.constraint_name = s.constraint_name
									 AND  f.constraint_type = 'P'
									 AND  f.table_name      = 'GR_CONFIG_EXPRESSION'
	   )
	   AND  a.constraint_name = b.constraint_name
	   AND  a.owner           = b.owner
	   AND  a.table_name      = b.table_name;

	  sbStatement  varchar2(2000);
	  blExiste    boolean := FALSE;
	  nuCant      number;
	  nuCodigo    number:=1296;
	  sbTabla     varchar2(50);
	  sbCampo     varchar2(50);
	    

	  CURSOR cuNum ( inuConfExpreID IN gr_config_expression.config_expression_id%type ) IS
	  SELECT CONFIG_EXPRESSION_ID codigo, object_name objeto
	  FROM gr_config_expression WHERE config_expression_id in (inuConfExpreID);
	  
	  CURSOR cuTipoObjeto ( isbNomObj IN gr_config_expression.object_name%type ) IS
	  SELECT  object_type
	  FROM    DBA_OBJECTS
	  WHERE   OBJECT_NAME = isbNomObj;
    sbObjetoEliminar gr_config_expression.object_name%type;
    sbObjeto 		 gr_config_expression.object_name%type;
    sbtipo			 dba_objects.object_type%type;
    
BEGIN

  dbms_output.put_line('Inicia Proceso '||sysdate);
  IdConfExpre := 121396482;

  dbms_output.put_line('Insertando Regla: '||IdConfExpre);

  --INICIO Busca regla para realizar los ajustes correspondientes¿
  dbms_output.put_line('Inicia Proceso ajustes regla');  
	open cuNum(IdConfExpre);
	  loop
		fetch cuNum INTO nuCodigo, sbObjeto;
		exit when cuNum%NOTFOUND;
		dbms_output.put_line('Registro --> '||nuCodigo);

		blExiste := FALSE;
		open cuRef;
		loop
		  fetch cuRef INTO sbTabla, sbCampo;
		  exit when cuRef%NOTFOUND ;

		  sbStatement := ' Begin SELECT count(1) INTO :x FROM '||sbTabla||
						 ' Where '||sbCampo ||'='||nuCodigo ||' AND ROWNUM=1;End;';

		  execute immediate sbStatement using out nuCant;
		  if ( nuCant > 0 ) then
			dbms_output.put_line(' ['||nuCodigo ||'] Existe  en ['||sbTabla ||'] '||sbCampo);
			blExiste  := true;
		  END if;
		END loop;
		close cuRef;
		if blExiste then
		  BEGIN
			sbObjetoEliminar := dagr_config_expression.fsbGetobject_name(nuCodigo);
			dbms_output.put_line('drop objeto '||sbObjetoEliminar||';');
			if(sbObjeto = sbObjetoEliminar) then
				--cursor que busca el tipo de objeto
				Open cuTipoObjeto(sbObjetoEliminar);
				  fetch cuTipoObjeto
					into sbTipo;
				close cuTipoObjeto;
							
				--tipo = procedure o function
				sbStatement := ' drop ' || sbTipo || ' ' || sbObjetoEliminar;

				dbms_output.put_line(sbStatement);
				execute immediate (sbStatement);
			end if;	
		  Exception
			When Others then
			  dbms_output.put_line('-- No Existe registro en gr_config_expression para '||nuCodigo);
		  End;
		END if;

	  END loop;
	close cuNum;
	dbms_output.put_line('Termine Proceso ajustes regla');
	
	--FIN Busca regla para realizar los ajustes correspondientes
  

    UPDATE GR_CONFIG_EXPRESSION
	set expression = 'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuAddressID);CF_BORegisterRulesCrm.LoadAddress(sbInstance,inuAddressID);nuCiclo = AB_BOADDRESS.FNUGETCICLFACT(inuAddressID);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"SUSCRIPC",'||
'"SUSCCICL",'||
'nuCiclo);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"SUSCRIPC",'||
'"SUSCIDDI",'||
'inuAddressID);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_PACKAGES_ASSO",'||
'"PACKAGE_ID_ASSO",'||
'nuCotiza);CC_BOQUOTATIONMGR.VALIDATEADDRESSQUOTATION(nuCotiza,'||
'inuAddressID);LDC_BOINFOADDRESS.VALINFOPREMISE(inuAddressID);PKG_UIINFOPREDIO.PRCVALIDAPREDIOCASTIGADO(inuAddressID)', author = 'OPEN',
generation_date = to_date ('19-07-2024 09:05:10','DD/MM/YYYY HH24:MI:SS'),
last_modifi_date = to_date ('19-07-2024 09:05:10','DD/MM/YYYY HH24:MI:SS'),
object_type = 'PP',
code = 'CREATE OR REPLACE PROCEDURE MO_VALIDATTR_CT26E"||IdConfExpre||"(errorNumber OUT NUMBER, errorMessage OUT VARCHAR2)
IS
-- Generated by Code Generator (PVCS Version 1.5)
 -- Open Systems Ltd, Copyright 2003.
V0 NUMBER;
sbInstance VARCHAR2(4000);
V1 NUMBER;
inuAddressID VARCHAR2(4000);
V2 NUMBER;
V3 NUMBER;
nuCiclo NUMBER;
V4 NUMBER;
V5 VARCHAR2(4000);
V6 VARCHAR2(4000);
V7 NUMBER;
V8 VARCHAR2(4000);
V9 VARCHAR2(4000);
V10 NUMBER;
V11 VARCHAR2(4000);
V12 VARCHAR2(4000);
nuCotiza VARCHAR2(4000);
V13 NUMBER;
V14 NUMBER;
V15 NUMBER;

BEGIN
GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);
V0:= 0;
GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(inuAddressID);
V1:= 0;
CF_BORegisterRulesCrm.LoadAddress(sbInstance, inuAddressID);
V2:= 0;
V3:=AB_BOADDRESS.FNUGETCICLFACT(inuAddressID);
nuCiclo:=V3;
V5 := "SUSCRIPC";
V6 := "SUSCCICL";
GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance, null, V5, V6, nuCiclo);
V4:= 0;
V8 := "SUSCRIPC";
V9 := "SUSCIDDI";
GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance, null, V8, V9, inuAddressID);
V7:= 0;
V11 := "MO_PACKAGES_ASSO";
V12 := "PACKAGE_ID_ASSO";
GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance, null, V11, V12, nuCotiza);
V10:= 0;
CC_BOQUOTATIONMGR.VALIDATEADDRESSQUOTATION(nuCotiza, inuAddressID);
V13:= 0;
LDC_BOINFOADDRESS.VALINFOPREMISE(inuAddressID);
V14:= 0;
PKG_UIINFOPREDIO.PRCVALIDAPREDIOCASTIGADO(inuAddressID);
V15:= 0;
errorNumber := 0;
errorMessage:= NULL;
EXCEPTION
	WHEN ex.CONTROLLED_ERROR then
	errors.getError(errorNumber, errorMessage);
	WHEN OTHERS THEN
	errors.setError;
	errors.getError(errorNumber, errorMessage);
END;
'
 where config_expression_id = 121396482;

    dbms_output.put_line('Regenerando Regla: '||IdConfExpre);

    -- Recorre la regla insertada para regenerarla
    for reg in cuData(IdConfExpre) loop
    BEGIN

        GR_BOINTERFACE_BODY.GenerateRule (reg.expression, reg.configura_type_id,
                            reg.description, reg.config_expression_id, onuExprId, reg.object_type);
        GR_BOINTERFACE_BODY.CreateStprByConfExpreId(onuExprId);
        dbms_output.put_line('Expresion Generada = '||onuExprId);

        nuProc := nuProc + 1;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                 nuCountErr := nuCountErr + 1;
                 Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr('ExprId = '||reg.config_expression_id||', Err : '||nuErrorCode||', '||sbErrorMsg,1,250));

            when others then
                 nuCountErr := nuCountErr + 1;
                 Errors.setError;
                        Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr('ExprId = '||reg.config_expression_id||', Err : '||nuErrorCode||', '||sbErrorMsg,1,250));

    END;

    END loop;
    dbms_output.put_line('Termina regenerar Regla: '||IdConfExpre);

    --<INSERT_TABLA> o <UPDATE_TABLA>

    commit;

    dbms_output.put_line('Fin Proceso '||sysdate);
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        rollback;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMsg);

    when OTHERS then
        rollback;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMsg);
END;
/
