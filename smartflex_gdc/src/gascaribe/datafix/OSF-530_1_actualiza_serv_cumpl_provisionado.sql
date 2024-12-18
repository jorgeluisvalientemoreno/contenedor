Declare

Begin
  --
  -- Se actualiza la descripción del campo CONCEPTO, en este campo va el codigo del clasificador contable.
  --
  EXECUTE IMMEDIATE 'comment on column LDC_OSF_SERV_PENDIENTE.concepto is ''Clasificador Contable del Concepto''';
  --
  -- Actualizamos el campo concepto antes de aplicar el cumplido provisionado
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
      set concepto = 400
   where p.nuano = 2022 
     and p.numes = 6 
     and p.cert_previa > 0;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
      set concepto = 4
   where p.nuano = 2022 
     and p.numes = 6 
     and p.carg_x_conex > 0;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
      set concepto = 19
   where p.nuano = 2022 
     and p.numes = 6 
     and p.interna > 0;
  --
  commit; 
  -- 
  -- solicitud = 178213914
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -588524
   where p.nuano = 2022 
     and p.numes = 7 
     and p.product_id = 52276855     
     and p.solicitud = 178213914
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -88034
   where p.nuano = 2022 
     and p.numes = 7 
     and p.product_id = 52276855     
     and p.solicitud = 178213914
     and p.concepto = 400;
  --
  commit;
  -- solicitud = 178237836
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -10640000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178237836
     and p.concepto = 19;
  -- 
  commit;
  --
  -- solicitud = 179772348
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -9000000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 179772348
     and p.concepto  = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -588524
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 179772348
     and p.concepto = 4; 
  -- 
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -88034
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 179772348
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 178599734
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -230000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178599734
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -588524
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178599734
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -88034
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178599734
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 178836754
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -345000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178836754
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -588524
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178836754
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -88034
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 178836754
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 182636491
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -9200000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 182636491
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 182636491
     and p.concepto = 4;
  --
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 182636491
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 179760009
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -588524
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 179760009
     and p.concepto = 4;
  --
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -88034
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 179760009
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 183006410
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -6600000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183006410
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183006410
     and p.concepto = 4;
  --
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183006410
     and p.concepto = 400;
  --
  commit;
  -- 
  -- solicitud = 183007532
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -3600000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183007532
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183007532
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 183007532
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 184224743
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 184224743
     and p.concepto = 4;
  --
  commit;
  -- 
  -- solicitud = 184774135
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -11600000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 184774135
     and p.concepto = 19;
  --
  commit;
  --
  -- solicitud = 185033861
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -6760000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185033861
     and p.concepto = 19;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185033861
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185033861
     and p.concepto = 400;
  --
  commit;
  -- solicitud = 185593617
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -4800000
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185593617
     and p.concepto = 19;
  --
  commit;
  --  
  -- solicitud = 186107257
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -7952222
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 186107257
     and p.concepto = 19;
  --
  commit;
  --
  -- solicitud = 186740198
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 186740198
     and p.concepto = 4;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 186740198
     and p.concepto = 400;
  --
  commit;
  --
  -- solicitud = 184452142
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52362740 and
            p.product_id <= 52362782
           )
          OR
           (
            p.product_id >= 52362784 and
            p.product_id <= 52362847
           )
          OR 
           (
            p.product_id >= 52363173 and
            p.product_id <= 52363174
           )
         )                
     and p.solicitud = 184452142
     and p.concepto = 4;
  --
  commit;
  --
  -- solicitud = 184499586
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52362740 and
            p.product_id <= 52371497
           )
          OR
           (
            p.product_id >= 52371499 and
            p.product_id <= 52371515
           )
         )
     and p.solicitud = 184499586
     and p.concepto = 4;
  --
  commit;
  --
  -- solicitud = 185656378
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185656378
     and p.concepto = 4;
  --
  commit;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and p.solicitud = 185656378
     and p.concepto = 400;     
  --
  commit;
  -- solicitud = 186117774
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52395366 and
            p.product_id <= 52395389
           )
          OR
           (
            p.product_id >= 52395391 and
            p.product_id <= 52395399
           )  
          OR
           (
            p.product_id >= 52395401 and
            p.product_id <= 52395426
           )     
          OR
           (
            p.product_id >= 52395431 and
            p.product_id <= 52395438
           ) 
          OR
           (
            p.product_id >= 52395440 and
            p.product_id <= 52395462
           )          
          OR
           (
            p.product_id >= 52395464 and
            p.product_id <= 52395507
           )
         )
     and p.solicitud = 186117774
     and p.concepto = 4;
  --
  commit;
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52395366 and
            p.product_id <= 52395389
           )
          OR
           (
            p.product_id >= 52395391 and
            p.product_id <= 52395399
           )  
          OR
           (
            p.product_id >= 52395401 and
            p.product_id <= 52395426
           )     
          OR
           (
            p.product_id >= 52395431 and
            p.product_id <= 52395438
           ) 
          OR
           (
            p.product_id >= 52395440 and
            p.product_id <= 52395462
           )          
          OR
           (
            p.product_id >= 52395464 and
            p.product_id <= 52395507
           )
         )
     and p.solicitud = 186117774
     and p.concepto = 400;     
  --
  commit;  
  --
  -- solicitud = 186143093
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52411537 and
            p.product_id <= 52411557
           )
          OR
           (
            p.product_id >= 52411565 and
            p.product_id <= 52411566
           )
         )  
     and p.solicitud = 186143093
     and p.concepto = 400;     
  --
  commit;    
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52411537 and
            p.product_id <= 52411557
           )
          OR
           (
            p.product_id >= 52411565 and
            p.product_id <= 52411566
           )
         )  
     and p.solicitud = 186143093
     and p.concepto = 4;     
  --
  commit; 
  --
  -- Solicitud 186805443
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -621599
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52414213 and
            p.product_id <= 52414260
           )
          OR
           (
            p.product_id  = 52414272
           )
          OR
           (
            p.product_id >= 52414291 and
            p.product_id <= 52414297
           )
          OR
           (
            p.product_id >= 52414299 and
            p.product_id <= 52414330
           )
          OR
           (
            p.product_id  = 52414332
           )
         )
     and p.solicitud = 186805443
     and p.concepto = 4;     
  --
  commit; 
  --
  update OPEN.LDC_OSF_SERV_PENDIENTE p 
     set p.ingreso_report = -92699
   where p.nuano = 2022 
     and p.numes = 7 
     and (
           (
            p.product_id >= 52414213 and
            p.product_id <= 52414267
           )
          OR
           (
            p.product_id >= 52414272 and 
            p.product_id <= 52414273 
           )
          OR
           (
            p.product_id  = 52414275
           )
          OR
           (
            p.product_id  = 52414279
           )
          OR
           (
            p.product_id  = 52414284
           )
          OR
           (
            p.product_id  = 52414288
           )         
          OR
           (
            p.product_id >= 52414291 and
            p.product_id <= 52414297
           )
          OR
           (
            p.product_id >= 52414299 and
            p.product_id <= 52414330
           )
          OR
           (
            p.product_id  = 52414332
           )
         )
     and p.solicitud = 186805443
     and p.concepto = 400;     
  --
  commit; 
  --
  DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
  --
  Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error : ' || SQLERRM);
  End;
/