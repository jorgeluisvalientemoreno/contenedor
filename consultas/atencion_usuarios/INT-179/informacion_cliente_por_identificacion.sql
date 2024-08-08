select ge.subscriber_id  "CLIENTE", 
       ge.ident_type_id || '-  ' || it.description "TIPO", 
       ge.identification  "# IDENTIFICACION", 
       ge.subscriber_name  "NOMBRE", 
       ge.phone  "TELEFONO",
       ge.active  "ACTIVO"
from open.ge_subscriber  ge
inner join open.ge_identifica_type  it on it.ident_type_id = ge.ident_type_id
where ge.identification = '8001852951'