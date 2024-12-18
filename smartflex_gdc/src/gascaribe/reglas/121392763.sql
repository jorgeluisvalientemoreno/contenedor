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
  IdConfExpre := 121392763;

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
	MERGE INTO OPEN.GR_CONFIG_EXPRESSION A USING
	 (SELECT
	  121392763 as CONFIG_EXPRESSION_ID,
	  65 as CONFIGURA_TYPE_ID,
	  'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbInstance,sbFatherInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_MOTIVE","SUBSCRIPTION_ID",nuContrato);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"MO_DATA_FOR_ORDER","ITEM_ID",nuItem);nuTramite = DALD_PARAMETER.FNUGETNUMERIC_VALUE("SOL_REVPER_SAC", 0);boSolicitud = LDC_FBL_EXIST_ACTIV_BY_SUSC(nuContrato, nuItem, nuTramite);if (boSolicitud = TRUE,GI_BOERRORS.SETERRORCODEARGUMENT(2741,"El contrato ya cuenta con una solicitud SAC Revisión Periódica con ese tipo de actividad");,);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,NULL,"MO_PROCESS","ADDRESS_MAIN_MOTIVE",sbAddressId);nuAddressId = UT_CONVERT.FNUCHARTONUMBER(sbAddressId);CF_BOREGISTERRULESCRM.LOADADDRESS(sbInstance,sbAddressId)' as EXPRESSION,
	  'OPEN' as AUTHOR,
	  TO_DATE('12/04/2016 15:01:53', 'DD/MM/YYYY HH24:MI:SS') as CREATION_DATE,
	  TO_DATE('13/07/2022 19:39:40', 'DD/MM/YYYY HH24:MI:SS') as GENERATION_DATE,
	  TO_DATE('13/07/2022 19:39:40', 'DD/MM/YYYY HH24:MI:SS') as LAST_MODIFI_DATE,
	  'G' as STATUS,
	  'N' as USED_OTHER_EXPRESION,
	  'PU' as MODIFICATION_TYPE,
	  NULL as PASSWORD,
	  'DS' as EXECUTION_TYPE,
	  'PRE - Valida solicitudes con la misma actividad - Revisi¿n Peri¿dica SAC' as DESCRIPTION,
	  'MO_EVE_COMP_CT65E121392763' as OBJECT_NAME,
	  'PP' as OBJECT_TYPE,
	  NULL as CODE
	  FROM DUAL) B
	ON (A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID)
	WHEN NOT MATCHED THEN 
	INSERT (
	  CONFIG_EXPRESSION_ID, CONFIGURA_TYPE_ID, EXPRESSION, AUTHOR, CREATION_DATE, 
	  GENERATION_DATE, LAST_MODIFI_DATE, STATUS, USED_OTHER_EXPRESION, MODIFICATION_TYPE, 
	  PASSWORD, EXECUTION_TYPE, DESCRIPTION, OBJECT_NAME, OBJECT_TYPE, 
	  CODE)
	VALUES (
	  B.CONFIG_EXPRESSION_ID, B.CONFIGURA_TYPE_ID, B.EXPRESSION, B.AUTHOR, B.CREATION_DATE, 
	  B.GENERATION_DATE, B.LAST_MODIFI_DATE, B.STATUS, B.USED_OTHER_EXPRESION, B.MODIFICATION_TYPE, 
	  B.PASSWORD, B.EXECUTION_TYPE, B.DESCRIPTION, B.OBJECT_NAME, B.OBJECT_TYPE, 
	  B.CODE)
	WHEN MATCHED THEN
	UPDATE SET 
	  A.CONFIGURA_TYPE_ID = B.CONFIGURA_TYPE_ID,
	  A.EXPRESSION = B.EXPRESSION,
	  A.AUTHOR = B.AUTHOR,
	  A.CREATION_DATE = B.CREATION_DATE,
	  A.GENERATION_DATE = B.GENERATION_DATE,
	  A.LAST_MODIFI_DATE = B.LAST_MODIFI_DATE,
	  A.STATUS = B.STATUS,
	  A.USED_OTHER_EXPRESION = B.USED_OTHER_EXPRESION,
	  A.MODIFICATION_TYPE = B.MODIFICATION_TYPE,
	  A.PASSWORD = B.PASSWORD,
	  A.EXECUTION_TYPE = B.EXECUTION_TYPE,
	  A.DESCRIPTION = B.DESCRIPTION,
	  A.OBJECT_NAME = B.OBJECT_NAME,
	  A.OBJECT_TYPE = B.OBJECT_TYPE,
	  A.CODE = B.CODE;


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
