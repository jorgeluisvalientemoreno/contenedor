--Regsitro insolvencia
select a.*, rowid
  from OPEN.MO_DATA_INSOLVENCY a
 where a.subscription_id = 66572991
 order by a.motive_id desc;

--Solciitud Insolvencia
select ppt.description, mp.*
  from open.mo_packages mp, open.mo_motive mm, open.ps_package_type ppt
 where mm.package_id = mp.package_id
   and mm.motive_id in
       (select a.motive_id
          from OPEN.MO_DATA_INSOLVENCY a
         where a.subscription_id = 66572991)
   and ppt.package_type_id = mp.package_type_id
 order by mp.request_date desc;

--Contrato origen y contrato de insolvencia
SELECT s.susccodi Contrato,
       a.address_id,
       a.subscriber_id subscriber_id,
       a.subscriber_name subscriber_name,
       a.subs_last_name subs_last_name,
       a.ident_type_id || ' - ' || a.identification identification,
       a.subscriber_type_id || ' - ' || a.e_mail e_mail,
       a.contact_id contact_id,
       b.subscriber_name || ' ' || b.subs_last_name contact_name,
       b.phone contact_phone,
       b.address contact_address,
       a.subs_status_id || ' - ' || c.economic_activity_id || ' - ' ||
       decode(a.active, 'Y', 'Si', 'No') active,
       a.vinculate_date vinculate_date,
       a.taxpayer_type || ' - ' ||
       decode(a.Is_Corporative, 'Y', 'Si', 'No') Is_Corporative,
       s.susccicl Cilo_Facturacion,
       s.SUSCIDDI || ' - ' || ab.address Direccion_Cobro,
       ab.segment_id Segmento,
       as1.category_ Categoria,
       as1.subcategory_ Subcategoria,
       s.SUSCTISU || ' - ' || gst.description Tipo_contrato
  FROM open.ge_subscriber        a,
       open.ge_subscriber        b,
       open.ge_subs_busines_data c,
       open.suscripc             s,
       open.ab_address           ab,
       OPEN.AB_SEGMENTS          as1,
       OPEN.GE_SUBSCRIPTION_TYPE gst
 WHERE a.subscriber_id = s.suscclie
   AND b.subscriber_id(+) = a.contact_id
   AND a.subscriber_id = c.subscriber_id(+)
   and ab.address_id = s.SUSCIDDI
   and as1.segments_id = ab.segment_id
   and gst.subscription_type = s.susctisu
      --and s.susccodi in (67464673, 66572991)
   and s.suscclie =
       (select z.suscclie from OPEN.SUSCRIPC z where z.susccodi = 66572991);

select a.*, rowid from open.servsusc a where a.sesuSUSC in (66572991); --, 67464673);

--cargos contrato origen producto gas
select a.*, rowid
  from open.cargos a
 where a.cargnuse = 51372345
   and a.cargcaca not in (49, 48)
   and a.cargfecr <= '16/08/2023';

--cargos contrato origen producto brilla
select sum(decode(a.cargsign, 'DB', a.cargvalo, -a.cargvalo)) -- a.*, rowid
  from open.cargos a
 where a.cargnuse = 52079597
      --and a.cargcaca not in (49, 48)
   and a.cargsign in ('DB', 'CR')
   and a.cargprog = 290
   and trunc(a.cargfecr) = '27/06/2024';

--cuenta cobro de prodcutos de insolvencia
select s.sesuserv, a.*
  from open.cuencobr a
  left join open.servsusc s
    on s.sesunuse = a.cuconuse
 where a.cuconuse in (52696947, 52696948, 52879157, 52879158);
select a.*, rowid from open.cargos a where a.cargcuco = 3044152441;
select a.*, rowid from open.cargos a where a.cargcuco = 3044152442;
select a.*, rowid from open.cargos a where a.cargcuco = 3063904849;
select a.*, rowid from open.cargos a where a.cargcuco = 3063904850;

---derifo
select a.*, rowid
  from OPEN.DIFERIDO a
 where a.difesusc in (66572991, 67464673)
   --and a.difenucu <> a.difecupa
   ;

select a.*, rowid
  from open.cargos a
 where a.cargnuse in (51372345, 52079597)
   and a.cargfecr > '28/06/2024';

select a.*, rowid
  from OPEN.LD_NON_BAN_FI_ITEM a
 where a.non_ba_fi_requ_id in
       (select mm.package_id
          from open.mo_motive mm
         where mm.subscription_id = 66572991or mm.product_id = 52079597);

select a.*, rowid
  from open.cargos a
 where a.cargnuse = 52079597
 order by a.cargfecr desc;
