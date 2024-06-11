 select *
        from OPEN.GE_EQUIVALENC_VALUES a
        where A.ORIGIN_VALUE = '10133-3044-'
        and A.equivalence_set_id = 50301;
        
select *
from open.or_task_type
where task_type_id in (10133, 10338);
