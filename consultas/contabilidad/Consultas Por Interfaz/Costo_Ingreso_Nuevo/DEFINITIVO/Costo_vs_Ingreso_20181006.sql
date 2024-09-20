-- Informe Costos vs Ingreso
SELECT CUENTA, NOM_CUENTA, PRODUCTO, NOM_PRODUCTO, CATEGORIA, SUBCATEGORIA, FEC_VENTA, INSTALACION, TIPO, ACTA, FACTURA, FECHA, 
       CONTRATISTA, NOMBRE, TITR, DESC_TITR, CLASIFICADOR, DESC_CLASIFICADOR,
       ACTIVIDAD,
       CASE
         WHEN DES_ACTIVIDAD IS NULL THEN
           (select gt.description from open.ge_items gt where gt.items_id = actividad)
         ELSE
           DES_ACTIVIDAD
       END DES_ACTIVIDAD,
       CONCEPT, DESC_CONC, COSTO, IVA, ING_OTRO, NOTAS, ING_INT_MIG, Ing_CxC_Mig, Ing_RP_Mig, ING_INT_OSF, ING_CXC_OSF, ING_RP_OSF,
       ING_INT_CON, ING_CXC_CON, ING_RP_CON, TOTAL_INGRESO, T_INT_CUMP, T_CXC_CUMP, T_RP_CUMP, T_SERV_CUMP,
       UTILIDAD, MARGEN, CLASE_CONTRATO
