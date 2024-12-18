set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-3705

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Diciembre 2024 
JIRA:           OSF-3705

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    xx/xx/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3705';
    csbTitulo           constant varchar2(2000) := csbCaso||': Anulación y atención de soliicutudes de reconexión';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    cursor cudata is
    with base as
    (
        SELECT P.PACKAGE_ID, P.cust_care_reques_num,A.PRODUCT_ID, P.REQUEST_DATE, P.MOTIVE_STATUS_ID, O.ORDER_ID, O.LEGALIZATION_DATE, O.TASK_TYPE_ID, O.ORDER_STATUS_ID, P.PACKAGE_TYPE_ID,
        (
            select substr(mensaje_error,55,3) 
            from ldc_wf_sendactivitieslog l
            where l.package_id = p.package_id
        ) errorId,
        (
            select --mensaje_error
            substr(replace(mensaje_error,chr(10),' '),20,136) 
            from ldc_wf_sendactivitieslog l
            where l.package_id = p.package_id
        ) error,
        (
            select suconuor
            from SUSPCONE 
            where suconuor = o.order_id
        ) suconuor,
        (
            select sucofeat
            from SUSPCONE 
            where suconuor = o.order_id
        ) sucofeat,
        (
            select pa.package_id
            from suspcone,or_order_activity aa,mo_packages pa
            where suconuse = a.product_id
            and trunc(sucofeor) = trunc(o.created_date)
            and sucotipo = 'C'
            and aa.order_id = suconuor
            and pa.package_id = aa.package_id
            and pa.package_type_id = p.package_type_id
            and pa.package_id != p.package_id
        ) sol_alterna,
        (
            select pa.motive_status_id
            from suspcone,or_order_activity aa,mo_packages pa
            where suconuse = a.product_id
            and trunc(sucofeor) = trunc(o.created_date)
            and sucotipo = 'C'
            and aa.order_id = suconuor
            and pa.package_id = aa.package_id
            and pa.package_type_id = p.package_type_id
            and pa.package_id != p.package_id
        ) estado_alterna
        FROM OPEN.MO_PACKAGES P,OR_ORDER_ACTIVITY A,OR_ORDER O,GE_CAUSAL GC
        where P.PACKAGE_ID = A.PACKAGE_ID(+)
        and O.ORDER_ID(+) = A.ORDER_ID
        and O.CAUSAL_ID = GC.CAUSAL_ID(+)
        and P.PACKAGE_TYPE_ID in( 300,100240,100333)
        AND P.MOTIVE_STATUS_ID = 13
        AND O.ORDER_STATUS_ID = 8
        AND GC.CLASS_CAUSAL_ID = 1
        AND o.LEGALIZATION_DATE <= to_date('30-11-2024','dd-mm-yyyy')
        order by p.package_id desc
    ), agrupa as
    (
        select 
        (select sesuesco||'-'||escodesc from servsusc,estacort where sesunuse = b.product_id and escocodi = sesuesco) sesuesco,
        (select unique first_value(hcecfech) over (partition by hcecnuse order by hcecfech desc) from hicaesco where hcecnuse = product_id) fecha_estado,
        (select unique first_value(hcececac) over (partition by hcecnuse order by hcecfech desc) from hicaesco where hcecnuse = product_id) hcececac,
        (select suspen_ord_act_id from pr_product p where p.product_id = b.product_id) act_susp,
        (
        select unique first_value(o.order_id) over (partition by a.product_id order by o.order_id desc) 
        from or_order o,or_order_activity a,or_task_type t
        where a.order_id = o.order_id 
        and a.product_id = b.product_id
        and t.task_type_id = o.task_type_id
        and o.order_status_id = 8
        and t.description like 'SUSPENSI%'
        ) order_susp,
        (
        select unique first_value(a.order_activity_id) over (partition by a.product_id order by o.order_id desc) 
        from or_order o,or_order_activity a,or_task_type t
        where a.order_id = o.order_id 
        and a.product_id = b.product_id
        and t.task_type_id = o.task_type_id
        and o.order_status_id = 8
        and t.description like 'SUSPENSI%'
        ) order_activity_susp,
        b.* from base b
       where error like '%acción 203%'
        or error  like '%acción 213%'
        or error like '%ncia%'
        or error like '%interfaz%'
    )
    select 
    case
        when a.order_susp is null then 'NA'
        when a.order_susp > a.order_id then 'Mayor'
        when a.order_susp < a.order_id then 'Menor'
        else 'Otro'
    end valida_susp,
    SESUESCO,FECHA_ESTADO,HCECECAC,ACT_SUSP,ORDER_SUSP,ORDER_ACTIVITY_SUSP,
    (select package_id from or_order_activity oa where oa.order_id = a.order_susp) sol_suspen,
    (select p.request_date from or_order_activity oa,mo_packages p where oa.order_id = a.order_susp and p.package_id = oa.package_id) sol_suspen_date,
    (select p.motive_status_id from or_order_activity oa,mo_packages p where oa.order_id = a.order_susp and p.package_id = oa.package_id) sol_suspen_estado,
    (select p.package_type_id from or_order_activity oa,mo_packages p where oa.order_id = a.order_susp and p.package_id = oa.package_id) sol_suspen_type,
    PACKAGE_ID,PRODUCT_ID,REQUEST_DATE,cust_care_reques_num,
    MOTIVE_STATUS_ID,ORDER_ID,LEGALIZATION_DATE,TASK_TYPE_ID,ORDER_STATUS_ID,PACKAGE_TYPE_ID,SUCONUOR,SUCOFEAT,SOL_ALTERNA,ESTADO_ALTERNA,ERRORID,ERROR
    from agrupa a
    --where package_id = 209314113
    ;
    
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nuan                number;
    nuup                number;
    nuerr               number;
    nuPlanId            number;
    nuPlanIdInte        number;
    nuCantSoli          number;
    
    
    FUNCTION fnc_rs_CalculaTiempo
    (
        idtFechaIni IN DATE,
        idtFechaFin IN DATE
    )
    RETURN VARCHAR2
    IS
        nuTiempo NUMBER;
        nuHoras NUMBER;
        nuMinutos NUMBER;
        sbRetorno VARCHAR2( 100 );
    BEGIN
        -- Convierte los dias en segundos
        nuTiempo := ( idtFechaFin - idtFechaIni ) * 86400;
        -- Obtiene las horas
        nuHoras := TRUNC( nuTiempo / 3600 );
        -- Publica las horas
        sbRetorno := TO_CHAR( nuHoras ) ||'h ';
        -- Resta las horas para obtener los minutos
        nuTiempo := nuTiempo - ( nuHoras * 3600 );
        -- Obtiene los minutos
        nuMinutos := TRUNC( nuTiempo / 60 );
        -- Publica los minutos
        sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||'m ';
        -- Resta los minutos y obtiene los segundos redondeados a dos decimales
        nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
        -- Publica los segundos
        sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||'s';
        -- Retorna el tiempo
        RETURN( sbRetorno );
    EXCEPTION
        WHEN OTHERS THEN
            -- No se eleva excepcion, pues no es parte fundamental del proceso
            RETURN NULL;
    END fnc_rs_CalculaTiempo;
    
    procedure panula (inuSol in number,inuCust in number,onuerror out number, osberror out varchar2) 
    is
        csbproceso      constant varchar2(200) := 'panula';
        
        cursor cuSoliAdicional (inupackage in number,isbcust_care_reques_num in varchar2) is
        select count(1) 
        from mo_packages
        where CUST_CARE_REQUES_NUM = isbcust_care_reques_num
        and package_id <> inupackage
        and package_type_id <> 268;
        
        nuCantSoli  number;
        
    begin
        pkg_error.prInicializaError(onuerror,osberror);
        --Anula solicitud
        pkgManejoSolicitudes.pAnnulRequest(inuSol,'Anulación caso '||csbCaso);

        -- Se obtiene el plan de wf
        nuPlanId := null;
        nuPlanId := wf_boinstance.fnugetplanid(inuSol, 17);
         
        -- anula el plan de wf
        IF nuPlanId IS NOT NULL THEN
            pkgManejoSolicitudes.prcAnulaFlujo(nuPlanId);
        END IF;
        
        pkgManejoSolicitudes.pAnnulErrorFlow(inuSol);

        --se valida si interaccion solo tiene asociada solicitud actual
        if cuSoliAdicional%isopen then close cuSoliAdicional; end if;
        
        open cuSoliAdicional(inuSol,inuCust);
        fetch cuSoliAdicional into nuCantSoli;
        close cuSoliAdicional;
        
        
        IF nuCantSoli = 0 THEN
            --se anula interaccion
            pkgManejoSolicitudes.pAnnulRequest(inuCust,'Anulación caso '||csbCaso);
            
            -- Se obtiene el plan de wf
            nuPlanIdInte := null;
            nuPlanIdInte := wf_boinstance.fnugetplanid(inuCust, 17);
            
            -- anula el plan de wf
            IF nuPlanIdInte IS NOT NULL THEN
                pkgManejoSolicitudes.prcAnulaFlujo(nuPlanIdInte);
            END IF;
     
            pkgManejoSolicitudes.pAnnulErrorFlow(inuCust);
      
        END IF;
        
    exception
        when others then
            pkg_error.seterror;
            pkg_error.geterror(onuerror,osberror);
            osberror := csbproceso||': '||osberror;
    end;
    
    procedure patiende (inusol in number,onuerror out number, osberror out varchar2)
    is 
        csbproceso      constant varchar2(200) := 'patiende';
        
        cursor cuplan (inusol in number) is
        select w.* from wf_data_external de,wf_instance w
        where de.package_id = inusol
        and w.plan_id = de.plan_id
        and w.instance_id = w.plan_id;
        
        rcplan  cuplan%rowtype;
        
    begin
        MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(inusol,GE_BOPARAMETER.FNUGET('ACTION_ATTEND', 'N'));
        pkgManejoSolicitudes.pAnnulErrorFlow(inusol);
        
        if cuplan%isopen then close cuplan; end if;
        
        open cuplan(inusol);
        fetch cuplan into rcplan;
        close cuplan;
        
        update wf_instance
        set status_id = 6
        where instance_id = rcplan.instance_id;
        
    exception
        when others then
            pkg_error.seterror;
            pkg_error.geterror(onuerror,osberror);
            osberror := csbproceso||': '||osberror;
    end;
    
    procedure pcancelasusp (inuprod in number,onuerror out number, osberror out varchar2) 
    is
        csbproceso      constant varchar2(200) := 'pcancelasusp';
        
        cursor cususpension is
        select product_status_id,s.* 
        from pr_prod_suspension s,pr_product p
        where s.product_id = inuprod
        and p.product_id = s.product_id
        order by prod_suspension_id desc;
        
        rcsuspension    cususpension%rowtype;
    begin
        if cususpension%isopen then close cususpension; end if;
        
        open cususpension;
        fetch cususpension into rcsuspension;
        close cususpension;
        
        if rcsuspension.product_id is not null and rcsuspension.inactive_date is null then
            update pr_prod_suspension
            set inactive_date = sysdate, active = 'N'
            where prod_suspension_id = rcsuspension.prod_suspension_id;
            
            if rcsuspension.product_status_id = 2 then
                update pr_product
                set product_status_id = 1
                where product_id = rcsuspension.product_id;
            end if;
            
        end if;
    exception
        when others then
            pkg_error.seterror;
            pkg_error.geterror(onuerror,osberror);
            osberror := csbproceso||': '||osberror;
    end;
    
