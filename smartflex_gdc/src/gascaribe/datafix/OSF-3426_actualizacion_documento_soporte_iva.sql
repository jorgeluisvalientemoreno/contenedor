set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
DECLARE
  CURSOR cuGetCuentas IS
  SELECT distinct cargcuco
    FROM open.cargos, OPEN.SERVSUSC
    WHERE cargnuse = SESUNUSE 
    and SESUSUSC IN (67438478
        ,67466854
        ,67466851
        ,67424854
        ,67463619
        ,67444495
        ,67305748
        ,67411353
        ,67497005
        ,67495161
        ,67438478
        ,67466854
        ,67466851
        ,67424854
        ,67463619
        ,67444495
        ,67305748
        ,67411353
        ,67497005
        ,67495161) 
     AND CARGFECR > TO_DATE('07/10/2024','DD/MM/YYYY')
     AND cargconc <> 9;
 
BEGIN
  FOR reg IN cuGetCuentas LOOP
      UPDATE cargos SET CARGDOSO = 'PP-24005580' WHERE cargcuco =reg.cargcuco AND CARGCONC IN (137,287);
      UPDATE cargos SET CARGCACA = 53 WHERE cargcuco =reg.cargcuco AND CARGCONC IN (30,674);
  END LOOP;
  COMMIT;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/