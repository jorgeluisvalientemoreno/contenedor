-- Usarios con ordenes de suspension y notificacion

DECLARE

 CURSOR cuordenesmarcat IS

  SELECT p.category_id cate,p.subcategory_id suca,p.product_status_id espr,d.sesucicl cicl,d.sesuesco esco,d.sesuesfn esfn,COUNT(p.product_id) CANTIDAD

    FROM open.pr_product p,open.or_order_activity a,open.or_order ot,open.servsusc d

   WHERE p.product_type_id = 7014

     AND ot.order_status_id IN(0,5,7,11,20)

     AND ot.task_type_id IN(10449,10450,12457)
   and p.product_id=6121989

    AND p.product_id = a.product_id 

     AND a.order_id = ot.order_id

     AND p.product_id = d.sesunuse

   
   GROUP BY p.category_id,p.subcategory_id,p.product_status_id,d.sesucicl,d.sesuesco,d.sesuesfn 

   ORDER BY cantidad ASC;



 CURSOR cuordenesmarca(nucucate NUMBER,nucusuca NUMBER,nucuespr NUMBER,nucicl NUMBER,nucuesco NUMBER,sbcuesfn VARCHAR2) IS

  SELECT p.product_id producto

    FROM open.pr_product p,open.or_order_activity a,open.or_order ot,open.servsusc s

   WHERE p.product_type_id = 7014

     AND ot.order_status_id IN(0,5,7,11,20)
     AND P.PRODUCT_ID=6121989

     AND ot.task_type_id IN(10449,10450,12457)
     AND p.category_id       = nucucate

     AND p.subcategory_id    = nucusuca

     AND p.product_status_id = nucuespr

     AND s.sesucicl          = nucicl

     AND s.sesuesco          = nucuesco

     AND s.sesuesfn          = sbcuesfn                             

     AND p.product_id        = a.product_id 

     AND a.order_id          = ot.order_id

     AND p.product_id        = s.sesunuse;

     

dtfechalega  DATE;

nuvamarca    NUMBER;   

nuparano NUMBER;

nuparmes NUMBER;

nutsess  NUMBER;

sbparuser VARCHAR2(100);

nuconta   NUMBER(10) DEFAULT 0;

nuvalorinf NUMBER;

BEGIN

  SELECT to_number(to_char(SYSDATE,'YYYY'))

       ,to_number(to_char(SYSDATE,'MM'))

       ,userenv('SESSIONID')

       ,USER INTO nuparano,nuparmes,nutsess,sbparuser

   FROM dual;

  -- Se inicia log del programa

-- nuerror := -2; 

 nuconta := 0;

 nuvalorinf := 0;

 FOR i IN cuordenesmarcat LOOP 
   dbms_output.put_line('ENTRO');

    nuvalorinf := nuvalorinf + 1;

     --"OPEN".ldc_proinsertaestaprog(nuparano,nuparmes,'ORDENES_SUSPENSION','En ejecucion',nuvalorinf,sbparuser);

  FOR j IN cuordenesmarca(i.cate,i.suca,i.espr,i.cicl,i.esco,i.esfn) LOOP

   -- dbms_output.put_line('Producto : '||j.producto);

   -- Actualizamos marca producto

   dtfechalega :=NULL;

   nuvamarca := NULL;

               BEGIN

                SELECT fecha_legalizacion,numarca INTO dtfechalega,nuvamarca

                 FROM(

                SELECT ot.legalization_date fecha_legalizacion

                  ,DECODE(ot.task_type_id,12161,101,10444,101,10834,101

                                         ,10714,102,10715,102,10716,102,10717,102,10718,102,10719,102,10720,102,10721,102,10722,102,10723,102,10445,102,10835,102

                                         ,12164,103,10795,103,10446,103,10836,103) numarca 

              FROM open.pr_product p,open.or_order_activity a,open.or_order ot,open.ge_causal c

             WHERE p.product_id      = j.producto

               AND p.product_type_id = 7014

               AND ot.order_status_id = 8

               AND c.class_causal_id = 2

               AND ot.task_type_id IN(12161,10444,10834

                                     ,10714,10715,10716,10717,10718,10719,10720,10721,10722,10723,10445,10835

                                     ,12164,10795,10446,10836

                                     )

               AND 0 =( 

                       SELECT COUNT(k.id_producto) 

                         FROM open.ldc_plazos_cert k

                        WHERE k.plazo_maximo >= to_date('01/06/2018 00:00:00','dd/mm/yyyy hh24:mi:ss')

                          AND k.id_producto = p.product_id

                       )

               AND p.product_id = a.product_id 

               AND a.order_id = ot.order_id 

               AND ot.causal_id = c.causal_id

            UNION ALL

              SELECT ot.legalization_date

                    ,DECODE(ot.task_type_id,12135,102,12136,102,12138,102,12139,102,12140,102,12142,102,12143,102,12147,102,12148,102,12487,102) marca

                FROM open.pr_product p,open.or_order_activity a,open.or_order ot,open.mo_packages m,open.ge_causal c

               WHERE p.product_id      = j.producto

                 AND p.product_type_id = 7014

                 AND ot.order_status_id = 8

                 AND c.class_causal_id = 2

                 AND ot.task_type_id IN(12135,12136,12138,12139,12140,12142,12143,12147,12148,12487)

                 AND m.package_type_id <> 100101

                 AND 0 = ( 

                          SELECT COUNT(k.id_producto) 

                            FROM open.ldc_plazos_cert k

                           WHERE k.plazo_maximo >= to_date('01/06/2018 00:00:00','dd/mm/yyyy hh24:mi:ss')

                             AND k.id_producto = p.product_id

                          )

               AND p.product_id = a.product_id 

               AND a.order_id = ot.order_id    

               AND a.package_id = m.package_id

               AND ot.causal_id = c.causal_id

            ORDER BY fecha_legalizacion DESC)

            WHERE ROWNUM = 1; 

            EXCEPTION 

             WHEN OTHERS THEN

              dtfechalega := NULL;

              nuvamarca  := NULL;

            END;

IF dtfechalega IS NOT NULL THEN

  --"OPEN".ldcprocinsactumarcaprodu(j.producto,nuvamarca,NULL);
  DBMS_OUTPUT.PUT_LINE('PRODUCTO|'||j.producto||'|'||nuvamarca);

ELSE

  --"OPEN".ldcprocinsactumarcaprodu(j.producto,101,NULL); 
  DBMS_OUTPUT.PUT_LINE('PRODUCTO|'||j.producto||'|101');

END IF;   

  nuconta := nuconta + 1;

  IF nuconta >= 100 THEN

     COMMIT;

  END IF; 

  END LOOP;

  --"OPEN".ldc_proactualizaestaprog(nuvalorinf,'Ok cantidad :'||to_char(nuconta)||' CANTIDAD : '||i.cantidad,'ORDENES_SUSPENSION','Termino');

 END LOOP;  

EXCEPTION

 WHEN OTHERS THEN

  --"OPEN".ldc_proactualizaestaprog(nuvalorinf,SQLERRM,'ORDENES_SUSPENSION','Termino CON ERROR');
  DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;