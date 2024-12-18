SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2772');
DECLARE
 
 CURSOR cu_servicios is
    SELECT *
      FROM PERSONALIZACIONES.HOMOLOGACION_SERVICIOS
     WHERE SERVICIO_ORIGEN  in ('DAMO_PACKAGES.FRCGETRECORS',
                                'DAOR_OPERATING_UNIT.FNUASSIGN_TYPE',
                                'DAOR_ORDER.FNUGETEXTERNAL_ADDRESS_ID',
                                'DAOR_ORDER_ACTIVITY.FNUGETORDER_ID',
                                'DBMS_OUTPUT',
                                'OR_BSEXTERNALLEGALIZEACTIVITY.LEGALIZEORDER',
                                'PKTBLSERVSUSC.FDTGETRETIREDATE',
                                'PKTBLSUSCRIPC.FNUGETBILLINGCYCLE',
                                'LDC_BOUTILITIES.SPLITSTRINGS');
    nuCantidad NUMBER;
    nuCant NUMBER;
 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-2772');
    BEGIN 
        SELECT COUNT(1) INTO nuCantidad
          FROM PERSONALIZACIONES.HOMOLOGACION_SERVICIOS
         WHERE SERVICIO_ORIGEN  in ('DAMO_PACKAGES.FRCGETRECORS',
                                    'DAOR_OPERATING_UNIT.FNUASSIGN_TYPE',
                                    'DAOR_ORDER.FNUGETEXTERNAL_ADDRESS_ID',
                                    'DAOR_ORDER_ACTIVITY.FNUGETORDER_ID',
                                    'DBMS_OUTPUT',
                                    'OR_BSEXTERNALLEGALIZEACTIVITY.LEGALIZEORDER',
                                    'PKTBLSERVSUSC.FDTGETRETIREDATE',
                                    'PKTBLSUSCRIPC.FNUGETBILLINGCYCLE',
                                    'LDC_BOUTILITIES.SPLITSTRINGS');        
    EXCEPTION WHEN OTHERS THEN
        nuCantidad:= 0;    
    END;
    IF nuCantidad = 0 THEN 
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAMO_PACKAGES.FRCGETRECORS','Retorna el registro de mo_packages','ADM_PERSON','PKG_BCSOLICITUDES.FRCGETRECORD ',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAOR_OPERATING_UNIT.FNUASSIGN_TYPE','Retorna tipo de asignacion','ADM_PERSON','PKG_BCUNIDADOPERATIVA.FSBGETTIPOASIGNACION',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAOR_ORDER.FNUGETEXTERNAL_ADDRESS_ID','Obtiene Dirección de la orden','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEDIRECCION',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAOR_ORDER_ACTIVITY.FNUGETORDER_ID','Retorna el ID de la Orden de la Actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEORDENDEACTIVIDAD',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAOR_ORDER_ACTIVITY.FNUGETORDER_ID','Retorna el ID de la Orden de la Actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEORDENDEACTIVIDAD',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','OR_BSEXTERNALLEGALIZEACTIVITY.LEGALIZEORDER','Legalizar Orden detrabajo','ADM_PERSON','API_LEGALIZEORDERS',null,null);
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','PKTBLSERVSUSC.FDTGETRETIREDATE','Retorna la fecha de retiro del producto.','ADM_PERSON','PKG_BCPRODUCTO.FNUCONTRATO','**VER OBSERVACIÓN**','Al realizar el cambio es necesario tener en cuenta que el método: PKG_BCPRODUCTO.FDTFECHARETIRO 
        se comporta igual que el método PKTBLSERVSUSC.FDTGETRETIREDATE y **REALIZA RAISE** cuando el contrato no existe');
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','PKTBLSUSCRIPC.FNUGETBILLINGCYCLE','Retorna el ciclo de facturación del contrato.','ADM_PERSON','PKG_BCCONTRATO.FNUCICLOFACTURACION','**VER OBSERVACIÓN**','Al realizar el cambio es necesario tener en cuenta que el método: PKG_BCCONTRATO.FNUCICLOFACTURACION 
        se comporta diferente al método PKTBLSUSCRIPC.FNUGETBILLINGCYCLE y no levanta excepción cuando el contrato no existe.');
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','LDC_BOUTILITIES.SPLITSTRINGS','Método que retorna una tabla con la cadena enviada.','N/A','REGEXP_SUBSTR','Utilización buenas prácticas. Ver campo observación','--Código actual
        SELECT TO_NUMBER (COLUMN_VALUE)
          FROM TABLE ( ldc_boutilities.splitstrings (
                                                     dald_parameter.fsbgetvalue_chain (''VAL_TRAMITES_NUEVOS_FLUJOS'',NULL),
                                                     '',''
                                                    )
                     )
        --***************************
        --Código sugerido
        
        SELECT (regexp_substr(dald_parameter.fsbgetvalue_chain (''VAL_TRAMITES_NUEVOS_FLUJOS'',NULL),
                                                                ''[^,]+'', 
                                                                1, 
                                                                LEVEL)
                                                                ) AS vlrColumna
          FROM dual
        CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain (''VAL_TRAMITES_NUEVOS_FLUJOS'',NULL), 
                                                                  ''[^,]+'', 
                                                                  1,
                                                                  LEVEL
                                                                  ) IS NOT NULL  
        ');

       
        COMMIT;    
    END IF;
    
    SELECT COUNT(1) INTO nuCantidad
      FROM PERSONALIZACIONES.HOMOLOGACION_SERVICIOS
     WHERE SERVICIO_ORIGEN  in ('DAMO_PACKAGES.FRCGETRECORS',
                                'DAOR_OPERATING_UNIT.FNUASSIGN_TYPE',
                                'DAOR_ORDER.FNUGETEXTERNAL_ADDRESS_ID',
                                'DAOR_ORDER_ACTIVITY.FNUGETORDER_ID',
                                'DBMS_OUTPUT',
                                'OR_BSEXTERNALLEGALIZEACTIVITY.LEGALIZEORDER',
                                'PKTBLSERVSUSC.FDTGETRETIREDATE',
                                'PKTBLSUSCRIPC.FNUGETBILLINGCYCLE',
                                'LDC_BOUTILITIES.SPLITSTRINGS');
    
      nuCant:= 0;
      IF nuCantidad > 0 THEN        
        dbms_output.put_line('RESULTADO:');
        dbms_output.put_line('SERVICIO_ORIGEN|DESCRIPCION_ORIGEN|ESQUEMA_DESTINO|SERVICIO_DESTINO');
        nuCant:= 1;
        FOR reg IN cu_servicios LOOP          
          dbms_output.put_line(nuCant||'.-'||reg.SERVICIO_ORIGEN||'|'||reg.DESCRIPCION_ORIGEN||'|'||reg.ESQUEMA_DESTINO||'|'||reg.SERVICIO_DESTINO);
          nuCant:= nuCant+1;
        END LOOP;
      END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/