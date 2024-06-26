/*
    Propiedad intelectual de Open International Systems. (c).

    Unidad      : AnalisisImpactoTiposUnidadWF.sql

    Descripcion  : Realiza la busqueda de los flujos y procesos dinámicos para
                  los cuales un tipo de unidad () esta siendo utilizado.
                  
    Parametros Entrada: Recibe el idnentificador de Tipo de Unidad

    Autor      : Andrés Felipe Valencia Arango
    Fecha      : 03-01-2013

    Historia de Modificaciones
    Fecha       Entrega

    21-01-2013  asamboni   Mejoras al proceso
    03-01-2013  afvalencia SAO198954
    Creacion
*/
ALTER SESSION SET CURRENT_SCHEMA= OPEN;
DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    nuIndex binary_integer;
    nuUnitType  number;
    nuParentUnitId number;
    type tytbUnitTypeId IS table of number index BY binary_integer;
    tbUnitTypeId tytbUnitTypeId;
    nuParentId2  wf_unit.unit_id%type;
    
    nuTipoUnidad  wf_instance.unit_type_id%type;

    -----------tramite    
    CURSOR cuTramitexFlujo(Inuunit_type_id number) is 
           select ppu.package_type_id ||' - '|| ppt.description Tramite
             from ps_package_unittype ppu, ps_package_type ppt
            where ppu.unit_type_id = Inuunit_type_id
              and ppu.package_type_id = ppt.package_type_id;

    rfcuTramitexFlujo cuTramitexFlujo%rowtype;          
    ----------------------

    --------Regla actividad del flujo
    CURSOR cuReglaActividad(Inuunit_type_id number, InuFlujo number) is    
      SELECT gce.config_expression_id Codigo, gce.description Descripcion, gce.code Procedimiento
        FROM wf_unit wu, ge_action_module gam, gr_config_expression gce
       WHERE wu.unit_type_id = Inuunit_type_id       
       and wu.unit_id = InuFlujo
         and wu.action_id = gam.action_id
         and gam.config_expression_id = gce.config_expression_id; 
   
    rfcuReglaActividad cuReglaActividad%rowtype;                 
    -----------------------------------------------

    CURSOR cuProcess (nuTipoUnidad number)
    is
        SELECT * FROM wf_unit WHERE unit_type_id = nuTipoUnidad; -- Tipos de Unidad

    CURSOR cuProcssDinam2
        (
            inuUnitTypeId   in      wf_unit_type.unit_type_id%type
        )
        IS
            SELECT /*+ index (a IDX_PS_PROCESS_COMPTYPE02)  */
            c.process_id, a.component_type_id, a.motive_type_id, a.active
            FROM ps_process_comptype a, wf_unit_type b, wf_unit c
            WHERE a.unit_type_id = inuUnitTypeId
            AND a.stage_tag_name = b.tag_name
            AND b.unit_type_id = c.unit_type_id;

    CURSOR PadresNulos2
            (
                inuUnitTypeId   in      wf_unit_type.unit_type_id%type
            )
            IS
                SELECT process_id FROM wf_unit WHERE unit_type_id = inuUnitTypeId AND process_id IS not null;

    PROCEDURE ProcessPincipal
    (
        inuProcessId    in  wf_unit.unit_id%type
    )
    IS
        nuParentId  wf_unit.unit_id%type;
        nuCategory  wf_unit_type.category_id%type;
        nuUnitType  wf_unit_type.unit_type_id%type;

        CURSOR cuProcssDinam
        (
            inuUnitTypeId   in      wf_unit_type.unit_type_id%type
        )
        IS
            SELECT /*+ index (a IDX_PS_PROCESS_COMPTYPE02)  */
            c.process_id, a.component_type_id, a.motive_type_id, a.active
            FROM ps_process_comptype a, wf_unit_type b, wf_unit c
            WHERE a.unit_type_id = inuUnitTypeId
            AND a.stage_tag_name = b.tag_name
            AND b.unit_type_id = c.unit_type_id;

        CURSOR PadresNulos
            (
                inuUnitTypeId   in      wf_unit_type.unit_type_id%type
            )
            IS
                SELECT /*+ index (wf_unit IDX_WF_UNIT_03) */
                process_id
                FROM wf_unit
                WHERE unit_type_id = inuUnitTypeId AND process_id IS not null;

        CURSOR cuProcessType
        (
            inuProcessId    in  wf_unit.unit_id%type
        )
        is
            SELECT b.category_id, b.unit_type_id, a.process_id padre
            FROM wf_unit a, wf_unit_type b
            WHERE a.unit_id = inuProcessId AND a.unit_type_id = b.unit_type_id;

    BEGIN
        open cuProcessType(inuProcessId);
        fetch cuProcessType INTO nuCategory,nuUnitType,nuParentId;
        close cuProcessType;
        --dbms_output.put_Line('inuProcessId '||inuProcessId);
        --dbms_output.put_Line('nuCategory '||nuCategory);
        --dbms_output.put_Line('nuUnitType '||nuUnitType);
        --dbms_output.put_Line('nuParentId '||nuParentId);
        if nuCategory = 3 then
            if not tbUnitTypeId.exists(nuUnitType) then
                tbUnitTypeId(nuUnitType) := nuUnitType;
            END if;
        elsif nuCategory!=3 AND nuCategory IS not null then
            if nuParentId IS not null then
                ProcessPincipal(nuParentId);
            else
                --dbms_output.put_Line('Tipo Unidad '||nuUnitType);
                for rcProcssDinam in cuProcssDinam(nuUnitType) loop
                    nuParentId:= rcProcssDinam.process_id;
                    if nuParentId IS not null then
                        dbms_output.put_Line('Proceso dinámico [Tipo de Componente :['||rcProcssDinam.component_type_id||' Tipo de Motivo:'||rcProcssDinam.motive_type_id||' Activo:'||rcProcssDinam.active||']');
                        --dbms_output.put_Line('Proceso Dinamico '||nuParentId);
                        ProcessPincipal(nuParentId);
                    END if;
                END loop;
                for rcPadresNulos in PadresNulos(nuUnitType) loop
                    nuParentId:= rcPadresNulos.process_id;
                    if nuParentId IS not null then
                        ProcessPincipal(nuParentId);
                    END if;
                END loop;
            END if;
        END if;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;


