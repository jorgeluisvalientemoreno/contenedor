select oo.order_id,
       nvl(ooa.subscription_id, mm.subscription_id)Contrato,
       ',' separador,
       oo.legalization_date Legalizacion_Orden,       
       nvl(ooa.product_id, mm.product_id) Producto,
       ooa.activity_id || ' - ' ||
       (select gi.description
          from open.ge_items gi
         where gi.items_id = ooa.activity_id) Actividad,
       oo.task_type_id || ' - ' ||
       (select a.description
          from open.or_task_type a
         where a.task_type_id = oo.task_type_id) Tipo_Trabajo,
       oo.causal_id || ' - ' ||
       (select gc.description
          from open.ge_causal gc
         where gc.causal_id = oo.causal_id) Causal_Legalizacion,
       (select x.class_causal_id || ' - ' || x.description
          from open.ge_class_causal x
         where x.class_causal_id =
               (select y.class_causal_id
                  from open.ge_causal y
                 where y.causal_id = oo.causal_id)) Clasificacion_Causal,
       oo.operating_unit_id || ' - ' ||
       (select h.name
          from open.or_operating_unit h
         where h.operating_unit_id = oo.operating_unit_id) Unidad_Operativa,
       oo.created_date Creacion_Orden,
       ooa.comment_ Comentario_Orden,
       ooa.package_id Solicitud,
       ooa.instance_id,
       mp.package_type_id || ' - ' ||
       (select b.description
          from open.ps_package_type b
         where b.package_type_id = mp.package_type_id) Tipo_Solicitud,
       mp.reception_type_id || ' - ' ||
       (select c.description
          from open.ge_reception_type c
         where c.reception_type_id = mp.reception_type_id) Medio_Recepcion,
       mp.request_date Registro_Solicitud,
       mp.cust_care_reques_num Interaccion,
       mp.motive_status_id || ' - ' ||
       (select d.description
          from open.ps_motive_status d
         where d.motive_status_id = mp.motive_status_id) Estado_Solicitud
  from open.or_order_activity ooa,
       open.or_order oo,
       open.mo_packages mp,
       open.mo_motive mm,
       (SELECT trim(regexp_substr(&sbEstaCort, '[^,]+', 1, LEVEL)) AS orden
          FROM dual
        CONNECT BY regexp_substr(&sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL) B
 where ooa.order_id = oo.order_id
   and ooa.order_id = b.orden --149799183
      --and ooa.product_id = 52359077
      --and (trunc(oo.legalization_date) >= '01/03/2022'
      --or trunc(oo.created_date) >= '01/03/2022')   
      --and oo.task_type_id = 10784
   and mm.package_id(+) = ooa.package_id
   and mp.package_id(+) = ooa.package_id
--and mp.cust_care_reques_num = '192735615'   
--and mp.package_id = 194041548
 order by oo.legalization_date desc;

SELECT *
  FROM open.LDC_NOVELTY_CONDITIONS C
 WHERE C.TASK_TYPE_ID = 12526
   AND c.causal_id = 9777
 ORDER BY val_balance;
select b.estacort, l.observacion
  from open.LDC_OSF_ESTAPROC l,
       (SELECT trim(regexp_substr(&sbEstaCort, '[^,]+', 1, LEVEL)) AS estacort
          FROM dual
        CONNECT BY regexp_substr(&sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL) B
 where l.proceso = 'PANOVA'
      --and trunc(l.fecha_inicial_ejec) = '11/07/2023'
   and l.observacion like '%' || B.estacort || '%';

SELECT nvl(SUM(AccBal), 0) AccBal
  FROM (SELECT cuco.cuconuse, COUNT(1) AccBal
          FROM open.servsusc ser, open.cuencobr cuco
         WHERE ser.sesususc = 603711
           AND cuco.cuconuse = ser.sesunuse
           AND cuco.cucofeve < '23/07/2023' --SYSDATE
           AND cuco.cucosacu IS NOT NULL
         GROUP BY cuco.cuconuse);

SELECT CUCO.CUCONUSE, COUNT(1) ACCBAL
  FROM open.SERVSUSC SER, open.CUENCOBR CUCO
 WHERE SER.SESUSUSC = 603711
   AND CUCO.CUCONUSE = SER.SESUNUSE
   AND CUCO.CUCOFEVE < '23/07/2023' --SYSDATE
   AND CUCO.CUCOSACU IS NOT NULL
 GROUP BY CUCO.CUCONUSE;
