select *
  from (select mo.operating_unit_id || ' - ' ||
               (select uo3.name
                  from open.or_operating_unit uo3
                 where uo3.operating_unit_id = mo.operating_unit_id) unidad_base,
               mo.uni_item_bala_mov_id,
               mo.items_id,
               it.description descripcion_item,
               it.item_classif_id,
               decode(mo.movement_type, 'I', 1, 'D', -1) * mo.amount cantidad,
               mo.item_moveme_caus_id || ' - ' ||
               (select ca.description
                  from open.or_item_moveme_caus ca
                 where ca.item_moveme_caus_id = mo.item_moveme_caus_id) causal,
               mo.move_date fecha,
               mo.user_id || ' - ' ||
               (select pe.name_
                  from open.ge_person pe, open.sa_user us
                 where pe.user_id = us.user_id
                   and us.mask = mo.user_id
                   and rownum = 1) usuario,
               mo.target_oper_unit_id || ' - ' ||
               (select uo2.name
                  from open.or_operating_unit uo2
                 where uo2.operating_unit_id = mo.target_oper_unit_id) unidad_objetivo,
               mo.terminal,
               case
                 when mo.item_moveme_caus_id = 4 then
                 --- Viene de una legalizacion
                  'ORDEN: ' ||
                  (select ot.order_id || ' // ' ||
                          'open.ldc_reportesconsulta.fsbObsActivity(' ||
                          ot.order_id || ')' || ' // ' ||
                          'open.ldc_reportesconsulta.fsbObservacionOT(' ||
                          ot.order_id || ')' || ' // ' || ot.legalization_date
                     from open.or_order ot
                    where ot.order_id = to_number(do.documento_externo))
                 when mo.movement_type = 'I' and mo.terminal = 'UNKNOWN' and
                      mo.item_moveme_caus_id in (15, 16) then
                 --- Viene de una requisicion // puede haber duplicidad (caso vivir mejor)
                  'REQUISICION: ' || chr(10) ||
                  (select rtrim(xmlagg(xmlelement(e,(dor.id_items_documento || ' - ' || (select pe2.name_
                                                                                          from open.ge_person pe2,
                                                                                               open.sa_user   us2
                                                                                         where pe2.user_id =
                                                                                               us2.user_id
                                                                                           and us2.user_id =
                                                                                               dor.user_id
                                                                                           and rownum = 1) || ' // Causal: ' || (select ca2.description
                                                                                                                                  from open.ge_causal ca2
                                                                                                                                 where ca2.causal_id =
                                                                                                                                       dor.causal_id) || ' // ' || dor.comentario) || chr(10)))
                                .extract('//text()'),
                                chr(10))
                     from open.ge_items_documento dor, open.ldci_intemmit sa
                    where ('AUTO_' || sa.mmitdsap = do.documento_externo or
                          sa.mmitdsap = do.documento_externo)
                      and sa.mmitnudo = dor.id_items_documento)
                 when mo.item_moveme_caus_id = 20 and mo.movement_type = 'D' then
                 --- Se trasladan a otra unidad operativa
                  'TRASLADO: ' || do.id_items_documento || ' // Causal: ' ||
                  (select ca.description
                     from open.ge_causal ca
                    where ca.causal_id = do.causal_id) || ' // ' ||
                  do.comentario
                 when mo.item_moveme_caus_id = 16 and mo.movement_type = 'I' then
                 --- Se acepta un traslado
                  'ACEPTA TRASLADO DE: ' || chr(10) ||
                  (select rtrim(xmlagg(xmlelement(e, dot.id_items_documento || ' - ' || (select pe3.name_
                                                                                          from open.ge_person pe3
                                                                                         where pe3.user_id =
                                                                                               dot.user_id) || ' // Causal: ' || (select ca3.description
                                                                                                                                   from open.ge_causal ca3
                                                                                                                                  where ca3.causal_id =
                                                                                                                                        dot.causal_id) || ' // ' || dot.comentario || chr(10)))
                                .extract('//text()'),
                                chr(10))
                     from open.or_uni_item_bala_mov mot,
                          open.ge_items_documento   dot
                    where mot.items_id = mo.items_id
                      and mot.operating_unit_id = mo.operating_unit_id
                      and mot.target_oper_unit_id = mo.target_oper_unit_id
                      and mot.item_moveme_caus_id = 20
                      and mot.id_items_documento = dot.id_items_documento
                      and mot.movement_type = 'N'
                      and nvl(mot.id_items_seriado, -1) =
                          nvl(mo.id_items_seriado, -1)
                      and mot.support_document =
                          to_char(mo.id_items_documento))
                 when mo.item_moveme_caus_id = 17 and mo.movement_type = 'I' then
                 --- Ingreso por rechazo de traslado
                  'RECHAZO: ' || chr(10) ||
                  (select rtrim(xmlagg(xmlelement(e, dor.id_items_documento || ' - ' || (select pe3.name_
                                                                                          from open.ge_person pe3
                                                                                         where pe3.user_id =
                                                                                               dor.user_id) || ' // ' || dor.comentario || chr(10)))
                                .extract('//text()'),
                                chr(10))
                     from open.ge_items_documento   dor,
                          open.ge_items_doc_rel     dr,
                          open.or_uni_item_bala_mov mot
                    where dor.id_items_documento = dr.id_items_doc_destino
                      and dr.id_items_doc_origen = mo.id_items_documento
                      and mot.items_id = mo.items_id
                      and nvl(mot.id_items_seriado, -1) =
                          nvl(mo.id_items_seriado, -1)
                      and mot.operating_unit_id = mo.operating_unit_id
                      and mot.id_items_documento = dr.id_items_doc_destino)
               end informacion_adicional
          from open.or_uni_item_bala_mov mo
         inner join open.ge_items it
            on mo.items_id = it.items_id
          left join open.ge_items_documento do
            on do.id_items_documento = mo.id_items_documento
         where mo.move_date > to_date(&FECHA_INICIAL, 'dd/mm/yyyy')
           and mo.move_date < to_date(&FECHA_FINAL, 'dd/mm/yyyy')
           and mo.items_id = it.items_id
              --and mo.items_id = decode(&ITEM, -1, mo.items_id, &ITEM)
           and mo.operating_unit_id =
               decode(&UNIDAD, -1, mo.operating_unit_id, &UNIDAD)
           and mo.movement_type in ('I', 'D')
        union all
        select ba1_.operating_unit_id || ' - ' ||
               (select uo4.name
                  from open.or_operating_unit uo4
                 where uo4.operating_unit_id = ba1_.operating_unit_id) unidad_base,
               -1,
               ba1_.items_id,
               it1_.description,
               it1_.item_classif_id,
               ba1_.balance -
               nvl((select sum(decode(mo1_.movement_type, 'I', 1, 'D', -1) *
                              mo1_.amount)
                     from open.or_uni_item_bala_mov mo1_
                    where mo1_.operating_unit_id = ba1_.operating_unit_id
                      and mo1_.items_id = ba1_.items_id
                      and mo1_.move_date >
                          to_date(&FECHA_INICIAL, 'dd/mm/yyyy')
                      and mo1_.movement_type in ('I', 'D')),
                   0),
               'Saldo Inicial',
               to_date(&FECHA_INICIAL, 'dd/mm/yyyy') fecha,
               '',
               '',
               '',
               ''
          from open.or_ope_uni_item_bala ba1_, open.ge_items it1_
         where 1 = 1
           and ba1_.operating_unit_id =
               decode(&UNIDAD, -1, ba1_.operating_unit_id, &UNIDAD)
              --and ba1_.items_id = decode(&ITEM, -1, ba1_.items_id, &ITEM)
           and exists
         (select *
                  from open.or_ope_uni_item_bala mo1_
                 where mo1_.operating_unit_id = ba1_.operating_unit_id
                   and mo1_.items_id = ba1_.items_id)
           and ba1_.items_id = it1_.items_id
        union all
        select ba2_.operating_unit_id || ' - ' ||
               (select uo5.name
                  from open.or_operating_unit uo5
                 where uo5.operating_unit_id = ba2_.operating_unit_id) unidad_base,
               -1,
               ba2_.items_id,
               it2_.description,
               it2_.item_classif_id,
               ba2_.balance -
               nvl((select sum(decode(mo2_.movement_type, 'I', 1, 'D', -1) *
                              mo2_.amount)
                     from open.or_uni_item_bala_mov mo2_
                    where mo2_.operating_unit_id = ba2_.operating_unit_id
                      and mo2_.items_id = ba2_.items_id
                      and mo2_.move_date >
                          to_date(&FECHA_FINAL, 'dd/mm/yyyy')
                      and mo2_.movement_type in ('I', 'D')),
                   0),
               'Saldo Final',
               to_date(&FECHA_FINAL, 'dd/mm/yyyy') fecha,
               '',
               '',
               '',
               ''
          from open.or_ope_uni_item_bala ba2_, open.ge_items it2_
         where 1 = 1
           and ba2_.operating_unit_id =
               decode(&UNIDAD, -1, ba2_.operating_unit_id, &UNIDAD)
              --and ba2_.items_id = decode(&ITEM, -1, ba2_.items_id, &ITEM)
           and exists
         (select *
                  from open.or_ope_uni_item_bala mo2_
                 where mo2_.operating_unit_id = ba2_.operating_unit_id
                   and mo2_.items_id = ba2_.items_id)
           and ba2_.items_id = it2_.items_id
        union all
        select ba3_.operating_unit_id || ' - ' ||
               (select uo6.name
                  from open.or_operating_unit uo6
                 where uo6.operating_unit_id = ba3_.operating_unit_id) unidad_base,
               -1,
               ba3_.items_id,
               it3_.description,
               it3_.item_classif_id,
               nvl(ba3_.transit_out, 0),
               'Saldo en Transito',
               sysdate fecha,
               '',
               '',
               '',
               ''
          from open.or_ope_uni_item_bala ba3_, open.ge_items it3_
         where 1 = 1
           and ba3_.operating_unit_id in (&UNIDAD) --= decode( &UNIDAD, -1, ba3_.operating_unit_id, &UNIDAD )
              --and ba3_.items_id = decode(&ITEM, -1, ba3_.items_id, &ITEM)
           and nvl(ba3_.transit_out, 0) > 0
           and ba3_.items_id = it3_.items_id) r
 order by r.items_id, r.fecha
