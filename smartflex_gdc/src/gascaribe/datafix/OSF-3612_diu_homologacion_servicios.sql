--Punto 0
-- Reemplazar servicio destino PKG_GESTION_PRODUCTO PRCACTCATEGORIAPRODUCTO con PKG_PRODUCTO.prcActuCategoriaySubcategoria para servicio origen PR_BOPRODUCT.UPDPRODCATBYCONTRACT
update HOMOLOGACION_SERVICIOS
set servicio_destino = 'PKG_PRODUCTO.PRCACTUCATEGORIAYSUBCATEGORIA'
where servicio_origen = 'PR_BOPRODUCT.UPDPRODCATBYCONTRACT';

commit;
/
-- Reemplazar servicio destino PKG_LDC_MARCA_PRODUCTO.FNUOBTIENEMARCAPRODUCTO con PKG_BCPRODUCTO.FNUOBTIENEMARCAPRODUCTO para servicio origen LDC_FNCRETORNAMARCAPROD
update HOMOLOGACION_SERVICIOS
set servicio_destino = 'PKG_BCPRODUCTO.FNUOBTIENEMARCAPRODUCTO'
where servicio_origen = 'LDC_FNCRETORNAMARCAPROD';

commit;

/
--Punto 1
--Eliminar registro donde el campo servicio_origen es PKG_SESSION.GETUSER
delete
from HOMOLOGACION_SERVICIOS
where servicio_origen = 'PKG_SESSION.GETUSER';

commit;
/

--Punto 2
--Eliminar 1 registro duplicado donde el campo servicio_origen es “DAOR_ORDER_ACTIVITY.FNUGETORDER_ID“
DECLARE
    nuCant NUMBER;
BEGIN
    
    SELECT COUNT(*)
    INTO   nuCant
    FROM   homologacion_servicios 
    WHERE  servicio_origen = 'DAOR_ORDER_ACTIVITY.FNUGETORDER_ID';
    
    IF nuCant > 1 THEN

        delete
        from HOMOLOGACION_SERVICIOS
        where servicio_origen = 'DAOR_ORDER_ACTIVITY.FNUGETORDER_ID'
        and ROWNUM = 1;
        
    END IF;
    
    commit;

END;
/

--Punto 3
--Insertar las siguientes homologaciones, que existen en EFIGAS y no en GDC (Si el servicio_destino no existe, se debe crear):
DECLARE 
    
    nuCant  NUMBER;
    
    CURSOR cuExisteReg(isbservicio_origen IN homologacion_servicios.servicio_origen%TYPE,
                       isbservicio_destino IN homologacion_servicios.servicio_destino%TYPE)
    IS
    SELECT COUNT(*)    
    FROM   homologacion_servicios 
    WHERE  servicio_origen = isbservicio_origen
    AND    servicio_destino = isbservicio_destino;    

BEGIN
    
    OPEN cuExisteReg('DBMS_OUTPUT', '**VER OBSERVACIÓN**');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN     
        --DBMS_OUTPUT
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'DBMS_OUTPUT',
            'Paquete para escritura en la salida estándar de la BD',
            'ADM_PERSON',
            '**VER OBSERVACIÓN**',
            '**VER OBSERVACIÓN**',
            'Se deben eliminar los llamados a los métodos dbms_output.disable,dbms_output.enable 
        Los llamados a los métodos: dbms_output.new_line, dbms_output.put, Dbms_Output.Put_Line de ser  
        deben reemplazarse por el método:pkg_traza.trace '
        );
    
    END IF;
    
    -------
    OPEN cuExisteReg('PKTBLSUSCRIPC.FNUGETADDRESS_ID', 'PKG_BCCONTRATO.FNUIDDIRECCREPARTO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN   
        --PKTBLSUSCRIPC.FNUGETADDRESS_ID
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'PKTBLSUSCRIPC.FNUGETADDRESS_ID',
            'Consultar direccion de reparto',
            'ADM_PERSON',
            'PKG_BCCONTRATO.FNUIDDIRECCREPARTO',
            'Consultar direccion de reparto',
            NULL
        );
    END IF;
            
    -------
    OPEN cuExisteReg('SA_BOUSER.FNUGETUSERID', 'PKG_SESSION.FNUGETUSERIDBYMASK');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN 
        --SA_BOUSER.FNUGETUSERID
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'SA_BOUSER.FNUGETUSERID',
            'Obtiene el id de usuario para la máscara de usuario enviada.',
            'ADM_PERSON',
            'PKG_SESSION.FNUGETUSERIDBYMASK',
            'El método SA_BOUSER.FNUGETUSERID se encuentra sobrecargado, cuando se esté usando con el envío de la máscara se debe reemplazar por PKG_SESSION.FNUGETUSERIDBYMASK',
            NULL
        );
    END IF;

    -------
    OPEN cuExisteReg('GW_BOERRORS.CHECKERROR', 'PKG_ERROR.SETERRORMESSAGE');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN 
        --GW_BOERRORS.CHECKERROR 
        INSERT INTO homologacion_servicios (
            esquema_origen,
            servicio_origen,
            descripcion_origen,
            esquema_destino,
            servicio_destino,
            descripcion_destino,
            observacion
        ) VALUES (
            'OPEN',
            'GW_BOERRORS.CHECKERROR',
            'Setear Error',
            'ADM_PERSON',
            'PKG_ERROR.SETERRORMESSAGE',
            NULL,
            'Tener en cuenta que servicio origen valida si existe error, si el error existe se hace raise del error'
        );
    END IF;
    
    commit;
