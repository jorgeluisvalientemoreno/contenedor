CREATE OR REPLACE PROCEDURE adm_person.ldc_practualizaotesdoc(inuidorder      IN or_order.order_id%TYPE,
                                                              inucurrent      IN NUMBER,
                                                              inutotal        IN NUMBER,
                                                              onuerrorcode    OUT NUMBER,
                                                              osberrormessage OUT VARCHAR) 
IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).
    
    Unidad         : LDC_PRACTUALIZAOTESDOC
    Descripcion    : Procedimiento para actulizar los estados de documentos de las OTs
    Autor          : Sebastian Tapias
    Fecha          : 30/07/2017
    
    Parametros              Descripcion
    ============         ===================
    
    Fecha             Autor                 Modificacion
    =========       =========              ====================
    16/04/2024      PAcosta                OSF-2532: Se crea el objeto en el esquema adm_person  
    26/10/2020	    OLSOFTWARE			   Se elimina la validación que tiene en cuenta el estado “AR” para pasar al estado archivado
                                           ya que este proceso ya no se tendrá en cuenta y no se podrá seleccionar del campo “Nuevo Estado”.
  ******************************************************************/
    
    --Variables Generales
    cnunull_attribute CONSTANT NUMBER := 2126;
    sboperating_unit_id   ge_boinstancecontrol.stysbvalue;
    sbstatus_docu         ge_boinstancecontrol.stysbvalue;
    sbexec_initial_date   ge_boinstancecontrol.stysbvalue;
    sblegalization_date   ge_boinstancecontrol.stysbvalue;
    sbtask_type_id        ge_boinstancecontrol.stysbvalue;
    sbappointment_confirm ge_boinstancecontrol.stysbvalue;
    sbnuevo_estado        ldc_docuorder.status_docu%TYPE;
    v_isbuser             ld_quota_block.username%TYPE;
    v_isbterminal         ld_quota_block.terminal%TYPE;
    sbuserdb              sa_user.MASK%TYPE;
    nuuser                sa_user.user_id%TYPE;
    sbuser                VARCHAR2(100);
    sbterminal            VARCHAR2(100);
    sbestadoant           VARCHAR2(2);
    
    -- Cursor para consultar el Usuario
    CURSOR cuconsultausuario(par1 sa_user.user_id%TYPE) IS
    SELECT substr(A.user_id || ' - ' || b.name_, 1, 100)
      FROM sa_user A, ge_person b
     WHERE A.user_id = par1
       AND b.user_id = A.user_id;
