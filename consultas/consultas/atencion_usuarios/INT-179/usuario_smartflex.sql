select user_id, 
       mask  "USUARIO", 
       length(mask)  "# CARACTERES" 
from open.sa_user  u
where length(mask) > 10