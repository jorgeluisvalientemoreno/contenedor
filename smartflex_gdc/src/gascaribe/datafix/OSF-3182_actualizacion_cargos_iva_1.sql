set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
DECLARE
  CURSOR cuGetactura IS
    select cargos.rowid id_reg, (SELECT ta_tariconc.tacocons
            FROM OPEN.ta_tariconc, OPEN.ta_conftaco
            WHERE ta_conftaco.cotcconc = CARGCONC
             AND ta_conftaco.cotccons = ta_tariconc.tacocotc
             AND sysdate BETWEEN ta_conftaco.cotcfein AND ta_conftaco.cotcfefi
             AND ta_conftaco.cotcvige = 'S'
             AND ta_conftaco.cotcserv = sesuserv
             AND ROWNUM < 2) cargtaco
from open.cargos, open.cuencobr, open.servsusc
where cargconc in (137, 287) 
 and sesunuse = cargnuse
 and cucocodi = cargcuco and cucofact in (2137626095,
                                                2137625756,
                                                2137625834,
                                                2137626131,
                                                2137626135,
                                                2137626224,
                                                2137626036,
                                                2137625651,
                                                2137625815,
                                                2137626081,
                                                2137626150,
                                                2137626020,
                                                2137625983,
                                                2137626192,
                                                2137626206,
                                                2137625832,
                                                2137626045,
                                                2137625976,
                                                2137625763,
                                                2137626139,
                                                2137626002,
                                                2137626035);
    
    

BEGIN
    dbms_output.put_line('inicio ');
    FOR reg IN cuGetactura LOOP
     update open.cargos set cargtaco = reg.cargtaco
     where rowid = reg.id_reg;
     commit;
   END LOOP;
      dbms_output.put_line('termino ');
exception
 when others then
   dbms_output.put_line('error '||sqlerrm);
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/