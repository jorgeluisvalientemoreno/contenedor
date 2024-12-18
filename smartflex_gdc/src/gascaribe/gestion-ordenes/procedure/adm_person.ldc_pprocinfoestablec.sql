CREATE OR REPLACE PROCEDURE adm_person.ldc_pprocinfoestablec
IS
    /******************************************************************************************
	Autor: Harrinson Henao Camelo/Horbath
    Nombre Objeto: LDC_PPROCINFOESTABLEC
    Tipo de objeto: procedimiento
	Fecha: 25-01-2022
	Ticket: CA918
	Descripcion:    PLUGIN para Procesamiento informacion
                    establecimientos por archivo

	Historia de modificaciones
    FECHA           AUTOR               DESCRIPCION
    -----           -----               -----------------------
    16/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
	25-01-2022	    hahenao.horbath	    Creacion    
	******************************************************************************************/
    -----------------------------
    -- Constantes Privadas
    -----------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete
    csbversion  CONSTANT VARCHAR2(100) := 'CA918';

    -- Para el control de traza:
    csbsp_name          CONSTANT VARCHAR2(100) := $$plsql_unit||'.';
    csbpush             CONSTANT VARCHAR2(50) := 'Inicia ';
    csbpop              CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbpop_erc          CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbpop_err          CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbldc              CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza BO.
    cnulevelpushpop     CONSTANT NUMBER := 1;
    cnulevel            CONSTANT NUMBER := 7;
    cnugenericerror     CONSTANT NUMBER := 2741;
    --Parametro con el grupo atributo de la informacion comercial del establecimiento
    csbgratrib          CONSTANT VARCHAR2(100) := 'LDC_GATR_ESTABCOMER';
    --Parametro con el atributo para sector comercial y nombre de establecimiento
    csbparatrsector     CONSTANT VARCHAR2(100) := 'LDC_ATR_SECTCOMER';
    csbparatrnomestab   CONSTANT VARCHAR2(100) := 'LDC_ATR_NOMBESTAB';
    --Parametro con los tipos de trabajo para los que aplica la logica
    csbparttinfocomer   CONSTANT VARCHAR2(100) := 'LDC_TTACT_SECTCOMER';
    --Cursores
    CURSOR cuorderdata
    (
        inuorderid  IN  or_order.order_id%TYPE
    )
    IS
    SELECT A.product_id, A.task_type_id
    FROM or_order_activity A
    WHERE A.order_id = inuorderid
    AND ROWNUM = 1;

    --Variables del proceso
    nuorderid           or_order.order_id%TYPE;
    nutasktype          or_order.task_type_id%TYPE;
    nuproductid         ldc_prod_comerc_sector.product_id%TYPE;
    nuidsector          ldc_prod_comerc_sector.comercial_sector_id%TYPE;
    sbnombestab         ldc_prod_comerc_sector.nombre_establec%TYPE;
    nuexistsector       NUMBER;
    sbmethodname        VARCHAR2(50) := 'LDC_PPROCINFOESTABLEC';
    nugratrib           ge_attributes_set.attribute_set_id%TYPE;
    nuatrsector         ge_attributes.attribute_id%TYPE;
    nuatrnomestab       ge_attributes.attribute_id%TYPE;
    rcprodcomersector   daldc_prod_comerc_sector.styldc_prod_comerc_sector;
    sbttactinfocomerc   VARCHAR2(100);

    FUNCTION fsbgetdatoadictmporden
    (
        inuordenleg IN  or_order.order_id%TYPE,
        inugratrib  IN  or_temp_data_values.attribute_set_id%TYPE,
        inuidatrib  IN  or_temp_data_values.attribute_id%TYPE,
        isbnombre   IN  or_temp_data_values.attribute_name%TYPE
    )
    RETURN VARCHAR2;

    FUNCTION fsbgetdatoadictmporden
    (
        inuordenleg IN  or_order.order_id%TYPE,
        inugratrib  IN  or_temp_data_values.attribute_set_id%TYPE,
        inuidatrib  IN  or_temp_data_values.attribute_id%TYPE,
        isbnombre   IN  or_temp_data_values.attribute_name%TYPE
    )
    RETURN VARCHAR2
    IS
        CURSOR cudatostmporden
        IS
        SELECT data_value
        FROM or_temp_data_values
        WHERE order_id = inuordenleg
        AND attribute_set_id = inugratrib
        AND attribute_id = inuidatrib
        AND attribute_name = isbnombre;
        
        sbreturn    or_temp_data_values.data_value%TYPE;

    BEGIN
        sbreturn := NULL;
    
        IF (cudatostmporden%isopen) THEN
            CLOSE cudatostmporden;
        END IF;
    
        OPEN cudatostmporden;
        FETCH cudatostmporden INTO sbreturn;
        CLOSE cudatostmporden;
    
        RETURN sbreturn;
    EXCEPTION
        WHEN ex.controlled_error THEN
            RETURN NULL;
    END;

