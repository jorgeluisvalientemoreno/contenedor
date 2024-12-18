CREATE OR REPLACE PROCEDURE adm_person.LDC_NOTIFICA_CIERRE_OT (
    nuOrden   or_order.order_id%TYPE,
    sbTipo    VARCHAR2)
AS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDC_NOTIFICA_CIERRE_OT
    Descripcion :  Validaciones:
                  *Notifica cierre de ordenes de trabajo a la unidad y al responsable configurado

    Autor       : Josh Brito
    Fecha       : 13-04-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========           ====================
    13-04-2018          Josh Brito          Creacion Caso 200-1871
    01/06/2020          dsaltarin           407: Si en el parmaetro sbTipo hay una "A"
    16/03/2021          dsaltarin           647: Se incluye notificacion de orden cerrada por suspensión de otro proceso.
    19/05/2021          horbath             693  consulte la configuración de la tabla LDC_CONFNCOR dependiendo del tipo de notificación
    26/04/2024          PACOSTA             OSF-2598: Se retira el llamado al esquema OPEN (open.)
                                            Se crea el objeto en el esquema adm_person
    19/06/2024          jpinedc             OSF-2605: * Se usa pkg_Correo
                                            * Ajustes por estándares
    **************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'LDC_NOTIFICA_CIERRE_OT';    
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuAddressId        ab_address.address_id%TYPE;
    sbmensamen         VARCHAR2 (4000);
    sbCorreosRes       VARCHAR2 (4000);
    sbsubject          VARCHAR2 (4000) := 'Notifcacion de cierre de Ordenes';
    sbRazon            VARCHAR2 (4000);
    nuDepart           ge_geogra_location.geograp_location_id%TYPE;
    NOMBRE_BD          VARCHAR2 (4000);
    sbDescUni          VARCHAR2 (4000);

    CURSOR cuDatosOt IS
        SELECT o.operating_unit_id,
               p.package_type_id,
               a.address_id,
               o.external_address_id,
               a.product_id,
               o.task_type_id,
               (SELECT description
                  FROM or_task_type t
                 WHERE t.task_type_id = o.task_type_id)    desc_titr,
               u.name                                      nombre_unidad,
               TRIM (u.e_mail)                             correo,
               o.order_status_id
          FROM or_order_activity  a,
               or_order           o
               LEFT JOIN or_operating_unit u
                   ON o.operating_unit_id = u.operating_unit_id,
               mo_packages        p
         WHERE     o.order_id = a.order_id
               AND a.package_id = p.package_id
               AND o.order_id = nuOrden
               AND a.package_id IS NOT NULL
               AND ROWNUM = 1;

    CURSOR cuPersonasNot (
        nuTipoSol   ps_package_type.package_type_id%TYPE,
        nuDepart    ge_geogra_location.geograp_location_id%TYPE)
    IS
        SELECT n.*, TRIM (p.e_mail) e_mail
          FROM ldc_notif_packtype n, ge_person p
         WHERE     package_type_id = nuTipoSol
               AND (departamento = nuDepart OR departamento = -1)
               AND p.person_id = n.person_id;

    CURSOR cuConfiguracion IS
        SELECT *
          FROM LDC_CONFNCOR
         WHERE CONCTIPO = sbTipo;

    regConfiguracion   cuConfiguracion%ROWTYPE;
    nuExisteConf       NUMBER;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    NOMBRE_BD := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;

    OPEN cuConfiguracion;

    FETCH cuConfiguracion INTO regConfiguracion;

    IF cuConfiguracion%NOTFOUND
    THEN
        nuExisteConf := 0;
    ELSE
        sbsubject := regConfiguracion.CONCRAZO;
        sbRazon := regConfiguracion.CONCASUN;
    END IF;

    CLOSE cuConfiguracion;


    IF nuExisteConf = 0
    THEN
        IF sbTipo = 'L'
        THEN
            sbsubject :=
                'Notificacion de cierre de Ordenes de Reparacion y/o Reparación';
        ELSIF sbTipo = 'A'
        THEN
            sbRazon := 'instalacion ya cuenta con un certificado';
        ELSIF sbTipo = 'C'
        THEN
            sbRazon := 'producto  suspedido por otro proceso';
        END IF;
    END IF;

    IF NOMBRE_BD != 'P'
    THEN
        sbsubject := sbsubject || 'BASE DE DATOS DE PRUEBA';
    END IF;

    FOR reg IN cuDatosOt
    LOOP
        IF reg.address_id IS NOT NULL
        THEN
            nuAddressId := reg.address_id;
        ELSIF reg.external_address_id IS NOT NULL
        THEN
            nuAddressId := reg.external_address_id;
        ELSE
            nuAddressId :=
                pkg_BCProducto.fnuIDDireccInstalacion (reg.product_id);
        END IF;

        IF nuAddressId IS NULL
        THEN
            sbmensamen := 'No se encontro la direccion de la orden';
            pkg_Traza.Trace ('LDC_NOTIFICA_CIERRE_OT-->' || sbmensamen, 10);
            pkg_error.setErrorMessage( isbMsgErrr => sbmensamen);
        END IF;

        nuDepart :=
            pkg_BCDirecciones.fnuGetUbicaGeoPadre (pkg_BCDirecciones.fnuGetLocalidad (nuAddressId));

        IF nuDepart IS NULL
        THEN
            sbmensamen := 'No se encontro el departamente de la orden';
            pkg_Traza.Trace ('LDC_NOTIFICA_CIERRE_OT-->' || sbmensamen, 10);
            pkg_error.setErrorMessage( isbMsgErrr => sbmensamen);
        END IF;

        FOR reg2 IN cuPersonasNot (reg.package_type_id, nuDepart)
        LOOP
            IF reg2.e_mail IS NOT NULL
            THEN
                IF sbCorreosRes IS NULL
                THEN
                    sbCorreosRes := reg2.e_mail;
                ELSE
                    sbCorreosRes := sbCorreosRes || ';' || reg2.e_mail;
                END IF;
            END IF;
        END LOOP;

        IF reg.operating_unit_id IS NULL
        THEN
            sbDescUni := NULL;
        ELSE
            sbDescUni :=
                   ' de la unidad '
                || reg.operating_unit_id
                || '-'
                || reg.nombre_unidad;

            IF reg.correo IS NOT NULL
            THEN
                IF sbCorreosRes IS NULL
                THEN
                    sbCorreosRes := reg.correo;
                ELSE
                    sbCorreosRes := sbCorreosRes || ';' || reg.correo;
                END IF;
            END IF;
        END IF;

        IF sbCorreosRes IS NOT NULL
        THEN
        
            pkg_Correo.prcEnviaCorreo
            ( 
                isbDestinatarios => sbCorreosRes,
                isbAsunto       => sbsubject,
                isbMensaje      => 'Se informa que la orden '
                || nuOrden
                || ' con tipo de trabajo '
                || reg.task_type_id
                || '-'
                || reg.desc_titr
                || sbDescUni
                || ' ha sido cerrada, '
                || sbRazon
            );
            
        END IF;
    END LOOP;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        IF sbTipo = 'A'
        THEN
            NULL;
        ELSE
            RAISE;
        END IF;
    WHEN OTHERS
    THEN
        pkg_Error.setError;

        IF sbTipo = 'A'
        THEN
            NULL;
        ELSE
            RAISE pkg_Error.CONTROLLED_ERROR;
        END IF;
END LDC_NOTIFICA_CIERRE_OT;
/

PROMPT Otorgando permisos de ejecucion a LDC_NOTIFICA_CIERRE_OT

BEGIN
    pkg_utilidades.praplicarpermisos ('LDC_NOTIFICA_CIERRE_OT', 'ADM_PERSON');
END;
/