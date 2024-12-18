/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-1440

Actualiza observaciones de servicios homologados

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    11/01/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    cursor cudata is
    select * from homologacion_servicios
    where servicio_origen in
    ('DAOR_ORDER.FNUGETORDER_STATUS_ID','DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID','DAMO_PACKAGES.FSBGETCOMMENT_','DAPR_PRODUCT.FNUGETADDRESS_ID',
    'GE_BOPERSONAL.FNUGETCURRENTCHANNEL','DAGE_GEOGRA_LOCATION.FSBGETDESCRIPTION','DAGE_GEOGRA_LOCATION.FNUGETGEO_LOCA_FATHER_ID','DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID')
    ;
    
    cursor cuproc is
    select * from all_procedures
    where procedure_name in ('FNUGETSUBSCRIBERID','FNUGETCUSTOMER','FNUGETSUSCRIPTION')
    and object_name in ('PKBCSUSCRIPC','PKTBLSUSCRIPC','PKTBLSERVSUSC');
    
    
    cursor cuvalida(isbserv in varchar2) is
    select * from homologacion_servicios
    where servicio_origen = isbserv;
    
    rcvalida    cuvalida%rowtype;
    
    nuRowcount  number;
    nucontador  number;
    nuok        number;
    nuins       number;
    nuerr       number;
    nuerror     number;
    sberror     varchar2(2000);
    sbcabecera  varchar2(400);
    sbactualiza varchar2(2000);
    sblog       varchar2(2000);
    sbobse      varchar2(4000);
    sbservicio  homologacion_servicios.servicio_origen%type;
    
BEGIN
    nucontador := 0;
    nuok := 0;
    nuins := 0;
    nuerr := 0;
    sbcabecera := 'EsquemaOrigen|ServicioOrigen|EsquemaDestino|ServicioDestino|Gestión|Error';
    dbms_output.put_line(sbcabecera);
    
    for rc in cudata loop
    
        begin
            nucontador := nucontador + 1;
            sblog := rc.esquema_origen;
            sblog := sblog||'|'||rc.servicio_origen;
            sblog := sblog||'|'||rc.esquema_destino;
            sblog := sblog||'|'||rc.servicio_destino;
            
            if rc.servicio_origen = 'GE_BOPERSONAL.FNUGETCURRENTCHANNEL' then
                sbobse := 'El servicio homologado no requiere el segundo parámetro INURAISEERROR, pero lo asigna a TRUE al llamar al método de open';
            else
                sbobse := 'El servicio homologado no requiere el segundo parámetro INURAISEERROR, validar la equivalencia en el comportamiento';
            end if;
            
            update homologacion_servicios
            set observacion = sbobse
            where esquema_origen = rc.esquema_origen
            and servicio_origen = rc.servicio_origen
            and esquema_destino = rc.esquema_destino
            and servicio_destino = rc.servicio_destino;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then
                nuok := nuok + nuRowcount;
                commit;
                sbactualiza := 'Actualizado|';
            else
                sbactualiza := 'No Actualizado|NA';
            end if;
            
        exception
            when others then
                rollback;
                nuerr := nuerr + 1;
                pkg_error.seterror;
                pkg_error.geterror(nuerror,sberror);
                sbactualiza := 'No Actualizado|'||sberror;
        end;
        
        dbms_output.put_line(sblog||'|'||sbactualiza);
        
    end loop;
    
    for rc in cuproc loop
        rcvalida :=null;
        sbservicio := rc.object_name||'.'||rc.procedure_name;
        open cuvalida(sbservicio);
        fetch cuvalida into rcvalida;
        close cuvalida;
        
        if rcvalida.servicio_origen is null then
            begin
                if sbservicio  = 'PKTBLSERVSUSC.FNUGETSUSCRIPTION' then
                    insert into homologacion_servicios(esquema_origen,servicio_origen,descripcion_origen,esquema_destino,servicio_destino,descripcion_destino,observacion)
                    values(rc.owner,sbservicio,'Retorna el contrato del producto','ADM_PERSON','PKG_BCPRODUCTO.FNUCONTRATO','Retorna el contrato del producto','');
                    
                    nuins := nuins +1;
                else
                    insert into homologacion_servicios(esquema_origen,servicio_origen,descripcion_origen,esquema_destino,servicio_destino,descripcion_destino,observacion)
                    values(rc.owner,sbservicio,'Retorna el cliente del contrato','ADM_PERSON','PKG_BCCONTRATO.FNUIDCLIENTE','Retorna el cliente del contrato','');
                    
                    nuins := nuins +1;
                end if;
                
                commit;
            exception 
                when others then
                    rollback;
                    nuerr := nuerr + 1;
            end;
        end if;
    end loop;
    
    rcvalida :=null;
    sbservicio := 'P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101';
    open cuvalida(sbservicio);
    fetch cuvalida into rcvalida;
    close cuvalida;
    
    if rcvalida.servicio_origen is null then
        begin
            insert into homologacion_servicios(esquema_origen,servicio_origen,descripcion_origen,esquema_destino,servicio_destino,descripcion_destino,observacion)
            values('OPEN','P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101','XML para VSI','PERSONALIZACIONES','PKG_XML_SOLI_VSI.GETSOLICITUDVSI','XML para VSI','');
                
            nuins := nuins +1;
                        
            commit;
        exception 
            when others then
                rollback;
                nuerr := nuerr + 1;
        end;
    end if;
    
    
    
        
    
    dbms_output.put_line('=========================================');
    dbms_output.put_line('Cantidad de registros obtenidos: '||nucontador);
    dbms_output.put_line('Cantidad de registros actualizados: '||nuok);
    dbms_output.put_line('Cantidad de registros insertados: '||nuins);
    dbms_output.put_line('Cantidad de errores en actualización: '||nuerr);
    
END;
/