select *
  from open.ge_attributes a
 where a.name_attribute = 'CLIENTE_PAGA'
    or a.comment_ = 'CLIENTE_PAGA'
    or a.display_name = 'CLIENTE_PAGA';

