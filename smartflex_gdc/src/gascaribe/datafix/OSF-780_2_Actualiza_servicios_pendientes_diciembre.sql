column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  -- CEBE 4121 OK
  delete open.LDC_OSF_SERV_PENDIENTE l
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (179342664)
    and l.interna != 2168408;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.interna = 26495408,
        l.ingreso_report = -21840000
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (179342664)
    and l.interna = 2168408;
  --
  commit;
  -- END 4121
  --
  -- CEBE 4101
  delete open.LDC_OSF_SERV_PENDIENTE l
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (180095740)
    and l.interna = 1328000;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.interna = 27616000
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (180095740)
    and l.interna = 24960000;
  --
  commit;
  -- 
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = -621599
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (186577400);
  --
  commit;
  -- 
  delete open.LDC_OSF_SERV_PENDIENTE l
  where l.nuano = 2022
    and l.numes = 12
    and l.solicitud in (10656469,10656631);
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = -l.carg_x_conex
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (186577400);
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (183548550)
    and l.product_id not in (52485909, 52485925)
    and l.ingreso_report = 0;
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = l.cert_previa * -1
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (183548550)
    and l.product_id in (52485909, 52485925)
    and l.cert_previa > 0;
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (188501765) -- 
    and l.product_id in (52482104,52482105,52482106,52482107,52482108,52482109,52482110,52482111,52482112,52482113,52482114,
                          52482115,52482116,52482118,52482119,52482120,52482121,52482122,52482123,52482124,52482125,52482127,
                          52482128,52482129,52482130,52482132,52482133,52482134,52482136,52482137,52482138,52482140,52482141,
                          52482142,52482143,52482144,52482145,52482147);
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (189354989) -- 
    and l.product_id in (52499613,52499615,52499616,52499617,52499619,52499620,52499621,52499622,52499623,52499625,52499626,
                          52499627,52499628,52499629,52499630)
    and l.ingreso_report = 0;
  --
  commit;
  --
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (189354989) -- 
    and l.product_id in (52499631,52499632,52499633,52499634,52499635,52499636,52499637,52499638,52499639,52499640,52499641,52499642,
                          52499643,52499644,52499645,52499646)
    and l.cert_previa > 0;
  --
  commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/