BEGIN                         -- ge_module
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(10);
    ut_trace.Trace('INICIO');

    tbUnitTypeId.delete;
    
    nuTipoUnidad := &nuTipoUnidad;

    for rcProcess in cuProcess (nuTipoUnidad) loop
        if rcProcess.process_id IS not null then
            ProcessPincipal(rcProcess.process_id);
        else
            for rcProcssDinam in cuProcssDinam2(rcProcess.unit_type_id) loop
                nuParentId2:= rcProcssDinam.process_id;
                if nuParentId2 IS not null then
                    dbms_output.put_Line('Proceso dinámico [Tipo de Componente:'||rcProcssDinam.component_type_id||' Tipo de Motivo:'||rcProcssDinam.motive_type_id||' Activo:'||rcProcssDinam.active||']');
                    --dbms_output.put_Line('Proceso Dinamico '||nuParentId);
                    ProcessPincipal(nuParentId2);
                END if;
            END loop;
            for rcPadresNulos in PadresNulos2(rcProcess.unit_type_id) loop
                nuParentId2:= rcPadresNulos.process_id;
                if nuParentId2 IS not null then
                    ProcessPincipal(nuParentId2);
                END if;
            END loop;
        END if;
    END loop;

    nuIndex := tbUnitTypeId.first;
    while nuIndex IS not null loop
        nuUnitType:=tbUnitTypeId(nuIndex);
        nuParentUnitId:=dawf_unit_type.fnugetparent_id(nuUnitType);
        dbms_output.put_Line('Flujo-['||nuUnitType||'-'||dawf_unit_type.fsbgetdescription(nuUnitType)||']Carpeta-['||dawf_unit_type.fsbgetdescription(nuParentUnitId)||']');
        ------Regla ascoiada a la unidad del flujo
        --dbms_output.put_Line('nuTipoUnidad['|| nuTipoUnidad ||'],nuUnitType['|| nuUnitType ||']');        
        for rfcuReglaActividad in cuReglaActividad(nuTipoUnidad,nuUnitType) loop
                  dbms_output.put_Line('     Regla-['||rfcuReglaActividad.Codigo||' - '||rfcuReglaActividad.Descripcion || ' - ' ||rfcuReglaActividad.Procedimiento||']');
        end loop;        
        ----------------------------------------------
        ------Tramite asociado al flujo
        for rfcuTramitexFlujo in cuTramitexFlujo(nuUnitType) loop
                  dbms_output.put_Line('          Tramite-['||rfcuTramitexFlujo.tramite||']');
        end loop;        
        ----------------------------------------------
        nuIndex := tbUnitTypeId.next(nuIndex);
        dbms_output.put_Line('');
    END loop;

    if nvl(nuErrorCode,0) <> 0 then
      dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
      dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);
    end if;


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
