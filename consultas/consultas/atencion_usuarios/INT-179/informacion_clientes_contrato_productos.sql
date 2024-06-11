select distinct ge.subscriber_id  "CLIENTE", 
                ge.subscriber_name || ' ' || ge.subs_last_name  "NOMBRE", 
                ge.identification  "IDENTIFICACION", 
                s.susccodi  "CONTRATO", 
                pr.product_id  "PRODUCTO", 
                pr.product_type_id || '-  ' || s.servdesc "TIPO",
                ab.address  "DIRECCION", 
                ss.sesucate  "CATEGORIA", 
                ge.phone  "TELEFONO", 
                ge.active  "ACTIVO"
from open.ge_subscriber ge
left join open.suscripc s  on s.suscclie = ge.subscriber_id  
left join open.servsusc ss on ss.sesususc = s.susccodi 
left join open.pr_product pr on pr.product_id = ss.sesunuse 
left join open.ab_address ab on ab.address_id = pr.address_id 
left join open.servicio s on s.servcodi = pr.product_type_id
where ge.subscriber_id = 52429