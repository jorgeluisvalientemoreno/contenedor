Declare

  Actividad        number;
  Contrato         number;
  Producto         number;
  Solicitud        number;
  Unidad_Operativa NUMBER;
  Ciclo            number;

  ID_CONTRATO_1 number;
  ID_PRODUCTO_1 number;
  PACKAGE_ID_1  number;
  ORDER_ID_1    number;
  CERTIFICADO_1 NUMBER;

begin

  select ooa.order_activity_id,
         ooa.subscription_id,
         ooa.product_id,
         ooa.package_id,
         ooa.operating_unit_id,
         (select s.susccicl
            from suscripc s
           where s.susccodi = ooa.subscription_id)
    into Actividad, Contrato, Producto, Solicitud, Unidad_Operativa, Ciclo
    from open.Or_Order_Activity ooa
   where ooa.order_id = 275457678;

  DBMS_OUTPUT.put_line('Actividad[' || Actividad || '], Contrato[' ||
                       Contrato || '], Producto[' || Producto ||
                       '], Solicitud[' || Solicitud ||
                       '], Unidad_Operativa[' || Unidad_Operativa ||
                       '], Ciclo[' || Ciclo || ']');

  select CERTIFICADO, ID_CONTRATO, ID_PRODUCTO, PACKAGE_ID, ORDER_ID
  --t.*, t.rowid
    INTO CERTIFICADO_1,
         ID_CONTRATO_1,
         ID_PRODUCTO_1,
         PACKAGE_ID_1,
         ORDER_ID_1
    from LDC_CERTIFICADOS_OIA t
   WHERE /*T.STATUS_CERTIFICADO = 'A'
       and */
   t.certificados_oia_id in (3) --(1, 3, 5)
  --and t.order_id = 267875945
   order by 1;

  DBMS_OUTPUT.put_line('CERTIFICADO[' || CERTIFICADO_1 ||
                       '], ID_CONTRATO[' || ID_CONTRATO_1 ||
                       '], ID_PRODUCTO[' || ID_PRODUCTO_1 ||
                       '], PACKAGE_ID [' || PACKAGE_ID_1 || '], ORDER_ID[' ||
                       ORDER_ID_1 || ']');

  begin
    update LDC_CERTIFICADOS_OIA t
       set ID_CONTRATO = Contrato,
           ID_PRODUCTO = Producto,
           PACKAGE_ID  = Solicitud,
           ORDER_ID    = 275457678
     WHERE t.certificados_oia_id = 3;
    commit;
  end;

  /*
  SELECT id_producto, id_organismo_oia, resultado_inspeccion --INTO nuproductocert,nuorganismoinsp,nuresultadoins
    FROM (SELECT c.id_producto,
                 c.id_organismo_oia,
                 c.resultado_inspeccion,
                 l.CONTRALEGCERT
          -- se agrega la tabla de configuracion de oia de certificacion
            FROM open.ldc_certificados_oia c, open.LDCCTROIACCTRL l
           WHERE TRIM(c.certificado) = TRIM(34157)
                --se agrega la validacion de oia de certificacion
             AND c.id_producto = 50734241
             AND c.id_organismo_oia = l.CONTRATISTAOIA
             AND l.CONTRALEGCERT = 4205
           ORDER BY c.fecha_registro DESC)
   WHERE ROWNUM = 1;
  SELECT id_producto, id_organismo_oia, resultado_inspeccion
    INTO nuproductocert, nuorganismoinsp, nuresultadoins
    FROM (SELECT c.id_producto, c.id_organismo_oia, c.resultado_inspeccion
          -- se agrega la tabla de configuracion de oia de certificacion
            FROM open.ldc_certificados_oia c, open.LDCCTROIACCTRL l
           WHERE TRIM(c.certificado) = TRIM(sbcertificado)
                --se agrega la validacion de oia de certificacion
             AND c.id_producto = 6591919
             AND c.id_organismo_oia = l.CONTRATISTAOIA
             AND l.CONTRALEGCERT = nuunitoper
           ORDER BY c.fecha_registro DESC)
   WHERE ROWNUM = 1;
   */

end;
