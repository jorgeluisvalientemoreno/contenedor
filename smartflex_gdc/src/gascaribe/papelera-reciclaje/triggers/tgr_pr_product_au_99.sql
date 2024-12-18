CREATE OR REPLACE TRIGGER TGR_PR_PRODUCT_AU_99
AFTER UPDATE OF PRODUCT_STATUS_ID ON PR_PRODUCT
FOR EACH ROW
WHEN ( OLD.PRODUCT_STATUS_ID <> NEW.PRODUCT_STATUS_ID )
/**************************************************************************
    Autor       :
    Fecha       : 31/05/2020
    Ticket      : 322
    Descripción: Trigger para validar si se cumplen con las condiciones
				para actualizar las variable presion
                operacion.

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE

    sbProductsTypes ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('LDC_PROD_TYPES_VAR_CORR');
    sbRequestTypes ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('LDC_PACK_TYPES_VAR_CORR');

    sbQuery VARCHAR2(10000);
    nuCountProductTypes NUMBER;
    nuCountPackagesTypes NUMBER;
    nuEstadoActual  HICAESCO.HCECECAC%type;
    nuEstadoAnterior HICAESCO.HCECECAN%type;
    cursor cuGetEstadoCorte(inuProducto IN pr_product.product_id%type)is
        SELECT subQuery.HCECECAC,
        subQuery.HCECECAN
        FROM (
            SELECT HCECECAC,
            HCECECAN
            FROM HICAESCO
            WHERE HCECNUSE = inuProducto
            ORDER BY HCECFECH DESC) subQuery
        WHERE ROWNUM = 1;
BEGIN
    ut_trace.trace('Inicia TGR_PR_PRODUCT_AU_99',10);

	ut_trace.trace('Cursor para obtener el cambio de estado de corte',10);

	OPEN cuGetEstadoCorte(:OLD.PRODUCT_ID);
	FETCH cuGetEstadoCorte INTO nuEstadoActual,nuEstadoAnterior;
	CLOSE cuGetEstadoCorte;

	ut_trace.trace('Valida que el nuevo estado sea activo y que su estado inmediatamente anterior sea PENDIENTE o que su ultimo cambio de estado de corte
	haya sido del estado Inactivo a Conexion',10);

	IF (:OLD.PRODUCT_STATUS_ID = 15 AND :NEW.PRODUCT_STATUS_ID = 1) OR (nuEstadoAnterior = 96 AND nuEstadoActual = 1) THEN

		ut_trace.trace('Se valida que los valores de los parametros tengan un valor',10);

		IF sbProductsTypes IS NOT NULL AND sbRequestTypes IS NOT NULL THEN

			ut_trace.trace('Cursor para determinar si el tipo de producto se encuentra en el parametro LDC_PROD_TYPES_VAR_CORR',10);

			SELECT COUNT(1)
			INTO nuCountProductTypes
			FROM (
				select to_number(regexp_substr(sbProductsTypes,'[^,]+', 1, level)) as valores
				from   dual
				connect by regexp_substr(sbProductsTypes, '[^,]+', 1, level) is not null)
			WHERE valores = :OLD.PRODUCT_TYPE_ID;



			IF nuCountProductTypes > 0 THEN

				ut_trace.trace('Cursor para determinar si el producto tiene solicitudes asociadas al tipo que se encuentra en el parametro LDC_PACK_TYPES_VAR_CORR',10);

				sbQuery := 'SELECT COUNT(mp.package_id) '||CHR(10);
				sbQuery := sbQuery || ' FROM mo_packages mp, mo_motive mm'|| chr(10);
				sbQuery := sbQuery || ' WHERE mp.PACKAGE_ID = mm.package_id'||chr(10);
				sbQuery := sbQuery || ' AND mp.motive_status_id in (13,14)'||chr(10);
				sbQuery := sbQuery || ' AND mp.package_type_id in ('||sbRequestTypes||')'||chr(10);
				sbQuery := sbQuery || ' AND mm.product_id = :a';

				EXECUTE IMMEDIATE sbQuery INTO nuCountPackagesTypes USING :OLD.PRODUCT_ID;

				IF nuCountPackagesTypes > 0 THEN

					ut_trace.trace('Se llama el servicio para actualizar la variable teniendo en cuenta la categoria y subcategoria del producto',10);

					LDC_BOACTUALIZAVARIABLES.ACTUALIZAVARBYPRODUCT(:OLD.PRODUCT_ID,:OLD.CATEGORY_ID, :OLD.SUBCATEGORY_ID, :OLD.address_id);

				END IF;

			END IF;

		END IF;

	END IF;
    ut_trace.trace('Fin TGR_PR_PRODUCT_AU_99',10);

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;

     WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
END TGR_PR_PRODUCT_AU_99;
/