BEGIN
    nucontador  := 0;
    nuok       := 0;
    nuerr       := 0;
    nuan        := 0;
    nuup        := 0;
    
    sbcabecera := 'Solicitud|Fecha|Estado|Gestión|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            nucontador := nucontador + 1;
            
            begin 
            
                s_out := rc.package_id;
                s_out := s_out||'|'||rc.request_date;
                s_out := s_out||'|'||rc.motive_status_id;
                
                if rc.sol_alterna is not null and rc.estado_alterna = 14 then
                    --Anulación por script
                    panula(rc.package_id,rc.cust_care_reques_num,nuerror,sberror);
                    if nuerror != 0 then
                        raise raise_continuar;
                    end if;
                    
                    s_out := s_out||'|'||'Anulación';
                    
                    nuan := nuan + 1;
                    
                elsif rc.sol_alterna is null then
                    if rc.errorid = '203' and rc.sucofeat is null then
                        --Ya gestionado o no necesita gestión
                        nucontador := nucontador - 1;
                        
                    elsif rc.errorid = '203' then
                        --Actualización fecha atención orden
                        update SUSPCONE 
                        set sucofeat = null
                        where suconuor = rc.suconuor;
                        
                        nuRowcount := sql%rowcount;
                
                        if nuRowcount != 1 then
                            sberror := 'Actualización de fecha de atención orden diferente a la esperada ['||nuRowcount||']';
                            raise raise_continuar;
                        end if;
                        
                        s_out := s_out||'|'||'Actualización Fecha SUSPCONE';
                        
                        nuup := nuup + 1;
                        
                    elsif rc.errorid = '213' and rc.sesuesco not like '6-%'then
                        --Atención por script
                        patiende(rc.package_id,nuerror,sberror);
                        if nuerror != 0 then
                            raise raise_continuar;
                        end if;
                        
                        s_out := s_out||'|'||'Atención';
                        
                        nuok := nuok + 1;
                        
                    else
                        --Atención por script
                        patiende(rc.package_id,nuerror,sberror);
                        if nuerror != 0 then
                            raise raise_continuar;
                        end if;
                        
                        if rc.sesuesco like '6-%' and rc.valida_susp = 'Menor' then
                            pcancelasusp(rc.product_id,nuerror,sberror);
                            if nuerror != 0 then
                                raise raise_continuar;
                            end if;
                            
                            s_out := s_out||'|'||'Atención e inactivación suspensión';
                            
                        else
                            s_out := s_out||'|'||'Atención';
                        end if;
                        
                        nuok := nuok + 1;
                        
                    end if;
                else
                    sberror := 'Escenario no contemplado';
                    raise raise_continuar;
                end if;
                
            
                s_out := s_out||'|'||'Ok';
                dbms_output.put_line(s_out);
                
                commit;
            
            exception
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en gestión de solicutud. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
      
        end loop;
        
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos de solicitudes para gestión';
            nuerr := nuerr + 1;
            s_out  := '||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
        
        
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de solicitudes atendidas: '||nuok);
    dbms_output.put_line('Cantidad de solicitudes anuladas: '||nuan);
    dbms_output.put_line('Cantidad de SUSPCON actualizadas: '||nuup);
    dbms_output.put_line('Cantidad de errores: '||nuerr);  
    dbms_output.put_line('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    dbms_output.put_line('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
