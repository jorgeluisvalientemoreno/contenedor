SELECT pp.subscription_id contrato,
       pp.product_id producto,
       emss.emsselme Serial,
       emss.emsscoem Medidor,
       emss.emssfein Fecha_Instalacion,
       emss.emssfere Fecha_Retira,
       lt.leemfele Fecha_lectura_Actual,
       lt.leemleto Lectura_Actual,
       lt.leemfela Fecha_lectura_Anterior,
       lt.leemlean Lectur_Anterio,
       lt.leemoble Observacion_Lectura,
       decode(lt.leemclec,
              'I',
              'I - Instalacion',
              'R',
              'R - Retiro',
              'F',
              'F - Facturacion',
              'T - Trabajo') Causal_Lectura
  FROM open.pr_product pp
 inner JOIN open.elmesesu emss
    ON emss.emsssesu = pp.product_id
  left join open.lectelme lt
    on lt.leemelme = emss.emsselme
 where 1 = 1
      -- 
   and emss.emsssesu = 1505492
-- pp.subscription_id = 1505492
 order by lt.leemfele desc;

--Lista Chequeo Medidor
-----*Validar existencia SAP (Adriana Pastrana)
-----*Validar movimiento en OSF
-----*Validar Bodega
select l.elmecodi Medidor,
       (select l2.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = l2.items_id) Item,
       l1.emsssesu Producto,
       (select ss.sesuesco || ' - ' ||
               (select e.escodesc
                  from open.estacort e
                 where e.escocodi = ss.sesuesco)
          from open.servsusc ss
         where ss.sesunuse = l1.emsssesu) Estado_Servico,
       (select l2.id_items_estado_inv || ' - ' || giei.descripcion
          from OPEN.GE_ITEMS_ESTADO_INV giei
         where giei.id_items_estado_inv = l2.id_items_estado_inv) Estado_Medidor,
       decode(l2.estado_tecnico,
              'N',
              'N - Nuevo',
              'R',
              'R - Reacondicionado',
              'D',
              'D - Dañado') Estado_Tecnico,
       decode(l2.Propiedad,
              'E',
              'E - Empresa',
              'T',
              'T - Tercero',
              'C',
              'C - Cliente',
              'V',
              'V - Vendido al Cliente') Propiedad,
       l4.item_moveme_caus_id || ' - ' || l4.description Causal_Movimiento,
       (select l3.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = l3.operating_unit_id) Unidad_Operativa_Origen,
       (select l3.target_oper_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = l3.target_oper_unit_id) Unidad_Operativa_Destino,
       l3.move_date Fecha_Movimiento,
       l3.terminal,
       l3.user_id,
       l3.support_document Documento_Soporte,
       (select l3.id_items_estado_inv || ' - ' || a.descripcion
          from OPEN.GE_ITEMS_ESTADO_INV a
         where a.id_items_estado_inv = l3.id_items_estado_inv) Estado_inventario,
       l3.*
  from open.elemmedi             l,
       open.elmesesu             l1,
       open.ge_items_seriado     l2,
       open.or_uni_item_bala_mov l3,
       OPEN.OR_ITEM_MOVEME_CAUS  l4
 where l.elmecodi = l1.emsscoem(+)
   and l.elmecodi = l2.serie
   and l1.emsssesu = (select ss.sesunuse
                        from open.servsusc ss
                       where ss.sesususc = 48032581
                         and ss.sesuserv = 7014
                         and ss.sesufere >= sysdate)
   and l2.id_items_seriado = l3.id_items_seriado
      --and l3.id_items_seriado in (1494450) ---in (1494450,2246399)
   and l3.ITEM_MOVEME_CAUS_ID = l4.Item_Moveme_Caus_Id
--and l2.serie = 'C-2133362-18'
--and l.elmecodi like '%I-13270248W%'
 order by l3.move_date;
