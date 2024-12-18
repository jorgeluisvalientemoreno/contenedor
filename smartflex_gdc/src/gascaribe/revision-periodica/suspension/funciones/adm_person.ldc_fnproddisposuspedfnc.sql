CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNPRODDISPOSUSPEDFNC" (PRODUCT_ID in number) return nvarchar2 is
   /*****************************************************************
        Propiedad intelectual de GDC.

        Unidad         : LDC_FNPRODDISPOSUSPEDFNC
        Descripcion    : FUNCION QUE VALIDA SI EL PRODUCTO TIENES ORDENES PARA SUSPENDER
        Autor          : Luis Salazar
        Fecha          : 22/08/2018

        Parametros              Descripcion
        ============         ===================
        PRODUCT_ID           Producto a consultar



        Historia de Modificaciones
        Fecha             Autor             Modificacion
        =========       =========           ====================


        ******************************************************************/

  nuDias_Anti_Notf number := nvl(open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_ANTICIPAR_NOTIFI_RP',NULL),0);
  nuDias_repa_OIA number := open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO_OIA', NULL);
  nuDias number := open.Dald_parameter.fnuGetNumeric_Value('DIAS_SUSP_X_DEFECTO',NULL);
  nuDias_dif_repa number := open.Dald_parameter.fnuGetNumeric_Value('NUM_DIAS_NOTIFICAR_RP_REPA',NULL);
  producto pr_product.product_id%TYPE;

  --Se valida si un producto se puede o no suspender
  CURSOR cuValidaProducto IS
   WITH ProductoFec AS
   (
     SELECT a.ID_PRODUCTO PRODUCTO
     FROM   ldc_plazos_cert a
     WHERE  A.plazo_min_suspension <= SYSDATE + nuDias_Anti_Notf
        AND A.is_notif IN ('YV', 'YR')
        AND a.ID_PRODUCTO = PRODUCT_ID

     ), producto AS(
        SELECT PRODUCTO
        FROM ProductoFec
        UNION
        SELECT a.ID_PRODUCTO
        FROM  ldc_marca_producto a, ldc_plazos_cert    B
        WHERE  fecha_ultima_actu <= (CASE WHEN a.MEDIO_RECEPCION = 'E' THEN
                                  SYSDATE - (nuDias_repa_OIA)
                              ELSE
                                  SYSDATE - (nuDias + nuDias_dif_repa)
                              END)
          AND REGISTER_POR_DEFECTO = 'Y'
          AND is_notif IN ('YV', 'YR')
          AND a.ID_PRODUCTO = PRODUCT_ID
          AND a.id_producto = b.id_producto
        UNION
        ( SELECT PRODUCTO
          FROM ProductoFec
          INTERSECT
          SELECT product_id
          FROM or_order_activity oa, or_order o
          WHERE oa.order_id = o.order_id
            AND o.task_type_id = 10445 AND o.order_status_id = 11
            AND product_id = PRODUCT_ID
        )
   )
    SELECT *
    FROM producto
    WHERE NOT EXISTS
     (SELECT PRODUCT_ID
       FROM   pr_prod_suspension
     WHERE  suspension_type_id IN (101, 102, 103, 104)
        AND active = 'Y'
        and PRODUCT_ID = PRODUCTO
             );

 sbSuspender VARCHAR2(1) := 'N';

begin
   --se carga consulta de validacion
   OPEN cuValidaProducto;
   FETCH cuValidaProducto INTO producto;
   IF cuValidaProducto%FOUND THEN
      sbSuspender := 'S';
   END IF;
   CLOSE cuValidaProducto;

  RETURN sbSuspender;

EXCEPTION
  when OTHERS then
    return sbSuspender;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNPRODDISPOSUSPEDFNC', 'ADM_PERSON');
END;
/