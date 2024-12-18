column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

--
delete open.LDC_OSF_SERV_PENDIENTE l
 where l.nuano = 2022
   and l.numes in (10)
   and l.solicitud in (190501765,189593158,189780414,181236904,188723076,189262105,190147145,190541875,181236904,185890574,186941307,183308985);
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report * -1
 where l.nuano = 2022
   and l.numes in (10)
   and l.product_id in (6634006,6634010,6634013,6634017,6634021);
-- 
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.interna * -1
 where l.nuano = 2022
   and l.numes in (10)
   and l.product_id in (52284998)
   and l.interna != 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = 0
 where l.nuano = 2022
   and l.numes in (9,10)
   and l.product_id = 52340035
   and l.interna != 43225000;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.interna * -1
 where l.nuano = 2022
   and l.numes in (10)
   and l.product_id in (52296581)
   and l.interna != 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.cert_previa = l.cert_previa * -1
 where l.nuano = 2022
   and l.numes in (10)
   and l.product_id in (52458965,52458966,52458967,52458969,52458970,52458971,52458972,52458973,52458974,52458975,52458976,52458977,
                        52458978,52458979,52458980,52458981,52458982,52458983,52458984,52458985,52458986,52458988,52458989,52458991,
                        52458992,52458993,52458994,52458996,52458997,52458998,52458999,52459000,52459001,52459002,52459003,52459004,
                        52459006,52459007,52459008,52459017,52459019,52459020,52459021,52459022,52459023,52459024,52459025,52459029,
                        52459033,52459035,52459036,52459037,52459039,52459040,52459042,52459044,52459045,52459047,52459049,52459050,
                        52459052,52459063,52459066,52459067,52459068,52459069,52459087,52459088,52473387)
   and l.cert_previa != 0;
--
commit;
--

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/