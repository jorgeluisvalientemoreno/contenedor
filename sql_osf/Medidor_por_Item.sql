--Lista Chequeo Medidor
-----*Validar existencia SAP (Adriana Pastrana)
-----*Validar movimiento en OSF
-----*Validar Bodega
select l2.id_items_seriado,
       (select gi.item_classif_id
          from open.ge_items gi
         where gi.items_id = l2.items_id) clasificador,
       l.elmecodi Medidor,
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
       (select l2.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = l2.operating_unit_id) Unidad_Operativa,
       l3.*
  from open.elemmedi             l,
       open.elmesesu             l1,
       open.ge_items_seriado     l2,
       open.or_uni_item_bala_mov l3
 where l.elmecodi = l1.emsscoem(+)
   and l.elmecodi = l2.serie
      --and l1.emsssesu = 50062001
   and l2.id_items_seriado = l3.id_items_seriado
--and l3.id_items_seriado in (1494450) ---in (1494450,2246399)
--and l2.serie = 'C-2133362-18'
--and l.elmecodi like '%I-13270248W%'
 order by l3.move_date;

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
              l4.item_moveme_caus_id || ' - '|| l4.description Causal_Movimiento,
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
         (select l3.id_items_estado_inv || ' - '|| a.descripcion from OPEN.GE_ITEMS_ESTADO_INV a where a.id_items_estado_inv = l3.id_items_estado_inv) Estado_inventario,
         l3.*         
  from open.elemmedi l, open.elmesesu l1, open.ge_items_seriado l2, open.or_uni_item_bala_mov l3, OPEN.OR_ITEM_MOVEME_CAUS l4
 where l.elmecodi = l1.emsscoem(+)
   and l.elmecodi = l2.serie
   and l1.emsssesu = 50062001
   and l2.id_items_seriado = l3.id_items_seriado
   and l3.id_items_seriado in (1494450) ---in (1494450,2246399)
   and l3.ITEM_MOVEME_CAUS_ID = l4.Item_Moveme_Caus_Id
   --and l2.serie = 'C-2133362-18'
   --and l.elmecodi like '%I-13270248W%'
   order by l3.move_date;

/*select t.*, rowid
  from open.or_uni_item_bala_mov t
 where t.id_items_seriado in (1494450) ---in (1494450,2246399)
 order by t.move_date;
select t.*, rowid
  from open.or_ope_uni_item_bala t
 where operating_unit_id in (3007, 1886)
   and items_id in (10004070, 10002017);
select t.*, rowid
  from open.ldc_act_ouib t
 where operating_unit_id in (3007, 1886)
   and items_id in (10004070, 10002017);
select t.*, rowid
  from open.ldc_inv_ouib t
 where operating_unit_id in (3007, 1886)
   and items_id in (10004070, 10002017);
select *
  from open.GE_ITEMS_SERIADO GIS
 where GIS.SERIE = 'C-2133362-18'
union all
select *
  from open.GE_ITEMS_SERIADO GIS
 where GIS.Propiedad = 'C'
   and rownum = 1;
select * from open.ge_items_estado_inv order by 1;
*/