END;
/
-- Punto 4
-- Para la homologación de UT_TRACE.TRACE, actualizar el campo observación con el siguiente mensaje
UPDATE homologacion_servicios
SET observacion = 'Tener en cuenta que existe servicio que recibe 3 parámetros. Para esos casos se debe ajustar para concatenar el parámetro 1 y el 2. Ejemplo: UT_Trace.Trace(''inuProducto='', inuProducto, 10); por pkg_traza.trace(''inuProducto = ''||to_char(inuProducto), 10);'
WHERE servicio_origen = 'UT_TRACE.TRACE';

commit;

/
-- Punto 5
-- Validar si existe alguna homologación nueva que exista en EFIGAS y no en GDC
DECLARE 
    
    nuCant  NUMBER;
    
    CURSOR cuExisteReg(isbservicio_origen IN homologacion_servicios.servicio_origen%TYPE,
                       isbservicio_destino IN homologacion_servicios.servicio_destino%TYPE)
    IS
    SELECT COUNT(*)    
    FROM   homologacion_servicios 
    WHERE  servicio_origen = isbservicio_origen
    AND    servicio_destino = isbservicio_destino;    

BEGIN
    --Objetos con su servicio origen y destino existente     
    --1
    OPEN cuExisteReg('DAMO_PACKAGES.FDTATTENTION_DATE', 'PKG_BCSOLICITUDES.FDTGETFECHAATENCION');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAMO_PACKAGES.FDTATTENTION_DATE','Consultar fecha de atencion de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FDTGETFECHAATENCION',null,null);    
    END IF;
    
    --2
    OPEN cuExisteReg('DAMO_PACKAGES.FDTREQUEST_DATE', 'PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAMO_PACKAGES.FDTREQUEST_DATE','Consultar fecha de registro de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO',null,null);    
    END IF;
    
    --3
    OPEN cuExisteReg('DAMO_PACKAGES.FNUPRODUCT_ID', 'PKG_BCSOLICITUDES.FNUGETPRODUCTO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAMO_PACKAGES.FNUPRODUCT_ID','Consultar producto de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETPRODUCTO',null,null);
    END IF;
    
    --4
    OPEN cuExisteReg('DAMO_PACKAGES.FNUSUBSCRIPTION_ID', 'PKG_BCSOLICITUDES.FNUGETCONTRATO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAMO_PACKAGES.FNUSUBSCRIPTION_ID','Consultar contrato de una solicitud','ADM_PERSON','PKG_BCSOLICITUDES.FNUGETCONTRATO',null,null);
    END IF;
    
    --5
    OPEN cuExisteReg('LDC_MANAGEMENTEMAILFNB.PROENVIARCHIVOCC', 'PKG_CORREO.PRCENVIACORREO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','LDC_MANAGEMENTEMAILFNB.PROENVIARCHIVOCC','Envia correo con archivo adjunto','ADM_PERSON','PKG_CORREO.PRCENVIACORREO','Envia Correo',null);    
    END IF;
    
    --6
    OPEN cuExisteReg('OR_BOACTIVITIESRULES.FNUGETACTIFROMORDERACT', 'PKG_BCORDENES.FNUOBTIENEITEMACTIVIDAD');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','OR_BOACTIVITIESRULES.FNUGETACTIFROMORDERACT','Retorna el item de una actividad','ADM_PERSON','PKG_BCORDENES.FNUOBTIENEITEMACTIVIDAD',null,null);
    END IF;
    
    --7
    OPEN cuExisteReg('PR_BOSUSPENSION.FNUGETLASTPRODSUSPORDERACTI', 'PKG_BCPRODUCTO.FNUIDACTIVORDENSUSP');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','PR_BOSUSPENSION.FNUGETLASTPRODSUSPORDERACTI','Retorna el id de la actividad de orden de suspensión','ADM_PERSON','PKG_BCPRODUCTO.FNUIDACTIVORDENSUSP',null,null);
    END IF; 
    
    --Objetos con su servicio origen existente y destino NO existente
    --1
    OPEN cuExisteReg('OBTVALORTARIFAVALORFIJO', 'FNUOBTVALORTARIFAVALORFIJO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','OBTVALORTARIFAVALORFIJO','Obtiene el valor tarifa valor fijo','ADM_PERSON','FNUOBTVALORTARIFAVALORFIJO','Obtiene el valor tarifa valor fijo',null);    
    END IF;
    
    --2
    OPEN cuExisteReg('CC_BOPACKADDIDATE.RUNMOCNP', 'PKG_BOGESTIONSOLICITUDES.PRCEJECUTARMOCNP');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','CC_BOPACKADDIDATE.RUNMOCNP','Carga ejecutable MOCNP de impresion','ADM_PERSON','PKG_BOGESTIONSOLICITUDES.PRCEJECUTARMOCNP','Carga ejecutable MOCNP de impresion',null);   
    END IF;
    
    --3
    OPEN cuExisteReg('OR_BOINSTANCE.SETSUCCESSININSTANCE', 'PKG_BOGESTION_INSTANCIAS.PRCFIJAREXITO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','OR_BOINSTANCE.SETSUCCESSININSTANCE','Establece EXITO en la Instancia','ADM_PERSON','PKG_BOGESTION_INSTANCIAS.PRCFIJAREXITO',null,null);   
    END IF;
    
    --4
    OPEN cuExisteReg('OR_BOINSTANCE.SETUN_SUCCESSININSTANCE', 'PKG_BOGESTION_INSTANCIAS.PRCFIJARNOEXITO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','OR_BOINSTANCE.SETUN_SUCCESSININSTANCE','Establece NO EXITO en la Instancia','ADM_PERSON','PKG_BOGESTION_INSTANCIAS.PRCFIJARNOEXITO',null,null);   
    END IF;
        
    --5
    OPEN cuExisteReg('GE_BONOTIFICATION.SETATTRIBUTE', 'PKG_BOGESTION_NOTIFICACIONES.PRCACTUALIZAATRIBUTO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','GE_BONOTIFICATION.SETATTRIBUTE','Configura atributo para notificacion','ADM_PERSON','PKG_BOGESTION_NOTIFICACIONES.PRCACTUALIZAATRIBUTO','Configura atributo para notificacion',null);    
    END IF;
    
    --6
    OPEN cuExisteReg('GE_BONOTIFICATION.SENDNOTIFY', 'PKG_BOGESTION_NOTIFICACIONES.PRCENVIANOTIFICACION');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','GE_BONOTIFICATION.SENDNOTIFY','Envía notificaccion','ADM_PERSON','PKG_BOGESTION_NOTIFICACIONES.PRCENVIANOTIFICACION','Envía notificaccion',null);    
    END IF;
    
    --7
    OPEN cuExisteReg('DAGE_NOTIFICATION.FNUGETORIGIN_MODULE_ID', 'PKG_GE_NOTIFICATION.FNUGETMODULOORIGEN');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAGE_NOTIFICATION.FNUGETORIGIN_MODULE_ID','Obtiene el Id del modulo origen','ADM_PERSON','PKG_GE_NOTIFICATION.FNUGETMODULOORIGEN','Obtiene el Id del modulo origen',null);
    END IF;
        
    --8
    OPEN cuExisteReg('DAOR_ORDER_ITEMS.UPDSERIAL_ITEMS_ID', 'PKG_OR_ORDER_ITEMS.PRCACTUALIZAITEMSERIADO');
    FETCH cuExisteReg INTO nuCant;
    CLOSE cuExisteReg;
    
    IF nuCant = 0 THEN
        Insert into HOMOLOGACION_SERVICIOS (ESQUEMA_ORIGEN,SERVICIO_ORIGEN,DESCRIPCION_ORIGEN,ESQUEMA_DESTINO,SERVICIO_DESTINO,DESCRIPCION_DESTINO,OBSERVACION) values ('OPEN','DAOR_ORDER_ITEMS.UPDSERIAL_ITEMS_ID','Actualiza el item seriado a los items de la orden','ADM_PERSON','PKG_OR_ORDER_ITEMS.PRCACTUALIZAITEMSERIADO','Actualiza el item seriado a los items de la orden',null);
    END IF;
    
    commit;
    
END;
/
