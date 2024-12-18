create or replace procedure prJobAnulaSoliNego is
/*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: prJobAnulaSoliNego
    Descripcion: job que anula soliicitudes de negociacion marcadas para Anular
    Autor    : Luis Javier Lopez Barrios / Horbath
    Fecha    : 27/05/2022

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
	08-02-2023	cgonzalez (Horbath)		OSF-880: Se ajusta para anular/atender las inconsistencias y mensajes de error del flujo
	21-08-2024  jcatuche                OSF-3120: Se ajusta la lógica del procedimiento, implementandola mediante llamados a métodos 
                                        del paquete pkgManejoSolicitudes
                                        Se estandariza traza y manejo de errores
 ******************************************************************/ 
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    sbProceso               varchar2(100); 
    sbObservacion           MO_PACKAGE_CHNG_LOG.CURRENT_PROGRAM%type;
    nuPlanId number;
    nuerror number;
    sberror varchar2(4000);

    CURSOR cugetSoliPendanula IS
    SELECT package_id, CUST_CARE_REQUES_NUM
    FROM mo_packages, ldc_solinean
    WHERE package_id = solicitud
    and estado in ('P', 'E')
    and motive_status_id = 13
    ;
    
    cursor cuCantidSolPend is
    SELECT count(*)
    FROM mo_packages, ldc_solinean
    WHERE package_id = solicitud
    and estado in ('P', 'E')
    and motive_status_id = 13
    ;
    
    nutotalreg  number;
    
    cursor cuSoliAdicional (inupackage in number,isbcust_care_reques_num in varchar2) is
    select count(1) 
    from mo_packages
    where CUST_CARE_REQUES_NUM = isbcust_care_reques_num
    and package_id <> inupackage
    and package_type_id <> 268;

    inusolicitud number;
    NUSESION number;
    nuPlanIdInte number;
    nuCantSoli number;
  
begin
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    
    if cuCantidSolPend%isopen then
        close cuCantidSolPend;
    end if;
    
    open cuCantidSolPend;
    fetch cuCantidSolPend into nutotalreg;
    close cuCantidSolPend;
    
    sbProceso := 'PRJOBANULASOLINEGO_'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    sbObservacion := 'ANULADO POR VALIDACIÓN DE PLAN ESPECIAL';
  
    pkg_estaproc.prInsertaEstaproc(sbProceso,nutotalreg);
    
    for REG IN cugetSoliPendanula LOOP
        begin
        
            inusolicitud :=  reg.package_id;
            sberror := null;
            nuPlanId := null;
            nuPlanIdInte := null;
            
            --Anula solicitud
            pkg_traza.trace('Anulación solicitud: '|| inusolicitud, csbNivelTraza);
            pkgManejoSolicitudes.pAnnulRequest(inusolicitud,sbObservacion);

            -- Se obtiene el plan de wf
            nuPlanId := wf_boinstance.fnugetplanid(inusolicitud, 17);
            pkg_traza.trace('Obtiene plan de la solicitud: '||nuPlanId, csbNivelTraza);
            
            -- anula el plan de wf
            IF nuPlanId IS NOT NULL THEN
                pkg_traza.trace('Anular plan de wortflow: '||nuPlanId, csbNivelTraza);
                pkgManejoSolicitudes.prcAnulaFlujo(nuPlanId);
            END IF;
            
            --OSF-880
            pkg_traza.trace('Anular Error de wortflow', csbNivelTraza);
            pkgManejoSolicitudes.pAnnulErrorFlow(reg.package_id);
   
            --se valida si interaccion solo tiene asociada solicitud actual
            if cuSoliAdicional%isopen then 
                close cuSoliAdicional;
            end if;
            
            open cuSoliAdicional(reg.package_id,reg.CUST_CARE_REQUES_NUM);
            fetch cuSoliAdicional into nuCantSoli;
            close cuSoliAdicional;
            
            pkg_traza.trace('Cantidad de solicitudes adicionales: '||nuCantSoli, csbNivelTraza);
            
            IF nuCantSoli = 0 THEN
                --se anula interaccion
                pkg_traza.trace('Anulación interacción: '||reg.CUST_CARE_REQUES_NUM, csbNivelTraza);
                pkgManejoSolicitudes.pAnnulRequest(reg.CUST_CARE_REQUES_NUM,sbObservacion);
                
                -- Se obtiene el plan de wf
                nuPlanIdInte := wf_boinstance.fnugetplanid(reg.CUST_CARE_REQUES_NUM, 17);
                pkg_traza.trace('Obtiene plan de la interacción: '||nuPlanIdInte, csbNivelTraza);
                
                -- anula el plan de wf
                IF nuPlanIdInte IS NOT NULL THEN
                    pkg_traza.trace('Anular plan de wortflow interacción: '||nuPlanIdInte, csbNivelTraza);
                    pkgManejoSolicitudes.prcAnulaFlujo(nuPlanIdInte);
                END IF;
         
                --OSF-880
                pkg_traza.trace('Anular Error de wortflow interacción', csbNivelTraza);
                pkgManejoSolicitudes.pAnnulErrorFlow(reg.CUST_CARE_REQUES_NUM);
          
            END IF;
   
            pkg_ldc_solinean.prActualizaRegistro(inusolicitud,'T','proceso exitoso');
            
        exception
            when pkg_error.CONTROLLED_ERROR then
                pkg_Error.getError(nuError, sbError);
                --Reversar cambios si el proceso fallo
                rollback;
                pkg_ldc_solinean.prActualizaRegistro(inusolicitud,'E','proceso termino con error '||sberror);                
            when others then
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                --Reversar cambios si el proceso fallo
                rollback;
                pkg_ldc_solinean.prActualizaRegistro(inusolicitud,'E','proceso termino con error '||sberror);
        end;
        
        commit;
        
    end loop;
    
    pkg_estaproc.prActualizaEstaproc(sbProceso);
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    
exception
    WHEN pkg_Error.Controlled_Error  THEN
        ROLLBACK;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError   => ' || sbError, csbNivelTraza);
        pkg_estaproc.prActualizaEstaproc(sbProceso,'FIN ERROR',sbError);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
    WHEN OTHERS THEN
        ROLLBACK;
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError   => ' || sbError, csbNivelTraza);
        pkg_estaproc.prActualizaEstaproc(sbProceso,'FIN ERROR',sbError);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
end;
/
grant execute on PRJOBANULASOLINEGO to SYSTEM_OBJ_PRIVS_ROLE;
/