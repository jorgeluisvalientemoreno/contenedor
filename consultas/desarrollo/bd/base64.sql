select utl_raw.cast_to_raw('222222222222222222222222222222222222222222222223') from dual;
select utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('222222222222222222222222222222222222222222222223'))) from dual;
select utl_raw.cast_to_raw('MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIz') from dual ;
select utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw('MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIz'))) from dual;
