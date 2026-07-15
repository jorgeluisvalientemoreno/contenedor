SELECT *
FROM LDCI_LOGSPROC
WHERE LOPRPROC = 'L2' AND LOPRFECH >= TRUNC(SYSDATE) 
ORDER BY LOPRFECH DESC ;


select cod_interfazldc, count(distinct( num_documentosap ) )
 from ldci_encaintesap
where cod_interfazldc in ( 57303, 57294 ) 
group by cod_interfazldc  ;


select * from ldci_detaintesap
where cod_interfazldc = 57303 ;  