BEGIN
    ut_trace.TRACE(csbldc||csbsp_name||csbpush||sbmethodname,cnulevelpushpop);
    IF (fblaplicaentregaxcaso('0000918')) THEN
        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuorderid:=   or_bolegalizeorder.fnugetcurrentorder;

        --Se valida existencia y nulidad de parametros
        IF NOT (dald_parameter.fblexist(csbgratrib)) THEN
            ge_boerrors.seterrorcodeargument
            (
                cnugenericerror,
                'El parametro ['||csbgratrib||'] no existe en LDPAR'
            );
            RAISE ex.controlled_error;
        ELSE
            nugratrib := dald_parameter.fnugetnumeric_value(csbgratrib);

            IF (nugratrib IS NULL) THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnugenericerror,
                    'El grupo de atributos no esta configurado en el parametro ['||csbgratrib||'] en LDPAR'
                );
                RAISE ex.controlled_error;
            END IF;
        END IF;

        IF NOT (dald_parameter.fblexist(csbparatrsector)) THEN
            ge_boerrors.seterrorcodeargument
            (
                cnugenericerror,
                'El parametro ['||csbparatrsector||'] no existe en LDPAR'
            );
            RAISE ex.controlled_error;
        ELSE
            nuatrsector := dald_parameter.fnugetnumeric_value(csbparatrsector);

            IF (nuatrsector IS NULL) THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnugenericerror,
                    'El atributo para el sector comercial no esta configurado en el parametro ['||csbparatrsector||'] en LDPAR'
                );
                RAISE ex.controlled_error;
            END IF;
        END IF;

        IF NOT (dald_parameter.fblexist(csbparatrnomestab)) THEN
            ge_boerrors.seterrorcodeargument
            (
                cnugenericerror,
                'El parametro ['||csbparatrnomestab||'] no existe en LDPAR'
            );
            RAISE ex.controlled_error;
        ELSE
            nuatrnomestab := dald_parameter.fnugetnumeric_value(csbparatrnomestab);

            IF (nuatrnomestab IS NULL) THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnugenericerror,
                    'El atributo para el nombre del establecimiento no esta configurado en el parametro ['||csbparatrnomestab||'] en LDPAR'
                );
                RAISE ex.controlled_error;
            END IF;
        END IF;

        IF NOT (dald_parameter.fblexist(csbparttinfocomer)) THEN
            ge_boerrors.seterrorcodeargument
            (
                cnugenericerror,
                'El parametro ['||csbparttinfocomer||'] no existe en LDPAR'
            );
            RAISE ex.controlled_error;
        ELSE
            sbttactinfocomerc := dald_parameter.fsbgetvalue_chain(csbparttinfocomer);

            IF (sbttactinfocomerc IS NULL) THEN
                ge_boerrors.seterrorcodeargument
                (
                    cnugenericerror,
                    'Los codigos de los tipos de trabajo que actualizan informacion comercial no estan configurados en el parametro ['||csbparttinfocomer||'] en LDPAR'
                );
                RAISE ex.controlled_error;
            END IF;
        END IF;

        --Obtener el numero de producto y tipo de la orden
        IF (cuorderdata%isopen) THEN
            CLOSE cuorderdata;
        END IF;

        OPEN cuorderdata(nuorderid);
        FETCH cuorderdata INTO nuproductid, nutasktype;
        CLOSE cuorderdata;

        --Se valida que los tipos de trabajo sean los parametrizados para actualizar informacin comercial
        IF (','||sbttactinfocomerc||',' LIKE '%,'||nutasktype||',%') THEN
            --Obtiene el codigo de sector
            nuidsector := to_number(fsbgetdatoadictmporden(nuorderid,nugratrib,nuatrsector,dage_attributes.fsbgetname_attribute(nuatrsector)));
            sbnombestab := fsbgetdatoadictmporden(nuorderid,nugratrib,nuatrnomestab,dage_attributes.fsbgetname_attribute(nuatrnomestab));

            --Se valida que se hayan ingresado los datos adicionales en la legalizacion de la orden
            IF (nuidsector IS NOT NULL AND sbnombestab IS NOT NULL) THEN

                SELECT COUNT(*) INTO nuexistsector
                FROM ldc_sector_comercial
                WHERE comercial_sector_id = nuidsector;

                IF (nuexistsector = 0) THEN
                    ge_boerrors.seterrorcodeargument
                    (
                        cnugenericerror,
                        'El sector comercial ingresado no existe en Smart Flex, corrija la informacion'
                    );
                    RAISE ex.controlled_error;
                END IF;

                --Se alimenta el registro de la tabla ldc_prod_comerc_sector
                rcprodcomersector.product_id := nuproductid;
                rcprodcomersector.comercial_sector_id := nuidsector;
                rcprodcomersector.nombre_establec := sbnombestab;
                rcprodcomersector.last_update_date := sysdate;
                rcprodcomersector.last_user_update := pkgeneralservices.fsbgetusername;

                IF (daldc_prod_comerc_sector.fblexist(nuproductid)) THEN
                    --Se actualiza el registro
                    daldc_prod_comerc_sector.updrecord(rcprodcomersector);
                ELSE
                    --Se inserta el registro
                    daldc_prod_comerc_sector.insrecord(rcprodcomersector);
                END IF;
            END IF;
        END IF;
    END IF;
    
    ut_trace.TRACE(csbldc||csbsp_name||csbpop||sbmethodname,cnulevelpushpop);
EXCEPTION
    WHEN ex.controlled_error THEN
        ut_trace.TRACE(csbldc||csbsp_name||csbpop_erc||sbmethodname,cnulevel);
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ut_trace.TRACE(csbldc||csbsp_name||csbpop_err||sbmethodname,cnulevel);
        ERRORS.seterror;
        RAISE ex.controlled_error;
END ldc_pprocinfoestablec;
/
PROMPT Otorgando permisos de ejecucion a LDC_PPROCINFOESTABLEC
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PPROCINFOESTABLEC','ADM_PERSON');
END;
/