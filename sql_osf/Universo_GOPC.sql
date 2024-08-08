select /*+ INDEX (LDC_SUSP_PERSECUCION IDX_LDC_SUSP_PERSECUCION01,IDX_LDC_SUSP_PERSECUCION02) INDEX (LP PK_PROCESO) INDEX (CICLO UX_CICLO03)*/
DISTINCT LP.proceso_id CODIGO_PROCESO,
         lp.proceso_descripcion NOMBRE_PROCESO,
         SUSP_PERSEC_CICLCODI Ciclo,
         CICLDESC Descripcion_Ciclo,
         SUSP_PERSEC_PRODUCTO Producto,
         servsusc.SESUESCO CODIGO_ESTADO_CORTE,
         (SELECT ESTC.ESCODESC FROM ESTACORT ESTC WHERE ESTC.ESCOCODI = servsusc.SESUESCO) ESTADO_CORTE,
         SUBSCRIBER_NAME || ' ' || SUBS_LAST_NAME Nombre,
         SUSP_PERSEC_SALPEND Saldo,
         gc_bodebtmanagement.fnugetexpirdebtbyprod(SUSP_PERSEC_PRODUCTO) CARTERA_VENCIDA,
         (select round(MONTHS_BETWEEN(TO_DATE(sysdate),
                                      max(pps.register_date)))
            from pr_prod_suspension pps
           where pps.product_id = SUSP_PERSEC_PRODUCTO) MESES_SUSPENCION,
         SUSP_PERSEC_CONSUMO Consumo,
         SUSP_PERSEC_ACT_ORIG Actividad_Origen,
         b.DESCRIPTION Descripcion_Origen,
         SUSP_PERSEC_ACTIVID Actividad_Destino,
         a.DESCRIPTION Descripcion_Destino,
         SUSP_PERSEC_PERVARI Numero_Periodos,
         SUSP_PERSEC_PERSEC Flag_Persecucion,
         ldc_Reportesconsulta.fsbEstadoFinancieroProducto(SUSP_PERSEC_PRODUCTO) Estado_Financiero,
         SUSP_PERSEC_FEJPROC Fecha_Proceso,
         SUSP_PERSEC_CODI CONSECUTIVO,
         (SELECT count(*)
            FROM cuencobr
           WHERE cucosacu > 0
             AND cuconuse = SUSP_PERSEC_PRODUCTO) CUENTAS_CON_SALDO,
         sesucate USO,
         (select c.catedesc from categori c where c.catecodi = sesucate) DESCRIPCION_USO,
         (SELECT max(leemleto)
            FROM pr_product, lectelme
           WHERE product_id = leemsesu
             AND leemdocu = suspen_ord_Act_id
             AND leemclec <> 'F'
             AND product_id = SUSP_PERSEC_PRODUCTO) LECTURA_ULTIMA_SUSPENSION,
         (SELECT max(leemleto)
            FROM lectelme
           WHERE leemsesu = sesunuse
             AND leemclec = 'F'
             and lectelme.leemfele in
                 (SELECT max(lectelme.leemfele)
                    FROM lectelme
                   WHERE leemsesu = sesunuse
                     AND leemclec = 'F')) ULTIMA_LECTURA_FACTURACION,
         (SELECT G.GEO_LOCA_FATHER_ID FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Cod_departamento,
         (SELECT G2.DESCRIPTION FROM GE_GEOGRA_LOCATION G, GE_GEOGRA_LOCATION G2 WHERE G2.GEOGRAP_LOCATION_ID = G.GEO_LOCA_FATHER_ID AND G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Departamento,
         open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID) Cod_localidad,
         (SELECT G.DESCRIPTION FROM GE_GEOGRA_LOCATION G WHERE G.GEOGRAP_LOCATION_ID = open.DAAB_ADDRESS.FNUGETGEOGRAP_LOCATION_ID(pr.ADDRESS_ID)) Localidad
  from LDC_SUSP_PERSECUCION,
       ge_items              a,
       ge_items              b,
       ciclo,
       servsusc,
       suscripc,
       ge_subscriber,
       ldc_proceso           lp,
       ldc_proceso_actividad lpa,
       pr_product            pr
 where a.ITEMS_ID = SUSP_PERSEC_ACTIVID
   and b.ITEMS_ID = SUSP_PERSEC_ACT_ORIG
   and CICLCICO = SUSP_PERSEC_CICLCODI
   and SESUNUSE = SUSP_PERSEC_PRODUCTO
   and SESUSUSC = SUSCCODI
   and SUBSCRIBER_ID = SUSCCLIE
   and pr.PRODUCT_ID = SESUNUSE
   and SUSP_PERSEC_ORDER_ID is null
   and 0 = (select count(1)
              from ldc_consumo_cero lcc
             where lcc.proceso_id = lp.proceso_id
               and lcc.product_id = SUSP_PERSEC_PRODUCTO)
   and lp.proceso_id = lpa.proceso_id
   and (B.ITEMS_ID = lpa.activity_id OR A.ITEMS_ID = lpa.activity_id)
   and SUSP_PERSEC_CICLCODI = 5502
   --and rownum = 1
   
