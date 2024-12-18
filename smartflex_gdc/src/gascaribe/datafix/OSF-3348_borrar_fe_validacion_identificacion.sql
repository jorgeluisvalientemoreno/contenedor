column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-3348');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    nuerror   NUMBER;
    sberror   VARCHAR2(4000);
    --tipo tabla fe_validacion_identificacion
    type tyclidif110 is table of fe_validacion_identificacion%ROWTYPE;
    tblclidif110 tyclidif110;
    
    --obtiene los clientes con más de un registro
    CURSOR cuclvarreg IS
    SELECT
        id_cliente,
        COUNT(*) AS cnt
    FROM
        open.fe_validacion_identificacion    
    GROUP BY
        id_cliente
    HAVING
        COUNT(*) > 1;
        
    cursor cuclientestidif110 is
    select ROWID, a.*
    from open.fe_validacion_identificacion a;
    
    cursor cuIdentnuevaIgual (nuid_cliente fe_validacion_identificacion.id_cliente%type, 
                              nuident_anterior fe_validacion_identificacion.ident_anterior%type) is
            select *
            from fe_validacion_identificacion
            where id_cliente = nuid_cliente
            and ident_anterior <> nuident_anterior;
    
    RCREGISTRO     cuclientestidif110%ROWTYPE; 
    
    NUREGREPETIDOS NUMBER;    
    nucantid number;
    
    
    blLog           pkg_gestionarchivos.styarchivo;
    sbRutaGen    	VARCHAR2(1000) := '/smartfiles/tmp';
    sbNombreArchivo VARCHAR2(100)  := 'log_validacion_identificacion_'||TO_CHAR(SYSDATE, 'DD_MM_YYYY_HH24_MI_SS')||'.txt';
