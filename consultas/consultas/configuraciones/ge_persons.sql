select p.person_id,
       p.personal_type,
       p.name_,
       u.mask,
       p.e_mail,
       p.organizat_area_id,
       p.beeper,
       p.user_id,
       p.phone_number,
       p.geograp_location_id,
       p.ident_type_id,
       p.employee_company_id,
       p.fax_number,
       p.comment_,
       p.atel_phone_number,
       p.position_type_id
  from open.ge_person p
 inner join open.sa_user u on u.user_id = p.user_id
