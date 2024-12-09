select *
  from open.ge_object a
 where 
 upper(a.name_) LIKE upper('%MO_BOSEQUENCES.FNUGETSEQ_MO_BILL_DATA_CHANGE%')
 --upper(a.description) LIKE upper('%Exencion%')
