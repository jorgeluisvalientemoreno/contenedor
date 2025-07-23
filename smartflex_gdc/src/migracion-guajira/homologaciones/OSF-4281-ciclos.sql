column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  insert into homologacion.homociclo
with base as(
select 101 as ciclcodi, 6001 as ciclhomo from dual union all
select 201 as ciclcodi, 6002 as ciclhomo from dual union all
select 301 as ciclcodi, 6003 as ciclhomo from dual union all
select 401 as ciclcodi, 6004 as ciclhomo from dual union all
select 501 as ciclcodi, 6005 as ciclhomo from dual union all
select 601 as ciclcodi, 6006 as ciclhomo from dual union all
select 701 as ciclcodi, 6007 as ciclhomo from dual union all
select 801 as ciclcodi, 6008 as ciclhomo from dual union all
select 901 as ciclcodi, 6009 as ciclhomo from dual union all
select 1001 as ciclcodi, 6010 as ciclhomo from dual union all
select 1101 as ciclcodi, 6011 as ciclhomo from dual union all
select 1201 as ciclcodi, 6012 as ciclhomo from dual union all
select 9901 as ciclcodi, 6501 as ciclhomo from dual union all
select 9991 as ciclcodi, 6500 as ciclhomo from dual union all
select 9997 as ciclcodi, 6507 as ciclhomo from dual union all
select 9998 as ciclcodi, 6508 as ciclhomo from dual union all
select 9999 as ciclcodi, 6509 as ciclhomo from dual union all
select 102 as ciclcodi, 6021 as ciclhomo from dual union all
select 202 as ciclcodi, 6022 as ciclhomo from dual union all
select 302 as ciclcodi, 6023 as ciclhomo from dual union all
select 402 as ciclcodi, 6024 as ciclhomo from dual union all
select 502 as ciclcodi, 6025 as ciclhomo from dual union all
select 602 as ciclcodi, 6026 as ciclhomo from dual union all
select 702 as ciclcodi, 6027 as ciclhomo from dual union all
select 802 as ciclcodi, 6028 as ciclhomo from dual union all
select 902 as ciclcodi, 6029 as ciclhomo from dual union all
select 1002 as ciclcodi, 6030 as ciclhomo from dual union all
select 1102 as ciclcodi, 6031 as ciclhomo from dual union all
select 1202 as ciclcodi, 6032 as ciclhomo from dual union all
select 103 as ciclcodi, 6040 as ciclhomo from dual union all
select 9903 as ciclcodi, 6503 as ciclhomo from dual union all
select 204 as ciclcodi, 6043 as ciclhomo from dual union all
select 9902 as ciclcodi, 6502 as ciclhomo from dual union all
select 205 as ciclcodi, 6048 as ciclhomo from dual union all
select 106 as ciclcodi, 6051 as ciclhomo from dual union all
select 1307 as ciclcodi, 6054 as ciclhomo from dual union all
select 1308 as ciclcodi, 6059 as ciclhomo from dual union all
select 109 as ciclcodi, 6064 as ciclhomo from dual union all
select 609 as ciclcodi, 6194 as ciclhomo from dual union all
select 310 as ciclcodi, 6069 as ciclhomo from dual union all
select 411 as ciclcodi, 6072 as ciclhomo from dual union all
select 711 as ciclcodi, 6073 as ciclhomo from dual union all
select 811 as ciclcodi, 6074 as ciclhomo from dual union all
select 212 as ciclcodi, 6082 as ciclhomo from dual union all
select 312 as ciclcodi, 6083 as ciclhomo from dual union all
select 412 as ciclcodi, 6084 as ciclhomo from dual union all
select 812 as ciclcodi, 6085 as ciclhomo from dual union all
select 913 as ciclcodi, 6092 as ciclhomo from dual union all
select 1013 as ciclcodi, 6093 as ciclhomo from dual union all
select 1071 as ciclcodi, 6287 as ciclhomo from dual union all
select 1113 as ciclcodi, 6094 as ciclhomo from dual union all
select 1213 as ciclcodi, 6095 as ciclhomo from dual union all
select 1214 as ciclcodi, 6102 as ciclhomo from dual union all
select 615 as ciclcodi, 6107 as ciclhomo from dual union all
select 715 as ciclcodi, 6108 as ciclhomo from dual union all
select 1115 as ciclcodi, 6109 as ciclhomo from dual union all
select 1316 as ciclcodi, 6117 as ciclhomo from dual union all
select 517 as ciclcodi, 6122 as ciclhomo from dual union all
select 618 as ciclcodi, 6127 as ciclhomo from dual union all
select 519 as ciclcodi, 6130 as ciclhomo from dual union all
select 520 as ciclcodi, 6135 as ciclhomo from dual union all
select 121 as ciclcodi, 6138 as ciclhomo from dual union all
select 122 as ciclcodi, 6142 as ciclhomo from dual union all
select 9922 as ciclcodi, 6141 as ciclhomo from dual union all
select 123 as ciclcodi, 6144 as ciclhomo from dual union all
select 1325 as ciclcodi, 6147 as ciclhomo from dual union all
select 326 as ciclcodi, 6150 as ciclhomo from dual union all
select 927 as ciclcodi, 6153 as ciclhomo from dual union all
select 128 as ciclcodi, 6156 as ciclhomo from dual union all
select 528 as ciclcodi, 6157 as ciclhomo from dual union all
select 129 as ciclcodi, 6159 as ciclhomo from dual union all
select 529 as ciclcodi, 6160 as ciclhomo from dual union all
select 130 as ciclcodi, 6162 as ciclhomo from dual union all
select 530 as ciclcodi, 6163 as ciclhomo from dual union all
select 531 as ciclcodi, 6165 as ciclhomo from dual union all
select 532 as ciclcodi, 6168 as ciclhomo from dual union all
select 733 as ciclcodi, 6171 as ciclhomo from dual union all
select 134 as ciclcodi, 6174 as ciclhomo from dual union all
select 135 as ciclcodi, 6177 as ciclhomo from dual union all
select 735 as ciclcodi, 6178 as ciclhomo from dual union all
select 1336 as ciclcodi, 6180 as ciclhomo from dual union all
select 737 as ciclcodi, 6183 as ciclhomo from dual union all
select 338 as ciclcodi, 6186 as ciclhomo from dual union all
select 539 as ciclcodi, 6189 as ciclhomo from dual union all
select 540 as ciclcodi, 6192 as ciclhomo from dual union all
select 640 as ciclcodi, 6193 as ciclhomo from dual union all
select 1343 as ciclcodi, 6203 as ciclhomo from dual union all
select 644 as ciclcodi, 6206 as ciclhomo from dual union all
select 345 as ciclcodi, 6209 as ciclhomo from dual union all
select 246 as ciclcodi, 6212 as ciclhomo from dual union all
select 247 as ciclcodi, 6215 as ciclhomo from dual union all
select 948 as ciclcodi, 6218 as ciclhomo from dual union all
select 1049 as ciclcodi, 6221 as ciclhomo from dual union all
select 950 as ciclcodi, 6224 as ciclhomo from dual union all
select 951 as ciclcodi, 6227 as ciclhomo from dual union all
select 1052 as ciclcodi, 6230 as ciclhomo from dual union all
select 953 as ciclcodi, 6233 as ciclhomo from dual union all
select 154 as ciclcodi, 6236 as ciclhomo from dual union all
select 255 as ciclcodi, 6239 as ciclhomo from dual union all
select 1056 as ciclcodi, 6242 as ciclhomo from dual union all
select 1057 as ciclcodi, 6245 as ciclhomo from dual union all
select 158 as ciclcodi, 6248 as ciclhomo from dual union all
select 1258 as ciclcodi, 6249 as ciclhomo from dual union all
select 1358 as ciclcodi, 6250 as ciclhomo from dual union all
select 1159 as ciclcodi, 6251 as ciclhomo from dual union all
select 1160 as ciclcodi, 6254 as ciclhomo from dual union all
select 1161 as ciclcodi, 6257 as ciclhomo from dual union all
select 1162 as ciclcodi, 6260 as ciclhomo from dual union all
select 1263 as ciclcodi, 6263 as ciclhomo from dual union all
select 1364 as ciclcodi, 6266 as ciclhomo from dual union all
select 1265 as ciclcodi, 6269 as ciclhomo from dual union all
select 666 as ciclcodi, 6272 as ciclhomo from dual union all
select 667 as ciclcodi, 6275 as ciclhomo from dual union all
select 668 as ciclcodi, 6278 as ciclhomo from dual union all
select 669 as ciclcodi, 6281 as ciclhomo from dual union all
select 1170 as ciclcodi, 6284 as ciclhomo from dual union all
select 1271 as ciclcodi, 6287 as ciclhomo from dual union all
select 1272 as ciclcodi, 6290 as ciclhomo from dual union all
select 1273 as ciclcodi, 6293 as ciclhomo from dual union all
select 1174 as ciclcodi, 6296 as ciclhomo from dual union all
select 1275 as ciclcodi, 6299 as ciclhomo from dual union all
select 1076 as ciclcodi, 6302 as ciclhomo from dual union all
select 1077 as ciclcodi, 6305 as ciclhomo from dual union all
select 1078 as ciclcodi, 6308 as ciclhomo from dual union all
select 279 as ciclcodi, 6311 as ciclhomo from dual union all
select 1380 as ciclcodi, 6314 as ciclhomo from dual union all
select 681 as ciclcodi, 6317 as ciclhomo from dual union all
select 782 as ciclcodi, 6320 as ciclhomo from dual union all
select 1283 as ciclcodi, 6323 as ciclhomo from dual)
select *
from base b
where exists(select null from open.ciclo c where b.ciclhomo=c.ciclcodi)
  and not exists(select null from homologacion.homociclo h where h.ciclcodi = b.ciclcodi and h.ciclhomo = b.ciclhomo);
  dbms_output.put_line('Se insertaron '||sql%rowcount||' registros');
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/