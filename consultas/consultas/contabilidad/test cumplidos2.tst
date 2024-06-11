PL/SQL Developer Test script 3.0
235
declare
  sbClasiIngresos  open.LDCI_CARASEWE.CASEVALO%type;
  osbErrorMessage  open.ge_error_log.description%TYPE;
  errorPara01      EXCEPTION;
  inuAno      number:=2023;
  inuMes      number:=09;
  dtfefein    DATE:=to_Date('01/09/2023','dd/mm/yyyy');
  dtfefefin   DATE:=to_date('30/09/2023 23:59:59','dd/mm/yyyy hh24:mi:ss');
  sbCorreo    VARCHAR2(4000);
  sbTipoBD    VARCHAR2(4000);
  sbmensa     VARCHAR2(4000);
  error       NUMBER;
  nucontareg              NUMBER(15) DEFAULT 0;
  nucantiregcom           NUMBER(15) DEFAULT 0;
  nucantiregtot           NUMBER(15) DEFAULT 0;
  sbmail                  ld_parameter.value_chain%type;
  sbMes                   VARCHAR2(2000);  

  -- Cursor de servicios cumplidos..
  Cursor CuCumplidos IS
      -- SC UNIFICADO
        select PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT,
               (SELECT lg.cuencosto from open.ldci_cugacoclasi lg
                 WHERE lg.cuenclasifi = CLASITT) CUENTA,
               (select cb.cuctdesc from open.ldci_cuentacontable cb
                 where cb.cuctcodi in (SELECT lg.cuencosto from open.ldci_cugacoclasi lg
                                        WHERE lg.cuenclasifi = CLASITT)
               ) nomcuenta,
               --cuenta,  nomcuenta,
               -- MIGRADOS
               SUM(ING_CXC_M) ING_CXC_M,
               SUM(ING_INT_M) ING_INT_M,
               SUM(ING_CER_M) ING_CER_M,
               -- CONSTRUCTORAS
               SUM(ING_CXC) ING_CXC,
               SUM(ING_INT) ING_INT,
               SUM(ING_CER) ING_CER,
               -- TOTAL INGRESO
               SUM(TOT_INGRE) TOT_INGRE
        from
        (
        -- Constructoras
        -- OSF-1402
        --
        -- Consulta Servicio Cumplido Migrado
        select 'MIGRADOS' TIPO,  A.PRODUCT_ID, sesucate, conccodi cargconc, concclco clasificador, o2.order_id orden, o2.task_type_id TITR,
               (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               0 ING_CXC,
               0 ING_INT,
               0 ING_CER,
               CASE WHEN
                 concclco IN (4) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CXC_M,
               CASE WHEN
                 concclco IN (19) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_INT_M,
               CASE WHEN
                 concclco IN (400) THEN
                    (mi.invmvain)
                 ELSE
                   0
               END ING_CER_M,
               (mi.invmvain) TOT_INGRE
         from open.or_order o2
         inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join open.or_order_activity a ON a.order_id = o2.order_id
         inner join open.mo_packages m on m.package_id = a.package_id and m.package_type_id = 100271 -- 323
         inner join open.Ldci_Ingrevemi mi ON mi.invmsesu = a.product_id
         inner join open.concepto o ON conccodi = mi.invmconc
         inner join open.servsusc sc ON sc.sesunuse = a.product_id
         inner join open.suscripc su ON su.susccodi = sc.sesususc
         inner join open.ab_address ab ON ab.address_id = su.susciddi
         where trunc(o2.legalization_date) >= dtfefein -- '01-03-2019'
           and trunc(o2.legalization_date) < dtfefefin --'01-04-2019'
           and o2.order_status_id = 8
        --   and trunc(o2.created_date ) <=  '01-03-2019' --dtfefefin
           and (
                  (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                         FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM OPEN.LDCI_CARASEWE C
                                                                                         WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                   concclco in (19) and -- Interna
                   a.product_id not in (select act.product_id
                                           from open.or_order_activity act, open.or_order oo
                                          where act.product_id = a.product_id
                                            and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                     FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                                                     FROM OPEN.LDCI_CARASEWE C
                                                                                                                    WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_OT_APOYO'),',') ))
                                            and act.order_id = oo.order_id
                                            and oo.legalization_date < to_date((SELECT casevalo
                                                                                  FROM OPEN.LDCI_CARASEWE C
                                                                                 WHERE C.CASECODI = 'FECHA_FIN_ORDEN_DE_APOYO'))
                                        )
                  )

              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                 concclCo = 4 -- cxc
                )
              OR
                (
                 o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                 concclco = 400 -- Cert Previa
                )

              )
           AND o2.order_id not in (select oo.related_order_id
                                     from open.OR_related_order oo
                                    where oo.related_order_id = o2.order_id
                                      and oo.rela_order_type_id in (13,14)
                                  )
           AND a.product_id NOT IN (SELECT hcecnuse
                                      FROM open.hicaesco h
                                     WHERE hcecfech < to_date((SELECT casevalo
                                                                 FROM OPEN.LDCI_CARASEWE C
                                                                WHERE C.CASECODI = 'FECHA_INICIO_INGRESO_X_ORDEN'))
                                       AND hcecnuse = a.product_id
                                       AND hcececan = 96
                                       AND hcececac = 1
                                       AND hcecserv = 7014)
        ) GROUP BY PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT; --, cuenta, nomcuenta;
 

