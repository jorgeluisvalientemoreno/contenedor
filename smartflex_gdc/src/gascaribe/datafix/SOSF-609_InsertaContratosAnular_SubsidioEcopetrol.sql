column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
 insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238364);
 insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238367);
 insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238370);
 insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238373);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238376);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238383);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238386);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238389);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238392);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238395);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238398);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238405);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238408);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238411);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238414);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238417);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238420);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238423);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238426);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238429);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238432);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238435);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238438);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238441);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238444);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238447);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238450);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238453);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238456);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238459);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238462);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238465);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238468);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238471);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238474);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238480);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238483);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238486);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67238489);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303146);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303147);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303148);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303149);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303150);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303151);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303152);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303153);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303154);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303155);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303156);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303157);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303158);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303159);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303160);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303161);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303162);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303163);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303164);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303165);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303166);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303167);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303168);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303177);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303179);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303183);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303184);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303188);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303189);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303191);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303196);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303197);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303200);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303223);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303226);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303228);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303242);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303243);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303245);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303249);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303252);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303253);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303256);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303258);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303261);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303262);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303266);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303267);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303270);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303274);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303281);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303284);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303286);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303288);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303291);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303293);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303294);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303298);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303303);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303305);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303306);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303310);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303314);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303317);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303319);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303322);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303324);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303332);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303334);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303336);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303338);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303345);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303347);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303353);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303354);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303355);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303356);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303412);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303413);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67232709,67303414);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173621);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173628);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173693);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173696);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173699);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173723);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173744);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173750);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173759);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173762);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173765);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173768);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173786);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173792);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173795);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173813);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173822);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173825);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173828);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173837);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173843);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173849);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173855);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67173858);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185440);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185471);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185480);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185510);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185513);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185519);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185528);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185534);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185553);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185565);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185568);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185577);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185583);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185586);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185601);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185619);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185646);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185655);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185658);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185673);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185691);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185706);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185724);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185745);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185763);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185766);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185775);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185781);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185787);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185793);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67185802);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211258);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211261);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211270);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211276);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211291);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211297);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211306);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211330);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211354);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211360);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211366);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211375);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211408);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67211417);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236336);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236339);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236345);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236354);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236366);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236378);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236384);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236403);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236409);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236413);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236416);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236425);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236440);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236446);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236449);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236452);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236455);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236461);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236470);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236482);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236485);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236508);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236514);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236526);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236532);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236538);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236553);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236562);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236574);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236577);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236580);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236586);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236589);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236604);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236610);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67236613);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250461);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250467);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250472);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250473);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250474);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250488);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250493);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67250524);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251899);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251900);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251906);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251907);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251909);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251910);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251911);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251913);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251914);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251915);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251929);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251931);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251934);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251937);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251950);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251953);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67251999);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252000);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252002);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252008);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252014);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252020);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252022);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252521);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252522);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252523);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252524);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252526);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252527);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252528);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252530);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252532);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252533);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252534);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252535);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252536);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252537);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252555);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252560);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252562);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252564);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252571);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252578);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252581);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252584);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252587);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252591);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252595);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252598);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252611);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252612);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252614);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252615);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252636);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252637);
insert into LDC_CONTANVE(CONTPADRE,CONTANUL) values (67231314,67252638);  
commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/