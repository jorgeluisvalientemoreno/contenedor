DROP VIEW VW_CONSULTA_AUTORECONECTADOS;

  CREATE OR REPLACE FORCE VIEW "OPEN"."VW_CONSULTA_AUTORECONECTADOS" ("CODIGO_PROCESO", "NOMBRE_PROCESO", "CICLO", "DESCRIPCION_CICLO", "PRODUCTO", "CODIGO_ESTADO_CORTE", "ESTADO_CORTE", "NOMBRE", "CONTRATO", "ESTADO_PRODUCTO", "COD_DIRECCION", "DIRECCION", "USO", "DESCRIPCION_USO", "COD_DEPARTAMENTO", "DEPARTAMENTO", "COD_LOCALIDAD", "LOCALIDAD", "ESTADO_FINANCIERO", "SALDO", "CARTERA_VENCIDA", "CONSUMO", "LECTURA_ACTUAL", "LECTURA_ANTERIOR", "LECTURA_SUSPENSION", "FECHA_SUSPENSION", "TIPO_TRAB_SUSPENSION", "ORDEN_SUSPENSION", "MESES_SUSPENSION", "TIPO_SUSPEN_PRODUCTO", "MARCA_PRODUCTO", "MULTIFAMILIAR", "FECHA_MAXIMO_SUSP", "ACTIVIDAD_ORIGEN", "DESCRIPCION_ORIGEN", "ACTIVIDAD_DESTINO", "DESCRIPCION_DESTINO", "NUMERO_PERIODOS", "FLAG_PERSECUCION", "FECHA_PROCESO", "CONSECUTIVO", "CUENTAS_CON_SALDOS","DEFECTOS_NO_REPARABLES") AS 
  SELECT   /*+ index(aut idx001_ldc_susp_autoreco)*/lp.proceso_id codigo_proceso,
         lp.proceso_descripcion nombre_proceso,
         sarecicl ciclo,
         (SELECT cicldesc FROM ciclo WHERE ciclcodi = sarecicl) descripcion_ciclo,
         saresesu producto,
         s.sesuesco codigo_estado_corte,
         (SELECT estc.escodesc FROM estacort estc WHERE estc.escocodi = s.sesuesco) estado_corte,
         (SELECT subscriber_name || ' ' || subs_last_name FROM ge_subscriber WHERE subscriber_id = sareclie) nombre,
         sarecont contrato,
         sareespr estado_producto,
         pr.address_id cod_direccion,
         daab_address.fsbgetaddress_parsed(pr.address_id,NULL) direccion,
         pr.category_id uso,
         (SELECT c.catedesc FROM categori c WHERE c.catecodi = sesucate) descripcion_uso,
         saredepa cod_departamento,
         (SELECT g.description FROM ge_geogra_location g WHERE g.geograp_location_id = saredepa) departamento,
         sareloca cod_localidad,
         (SELECT g.description FROM ge_geogra_location g WHERE g.geograp_location_id = sareloca) localidad,
         pktblservsusc.fsbgetsesuesfn(saresesu) estado_financiero,
         saresape saldo,
         gc_bodebtmanagement.fnugetexpirdebtbyprod(saresesu) cartera_vencida,
         sarecons consumo,
         sareleac lectura_actual,
         sarelean lectura_anterior,
         sarelesu lectura_suspension,
         sarefesu fecha_suspension,
         sarettsu tipo_trab_suspension,
         sareorsu orden_suspension,
         (SELECT round(months_between(to_date(SYSDATE), MAX(pps.register_date)))
            FROM open.pr_prod_suspension pps
            WHERE pps.product_id = aut.saresesu
            AND pps.active = 'Y') meses_suspension,
         (SELECT ps.suspension_type_id
          FROM open.pr_prod_suspension ps
          WHERE ps.active = 'Y'
            AND ps.suspension_type_id IN ( select distinct
                                             REGEXP_SUBSTR( A.SUSPENSION_TYPES, '[^,]+', 1, level )
                                             from   open.LDC_PROCESO A
                                             where A.PROCESO_ID = open.dald_parameter.fnugetnumeric_value('LDC_PROCAUTORECO',NULL)
                                             connect by regexp_substr(SUSPENSION_TYPES, '[^,]+', 1, level) is not null)
            AND ps.product_id = s.sesunuse)Tipo_Suspen_Producto,
         (SELECT NVL((SELECT mp.SUSPENSION_TYPE_ID
            FROM open.LDC_MARCA_PRODUCTO mp
            WHERE mp.ID_PRODUCTO = s.sesunuse), 101)
            FROM DUAL
            WHERE EXISTS (SELECT * FROM open.LDC_MARCA_PRODUCTO mp
                          WHERE mp.ID_PRODUCTO = s.sesunuse)) MARCA_PRODUCTO,
         SAREMULT multifamiliar,
         SAREPLMA fecha_maximo_susp,
         sareacor actividad_origen,
         (SELECT A.description FROM ge_items A WHERE A.items_id = sareacor ) descripcion_origen,
         sareacti actividad_destino,
         (SELECT A.description FROM ge_items A WHERE A.items_id = sareacti ) descripcion_destino,
         sarepeva numero_periodos,
         sareaure flag_persecucion,
         sarefepr fecha_proceso,
         sarecodi consecutivo,
         (select count(cc.cucocodi)
            from cuencobr cc
           where cc.cuconuse = pr.product_id
             and nvl(cc.cucosacu,0) > 0
             and nvl(cc.cucovare,0) < nvl(cc.cucosacu,0)) Cuentas_con_saldos,
         decode((select lm.bloqueo
                  from LDC_MARCAPRODREPA lm
                 where lm.producto_id = pr.product_id and lm.bloqueo = 'Y'),
                'Y',
                'S',
                'N') Defectos_no_reparables
  FROM ldc_susp_autoreco aut,
       ldc_proceso lp,
       ldc_proceso_actividad lpa,
       pr_product  pr,
       servsusc s
 WHERE sesunuse = saresesu
   AND pr.product_id = sesunuse
   AND sareorde IS NULL
   AND (/*sareacti = lpa.activity_id OR*/ sareacor = lpa.activity_id)
   AND pr.product_status_id = 2
   And ((sarecons > 0 ) or (0>= sarecons and nvl(sareleac,0)-nvl(sarelean,0)!=0))
   And ((nvl(sarelesu,0) > 0) or ( 0>= nvl(sarelesu,0)  and nvl(sareleac,0)-nvl(sarelean,0)!=0))
   AND 0 = (SELECT count(1)
              FROM ldc_consumo_cero lcc
             WHERE lcc.proceso_id = lp.proceso_id
               AND lcc.product_id = sesunuse)
   AND lp.proceso_id = lpa.proceso_id
   AND lp.proceso_id  = dald_parameter.fnugetnumeric_value('LDC_PROCAUTORECO',NULL);

GRANT SELECT ON "OPEN"."VW_CONSULTA_AUTORECONECTADOS" TO "SYSTEM_OBJ_PRIVS_ROLE";

