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
  IdConfExpre := 121378613;

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
GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",NULL,'||
'"MO_PROCESS",'||
'"PACKAGE_TYPE_ID",'||
'nuPackageTypeId);PROVALIDACIONESTRAMITES_RP();if (nuPackageTypeId = "100294",'||
'sbIntancia = "M_MOTIVO_SOLICITUD_REPARACION_PRP_100289-2";,'||
'if (sbIntancia = "100295",'||
'sbIntancia = "M_MOTIVO_SOLICITUD_REPARACION_PRP_100289-2";,'||
'););if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK("WORK_INSTANCE",'||
' NULL,'||
' "PR_PRODUCT",'||
' "PRODUCT_ID",'||
' 1) = GE_BOCONSTANTS.GETTRUE(),'||
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE("WORK_INSTANCE",'||
'NULL,'||
'"PR_PRODUCT",'||
'"PRODUCT_ID",'||
'sbproducto);nuproducto = UT_CONVERT.FNUCHARTONUMBER(sbproducto);LDCVALASIGLEGASUSPENSION(nuproducto);,'||
'if (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbIntancia,'||
' NULL,'||
' "MO_MOTIVE",'||
' "PRODUCT_ID",'||
' 1) = GE_BOCONSTANTS.GETTRUE(),'||
'GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbIntancia,'||
'NULL,'||
'"MO_MOTIVE",'||
'"PRODUCT_ID",'||
'sbproducto);nuproducto = UT_CONVERT.FNUCHARTONUMBER(sbproducto);LDCVALASIGLEGASUSPENSION(nuproducto);,'||
');)', author = 'OPEN',
generation_date = to_date ('06/05/21','DD/MM/YYYY HH24:MI:SS'),
last_modifi_date = to_date ('06/05/21','DD/MM/YYYY HH24:MI:SS'),
object_type = 'PP',
code = 'CREATE OR REPLACE PROCEDURE MO_EVE_COMP_CT65E"||IdConfExpre||"(errorNumber OUT NUMBER, errorMessage OUT VARCHAR2)
IS
-- Generated by Code Generator (PVCS Version 1.5)
 -- Open Systems Ltd, Copyright 2003.
V0 NUMBER;
V1 VARCHAR2(4000);
V2 VARCHAR2(4000);
V3 VARCHAR2(4000);
nuPackageTypeId VARCHAR2(4000);
V4 NUMBER;
V5 VARCHAR2(4000);
V6 VARCHAR2(4000);
sbIntancia VARCHAR2(4000);
V7 VARCHAR2(4000);
V8 VARCHAR2(4000);
V9 VARCHAR2(4000);
V10 VARCHAR2(4000);
V11 BOOLEAN;
V12 VARCHAR2(4000);
V13 VARCHAR2(4000);
V14 VARCHAR2(4000);
V15 NUMBER;
V16 BOOLEAN;
V17 NUMBER;
V18 VARCHAR2(4000);
V19 VARCHAR2(4000);
V20 VARCHAR2(4000);
sbproducto VARCHAR2(4000);
V21 NUMBER;
nuproducto NUMBER;
V22 NUMBER;
V23 NUMBER;
V24 BOOLEAN;
V25 VARCHAR2(4000);
V26 VARCHAR2(4000);
V27 NUMBER;
V28 BOOLEAN;
V29 NUMBER;
V30 VARCHAR2(4000);
V31 VARCHAR2(4000);
V32 NUMBER;
V33 NUMBER;
V34 NUMBER;

BEGIN
V1 := "WORK_INSTANCE";
V2 := "MO_PROCESS";
V3 := "PACKAGE_TYPE_ID";
GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(V1, NULL, V2, V3, nuPackageTypeId);
V0:= 0;
PROVALIDACIONESTRAMITES_RP;
V4:= 0;
V5 := "100294";
IF ( nuPackageTypeId = V5 )
THEN
V6 := "M_MOTIVO_SOLICITUD_REPARACION_PRP_100289-2";
sbIntancia:=V6;
V7:=V6;
ELSE
V8 := "100295";
IF ( sbIntancia = V8 )
THEN
V9 := "M_MOTIVO_SOLICITUD_REPARACION_PRP_100289-2";
sbIntancia:=V9;
V10:=V9;
ELSE
null;
END IF;
V7:=V10;
END IF;
V12 := "WORK_INSTANCE";
V13 := "PR_PRODUCT";
V14 := "PRODUCT_ID";
V15 := 1;
V11:=GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(V12, NULL, V13, V14, V15);
V16:=GE_BOCONSTANTS.GETTRUE;
IF ( V11 = V16 )
THEN
V18 := "WORK_INSTANCE";
V19 := "PR_PRODUCT";
V20 := "PRODUCT_ID";
GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(V18, NULL, V19, V20, sbproducto);
V17:= 0;
V21:=UT_CONVERT.FNUCHARTONUMBER(sbproducto);
nuproducto:=V21;
LDCVALASIGLEGASUSPENSION(nuproducto);
V22:= 0;
V23:=V22;
ELSE
V25 := "MO_MOTIVE";
V26 := "PRODUCT_ID";
V27 := 1;
V24:=GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbIntancia, NULL, V25, V26, V27);
V28:=GE_BOCONSTANTS.GETTRUE;
IF ( V24 = V28 )
THEN
V30 := "MO_MOTIVE";
V31 := "PRODUCT_ID";
GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbIntancia, NULL, V30, V31, sbproducto);
V29:= 0;
V32:=UT_CONVERT.FNUCHARTONUMBER(sbproducto);
nuproducto:=V32;
LDCVALASIGLEGASUSPENSION(nuproducto);
V33:= 0;
V34:=V33;
ELSE
null;
END IF;
V23:=V34;
END IF;
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
 where config_expression_id = 121378613;

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
