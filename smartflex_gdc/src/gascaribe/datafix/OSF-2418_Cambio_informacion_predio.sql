column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  dbms_output.put_line('Inicia Cambio OSF-2418 !');

    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1296341;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1635027;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1635811;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1635793;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1637236;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1638124;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1653175;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1653923;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1413426;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1413428;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593568;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593534;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1652044;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1666787;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1642098;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1667486;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1667713;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1602599;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1022856;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669120;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669132;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669119;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669048;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669190;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1538135;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1538136;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1538134;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1538746;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1670201;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1668463;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593483;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1672082;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1544349;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1671752;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1669885;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1673662;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1321496;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 954582;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1674958;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1254959;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1674806;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1665216;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1127978;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676316;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676333;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676315;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676319;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676321;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676336;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1603435;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676337;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676324;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676313;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1603436;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676327;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676314;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1212283;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1209835;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676320;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676169;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1567591;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676352;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676354;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676343;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676340;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676345;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676312;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676342;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676416;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676543;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676570;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676366;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676349;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1586900;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676177;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1389563;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1439129;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676536;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676548;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1581397;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 532011;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580489;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580490;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676928;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 530729;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580357;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580491;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580834;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1580529;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1005279;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1072695;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1678173;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593628;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1541446;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676930;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1545121;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1676854;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593664;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1682601;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1321532;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1683990;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1690051;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1693861;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1697904;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1550462;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1641130;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='N', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1593697;
    UPDATE OPEN.LDC_INFO_PREDIO SET IS_ZONA ='S', PORC_PENETRACION = 100 WHERE PREMISE_ID = 1681527;

  commit;

  dbms_output.put_line('Termina Cambio OSF-2418 !');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/