begin
  
    nucantiregcom := 0;
    nucantiregtot := 0;

    --DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes and l.tipo='ING_CUMP';
    --COMMIT;
    For I in CuCumplidos loop

    			INSERT INTO ldc_osf_costingr
							 (
							  nuano
							 ,numes
				  --           ,estado
							 ,product_id
							 ,cate
							 ,tipo
							 ,acta
							 ,factura
							 ,fecha
							 ,contratista
							 ,nombre
							 ,titr
							 ,cuenta
							 ,nom_cuenta
							 ,clasificador
							 ,actividad
							 ,concept
							 ,costo
							 ,iva
							 ,ing_otro
							 ,notas
							 ,ing_int_mig
							 ,ing_cxc_mig
							 ,ing_rp_mig
							 ,ing_int_osf
							 ,ing_cxc_osf
							 ,ing_rp_osf
							 ,ing_int_con
							 ,ing_cxc_con
							 ,ing_rp_con
							 ,total_ingreso
							 ,utilidad
							 ,margen
							 ,order_id
							 )
					  VALUES
							(
							 inuAno
						   ,inuMes
					  --     ,i.estado
						   ,i.product_id   --i.invmsesu
						   ,i.sesucate
						   ,'ING_CUMP'
						   ,NULL
						   ,NULL
						   ,NULL
						   ,NULL  -- i.contratista
						   ,NULL  -- i.nombre
						   ,i.TITR -- NULL -- i.tipotrabajo
						   ,i.cuenta
						   ,i.nomcuenta
						   ,i.clasificador
						   ,NULL
						   ,i.cargconc  --i.invmconc
						   ,0
						   ,0
						   ,0 --i.ING_OTRO
						   ,0 --i.Notas
						   ,i.ing_int_m
						   ,i.ing_cxc_m
						   ,i.ing_cer_m
						   ,0 --i.ING_INT_OSF
						   ,0 --i.ING_CXC_OSF
						   ,0 --i.ING_RP_OSF
						   ,i.ing_int
						   ,i.ing_cxc
						   ,i.ing_cer
						   ,i.TOT_INGRE
						   ,0 --i.utilidad
						   ,0 --round(i.margen,2)
			         ,i.ORDEN --
               );
        --
        nucantiregcom := nucantiregcom + 1;
        IF nucantiregcom >= nucontareg THEN
          COMMIT;
          nucantiregtot := nucantiregtot + nucantiregcom;
          nucantiregcom := 0;
        END IF;

    end loop;

    
  Exception
     When others then
      sbmensa := ('ERROR: [FnuGeneIngreServCump]: ' || sqlerrm);
    
  end;
0
0
