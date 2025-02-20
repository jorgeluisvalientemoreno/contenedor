DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    sql_ins VARCHAR2(32000):=NULL;
    sbVariable varchar2(15);
    nuConfExpreId gr_config_expression.config_expression_id%type;
    sbObjectName varchar2(100);
    sbCode varchar2(4000);
    fileMgr         utl_file.file_type;
    sbentrega          clob;
    CURSOR cuGetConfExpre
    (
        inuConfExpreID IN gr_config_expression.config_expression_id%type
    )
    IS
        SELECT rowid,a.* FROM gr_config_expression a
        WHERE config_expression_id in (inuConfExpreID);

	sql_expression VARCHAR2(32000);
    sql_author VARCHAR2(32000);
	sql_GenDate VARCHAR2(32000);
	sql_lastModif VARCHAR2(32000);
	sql_objType VARCHAR2(32000);
    tbstring ut_string.tytb_string;
	sbentrega_1 VARCHAR2(8000);
	sbentrega_2 varchar2(8000);
  sbEntrega_Busca varchar2(8000);
	

  sbautor      varchar2(8000);
	sbfecgen     varchar2(8000);
	sbfecmod     varchar2(8000);
	sbtipoobj    varchar2(8000);
	sbCodigo     VARCHAR2(8000);
	
