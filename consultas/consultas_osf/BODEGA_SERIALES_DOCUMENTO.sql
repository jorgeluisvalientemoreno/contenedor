select oou.*
  from open.or_operating_unit oou
 where oou.operating_unit_id in (799);
select gi.*, rowid from open.ge_items gi where gi.items_id = 4295313;
select oou.*
  from open.or_operating_unit oou
 where oou.operating_unit_id = 799;
select *
  from open.or_ope_uni_item_bala a
 where a.operating_unit_id = 799
   and a.items_id = 4295313;

select max(uni_item_bala_mov_id)
  from open.or_uni_item_bala_mov a
 where a.operating_unit_id = 799
   and a.items_id = 4295313;

select *
  from open.or_uni_item_bala_mov a
 where a.uni_item_bala_mov_id = 6184468
   and a.operating_unit_id = 799;

select 'I', sum(a.amount)
  from open.or_uni_item_bala_mov a
 where a.movement_type = 'I'
   and a.operating_unit_id = 799
   and a.items_id = 4295313
union all
select 'D', sum(a.amount)
  from open.or_uni_item_bala_mov a
 where a.movement_type = 'D'
   and a.operating_unit_id = 799
   and a.items_id = 4295313
union all
select *
  from open.or_uni_item_bala_mov a
 where a.operating_unit_id = 799
   and a.items_id = 4295313
   and a.move_date >= '01/12/2023';

select *
  from open.or_uni_item_bala_mov a
 where a.movement_type = 'I'
   and a.operating_unit_id = 799
   and a.items_id = 4295313;
select *
  from open.or_uni_item_bala_mov a
 where a.movement_type = 'D'
   and a.operating_unit_id = 799
   and a.items_id = 4295313;
select *
  from open.or_uni_item_bala_mov a
 where a.movement_type = 'N'
   and a.operating_unit_id = 799
   and a.items_id = 4295313;
select *
  from open.or_uni_item_bala_mov a
 where a.id_items_seriado in (1011, 2085793, 2143775)
 order by a.id_items_seriado desc, a.move_date desc;

select * from open.ge_items_seriado a where a.id_items_seriado = 1007;
select *
  from open.ge_items_seriado a
 where a.serie in ('064-01-002874', '064-01-004327', '064-01-004864');
select *
  from open.or_uni_item_bala_mov a
 where a.id_items_seriado in (1011), 2085793, 2143775);
select *
  from open.ge_items_seriado a
 where a.operating_unit_id = 799
   and a.items_id = 4295313;
SELECT *
  FROM OPEN.LDC_OSF_LDCRBAI a
 where a.cod_unid_oper = 799and a.cod_item = 4295313
   and a.fec_corte >= '01/01/2022';
SELECT *
  FROM OPEN.ldc_osf_salbitemp a
 where a.items_id = 4295313
   and a.operating_unit_id = 799
   and a.nuano >= 2022;
select *
  from open.ge_items_documento a
 where a.id_items_documento = 1355562
