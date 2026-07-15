
SELECT * 
FROM LDC_VENT_EXC_COMISION
WHERE status_ = 'E'
and  package_id in (  236584567,236584562,236584557,236584548)
order by register_date desc 
