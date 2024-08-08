--revision api pno
select *
from open.or_order_activity
where package_id=10784532;--solicitud abierta sin cerrar
--ordenes legalizada y la que debio legalizar
select o.order_id,a.status,o.order_status_id, o.assigned_date, o.legalization_date,o.operating_unit_id, o.task_type_id, causal_id, a.package_id
from open.or_order_activity a, open.or_order o
where subscription_id=48165343
  and o.task_type_id in (10338, 10133)
  and o.order_id=a.order_id;

  

select open.ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY','ORDER_ID','PACKAGE_ID',14553403) from dual;
-- Cursor para obtener la solicitud de servicio al cliente (queja) relacionada con una
-- de las ordenes de la solicitud de PNO - Actuacion administrativa
    SELECT DISTINCT B.PACKAGE_ID
    FROM   OPEN.OR_ORDER_ACTIVITY A, OPEN.MO_PACKAGES B
    WHERE  A.PACKAGE_ID = 10783451 --solicitud que se cerro en este caso pno
    AND    B.ORDER_ID = A.ORDER_ID;


    -- Cursor para buscar solicitudes asociadas a una solicitud pasada como parametro
    select DISTINCT A.PACKAGE_ID
    from   open.mo_packages_asso a
    where  package_id_asso = 10784532 --solicitud devuelta por cursor anterior
    union
    select DISTINCT A.PACKAGE_ID
    from open.mo_packages_asso a
    where package_id = 10784532;--solicitud devuelta por cursor anterior 
    
 select distinct a.order_id, A.OPERATING_UNIT_ID
        from open.or_order_activity a, open.or_order b
        where A.ORDER_ID = B.ORDER_ID
        and A.PACKAGE_ID IN (10784532)
        and A.TASK_TYPE_ID = 10338
        and B.ORDER_STATUS_ID = 5;
select person_id 
from open.or_oper_unit_persons
where operating_unit_id = 76 and rownum = 1;        
select a.target_value
        from OPEN.GE_EQUIVALENC_VALUES a
        where A.ORIGIN_VALUE = '10133-3044-'
        and A.equivalence_set_id = 50301;
        
        
 SELECT target_value
                    FROM open.ge_equivalenc_values
                    WHERE equivalence_set_id = 218
                    AND origin_value = 9047
                    AND rownum = 1
                  UNION ALL
                    SELECT '-1'  FLAG_VALIDATE FROM dual

  
  
 
