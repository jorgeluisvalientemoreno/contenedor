/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Mayo 2024 
JIRA:           OSF-2467

Actualiza observaciones de servicios homologados

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    29/04/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    cursor cudata is
    with base as
    (
        select 'OPEN' esquema_origen, 'GE_BOCONSTANTS.GETYES' servicio_origen, 'Constante con valor Y' descripcion,'CONSTANTS_PER.CSBYES' servicio_destino,'' observacion  from dual union all
        select 'OPEN' esquema_origen, 'GE_BOCONSTANTS.CSBYES','Constante con valor Y','CONSTANTS_PER.CSBYES','' from dual union all
        select 'OPEN' esquema_origen, 'GE_BOCONSTANTS.GETNO', 'Constante con valor N','CONSTANTS_PER.CSBNO','' from dual union all
        select 'OPEN' esquema_origen, 'PKCONSTANTE.NO', 'Constante con valor N','CONSTANTS_PER.CSBNO','' from dual union all
        select 'OPEN' esquema_origen, 'PKCONSTANTE.SI', 'Constante con valor S','CONSTANTS_PER.CSBSI','' from dual union all
        select 'OPEN' esquema_origen, 'PKTBLSERVSUSC.FNUGETSERVICE', 'Obtiene el tipo de servicio','PKG_BCPRODUCTO.FNUTIPOPRODUCTO',
        'Servicio homologado no verifica si el producto existe, considerar validación de dato retornado nulo para hacerlo equivalente' from dual
    )
    select b.*,s.servicio_origen servicio_origen_t from base b,homologacion_servicios s
    where s.servicio_origen(+) = b.servicio_origen;
    
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
            sblog := sblog||'|'||'PERSONALIZACIONES';
            sblog := sblog||'|'||rc.servicio_destino;
            
            if rc.servicio_origen_t is null then
                
                insert into homologacion_servicios(esquema_origen,servicio_origen,descripcion_origen,esquema_destino,servicio_destino,descripcion_destino,observacion)
                values(rc.esquema_origen,rc.servicio_origen,rc.descripcion,'PERSONALIZACIONES',rc.servicio_destino,'',rc.observacion);
            
                nuRowcount := sql%rowcount;
                if nuRowcount > 0 then
                    nuins := nuins + nuRowcount;
                    commit;
                    sbactualiza := 'Registrado|NA';
                else
                    rollback;
                    sbactualiza := 'No Registrado|NA';
                end if;
            else
                sbactualiza := 'Ya Registrado|NA';
            end if;
            
        exception
            when others then
                rollback;
                nuerr := nuerr + 1;
                pkg_error.seterror;
                pkg_error.geterror(nuerror,sberror);
                sbactualiza := 'No Registrado|'||sberror;
        end;
        
        dbms_output.put_line(sblog||'|'||sbactualiza);
        
    end loop;
    
    dbms_output.put_line('=========================================');
    dbms_output.put_line('Cantidad de registros obtenidos: '||nucontador);
    dbms_output.put_line('Cantidad de registros actualizados: '||nuok);
    dbms_output.put_line('Cantidad de registros insertados: '||nuins);
    dbms_output.put_line('Cantidad de errores en actualización: '||nuerr);
    
END;
/