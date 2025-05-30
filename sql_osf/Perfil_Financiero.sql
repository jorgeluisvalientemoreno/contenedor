select a.*, rowid from OPEN.GE_PERSON a where a.person_id = 1;
select a.*, rowid from OPEN.SA_USER a where a. =;
-- perdil_financiero
select f.position_type_id,
       p.name_,
       case
         when f.action_amount_id = 1 then
          '1 - MONTO FINANCIACIONES'
         when f.action_amount_id = 2 then
          '2 - MONTO TRANSACCIÓN EN CAJA'
         when f.action_amount_id = 3 then
          '3 - MONTO NOVEDAD CONTRATISTA'
         when f.action_amount_id = 4 then
          '4 - MONTO NOTAS DE FACTURACIÓN'
         when f.action_amount_id = 5 then
          '5 - MONTO DEVOLUCIÓN SALDO A FAVOR'
         when f.action_amount_id = 6 then
          '6 - MONTO NEGOCIACIÓN DE DEUDA'
       end "accion",
       f.max_budget presupuesto_maximo
  from ge_person p, ge_financial_profile f
 where p.user_id =
       (select s.user_id from open.sa_user s where mask = 'ADMIOPEF')
   and f.position_type_id = p.position_type_id
   and p.position_type_id = 1293;
insert into ge_financial_profile values (1293, 1, 99999999999);
insert into ge_financial_profile values (1293, 2, 99999999999);
insert into ge_financial_profile values (1293, 3, 99999999999);
insert into ge_financial_profile values (1293, 4, 99999999999);
insert into ge_financial_profile values (1293, 5, 99999999999);
insert into ge_financial_profile values (1293, 6, 99999999999);
