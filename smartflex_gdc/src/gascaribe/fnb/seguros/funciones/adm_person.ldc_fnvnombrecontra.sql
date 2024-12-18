CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNVNOMBRECONTRA" (inPackage OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
                                               inOrder   OR_ORDER.ORDER_ID%TYPE,
                                               inArticle LD_ITEM_WORK_ORDER.ARTICLE_ID%TYPE)
  RETURN VARCHAR2 IS
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : LDC_FNVNOMBRECONTRA
  Descripcion : Funcion que retorna el nombre del proveedor que vende cardiff
  Autor       : Sebastian Tapias
  Fecha       : 10-08-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  v_Package  NUMBER := inPackage; --15652408
  v_Order    NUMBER := inOrder;
  v_Nombre   VARCHAR2(300) := null;
  v_ArtCar   NUMBER := 0;
  v_Articulo NUMBER := inArticle;
  v_Supplier NUMBER := null;
  v_Return   VARCHAR2(300) := null;

  CURSOR cuArticleBrilla(inuArti  LD_ITEM_WORK_ORDER.ARTICLE_ID%TYPE,
                         inuOrder OR_ORDER.ORDER_ID%TYPE) IS
    SELECT COUNT(1)
      FROM open.ld_item_work_order l
     WHERE l.article_id = inuArti
       AND l.order_id = inuOrder
       AND l.article_id IN
           (SELECT l.article_id
              FROM open.LD_ARTICLE L
             WHERE L.Concept_Id IN
                   (select nvl(to_number(column_value), 0)
                      from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                         NULL),

                                                                   ','))))
       AND ROWNUM = 1;
  CURSOR cuSuplierBrilla(inuPackage OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
                         inuOrder   OR_ORDER.ORDER_ID%TYPE) IS
    SELECT li.supplier_id
      FROM open.ld_item_work_order li,
           open.or_order           oo,
           open.or_order_activity  ooa
     WHERE oo.order_id = ooa.order_id
       AND li.order_id = oo.order_id
       AND ooa.package_id = inuPackage
       AND oo.order_id NOT IN inuOrder
       AND oo.task_type_id in
           (open.dald_parameter.fnuGetNumeric_Value('COD_FNB_SALE_TASK_TYPE'),
            open.dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB'))
       AND li.article_id NOT IN
           (SELECT l.article_id
              FROM open.LD_ARTICLE L
             WHERE L.Concept_Id IN
                   (select nvl(to_number(column_value), 0)
                      from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                         NULL),
                                                                   ','))))
       AND ROWNUM = 1;
  CURSOR cuSuplierBrillaArti(inuPackage OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
                             inuOrder   OR_ORDER.ORDER_ID%TYPE,
                             inuArti    LD_ITEM_WORK_ORDER.ARTICLE_ID%TYPE) IS
    SELECT li.supplier_id
      FROM open.ld_item_work_order li,
           open.or_order           oo,
           open.or_order_activity  ooa
     WHERE oo.order_id = ooa.order_id
       AND li.order_id = oo.order_id
       AND ooa.package_id = inuPackage
       AND oo.order_id = inuOrder
       AND li.article_id NOT IN inuArti
       AND oo.task_type_id in
           (open.dald_parameter.fnuGetNumeric_Value('COD_FNB_SALE_TASK_TYPE'),
            open.dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB'))
       AND li.article_id NOT IN
           (SELECT l.article_id
              FROM open.LD_ARTICLE L
             WHERE L.Concept_Id IN
                   (select nvl(to_number(column_value), 0)
                      from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CONCEPTO_EXCLUIDO_CUPO_BRILLA',
                                                                                                         NULL),
                                                                   ','))))
       AND ROWNUM = 1;
  CURSOR cuSuplierProveedor(inuPackage OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
                            inuOrder   OR_ORDER.ORDER_ID%TYPE,
                            inuArti    LD_ITEM_WORK_ORDER.ARTICLE_ID%TYPE) IS
    SELECT li.supplier_id
      INTO v_Supplier
      FROM open.ld_item_work_order li,
           open.or_order           oo,
           open.or_order_activity  ooa
     WHERE oo.order_id = ooa.order_id
       AND li.order_id = oo.order_id
       AND ooa.package_id = inuPackage
       AND oo.order_id IN inuOrder
       AND oo.task_type_id in
           (open.dald_parameter.fnuGetNumeric_Value('COD_FNB_SALE_TASK_TYPE'),
            open.dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB'))
       AND li.article_id = inuArti
       AND ROWNUM = 1;

BEGIN
  BEGIN
    --Verifica si el articulos es de tipo brilla
    OPEN cuArticleBrilla(v_Articulo, v_Order);
    FETCH cuArticleBrilla
      INTO v_ArtCar;
    CLOSE cuArticleBrilla;

    --  Si lo es, se busca el contratista (proveedor) asociado a la otra orden de entrega de la misma solicitud
    IF (v_ArtCar >= 1) THEN
      dbms_output.put_line('Seguro Cardif [' || v_ArtCar || ']' || chr(13));
      OPEN cuSuplierBrilla(v_Package, v_Order);
      FETCH cuSuplierBrilla
        INTO v_Supplier;
      IF cuSuplierBrilla%NOTFOUND THEN
        v_Supplier := null;
      END IF;
      CLOSE cuSuplierBrilla;
      dbms_output.put_line('v_Supplier [' || v_Supplier || ']' || chr(13));
      IF (v_Supplier is null) THEN
        OPEN cuSuplierBrillaArti(v_Package, v_Order, v_Articulo);
        FETCH cuSuplierBrillaArti
          INTO v_Supplier;
        IF cuSuplierBrillaArti%NOTFOUND THEN
          v_Supplier := '-';
        END IF;
        CLOSE cuSuplierBrillaArti;
      END IF;
      -- Si no es, se busca el contratista (proveedor) de la misma orden que ingresa
    ELSE
      dbms_output.put_line('Articulo Normal[' || v_ArtCar || ']' ||
                           chr(13));
      OPEN cuSuplierProveedor(v_Package, v_Order, v_Articulo);
      FETCH cuSuplierProveedor
        INTO v_Supplier;
      CLOSE cuSuplierProveedor;
      dbms_output.put_line('v_Supplier [' || v_Supplier || ']' || chr(13));
    END IF;
    -- Se busca el nombre del proveedor con el codigo obtenido
    SELECT CTT.NOMBRE_CONTRATISTA
      INTO v_Nombre
      FROM OPEN.GE_CONTRATISTA CTT
     WHERE CTT.ID_CONTRATISTA = v_Supplier
       AND ROWNUM = 1;
    dbms_output.put_line('Nombre del Proveedor [' || v_Nombre || ']' ||
                         chr(13));
   -- v_Return := v_Supplier || ' - ' || v_Nombre;
    v_Return := v_Nombre;
    dbms_output.put_line('Return [' || v_Return || ']' || chr(13));

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_Return := '-';
  END;
  RETURN v_Return;
EXCEPTION
  WHEN OTHERS THEN
    RETURN '-';
END LDC_FNVNOMBRECONTRA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNVNOMBRECONTRA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNVNOMBRECONTRA TO REPORTES;
/