BEGIN

    nuConfExpreId := &id_regla;

    sbVariable := 'IdConfExpre';
	
    for rcGetConfExpre in cuGetConfExpre(nuConfExpreId) loop


        sbObjectName := replace(rcGetConfExpre.OBJECT_NAME, nuConfExpreId, '''||'||sbVariable||'||''');
        sbCode := replace(rcGetConfExpre.CODE, nuConfExpreId, '''||'||sbVariable||'||''');
        sbcode:=replace(sbcode,'''','"');
        sql_ins := sbVariable||','||
        rcGetConfExpre.CONFIGURA_TYPE_ID||',''';
		
        sql_expression := rcgetconfexpre.expression||''',';
        sql_author := rcGetConfExpre.AUTHOR||''',';
        sql_GenDate := 'to_date ('''|| rcGetConfExpre.GENERATION_DATE||''',''DD/MM/YYYY HH24:MI:SS''),';
        sql_lastModif := 'to_date ('''|| rcGetConfExpre.LAST_MODIFI_DATE||''',''DD/MM/YYYY HH24:MI:SS''),';
        sql_objType := rcGetConfExpre.OBJECT_TYPE||''',';

    fileMgr := utl_file.fopen('/smartfiles/Construcciones/','ActualizaRegla_'||nuConfExpreId||'.sql','w');

    ut_string.extstring(sql_expression,',',tbstring);

	
sbentrega_1:='/******************************************************************
Propiedad intelectual de Open International Systems Copyright 2001
Archivo     insGR_CONFIG_EXPRESSION_<AAAAMMDD>.sql
Autor       <Nombre autor>
Fecha       <AAAAMMDD>

Descripción
Observaciones

Historia de Modificaciones
Fecha         Autor               Modificación
<AAAAMMDD>  <Nombre Autor>              Creación
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
									 AND  f.constraint_type = ''P''
									 AND  f.table_name      = ''GR_CONFIG_EXPRESSION''
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

  dbms_output.put_line(''Inicia Proceso ''||sysdate);
  IdConfExpre := '|| nuConfExpreId ||';

  dbms_output.put_line(''Insertando Regla: ''||IdConfExpre);

  --INICIO Busca regla para realizar los ajustes correspondientes�
  dbms_output.put_line(''Inicia Proceso ajustes regla'');  
	open cuNum(IdConfExpre);
	  loop
		fetch cuNum INTO nuCodigo, sbObjeto;
		exit when cuNum%NOTFOUND;
		dbms_output.put_line(''Registro --> ''||nuCodigo);

		blExiste := FALSE;
		open cuRef;
		loop
		  fetch cuRef INTO sbTabla, sbCampo;
		  exit when cuRef%NOTFOUND ;

		  sbStatement := '' Begin SELECT count(1) INTO :x FROM ''||sbTabla||
						 '' Where ''||sbCampo ||''=''||nuCodigo ||'' AND ROWNUM=1;End;'';

		  execute immediate sbStatement using out nuCant;
		  if ( nuCant > 0 ) then
			dbms_output.put_line('' [''||nuCodigo ||''] Existe  en [''||sbTabla ||''] ''||sbCampo);
			blExiste  := true;
		  END if;
		END loop;
		close cuRef;
		if blExiste then
		  BEGIN
			sbObjetoEliminar := dagr_config_expression.fsbGetobject_name(nuCodigo);
			dbms_output.put_line(''drop objeto ''||sbObjetoEliminar||'';'');
			if(sbObjeto = sbObjetoEliminar) then
				--cursor que busca el tipo de objeto
				Open cuTipoObjeto(sbObjetoEliminar);
				  fetch cuTipoObjeto
					into sbTipo;
				close cuTipoObjeto;
							
				--tipo = procedure o function
				sbStatement := '' drop '' || sbTipo || '' '' || sbObjetoEliminar;

				dbms_output.put_line(sbStatement);
				execute immediate (sbStatement);
			end if;	
		  Exception
			When Others then
			  dbms_output.put_line(''-- No Existe registro en gr_config_expression para ''||nuCodigo);
		  End;
		END if;

	  END loop;
	close cuNum;
	dbms_output.put_line(''Termine Proceso ajustes regla'');
	
	--FIN Busca regla para realizar los ajustes correspondientes
  

    UPDATE GR_CONFIG_EXPRESSION
	set expression = ''';
	--pone la sql_expression en el archivo
	sbautor := ' author = ''' || sql_author || '';
	--pone el sql_author en el archivo
	sbFecGen := 'generation_date = ' || sql_GenDate;
	--pone el sql_GenDate en el archivo
	sbFecMod := 'last_modifi_date = '|| sql_lastModif;
	--pone el sql_lastModif en el archivo
	sbTipoObj := 'object_type = ''' || sql_objType || '';
	--pone el sql_objType en el archivo
	sbCodigo := 'code = ''' || sbcode ;
	--pone code en el archivo
	
    sbentrega_2:= ' where config_expression_id = ' || nuConfExpreId || ';

    dbms_output.put_line(''Regenerando Regla: ''||IdConfExpre);

    -- Recorre la regla insertada para regenerarla
    for reg in cuData(IdConfExpre) loop
    BEGIN

        GR_BOINTERFACE_BODY.GenerateRule (reg.expression, reg.configura_type_id,
                            reg.description, reg.config_expression_id, onuExprId, reg.object_type);
        GR_BOINTERFACE_BODY.CreateStprByConfExpreId(onuExprId);
        dbms_output.put_line(''Expresion Generada = ''||onuExprId);

        nuProc := nuProc + 1;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                 nuCountErr := nuCountErr + 1;
                 Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr(''ExprId = ''||reg.config_expression_id||'', Err : ''||nuErrorCode||'', ''||sbErrorMsg,1,250));

            when others then
                 nuCountErr := nuCountErr + 1;
                 Errors.setError;
                        Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr(''ExprId = ''||reg.config_expression_id||'', Err : ''||nuErrorCode||'', ''||sbErrorMsg,1,250));

    END;

    END loop;
    dbms_output.put_line(''Termina regenerar Regla: ''||IdConfExpre);

    --<INSERT_TABLA> o <UPDATE_TABLA>

    commit;

    dbms_output.put_line(''Fin Proceso ''||sysdate);
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        rollback;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line(''ERROR CONTROLLED '');
        dbms_output.put_line(''error onuErrorCode: ''||nuErrorCode);
        dbms_output.put_line(''error osbErrorMess: ''||sbErrorMsg);

    when OTHERS then
        rollback;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line(''ERROR OTHERS '');
        dbms_output.put_line(''error onuErrorCode: ''||nuErrorCode);
        dbms_output.put_line(''error osbErrorMess: ''||sbErrorMsg);
END;';	
	
    utl_file.put_line(filemgr,sbentrega_1, true);
    --utl_file.put(fileMgr,sql_ins);

    FOR i IN 1..tbstring.count
    LOOP
          if i<> tbstring.count then
            if (i= tbstring.first) then
              utl_file.put(fileMgr,tbstring(i)||',');
            else
              if i<> (tbstring.count-1) then
                utl_file.put(fileMgr,tbstring(i)||','||'''||'||chr(10)||'''');

              else
                utl_file.put(fileMgr,tbstring(i)||',');
              END if;
            END if;
          else
            utl_file.put(fileMgr,tbstring(i));
          END if;
    END LOOP;

    utl_file.put_line(filemgr,sbautor, true);
    utl_file.put_line(filemgr,sbfecgen, true);
    utl_file.put_line(filemgr,sbfecmod, true);    
    utl_file.put_line(filemgr,sbtipoobj, true);
    utl_file.put_line(fileMgr,sbCodigo||'''', true);
	
    --utl_file.put_line(fileMgr,sbCode||'''');
	
    utl_file.put_line(fileMgr,sbentrega_2, TRUE);
    utl_file.put_line(fileMgr,'/', TRUE);
    utl_file.fclose(fileMgr);

    END loop;

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
