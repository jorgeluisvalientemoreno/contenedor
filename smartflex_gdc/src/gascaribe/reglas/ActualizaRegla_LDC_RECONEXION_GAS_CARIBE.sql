/******************************************************************
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
DECLARE
    CURSOR cugetrule IS
		select Config_Expression_id idconfexpre
		from gr_Config_Expression
		where description like 'LDC_RECONEXION_GAS_CARIBE'
		and configura_type_id = 591;

    CURSOR cudata (
        nuidconfexpre   IN              gr_config_expression.config_expression_id%TYPE
    ) IS
    -- Se obtiene la lista de expresiones a regenerar
    SELECT
        ROWID,
        config_expression_id,
        configura_type_id,
        object_name,
        expression,
        object_type,
        description,
        status
    FROM
        gr_config_expression
    WHERE
        config_expression_id IN (
            nuidconfexpre
        );

    onuexprid          gr_config_expression.config_expression_id%TYPE := NULL;
    nucounterr         NUMBER := 0;
    nuproc             NUMBER := 0;
    nuerrorcode        NUMBER(15);
    sberrormsg         VARCHAR2(2000);
    idconfexpre        gr_config_expression.config_expression_id%TYPE;
    CURSOR curef IS
    SELECT
        a.table_name,
        b.column_name
    FROM
        all_constraints    a,
        all_cons_columns   b
    WHERE
        r_constraint_name = (
            SELECT UNIQUE
                ( f.constraint_name )
            FROM
                all_constraints    f,
                all_cons_columns   s
            WHERE
                f.constraint_name = s.constraint_name
                AND f.constraint_type = 'P'
                AND f.table_name = 'GR_CONFIG_EXPRESSION'
        )
        AND a.constraint_name = b.constraint_name
        AND a.owner = b.owner
        AND a.table_name = b.table_name;

    sbstatement        VARCHAR2(2000);
    blexiste           BOOLEAN := false;
    nucant             NUMBER;
    nucodigo           NUMBER := 1296;
    sbtabla            VARCHAR2(50);
    sbcampo            VARCHAR2(50);
    CURSOR cunum (
        inuconfexpreid   IN               gr_config_expression.config_expression_id%TYPE
    ) IS
    SELECT
        config_expression_id   codigo,
        object_name            objeto
    FROM
        gr_config_expression
    WHERE
        config_expression_id IN (
            inuconfexpreid
        );

    CURSOR cutipoobjeto (
        isbnomobj   IN          gr_config_expression.object_name%TYPE
    ) IS
    SELECT
        object_type
    FROM
        dba_objects
    WHERE
        object_name = isbnomobj;

    sbobjetoeliminar   gr_config_expression.object_name%TYPE;
    sbobjeto           gr_config_expression.object_name%TYPE;
    sbtipo             dba_objects.object_type%TYPE;
BEGIN
    dbms_output.put_line('Inicia Proceso ' || SYSDATE);
    FOR rcRegl IN cugetrule LOOP
        --FETCH cugetrule INTO idconfexpre;
        --CLOSE cugetrule;
        dbms_output.put_line('Actualizando Regla: ' || rcRegl.idconfexpre);

        --INICIO Busca regla para realizar los ajustes correspondientesç
        dbms_output.put_line('Inicia Proceso ajustes regla');
        OPEN cunum(rcRegl.idconfexpre);
        LOOP
            FETCH cunum INTO
                nucodigo,
                sbobjeto;
            EXIT WHEN cunum%notfound;
            dbms_output.put_line('Registro --> ' || nucodigo);
            blexiste := false;
            OPEN curef;
            LOOP
                FETCH curef INTO
                    sbtabla,
                    sbcampo;
                EXIT WHEN curef%notfound;
                sbstatement := ' Begin SELECT count(1) INTO :x FROM '
                               || sbtabla
                               || ' Where '
                               || sbcampo
                               || '='
                               || nucodigo
                               || ' AND ROWNUM=1;End;';

                EXECUTE IMMEDIATE sbstatement
                    USING OUT nucant;
                IF ( nucant > 0 ) THEN
                    dbms_output.put_line(' ['
                                         || nucodigo
                                         || '] Existe  en ['
                                         || sbtabla
                                         || '] '
                                         || sbcampo);

                    blexiste := true;
                END IF;

            END LOOP;

            CLOSE curef;
            IF blexiste THEN
                BEGIN
                    sbobjetoeliminar := dagr_config_expression.fsbgetobject_name(nucodigo);
                    dbms_output.put_line('drop objeto '
                                         || sbobjetoeliminar
                                         || ';');
                    IF ( sbobjeto = sbobjetoeliminar ) THEN
    				--cursor que busca el tipo de objeto
                        OPEN cutipoobjeto(sbobjetoeliminar);
                        FETCH cutipoobjeto INTO sbtipo;
                        CLOSE cutipoobjeto;

    				--tipo = procedure o function
                        sbstatement := ' drop '|| sbtipo|| ' '|| sbobjetoeliminar;
                        dbms_output.put_line(sbstatement);
                        EXECUTE IMMEDIATE ( sbstatement );
                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        dbms_output.put_line('-- No Existe registro en gr_config_expression para ' || nucodigo);
                END;
            END IF;

        END LOOP;

        CLOSE cunum;
        dbms_output.put_line('Termine Proceso ajustes regla');

    	--FIN Busca regla para realizar los ajustes correspondientes
        UPDATE gr_config_expression
        SET
            expression = 'GC_BOSUSPREMRECONORD.GETPRODUCTID(producto);suspendido = FNUVALSUSPENPRODUCT(producto, 2);if (suspendido >= 1,nuContrato = PR_BOPRODUCT.GETSUBSCRIPTIONID(producto);if (CC_BORESTRICTION.FBLEXISTRESTBYPACKTYPE(nuContrato, null, null, 300) = TRUE,REVRECONPRODUCT(producto);,GENERATEPACKAGEUTILITIES(););,)'
            ,
            last_modifi_date = TO_DATE(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'),
            code = NULL
        WHERE
            config_expression_id = rcRegl.idconfexpre;

        dbms_output.put_line('Regenerando Regla: ' || idconfexpre);

        -- Recorre la regla insertada para regenerarla
        FOR reg IN cudata(rcRegl.idconfexpre) LOOP BEGIN
            gr_bointerface_body.generaterule(reg.expression, reg.configura_type_id, reg.description, reg.config_expression_id, onuexprid
            , reg.object_type);

            gr_bointerface_body.createstprbyconfexpreid(onuexprid);
            dbms_output.put_line('Expresion Generada = ' || onuexprid);
            nuproc := nuproc + 1;
        EXCEPTION
            WHEN ex.controlled_error THEN
                nucounterr := nucounterr + 1;
                errors.geterror(nuerrorcode, sberrormsg);
                dbms_output.put_line(substr('ExprId = '
                                            || reg.config_expression_id
                                            || ', Err : '
                                            || nuerrorcode
                                            || ', '
                                            || sberrormsg, 1, 250));

            WHEN OTHERS THEN
                nucounterr := nucounterr + 1;
                errors.seterror;
                errors.geterror(nuerrorcode, sberrormsg);
                dbms_output.put_line(substr('ExprId = '
                                            || reg.config_expression_id
                                            || ', Err : '
                                            || nuerrorcode
                                            || ', '
                                            || sberrormsg, 1, 250));

        END;
        END LOOP;
        dbms_output.put_line('Termina regenerar Regla: ' || rcRegl.idconfexpre);
    END LOOP; -- Termina todas las reglas



    COMMIT;
    
    dbms_output.put_line('Fin Proceso ' || SYSDATE);
EXCEPTION
    WHEN ex.controlled_error THEN
        ROLLBACK;
        errors.geterror(nuerrorcode, sberrormsg);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormsg);
    WHEN OTHERS THEN
        ROLLBACK;
        errors.seterror;
        errors.geterror(nuerrorcode, sberrormsg);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: ' || nuerrorcode);
        dbms_output.put_line('error osbErrorMess: ' || sberrormsg);
END;
/