BEGIN

    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: Inicia Procedimiento', 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: inuIdOrder => ' || inuidorder, 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: inuCurrent => ' || inucurrent, 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: inuTotal => ' || inutotal, 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Asignacion de variables', 1);
    -- Obtenemos los datos de la forma
    sboperating_unit_id   := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',      'OPERATING_UNIT_ID');
    sbstatus_docu         := ge_boinstancecontrol.fsbgetfieldvalue('LDC_DOCUORDER', 'STATUS_DOCU');
    sbexec_initial_date   := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',      'EXEC_INITIAL_DATE');
    sblegalization_date   := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',      'LEGALIZATION_DATE');
    sbtask_type_id        := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',      'TASK_TYPE_ID');
    sbappointment_confirm := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER',      'APPOINTMENT_CONFIRM');
    
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbOPERATING_UNIT_ID (' ||
                 sboperating_unit_id || ')',
                 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbSTATUS_DOCU (' ||
                 sbstatus_docu || ')',
                 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbEXEC_INITIAL_DATE (' ||
                 sbexec_initial_date || ')',
                 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbLEGALIZATION_DATE (' ||
                 sblegalization_date || ')',
                 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbTASK_TYPE_ID (' ||
                 sbtask_type_id || ')',
                 1);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbAPPOINTMENT_CONFIRM (' ||
                 sbappointment_confirm || ')',
                 1);
    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    --Validamos que el nuevo estado no sea nulo (no puede ser nulo pues es el dato que se va a actualizar)
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Validacion de campos nulos', 1);
    IF (sbappointment_confirm IS NULL) THEN
    ut_trace.TRACE('LDC_FNCONSULTAOTESDOC : Estado Nuevo Nulo', 1);
    ERRORS.seterror(cnunull_attribute, 'Nuevo Estado');
    RAISE ex.controlled_error;
    END IF;
    
    sbnuevo_estado := to_char(sbappointment_confirm);
    ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : sbNUEVO_ESTADO (' ||
                 sbnuevo_estado || ')',
                 1);
    ------------------------------------------------
    -- User code
    ------------------------------------------------
    
    -- captura la mascara del usuario oracle
    sbuserdb := ut_session.getuser;
    -- si la mascara no es vacia averigua el id de conexion
    IF sbuserdb IS NOT NULL THEN
    nuuser := sa_bouser.fnugetuserid(sbuserdb);
    ut_trace.TRACE('Id Del usuario conectado:[' || sbuserdb || '] [' ||
                   nuuser || ']',
                   10);
    ELSE
    nuuser := sa_bouser.fnugetuserid(ut_session.getuser);
    ut_trace.TRACE('Corrige Id Del usuario conectado:[' || sbuserdb ||
                   '] [' || nuuser || ']',
                   10);
    END IF;
    -- con el id del usuario de la base de datos averiguamos el nombre del usuario
    -- nombre del usuario conectado
    IF nuuser > 0 THEN
    OPEN cuconsultausuario(nuuser);
    FETCH cuconsultausuario
      INTO sbuser;
    IF cuconsultausuario%notfound THEN
      sbuser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
    END IF;
    CLOSE cuconsultausuario;
    ELSE
    sbuser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
    END IF;
    
    sbterminal := au_bosystem.getsystemuserterminal;
    -- Asignamos a las nuevas variables
    v_isbuser     := sbuser;
    v_isbterminal := sbterminal;
    --Iniciamos logica principal
    
    BEGIN
        ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Obteniendo estado anterior de la orden',
                       1);
        --Se consulta el estado anterior de la orden
        SELECT status_docu
          INTO sbestadoant
          FROM ldc_docuorder
         WHERE order_id = inuidorder;
        ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Estado Anterior (' ||
                       sbestadoant || ')',
                       1);
        --Si el estado anterior es igual al nuevo mandamos error
        IF (sbestadoant = sbnuevo_estado) THEN
          ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: Anterior[' || sbestadoant ||
                         '] Nuevo [' || sbnuevo_estado || ']',
                         1);
          ERRORS.seterror(-1,
                          'Estado Actual y Nuevo Estado, No pueden ser iguales');
          RAISE ex.controlled_error;
        END IF;
        --Validamos los cambios permidos
        IF (sbnuevo_estado = 'EP') THEN
          IF (sbestadoant <> 'CO') THEN
            ERRORS.seterror(-1,
                            'Para pasar al estado [EN PODER DE LA EMPRESA], el documento debe estar en estado [EN PODER DE CONTRATISTA]');
            RAISE ex.controlled_error;
          ELSE
            -- Actualizamos el estado
            UPDATE ldc_docuorder
               SET status_docu = sbnuevo_estado, reception_date = sysdate
             WHERE order_id = inuidorder;
            ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Se agregara registro de auditoria',
                           1);
            -- Agregamos registros a la tabla de auditoria
            INSERT INTO ldc_audocuorder
              (usuario,
               terminal,
               fecha_cambio,
               order_id,
               estado_anterior,
               nuevo_estado)
            VALUES
              (v_isbuser,
               v_isbterminal,
               sysdate,
               inuidorder,
               sbestadoant,
               sbnuevo_estado);
            COMMIT;
          END IF;
        
          -- MODIFICACION CASO 522 --
        
        /* ELSIF (sbNUEVO_ESTADO = 'AR') THEN
          IF (sbEstadoAnt <> 'EP') THEN
            errors.seterror(-1,
                            'Para pasar al estado [ARCHIVADO], el documento debe estar en estado [EN PODER DE LA EMPRESA]');
            RAISE ex.CONTROLLED_ERROR;
          ELSE
            -- Actualizamos el estado
            UPDATE LDC_DOCUORDER
               SET status_docu = sbNUEVO_ESTADO, file_date = sysdate
             WHERE order_id = inuIdOrder;
            ut_trace.trace('LDC_PRACTUALIZAOTESDOC : Se agregara registro de auditoria',
                           1);
            -- Agregamos registros a la tabla de auditoria
            INSERT INTO LDC_AUDOCUORDER
              (usuario,
               terminal,
               fecha_cambio,
               order_id,
               estado_anterior,
               nuevo_estado)
            VALUES
              (v_isbUser,
               v_isbTerminal,
               sysdate,
               inuIdOrder,
               sbEstadoAnt,
               sbNUEVO_ESTADO);
            COMMIT;
          END IF;*/
        
          -- FIN MODIFICACION CASO 522 --
        
        END IF;
        
        ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC : Fin de actualizacion', 1);
    EXCEPTION
        WHEN ex.controlled_error THEN
            ROLLBACK;
            RAISE;
        WHEN OTHERS THEN
          ROLLBACK;
          ERRORS.seterror(-1, 'Error Actualizando Estado');
          RAISE ex.controlled_error;
    END;
    
ut_trace.TRACE('LDC_PRACTUALIZAOTESDOC: Finaliza Procedimiento', 1);
EXCEPTION
    WHEN ex.controlled_error THEN
        ROLLBACK;
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        onuerrorcode    := ld_boconstans.cnugeneric_error;
        osberrormessage := sqlerrm;
        RAISE;
END ldc_practualizaotesdoc;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRACTUALIZAOTESDOC
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PRACTUALIZAOTESDOC','ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre ldc_practualizaotesdoc para reportes
GRANT EXECUTE ON adm_person.ldc_practualizaotesdoc TO rexereportes;
/