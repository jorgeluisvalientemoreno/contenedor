---cliento x contrato 
select *
  from open.GE_SUBSCRIBER gs
 where gs.subscriber_id in
       (select s.suscclie from open.suscripc s where s.susccodi = 67562052);

---contrato por cliento
select *
  from open.GE_SUBSCRIBER gs, open.suscripc s
 where gs.subscriber_id = s.suscclie
   and gs.subscriber_id = 2392715;

select s.* from open.suscripc s where s.susccodi = 67562052;
select a.*, rowid from open.servsusc a where a.sesuSUSC = 67562052;
select a.*, rowid
  from open.pr_product a
 where a.Subscription_Id = 67562052;
---cliento por contrato
select * from open.GE_SUBSCRIBER gs WHERE GS.PHONE = '3145681829';

select a.*, rowid
  from OPEN.GE_SUBS_PHONE a
 where a.subscriber_id = 2392715;
select a.*, rowid
  from OPEN.GE_SUBS_GENERAL_DATA a
 where a.subscriber_id = 2392715;

select a.*, rowid
  from OPEN.GE_SUBSCRIBER a
 where --A.PHONE = '3016927584'
 a.Identification = '36560671';

---cliento Sin contrato
select *
  from open.GE_SUBSCRIBER gs
 where (select count(1)
          from open.suscripc s
         where s.suscclie = gs.subscriber_id) = 0
 order by gs.subscriber_id desc;

---cliento con contrato
select *
  from open.GE_SUBSCRIBER gs
 where (select count(1)
          from open.suscripc s
         where s.suscclie = gs.subscriber_id
           and s.susccodi = 6108314) > 0;

---Contrato por codigo cliente
select *
  from open.servsusc ss
 where ss.sesususc in
       (select s.susccodi from open.suscripc s where s.suscclie = 476967);

select * from open.suscripc s where s.suscclie = 476967;
select * FROM open.ge_subscriber a WHERE a.subscriber_id = 476967;
select * from open.ab_address a where a.address_id = 1042818;
--DATA GENERAL
SELECT s.susccodi Contrato,
       a.address_id,
       a.subscriber_id subscriber_id,
       a.subscriber_name subscriber_name,
       a.subs_last_name subs_last_name,
       a.ident_type_id || ' - ' ||
       --cc_boOssDescription.fsbIdentificationType(a.ident_type_id) ident_type_id,
        a.identification identification,
       a.subscriber_type_id || ' - ' ||
       --cc_boOssDescription.fsbSubscriberType(a.subscriber_type_id) subscriber_type_id,
       --cc_boOssSubscriberData.fsbGetPhone(a.subscriber_id) phone,
       --cc_boOssDescription.fsbParsedAddress(a.address_id) address,
       --cc_boossaddress.fnuGeoLocIdByAddressId(a.address_id) || ' - ' ||
       --cc_boOssDescription.fsbGeograLocation(cc_boossaddress.fnuGeoLocIdByAddressId(a.address_id)) geograp_location_id,
       --cc_boossaddress.fnuNeighborthoodIdByAddressId(a.address_id) || ' - ' ||
       --CC_BOOssDescription.fsbNeighborthood(cc_boossaddress.fnuNeighborthoodIdByAddressId(a.address_id)) neighborthood_id,
        a.e_mail e_mail,
       a.contact_id contact_id,
       b.subscriber_name || ' ' || b.subs_last_name contact_name,
       b.phone contact_phone,
       b.address contact_address,
       a.subs_status_id || ' - ' ||
       --cc_boOssDescription.fsbSubscriberStatus(a.subs_status_id) status,
        c.economic_activity_id || ' - ' ||
       --cc_boOssDescription.fsbEconomicActivity(c.economic_activity_id) economic_activity,
       --cc_boOssSubscriberData.fsbNationality(a.subscriber_id) nationality,
       --cc_boOssSubscriberData.fnuCivilState(a.subscriber_id) || ' - ' ||
       --cc_boOssDescription.fsbCivilState(cc_boOssSubscriberData.fnuCivilState(a.subscriber_id)) civil_state_id,
       --cc_boOssSubscriberData.fsbGender(a.subscriber_id) gender,
        c.url url,
       decode(a.active, 'Y', 'Si', 'No') active,
       a.vinculate_date vinculate_date,
       a.marketing_segment_id || ' - ' ||
       --cc_boOssDescription.fsbMarketingSegment(a.marketing_segment_id) marketing_segment,
       ---cc_boOssSubscriberData.fnuGetPersonClassId(a.subscriber_id) || ' - ' ||
       --cc_boOssSubscriberData.fsbGetPersonClass(a.subscriber_id) person_class_id,
       --cc_boOssSubscriberData.fnuGetPaymentBehavior(a.subscriber_id) payment_behavior,
        a.accept_call accept_call,
       --cc_boOssSubscriberData.fdtGetDateBithBySubscriber(a.subscriber_id) date_birth,
       a.taxpayer_type || ' - ' ||
       --cc_boOssSubscriberData.fdtGetDescTaxPayerType(a.taxpayer_type) taxpayer_type,
       --cc_boOssSubscriberData.fsbGetScoring(a.subscriber_id) scoring,
        decode(a.Is_Corporative, 'Y', 'Si', 'No') Is_Corporative,
       s.susccicl Cilo_Facturacion,
       s.SUSCIDDI || ' - ' || ab.address Direccion_Cobro,
       ab.segment_id Segmento,
       as1.category_ Categoria,
       as1.subcategory_ Subcategoria,
       s.SUSCTISU || ' - ' || gst.description Tipo_contrato
--, cc_boOssSubscriberData.fnuGetOlderClient(a.subscriber_id) older_client
  FROM open.ge_subscriber a
  left join open.ge_subscriber b
    on b.subscriber_id(+) = a.contact_id
  left join open.ge_subs_busines_data c
    on a.subscriber_id = c.subscriber_id
  left join open.suscripc s
    on a.subscriber_id = s.suscclie
  left join open.ab_address ab
    on ab.address_id = s.SUSCIDDI
  left join OPEN.AB_SEGMENTS as1
    on as1.segments_id = ab.segment_id
  left join OPEN.GE_SUBSCRIPTION_TYPE gst
    on gst.subscription_type = s.susctisu
 WHERE
--and s.susccodi in (67464673, 66572991)
--and 
 a.subscriber_id in (2095479, 3220406)
