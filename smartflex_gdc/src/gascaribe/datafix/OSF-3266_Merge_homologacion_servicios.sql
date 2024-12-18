/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-3266

Inserta homologación de servicios

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    06/09/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbcaso     constant    varchar2(10)  := 'OSF-3266';
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
    nuok        number;
    nuupd       number;
    nuerr       number;
    nuerror     number;
    sberror     varchar2(2000);
    sbcabecera  varchar2(400);
    
BEGIN
    nuok := 0;
    nuupd := 0;
    nuerr := 0;
    sbcabecera := 'Inserción Homologación Servicios - '||csbcaso;
    dbms_output.put_line('=======================================');
    dbms_output.put_line(sbcabecera);
    
    begin
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSUSCRIPC.UPCYCLE' SERVICIO_ORIGEN,
            'Actualiza el ciclo del contrato' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_SUSCRIPC.PRACTUALIZACICLO' SERVICIO_DESTINO,
            null DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
        
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSUSCRIPC.UPDSUSCCICL' SERVICIO_ORIGEN,
            'Actualiza el ciclo del contrato' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_SUSCRIPC.PRACTUALIZACICLO' SERVICIO_DESTINO,
            null DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSUSCRIPC.FBLEXIST' SERVICIO_ORIGEN,
            'Valida que el contrato exista en la base de datos' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_BCCONTRATO.FBLEXISTE' SERVICIO_DESTINO,
            null DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSERVSUSC.UPDSESUCICL' SERVICIO_ORIGEN,
            'Actualiza el ciclo de facturación del producto' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_PRODUCTO.PRACTUALIZACICLOS' SERVICIO_DESTINO,
            'Actualiza ciclo de facturación y ciclo de consumo del producto' DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSERVSUSC.UPBILINGCYCLE' SERVICIO_ORIGEN,
            'Actualiza el ciclo de facturación del producto' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_PRODUCTO.PRACTUALIZACICLOS' SERVICIO_DESTINO,
            'Actualiza ciclo de facturación y ciclo de consumo del producto' DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSERVSUSC.UPDSESUCICO' SERVICIO_ORIGEN,
            'Actualiza el ciclo de consumo del producto' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_PRODUCTO.PRACTUALIZACICLOS' SERVICIO_DESTINO,
            'Actualiza ciclo de facturación y ciclo de consumo del producto' DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
            
        MERGE INTO homologacion_servicios A USING
        (
            SELECT
            'OPEN' as ESQUEMA_ORIGEN,
            'PKTBLSERVSUSC.UPCONSUMPTIONCYCLE' SERVICIO_ORIGEN,
            'Actualiza el ciclo de consumo del producto' DESCRIPCION_ORIGEN,
            'ADM_PERSON' ESQUEMA_DESTINO,
            'PKG_PRODUCTO.PRACTUALIZACICLOS' SERVICIO_DESTINO,
            'Actualiza ciclo de facturación y ciclo de consumo del producto' DESCRIPCION_DESTINO,
            null OBSERVACION
            FROM DUAL
        ) B
        ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN AND A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
        WHEN NOT MATCHED THEN 
        INSERT 
        (
            ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, DESCRIPCION_DESTINO, OBSERVACION
        )
        VALUES 
        (
            B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, B.DESCRIPCION_DESTINO, B.OBSERVACION
        )
        WHEN MATCHED THEN
        UPDATE SET 
            A.DESCRIPCION_ORIGEN    = B.DESCRIPCION_ORIGEN,
            A.ESQUEMA_DESTINO       = B.ESQUEMA_DESTINO,
            A.SERVICIO_DESTINO      = B.SERVICIO_DESTINO,
            A.DESCRIPCION_DESTINO   = B.DESCRIPCION_DESTINO,
            A.OBSERVACION           = B.OBSERVACION
        ;
                
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then
            nuok := nuok + nuRowcount;
            commit;
        else
            nuerr := nuerr + 1;
        end if;
        
    exception
        when others then
            pkg_error.seterror;
            pkg_error.geterror(nuerror,sberror);
            dbms_output.put_line('Error en merge homologación:'||sberror);
            nuerr := nuerr + 1;
    end;
    
    dbms_output.put_line('=========================================');
    dbms_output.put_line('Cantidad de registros gestionados: '||nuok);
    dbms_output.put_line('Cantidad de errores en merge: '||nuerr);
    
END;
/