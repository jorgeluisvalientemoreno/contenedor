CREATE OR REPLACE PROCEDURE prArmaEntregaReglas(inuConfig_id    gr_config_expression.config_expression_id%type,
                                                inuNombTabla    varchar2,
                                                inuidRegistro   number )
AS
    type tycol_names IS table of varchar2(100) index BY binary_integer;
    CURSOR cugr_config_expression(inuConfig_id  gr_config_expression.config_expression_id%type) IS
    SELECT *
    FROM gr_config_expression
    WHERE config_expression_id = inuConfig_id;
    
    sbllaveprimaria         varchar2(100);
    sbCamposTabla           varchar2(100);
    gsbst                   varchar2(3000);
    rcgr_config_expression  gr_config_expression%rowtype;
    --------------------------------------------------------------------------------------
    PROCEDURE GeneraInsertTabla(isbNombreTabla    varchar2,inuidRegistro   number ) IS
        sbStatement varchar2(3000);
    BEGIN
        sbStatement :=  'declare'||chr(10)||
                            'tbcol_names        tycol_names;'||chr(10)||
                            'sbLlaveprimaria    varchar2(100);'||chr(10)||
                            'rcregistro         '||isbNombreTabla||'%rowtype;'||chr(10)||
                        'begin '||chr(10)||
                            'select column_name INTO sbLlaveprimaria FROM USER_CONSTRAINTS a, USER_CONS_COLUMNS b'||chr(10)||
                            'where a.table_name = b.table_name'||chr(10)||
                            'and constraint_type = ''P'''||chr(10)||
                            'and a.constraint_name = b.constraint_name'||chr(10)||
                            'and a.table_name = '''||isbNombreTabla||''';'||chr(10)||
                            'SELECT column_name bulk collect INTO tbcol_names FROM user_tab_columns WHERE table_name = '||isbNombreTabla||';'||chr(10)||
                            'if tbcol_names.first IS null then '||chr(10)||
                            '   dbms_output.put_Line(''ERROR NO EXISTE LA TABLA INGRESADA'')'||chr(10)||
                            '   RETURN;'||chr(10)||
                            'END if;'||chr(10)||
                            'select * INTO rcregistro FROM '||isbNombreTabla||' WHERE sbLlaveprimaria='||inuidRegistro||';'||chr(10)||
                            'if fblExiste('||isbNombreTabla||','||inuidRegistro||')'||chr(10)||
                            '   sbst := UPDATE '||isbNombreTabla||'set '||chr(10)||
                            '   for nuidx in tbcol_names.first .. tbcol_names.last loop'||chr(10)||
                            '       sbst := sbst||tbcol_names(nuidx)||''=''||rcregistro.||tbcol_names(nuidx);'||chr(10)||
                            '   END loop;'||chr(10)||
                            '   sbst := sbst||''where ''||sbLlaveprimaria||''=''inuidRegistro'||chr(10)||
                            'else '||chr(10)||
                            '   sbst := INSERT INTO '||isbNombreTabla||' VALUES '||chr(10)||
                            '   for nuidx in tbcol_names.first .. tbcol_names.last loop'||chr(10)||
                            '       sbst := sbst||rcregistro.||tbcol_names(nuidx);'||chr(10)||
                            '   END loop;'||chr(10)||
                            '   sbst := sbst||''where ''||sbLlaveprimaria||''=''inuidRegistro'||chr(10)||
                            'end if;'||chr(10)||
                            --'dbms_output.put_line(sbst) '||chr(10)||
                            'gsbst := sbst'||chr(10)||
                        'end;';
        execute immediate sbStatement;
    END;
    --------------------------------------------------------------------------------------
BEGIN
    -- Si el CURSOR esta abierto lo cierra
    if cugr_config_expression%isopen then
        close cugr_config_expression;
    END if;
    
    -- Abre cursor
    open cugr_config_expression(inuConfig_id);
    -- Obtiene regla
    fetch cugr_config_expression INTO rcgr_config_expression;
    -- Cierra cursor
    close cugr_config_expression;
    
    -- Si no encontro regla termina
    if rcgr_config_expression.config_expression_id IS null then
        dbms_output.put_Line('ERROR: NO SE ENCONTRO REGISTRO DE REGLA EN GR_CONFIG_EXPRESSION');
        return;
    END if;

    dbms_output.put_Line('-- Inicia Entrega');
    dbms_output.put_Line('declare ');
    dbms_output.put_Line('  onuExprId       gr_config_expression.config_expression_id%type := NULL;');
    dbms_output.put_Line('--------------------------------------------------------------------------------------');
    dbms_output.put_Line('--------------------------------------------------------------------------------------');
    dbms_output.put_Line('FUNCTION fblExiste(inuNombTabla    varchar2,inuidRegistro   number ) RETURN BOOLEAN IS');
    dbms_output.put_Line('    sbStatement varchar2(3000);');
    dbms_output.put_Line('    nuCount     number;');
    dbms_output.put_Line('BEGIN');
    dbms_output.put_Line('    sbStatement := ''select count(1) FROM''||inuNombTabla;');
    dbms_output.put_Line('    execute immediate sbStatement INTO nuCount;');
    dbms_output.put_Line('    if nuCount > 0 then');
    dbms_output.put_Line('        return TRUE;');
    dbms_output.put_Line('    else');
    dbms_output.put_Line('      return FALSE;');
    dbms_output.put_Line('    END if;');
    dbms_output.put_Line('END;');
    dbms_output.put_Line('--------------------------------------------------------------------------------------');
    dbms_output.put_Line('begin');
    dbms_output.put_Line('  if fblexiste(''GR_CONFIG_EXPRESSION'''||','||inuidRegistro||') then');
    dbms_output.put_Line('      UPDATE gr_config_expression SET configura_type_id = '||rcgr_config_expression.configura_type_id||',');
    dbms_output.put_Line('                                      expression = '''||rcgr_config_expression.expression||''',');
    dbms_output.put_Line('                                      author = '''||rcgr_config_expression.author||''',');
    dbms_output.put_Line('                                      creation_date = '''||rcgr_config_expression.creation_date||''',');
    dbms_output.put_Line('                                      generation_date = '''||rcgr_config_expression.generation_date||''',');
    dbms_output.put_Line('                                      last_modifi_date = '''||rcgr_config_expression.last_modifi_date||''',');
    dbms_output.put_Line('                                      status = '''||rcgr_config_expression.status||''',');
    dbms_output.put_Line('                                      used_other_expresion = '''||rcgr_config_expression.used_other_expresion||''',');
    dbms_output.put_Line('                                      modification_type = '''||rcgr_config_expression.modification_type||''',');
    if rcgr_config_expression.password IS not null then
        dbms_output.put_Line('                                      password = '''||rcgr_config_expression.password||''',');
    END if;
    dbms_output.put_Line('                                      execution_type = '''||rcgr_config_expression.execution_type||''',');
    if rcgr_config_expression.description IS not null then
        dbms_output.put_Line('                                      description = '''||rcgr_config_expression.description||''',');
    END if;
    dbms_output.put_Line('                                      object_name = '''||rcgr_config_expression.object_name||''',');
    if rcgr_config_expression.object_type IS not null then
        dbms_output.put_Line('                                      object_type = '''||rcgr_config_expression.object_type||'''');
    END if;
    if rcgr_config_expression.code IS not null then
        dbms_output.put_Line('                                      ,code = '''||rcgr_config_expression.code||'''');
    END if;
    
    dbms_output.put_Line('      WHERE config_expression_id = '||rcgr_config_expression.config_expression_id||';');
    dbms_output.put_Line('  else ');
    dbms_output.put_Line('      INSERT INTO gr_config_expression (config_expression_id,configura_type_id,expression,');
    dbms_output.put_Line('                                          author,creation_date,generation_date,last_modifi_date,status,');
    dbms_output.put_Line('                                          used_other_expresion,modification_type,');
    dbms_output.put_Line('                                          password,execution_type,description,object_name,object_type,code');
    dbms_output.put_Line('                                          ) VALUES ('||rcgr_config_expression.config_expression_id||',');
    dbms_output.put_Line('                                                        '||rcgr_config_expression.configura_type_id||',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.expression||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.author||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.creation_date||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.generation_date||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.last_modifi_date||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.status||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.used_other_expresion||''',');
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.modification_type||''',');
    if rcgr_config_expression.password IS null then
        dbms_output.put_Line('                                                        NULL,');
    else
        dbms_output.put_Line('                                                        '''||rcgr_config_expression.password||''',');
    END if;
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.execution_type||''',');
    if rcgr_config_expression.description IS null then
        dbms_output.put_Line('                                                        NULL,');
    else
        dbms_output.put_Line('                                                        '''||rcgr_config_expression.description||''',');
    END if;
    dbms_output.put_Line('                                                        '''||rcgr_config_expression.object_name||''',');
    if rcgr_config_expression.object_type IS null then
        dbms_output.put_Line('                                                        NULL,');
    else
        dbms_output.put_Line('                                                        '''||rcgr_config_expression.object_type||''',');
    END if;
    if rcgr_config_expression.code IS null then
        dbms_output.put_Line('                                                        NULL');
    else
        dbms_output.put_Line('                                                        '''||rcgr_config_expression.code||''');');
    END if;
    dbms_output.put_Line('  END if;');
return;
    -- Genera insercion a tabla con la regla
    GeneraInsertTabla(inuNombTabla,inuidRegistro);
    dbms_output.put_Line(gsbst);
    
    -- Regenera regla
    dbms_output.put_Line('GR_BOINTERFACE_BODY.GenerateRule ('||rcgr_config_expression.expression||',');
    dbms_output.put_Line('                                  '||rcgr_config_expression.configura_type_id||',');
    dbms_output.put_Line('                                  '||rcgr_config_expression.description||',');
    dbms_output.put_Line('                                  '||rcgr_config_expression.config_expression_id||',onuExprId,');
    dbms_output.put_Line('                                  '||rcgr_config_expression.object_type||');');
    dbms_output.put_Line('GR_BOINTERFACE_BODY.CreateStprByConfExpreId(onuExprId);');
    dbms_output.put_Line('EXCEPTION');
    dbms_output.put_Line('    when others then');
    dbms_output.put_Line('        dbms_output.put_Line(''ERROR: ''||SQLERRM);');
    dbms_output.put_Line('    raise');
    dbms_output.put_Line('end;');
EXCEPTION
    when others then
        dbms_output.put_Line('ERROR: '||SQLERRM);
        raise;
END;
/