begin
    
    IF (pkg_gestionarchivos.fblarchivoabierto_smf(blLog) = FALSE) THEN
        blLog := pkg_gestionarchivos.ftabrirarchivo_smf(sbRutaGen, sbNombreArchivo, 'W');
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'LOG BORRADO REGISTROS DUPLICADOS TABLA FE_VALIDACION_IDENTIFICACION'); 
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, '');  
    END IF;
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'Se borran los registros con identificación diferente de 110 - Nit/Rut');  
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'ID_CLIENTE, IDENT_ANTERIOR, IDENT_NUEVA, VALIDO, OBSERVACION');  

    
    select a.*
    BULK COLLECT INTO tblclidif110
    from fe_validacion_identificacion a,
         ge_subscriber b   
    where a.id_cliente = b.subscriber_id
    and b.ident_type_id <> 110
    order by a.id_cliente desc;
      
    FOR i IN 1 .. tblclidif110.COUNT LOOP
        
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, tblclidif110(i).id_cliente
                             || ', '
                             || tblclidif110(i).ident_anterior
                             || ', '
                             || tblclidif110(i).ident_nueva
                             || ', '
                             || tblclidif110(i).valido
                             || ', '
                             || tblclidif110(i).observacion);
    END LOOP;
    
    IF tblclidif110.COUNT > 0 THEN
    
        delete fe_validacion_identificacion
        where id_cliente in (select a.id_cliente 
                            from fe_validacion_identificacion a,
                                 ge_subscriber b   
                            where a.id_cliente = b.subscriber_id
                            and b.ident_type_id <> 110); 
    END IF;    
    
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'Se borran los regitros iguales para un cliente dejando solo uno');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'ID_CLIENTE, IDENT_ANTERIOR, IDENT_NUEVA, VALIDO, OBSERVACION, CANTIDAD_BORRADA');
    --obtiene todos los clientes con mas de un registro 
    FOR reg1 IN cuclvarreg LOOP
        
        --indentiica si todos los registros del cliente son repetidos        
        SELECT
            COUNT(*)
        INTO nuregrepetidos
        FROM
            (
                SELECT
                    ident_anterior,
                    ident_nueva
                FROM
                    fe_validacion_identificacion
                WHERE
                    id_cliente = reg1.id_cliente
                GROUP BY
                    ident_anterior,
                    ident_nueva
            );         
        
        IF nuregrepetidos = 1 THEN
        
            --si son repetidos realiza borrado dejando solo uno
            SELECT ROWID, fe_validacion_identificacion.*
            INTO RCREGISTRO
            FROM fe_validacion_identificacion
            WHERE id_cliente = reg1.id_cliente
            AND ROWNUM = 1;
            
            DELETE fe_validacion_identificacion
            WHERE id_cliente = reg1.id_cliente
            AND ROWID <> RCREGISTRO.ROWID;
                       
            
           pkg_gestionarchivos.prcescribirlinea_smf(blLog,RCREGISTRO.id_cliente
                             || ', '
                             || RCREGISTRO.ident_anterior
                             || ', '
                             || RCREGISTRO.ident_nueva
                             || ', '
                             || RCREGISTRO.valido
                             || ', '
                             || RCREGISTRO.observacion
                             || ', '
                             || (reg1.cnt-1));
        END IF;
    END LOOP;
    
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'Se borran los registros con identificación IGUAL para el campo IDENT_NUEVA, se deja el reg con IDENT_ANTERIOR más larga');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'ID_CLIENTE, IDENT_ANTERIOR, IDENT_NUEVA, VALIDO, OBSERVACION');    
    FOR reg1 IN cuclvarreg LOOP
        SELECT COUNT(*)
        into nucantid
        FROM 
        (select ID_CLIENTE, IDENT_NUEVA
        from fe_validacion_identificacion 
        where id_cliente = reg1.id_cliente
        group by ID_CLIENTE, IDENT_NUEVA); 
        
        IF nucantid = 1 THEN
            select a.rowid, a.*
            INTO RCREGISTRO
            FROM fe_validacion_identificacion a
            WHERE id_cliente = reg1.id_cliente
            and length(ident_anterior) = (select max(length(ident_anterior))
                                            from fe_validacion_identificacion 
                                            where  id_cliente = reg1.id_cliente);                                        
                                            
            for RCREGISTRO1 in cuIdentnuevaIgual(reg1.id_cliente, RCREGISTRO.ident_anterior) loop
               pkg_gestionarchivos.prcescribirlinea_smf(blLog,RCREGISTRO1.id_cliente
                             || ', '
                             || RCREGISTRO1.ident_anterior
                             || ', '
                             || RCREGISTRO1.ident_nueva
                             || ', '
                             || RCREGISTRO1.valido
                             || ', '
                             || RCREGISTRO1.observacion);    
            end loop;            
            
            DELETE fe_validacion_identificacion
            WHERE id_cliente = reg1.id_cliente
            AND ROWID <> RCREGISTRO.ROWID;                   
            
                                                
                                            
        END IF;         
    END LOOP;    
    
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'Se borran los registros con identificación DIFERENTE para el campo IDENT_NUEVA, se deja el reg con identificación igual a ge_subscriber');
   pkg_gestionarchivos.prcescribirlinea_smf(blLog,'ID_CLIENTE, IDENT_ANTERIOR, IDENT_NUEVA, VALIDO, OBSERVACION');    
    FOR reg1 IN cuclvarreg LOOP
        
        SELECT COUNT(*)
        into nucantid
        FROM 
        (select ID_CLIENTE, IDENT_NUEVA
        from fe_validacion_identificacion 
        where id_cliente = reg1.id_cliente
        group by ID_CLIENTE, IDENT_NUEVA);
        
        IF nucantid > 1 THEN
            select a.rowid, a.*
            INTO RCREGISTRO
            FROM fe_validacion_identificacion a,
                 ge_subscriber b 
            WHERE a.id_cliente = b.subscriber_id
            and a.IDENT_nueva = b.IDENTIFICATION
            and a.id_cliente = reg1.id_cliente;
            
            DELETE fe_validacion_identificacion
            WHERE id_cliente = reg1.id_cliente
            AND ROWID <> RCREGISTRO.ROWID;                   
            
           pkg_gestionarchivos.prcescribirlinea_smf(blLog, RCREGISTRO.id_cliente
                             || ', '
                             || RCREGISTRO.ident_anterior
                             || ', '
                             || RCREGISTRO.ident_nueva
                             || ', '
                             || RCREGISTRO.valido
                             || ', '
                             || RCREGISTRO.observacion);            
        END IF;     
    END LOOP;
    
    pkg_gestionarchivos.prccerrararchivo_smf(blLog);
    
    COMMIT;
    
EXCEPTION
    WHEN pkg_error.controlled_error THEN      
        pkg_error.geterror(nuerror, sberror);
        pkg_gestionarchivos.prcescribirlinea_smf(blLog,'nuerror: '||nuerror||' - '||'sberror: '||sberror);
        pkg_gestionarchivos.prccerrararchivo_smf(blLog);
        RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN     
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror);   
        pkg_gestionarchivos.prcescribirlinea_smf(blLog,'nuerror: '||nuerror||' - '||'sberror: '||sberror);
        pkg_gestionarchivos.prccerrararchivo_smf(blLog);
        RAISE pkg_error.controlled_error;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/