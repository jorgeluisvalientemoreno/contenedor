select a.*, rowid
  from OPEN.PAGARE a
 where a.pagafech > trunc(sysdate) - 380
   and a.pagafech < trunc(sysdate) - 180
 order by a.pagafech desc;
select (select mm.product_id from open.mo_motive mm where mm.package_id=a.package_id ) Producto, a.*, rowid
  from OPEN.CC_FINANCING_REQUEST a
 where a.financing_id = 26578296;
select a.*, rowid
  from OPEN.CC_FIN_REQ_CONCEPT a
 where a.financing_request_id in
       (select a1.financing_request_id
          from OPEN.CC_FINANCING_REQUEST a1
         where a1.financing_id = 26578296);