FROM
      (
               
      SELECT (select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador) Cuenta,
             (select lc.cuctdesc from open.ldci_cuentacontable lc
               where lc.cuctcodi = (select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador)) Nom_Cuenta,
             producto, Nom_Producto, categoria, subcategoria,
             (
              CASE WHEN INSTALACION <= '10-02-2015' THEN
                   Instalacion
              ELSE
                 (select trunc(mo.request_date) from open.mo_packages mo, open.or_order_activity ac
                   where ac.product_id = producto and mo.package_id = ac.package_id and mo.package_type_id in (271,323,100229,100271) and rownum = 1) 
              END
             ) Fec_Venta,
             Instalacion, 
             tipo, acta, factura, fecha, contratista, nombre,
             Titr, Desc_Titr, Clasificador, Desc_Clasificador, 
             CASE 
               WHEN actividad IS NULL THEN
                 (select a.activity_id --i.description, a.*
                   from open.or_order_activity  a, open.ge_items  i
                  where a.product_id = producto
                    AND a.task_type_id IN (select t.clcttitr from open.ic_clascott t where t.clctclco = CLASIFICADOR)
                   --and a.activity_id = 4295271
                    AND a.activity_id = i.items_id
                    AND a.value_reference is null
                    AND a.activity_id NOT IN (select ty.items_id from open.ct_item_novelty ty where ty.items_id = a.activity_id)
                    AND ROWNUM = 1)
               ELSE
                 actividad
             END Actividad, 
             Des_actividad, 
             concept, Desc_conc,
             Costo, Iva, Ing_otro, notas, Ing_Int_Mig, Ing_CxC_Mig, Ing_RP_Mig, ING_INT_OSF, ING_CXC_OSF, ING_RP_OSF,
             ING_INT_CON, ING_CXC_CON, ING_RP_CON, TOTAL_INGRESO, T_INT_CUMP, T_CXC_CUMP, T_RP_CUMP, T_SERV_CUMP,
             (NVL(TOTAL_INGRESO, 0) - NVL(Costo, 0)) UTILIDAD,
             (CASE WHEN NVL(TOTAL_INGRESO, 0) > 0 THEN
                      trunc(((NVL(TOTAL_INGRESO, 0) - NVL(COSTO, 0))/NVL(TOTAL_INGRESO, 0))*100,5)
                   ELSE 
                     -100
                     END) MARGEN,
             CASE 
               WHEN TITR IS NULL THEN TIPO
               WHEN TITR IN (10011,10023,10075,10077,10088,10093,10094,10096,10127,10169,10198,10243,10248,10256,10330,10332,10333,10334,10339,10444,10450,10452,10453,10457,10458,10459,10469,10495,10529,10546,10547,10553,10555,10556,10564,10565,10568,10584,10585,10597,10606,10608,10611,10622,10630,10631,10657,10658,10666,10667,10681,10693,10714,10716,10717,10718,10719,10721,10722,10735,12135,12136,12137,12138,12139,12140,12142,12143,12146,12147,12148,12149,12150,12151,12152,12153,12155,12161,12162,12176,12182,12187,12188,12189,12190,12192,12204,12205,12241,12249,12262,12264,12283,12329,12332,12333,12335,12357,12359,12361,12362,12366,12371,12375,12376,12378,12379,12380,12383,12384,12385,12386,12387,12438,12457,12459,12460,12487,12521,12523,12524,12525,12526,12528,12529,12530,12705,12880,10169,10257,10268,10385,10607,10609,10624,10715,10720,12154,12173,12185,12193,12206,12164,10764,12292,10796,10797,10710,10171,10733,10321,10723,10598,12250,12210,12279,10709,12244,10762,10795,10743,10822,10823,12293,10799,10798,10801,10802,10830,10829,10831,12274,12194,12334) THEN 'VARIABLE'
               WHEN TITR IN (10559,10566,10567,10569,10570,10572,10573,10574,10575,10576,10577,10578,10582,10583,10586,10591,10592,10595,10596,10668,10671,10672,10677,10689,10711,10730,10736,12527,10712,10804,10792,10768,10770,10772,10593,10805,10675,10773,10766,10769,10771,10774,10197,10610,10688,10616,10806,10820,10821,10828,10809,10594,10767,10765,10803,10827,10826,10825) THEN 'FIJO'
               ELSE 'OTRO' 
             END CLASE_CONTRATO
               
      FROM
      (
      select product_id producto, tipo, Titr,
           (select s.subscriber_name|| ' ' || s.subs_last_name
              from open.servsusc c, open.ge_subscriber s, open.suscripc p
             where Product_id = c.sesunuse
               and c.sesususc = p.susccodi
               and p.suscclie = s.subscriber_id) Nom_Producto, sc.sesucate categoria, sc.sesusuca subcategoria, trunc(sc.sesufein) Instalacion,
             acta, factura, fecha, contratista, nombre,
             (select tt.description from open.or_task_type tt where tt.task_type_id = titr) Desc_Titr,
             Clasificador, (select clcodesc from open.ic_clascont ict where ict.clcocodi = Clasificador) Desc_Clasificador,
             actividad, (select gt.description from open.ge_items gt where gt.items_id = actividad) Des_actividad,
             concept, (select cc.concdesc from open.concepto cc where cc.conccodi = concept) Desc_conc,
             sum(costo) Costo, sum(iva) Iva, 
             (CASE WHEN ACTIVIDAD NOT IN (select cit.items_id from open.ct_item_novelty cit where cit.items_id = actividad) THEN
                 sum(Ing_otro) 
               ELSE
                 0
                 END) Ing_otro,        
             sum(notas) notas,
             sum(Ing_Int_Mig) Ing_Int_Mig, sum(Ing_CxC_Mig) Ing_CxC_Mig, sum(Ing_RP_Mig) Ing_RP_Mig,
             sum(ING_INT_OSF) ING_INT_OSF, sum(ING_CXC_OSF) ING_CXC_OSF, sum(ING_RP_OSF) ING_RP_OSF,
             sum(ING_INT_CON) ING_INT_CON, sum(ING_CXC_CON) ING_CXC_CON, sum(ING_RP_CON) ING_RP_CON,
             --
             sum(nvl(decode((select 'X' from open.ct_item_novelty cit where cit.items_id = actividad),
                            'X',
                            0,
                            nvl(ing_otro,0)
                           ),0) + nvl(notas, 0) + nvl(Ing_Int_Mig,0) + nvl(Ing_CxC_Mig,0) + nvl(Ing_RP_Mig,0) + nvl(ING_INT_OSF,0) +
                 nvl(ING_CXC_OSF,0) + nvl(ING_RP_OSF,0) + nvl(ING_INT_CON,0) + nvl(ING_CXC_CON,0) + nvl(ING_RP_CON,0)) TOTAL_INGRESO,       
             sum(nvl(Ing_Int_Mig,0) + nvl(ING_INT_OSF,0) + nvl(ING_INT_CON,0)) T_INT_CUMP,
             sum(nvl(Ing_CxC_Mig,0) + nvl(ING_CXC_OSF,0) + nvl(ING_CXC_CON,0)) T_CXC_CUMP,
             sum(nvl(Ing_RP_Mig,0)  + nvl(ING_RP_OSF,0)  + nvl(ING_RP_CON,0))  T_RP_CUMP,
             sum(nvl(Ing_Int_Mig,0) + nvl(Ing_CxC_Mig,0) + nvl(Ing_RP_Mig,0) +
                 nvl(ING_INT_OSF,0) + nvl(ING_CXC_OSF,0) + nvl(ING_RP_OSF,0) +
                 nvl(ING_INT_CON,0) + nvl(ING_CXC_CON,0) + nvl(ING_RP_CON,0)) T_SERV_CUMP
        from (
              select l.nuano, l.numes, l.estado, l.product_id, l.cate, l.tipo, l.acta, l.factura, l.fecha, l.contratista, l.nombre, l.titr, l.cuenta, l.nom_cuenta, 
                     l.clasificador, l.actividad, l.concept, l.costo, l.iva,
                     (decode(nn.comment_, null, 1, 0) * l.ing_otro) ing_otro, 
                     l.notas, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_int_mig)   ing_int_mig, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_cxc_mig)   ing_cxc_mig, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_rp_mig)    ing_rp_mig, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_int_osf)   ing_int_osf,
                     (decode(nn.comment_, null, 1, 0) * l.ing_cxc_osf)   ing_cxc_osf, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_rp_osf)    ing_rp_osf, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_int_con)   ing_int_con, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_cxc_con)   ing_cxc_con, 
                     (decode(nn.comment_, null, 1, 0) * l.ing_rp_con)    ing_rp_con, 
                     (decode(nn.comment_, null, 1, 0) * l.total_ingreso) total_ingreso, 
                     l.utilidad, l.margen, nn.comment_
                from open.ldc_osf_costingr l, open.ct_item_novelty nn
               where l.nuano = &AÑO_PROCESO
                 and l.numes = &MES_PROCESO
                 and l.actividad = nn.items_id(+)
             ) UU, open.servsusc sc
       where product_id = sc.sesunuse(+)
         and (nvl(costo, 0)       != 0 OR nvl(iva, 0)        != 0 OR nvl(Ing_otro, 0)   != 0 OR nvl(Ing_Int_Mig, 0) != 0 OR
              nvl(Ing_CxC_Mig, 0) != 0 OR nvl(Ing_RP_Mig,0)  != 0 OR nvl(ING_INT_OSF,0) != 0 OR nvl(ING_CXC_OSF, 0) != 0 OR
              nvl(ING_RP_OSF, 0)  != 0 OR nvl(ING_INT_CON,0) != 0 OR nvl(ING_CXC_CON,0) != 0 OR nvl(ING_RP_CON, 0)  != 0 OR
              nvl(NOTAS, 0)       != 0)
      group by product_id, tipo, acta, factura, fecha, contratista, nombre, titr, Clasificador, actividad, concept, sc.sesucate, sc.sesusuca, trunc(sc.sesufein)       
      ) --WHERE producto = 51507649 and CLASIFICADOR = 247
    ) --WHERE producto = 51507649 and CLASIFICADOR = 247
