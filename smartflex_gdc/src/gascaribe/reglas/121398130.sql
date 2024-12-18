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
  IdConfExpre := 121398130;

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
	set expression = '
GE_BOINSTANCECONTROL.GETFATHERCURRENTINSTANCE(sbInsPadre);GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,'||
'"MO_PROCESS",'||
'"VALUE_3",'||
'nuActividad);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_MOTIVE",'||
'"SERVICE_NUMBER",'||
'nuProduct);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_PROCESS",'||
'"GEOGRAP_LOCATION_ID",'||
'nuDireccion);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_PROCESS",'||
'"COMMENTARY",'||
'sbComentario);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_PROCESS",'||
'"SUBSCRIBER_ID",'||
'nusubscriber);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_PROCESS",'||
'"OPERATING_SECTOR",'||
'nuOperatingUnit);if (nuActividad = "4000948" && nusubscriber = null,'||
'GI_BOERRORS.SETERRORCODEARGUMENT(2741,'||
'"Debe seleccionar un informante si la actividad es <INFORMANTE>");,'||
');LD_BOVISIT.PROCGETINFADDRESS(nuDireccion,'||
'nuGeoLocation,'||
'sbDireccion);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,'||
'null,'||
'"MO_ADDRESS",'||
'"GEOGRAP_LOCATION_ID",'||
'nuGeoLocation);GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInstance,'||
'NULL,'||
'"MO_ADDRESS",'||
'"ADDRESS",'||
'sbDireccion);if (nusubscriber <> null,'||
'sbSubscriberId = UT_CONVERT.FSBNUMBERTOCHAR(nusubscriber);sbNombre = GE_BOSUBSCRIBER.FSBGETNAME(nusubscriber);cedula = DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(nusubscriber,'||
' null);sbTexto = UT_STRING.FSBCONCAT(cedula,'||
' sbNombre,'||
' " - ");sbTexto = UT_STRING.FSBCONCAT(sbComentario,'||
' sbTexto,'||
' " /// Informante --> ");unidadExterna = UT_STRING.FSBCONCAT(nuOperatingUnit,'||
' DAOR_OPERATING_UNIT.FSBGETNAME(nuOperatingUnit,'||
' null),'||
' "-");sbTexto = UT_STRING.FSBCONCAT(sbTexto,'||
' unidadExterna,'||
' " // Unidad Externa -->  ");GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(sbInsPadre,'||
'null,'||
'"MO_PACKAGES",'||
'"COMMENT_",'||
'sbTexto);,'||
');LDC_REGISTERNTL.PBREGISTER_NTL(nuActividad,'||
'nuDireccion,'||
'nusubscriber,'||
'nuProduct,'||
'sbComentario,'||
'nuOperatingUnit,'||
'OnuOrder)', author = 'OPEN',
generation_date = to_date ('24/07/23','DD/MM/YYYY HH24:MI:SS'),
last_modifi_date = to_date ('24/07/23','DD/MM/YYYY HH24:MI:SS'),
object_type = 'PP',
code = ''
 where config_expression_id = 121398130;

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
