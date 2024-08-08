PL/SQL Developer Test script 3.0
261
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
   with base as
        (select /*+index(ca IX_CARG_NUSE_CUCO_CONC) */
                cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
           from open.cargos ca, open.concepto o, open.servsusc
          where cargnuse =  sesunuse
            and cargcuco != -1
            and cargconc = conccodi
            and sesuserv =  6121
            and cargdoso like 'PP-%' -- || a.package_id
            and cargcaca in (53)
            and concclco in (4,19,400)
            and cargfecr <  dtfefefin
         group by cargcuco, cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         )
         ,cargo as (
         select cargdoso, to_number(replace(replace(trim(cargdoso),'PP-',''),'-ADD','')) package_id,   cargconc, concdesc, cargcaca, cargsign, concclco, sum(cargvalo) cargvalo, sum(cargunid) cargunid
          from base      
          inner join open.cuencobr c on c.cucocodi=base.cargcuco
          inner join open.factura f on f.factcodi=c.cucofact and f.factfege <  '01-10-2023'
          group by cargdoso, cargconc, concdesc, cargcaca, cargsign, concclco
         ),
         base2 as(
         select A.PRODUCT_ID, sesucate, cargconc, concclco clasificador, o2.order_id orden, o2.task_type_id TITR,
               (select tt.clctclco from open.ic_clascott tt where tt.clcttitr = o2.task_type_id) clasitt,
               CASE WHEN
                 concclco IN (4) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CXC,
               CASE WHEN
                 concclco IN (19) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_INT,
               CASE WHEN
                 concclco IN (400) THEN
                    ((ca.cargvalo/ca.cargunid))
                 ELSE
                   0
               END ING_CER,
               0 ING_CXC_M,
               0 ING_INT_M,
               0 ING_CER_M,
               ((ca.cargvalo/ca.cargunid)) TOT_INGRE
         from cargo ca
         inner join open.mo_packages m ON m.package_id = ca.package_id and m.package_type_id = 323
         inner join open.or_order_activity a ON a.package_id = m.package_id
         inner join open.or_order o2 on o2.order_id=a.order_id and o2.order_status_id = 8 and trunc(o2.legalization_date) >= dtfefein and trunc(o2.legalization_date) <= dtfefefin 
         inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
         inner join open.or_task_type tt ON tt.task_type_id = o2.task_type_id
         inner join open.servsusc sc ON sc.sesunuse = a.product_id
         inner join open.suscripc su ON su.susccodi = sc.sesususc
         inner join open.ab_address ab ON ab.address_id = su.susciddi
         where o2.order_id not in (select oo.related_order_id
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
           AND o2.task_type_id IN ( SELECT  regexp_substr(casevalo,
                                                                                 '[^,]+',
                                                                                                   1,
                                                                                                   LEVEL) AS titr
                                                                      from (select casevalo
                                                                      FROM OPEN.LDCI_CARASEWE C
                                                                      WHERE C.CASECODI IN ( 'TIPOS_DE_TRABAJOS_INTERNA','TIPOS_DE_TRABAJOS_C_X_C','TIPO_DE_TRABAJO_CERTIF_PREVIA'))
                                                                      CONNECT BY regexp_substr(casevalo, '[^,]+', 1, LEVEL) IS NOT NULL                                                 
                                  )                                       
                                  
                                  
    )
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
    from base2 
    WHERE   (
                  (base2.TITR IN (SELECT (COLUMN_VALUE)
                                         FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo FROM OPEN.LDCI_CARASEWE C
                                                                                         WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_INTERNA'),',') )) and
                   clasificador in (19) and -- Interna
                   base2.product_id not in (select act.product_id
                                           from open.or_order_activity act, open.or_order oo
                                          where act.product_id = base2.product_id
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
                 base2.TITR IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPOS_DE_TRABAJOS_C_X_C'),',') )) and
                 clasificador = 4 -- cxc
                )
              OR
                (
                 base2.TITR IN (SELECT (COLUMN_VALUE)
                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((SELECT casevalo
                                                                                        FROM OPEN.LDCI_CARASEWE C
                                                                                       WHERE C.CASECODI = 'TIPO_DE_TRABAJO_CERTIF_PREVIA'),',')) ) and
                 clasificador = 400 -- Cert Previa
                )

              )
              GROUP BY PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT
              --PRODUCT_ID, sesucate, cargconc, orden, clasificador, TITR, CLASITT
 
;
begin
  
    nucantiregcom := 0;
    nucantiregtot := 0;

    DELETE ldc_osf_costingr l WHERE l.nuano = inuAno AND l.numes = inuMes and l.tipo='ING_CUMP';
    COMMIT;
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
      dbms_output.put_line(sbmensa);
    
  end;
0
0
