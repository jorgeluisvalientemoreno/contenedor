PL/SQL Developer Test script 3.0
104
-- Created on 29/12/2022 by JORGE VALIENTE 
declare 

ircOrder        daor_order.styOR_order;
        inuOperUnitId   OR_operating_unit.operating_unit_id%type :=4282;

        sbValidAssign           varchar2(1);
        nuProjectId             pm_project.project_id%type;

        -- Validad si la unidad puede es valida para asignacion de la orden por Capacidad
        CURSOR cuValidOperUnitAssign_C
        IS
            SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                 or_boconstants.csbSI
            FROM ge_sectorope_zona, or_operating_unit, or_oper_unit_status,
                 or_ope_uni_task_type
                  /*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_operating_unit.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
              AND or_operating_unit.operating_unit_id = inuOperUnitId
              AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
              AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
              AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        )
              AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId)
              = or_boconstants.csbSI;

        -- Validad si la unidad puede es valida para asignacion de la orden por demanda
        CURSOR cuValidOperUnitAssign_D
        IS
            SELECT /*+ ordered
                       index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                       index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                       index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                       index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS )
                       index(OR_OPE_UNI_TASK_TYPE PK_OR_OPE_UNI_TASK_TYPE ) */
                 or_boconstants.csbSI
            FROM ge_sectorope_zona, or_zona_base_adm, or_operating_unit, or_oper_unit_status,
                 or_ope_uni_task_type
                  /*+ OR_BCOperUnit_Admin.fsbValidOperUnitAssign SAO168500 */
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
              AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_ope_uni_task_type.operating_unit_id = or_operating_unit.operating_unit_id
              AND or_operating_unit.operating_unit_id = inuOperUnitId
              AND or_ope_uni_task_type.task_type_id = ircOrder.task_type_id
              AND ge_sectorope_zona.id_sector_operativo = ircOrder.operating_sector_id
              AND or_oper_unit_status.valid_for_assign = or_boconstants.csbSI
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        )
              AND OR_BcActividad_Unitrab.fsbIsValidActOrder(ircOrder.order_id,inuOperUnitId)
              = or_boconstants.csbSI;
    BEGIN
        ircOrder := DAOR_ORDER.FRCGETRECORD(263385692);

        dbms_output.put_line('INICIO - OR_BCOperUnit_Admin.fsbValidOperUnitAssign');

        sbValidAssign := or_boconstants.csbNO;

        ut_trace.trace('ircOrder.stage_id := '||ircOrder.stage_id,12);
        --  se valida si la unidad esta asociada al proyecto
        if ( ircOrder.stage_id IS not null ) then

            -- Obtengo el identificador del proyecto
            nuProjectId := dapm_stage.fnuGetProject_id( ircOrder.stage_id );

            dbms_output.put_line('nuProjectId := '||nuProjectId);

            if not dapm_unit_by_project.fblexist(nuProjectId,inuOperUnitId) then
                dbms_output.put_line('sbValidAssign: '|| sbValidAssign);
            END if;
        END if;

        -- Se valida si la unidad trabaja sobre el sector de la orden por Capacidad
        open    cuValidOperUnitAssign_C;
        fetch   cuValidOperUnitAssign_C INTO sbValidAssign;
        close   cuValidOperUnitAssign_C;

        ut_trace.trace('Asigna por Capacidad :'||sbValidAssign,12);
        -- Si la unidad de trabajo no trabaja por Capacidad se analiza si trabaja por demanda
        IF sbValidAssign = or_boconstants.csbNO THEN

        -- Se valida si la unidad trabaja sobre el sector de la orden por demanda
        open    cuValidOperUnitAssign_D;
        fetch   cuValidOperUnitAssign_D INTO sbValidAssign;
        close   cuValidOperUnitAssign_D;
        dbms_output.put_line('Asigna por Demanda :'||sbValidAssign);
        END IF;

        dbms_output.put_line('FIN - OR_BCOperUnit_Admin.fsbValidOperUnitAssign');

        dbms_output.put_line('sbValidAssign: '||sbValidAssign);
  
end;
0
0
