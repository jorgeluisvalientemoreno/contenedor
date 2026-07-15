SELECT *
FROM GE_NOTIFICATION_LOG l
left join GE_NOTIFICATION  n  on n.notification_id = l.notification_id 
WHERE n.NOTIFICATION_ID IN (100212)
and description like '%POP-UP%SJ%' --and EXTERNAL_ID = 209060
ORDER BY 1 DESC 

SELECT *
FROM GE_CONF_ACCOUNT_NOTIF
where  USERNAME LIKE '%silvana.jurado%'
--for update CAMBIAR CORREO Y EN ASRENO LA CONTRASEÑA
  
SELECT *
FROM GE_NOTIFICATION 
WHERE NOTIFICATION_ID = 100206 

 description like '%SJ%'

SELECT *
FROM SA_USER
WHERE mask = 'SILVJURA'


select *
from ge_person 
where name_  like '%SILVANA%'
FOR UPDATE 
