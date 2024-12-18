column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  -- Poblacion a la que aplica el Datafix
  cursor cuPoblacionInicial is
    SELECT 262382386 as orden, 50117751 as producto, 48098641 as contrato from dual union all
    SELECT 274323333 as orden, 52081700 as producto, 67039454 as contrato from dual union all
    SELECT 271573975 as orden, 50513730 as producto, 48171621 as contrato  from dual;

  -- Poblacion Karen
  cursor cuPoblacionKa is
    SELECT 142158097 as orden, 50342608 as producto, 48153203 as contrato, 149511 as cliente from dual union all
    SELECT 143782906 as orden, 50117750 as producto, 48098640 as contrato, 1601201 as cliente from dual union all
    SELECT 145082970 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 147405279 as orden, 50504596 as producto, 48170110 as contrato, 135931 as cliente from dual union all
    SELECT 148043924 as orden, 17180150 as producto, 17192132 as contrato, 311569 as cliente from dual union all
    SELECT 149638754 as orden, 51034145 as producto, 66365467 as contrato, 2306579 as cliente from dual union all
    SELECT 150620478 as orden, 2000066 as producto, 2100066 as contrato, 594271 as cliente from dual union all
    SELECT 150635607 as orden, 2000062 as producto, 2100062 as contrato, 594275 as cliente from dual union all
    SELECT 150966676 as orden, 17067567 as producto, 17146982 as contrato, 347933 as cliente from dual union all
    SELECT 150967535 as orden, 51053181 as producto, 66380039 as contrato, 1324598 as cliente from dual union all
    SELECT 150968303 as orden, 17009669 as producto, 17108798 as contrato, 380486 as cliente from dual union all
    SELECT 151823592 as orden, 17076473 as producto, 17148120 as contrato, 346988 as cliente from dual union all
    SELECT 151859168 as orden, 17076682 as producto, 17148150 as contrato, 346966 as cliente from dual union all
    SELECT 156585443 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 156605749 as orden, 17005042 as producto, 17104309 as contrato, 384418 as cliente from dual union all
    SELECT 156611163 as orden, 3061474 as producto, 3161474 as contrato, 551497 as cliente from dual union all
    SELECT 156614614 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 156615616 as orden, 50504598 as producto, 48170112 as contrato, 135929 as cliente from dual union all
    SELECT 156622072 as orden, 50504598 as producto, 48170112 as contrato, 135929 as cliente from dual union all
    SELECT 177458959 as orden, 3056379 as producto, 3156379 as contrato, 554566 as cliente from dual union all
    SELECT 189496419 as orden, 50277872 as producto, 48127116 as contrato, 2007624 as cliente from dual union all
    SELECT 189497066 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 190258278 as orden, 50342608 as producto, 48153203 as contrato, 149511 as cliente from dual union all
    SELECT 190321570 as orden, 3056379 as producto, 3156379 as contrato, 554566 as cliente from dual union all
    SELECT 191020663 as orden, 50117750 as producto, 48098640 as contrato, 1601201 as cliente from dual union all
    SELECT 193631790 as orden, 50504598 as producto, 48170112 as contrato, 135929 as cliente from dual union all
    SELECT 198007635 as orden, 51034145 as producto, 66365467 as contrato, 2306579 as cliente from dual union all
    SELECT 198907463 as orden, 17180150 as producto, 17192132 as contrato, 311569 as cliente from dual union all
    SELECT 200411068 as orden, 17076473 as producto, 17148120 as contrato, 346988 as cliente from dual union all
    SELECT 205024623 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 205025567 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 205025837 as orden, 17005042 as producto, 17104309 as contrato, 384418 as cliente from dual union all
    SELECT 206906012 as orden, 50117751 as producto, 48098641 as contrato, 195233 as cliente from dual union all
    SELECT 212620973 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 212633728 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 218947946 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 223421488 as orden, 51295365 as producto, 66526208 as contrato, 1585192 as cliente from dual union all
    SELECT 229448416 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 229496645 as orden, 8064088 as producto, 8164088 as contrato, 442494 as cliente from dual union all
    SELECT 237584026 as orden, 50176516 as producto, 48110705 as contrato, 1647396 as cliente from dual union all
    SELECT 238978917 as orden, 52162259 as producto, 67099832 as contrato, 2173806 as cliente from dual union all
    SELECT 242118238 as orden, 50504597 as producto, 48170111 as contrato, 1592800 as cliente from dual union all
    SELECT 246169157 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 246330741 as orden, 50277872 as producto, 48127116 as contrato, 2007624 as cliente from dual union all
    SELECT 246331571 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 246333350 as orden, 3056379 as producto, 3156379 as contrato, 554566 as cliente from dual union all
    SELECT 246353125 as orden, 50342608 as producto, 48153203 as contrato, 149511 as cliente from dual union all
    SELECT 247650190 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 249828224 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 255080110 as orden, 51034145 as producto, 66365467 as contrato, 2306579 as cliente from dual union all
    SELECT 260503288 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 260651200 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 261273129 as orden, 17005042 as producto, 17104309 as contrato, 384418 as cliente from dual union all
    SELECT 261536081 as orden, 50094765 as producto, 48080062 as contrato, 233386 as cliente from dual union all
    SELECT 262382386 as orden, 50117751 as producto, 48098641 as contrato, 195233 as cliente from dual union all
    SELECT 263649667 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 265752021 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual union all
    SELECT 277519473 as orden, 51447143 as producto, 66619112 as contrato, 86791 as cliente from dual;

  -- Poblacion Oscar
  cursor cuPoblacionOs is
    SELECT 246938019 as orden, 50576857 as producto, 48195472 as contrato, 594605 as cliente from dual union all
    SELECT 255843847 as orden, 50576857 as producto, 48195472 as contrato, 594605 as cliente from dual union all
    SELECT 261207238 as orden, 50523930 as producto, 48174497 as contrato, 132379 as cliente from dual union all
    SELECT 267660820 as orden, 50307834 as producto, 48136622 as contrato, 163601 as cliente from dual union all
    SELECT 269094851 as orden, 52112173 as producto, 67063436 as contrato, 2287810 as cliente from dual union all
    --SELECT 271573975 as orden, 50513730 as producto, 48171621 as contrato, 48171621 as cliente from dual union all
    SELECT 272434264 as orden, 50316464 as producto, 48140043 as contrato, 1460400 as cliente from dual;

begin
  dbms_output.put_line('---- Inicio OSF-976 ----');

  -- recorrido de la poblacion Inicial
  FOR regPoblacion IN cuPoblacionInicial
  LOOP
    BEGIN
      UPDATE  OPEN.OR_ORDER_ACTIVITY oa
      SET     oa.PRODUCT_ID = regPoblacion.producto,
              oa.SUBSCRIPTION_ID = regPoblacion.contrato
      WHERE   oa.ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_ORDER_ACTIVITY ) - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||']');

      UPDATE  OPEN.OR_EXTERN_SYSTEMS_ID
      SET     SERVICE_NUMBER = regPoblacion.producto,
              PRODUCT_ID = regPoblacion.producto,
              SUBSCRIPTION_ID = regPoblacion.contrato
      WHERE   ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_EXTERN_SYSTEMS_ID) - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||']');

    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Fallo actualizando la Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||']');
    END;
  END LOOP;
  COMMIT;

  -- recorrido de la poblacion Karen
  FOR regPoblacion IN cuPoblacionKa
  LOOP
    BEGIN
      UPDATE  OPEN.OR_ORDER_ACTIVITY oa
      SET     oa.PRODUCT_ID = regPoblacion.producto,
              oa.SUBSCRIPTION_ID = regPoblacion.contrato,
              oa.SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   oa.ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    
      UPDATE  OPEN.OR_EXTERN_SYSTEMS_ID
      SET     SERVICE_NUMBER = regPoblacion.producto,
              PRODUCT_ID = regPoblacion.producto,
              SUBSCRIPTION_ID = regPoblacion.contrato,
              SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_EXTERN_SYSTEMS_ID) - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');

    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Fallo actualizando la Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    END;
  END LOOP;
  COMMIT;

  -- recorrido de la poblacion Oscar
  FOR regPoblacion IN cuPoblacionOs
  LOOP
    BEGIN
      UPDATE  OPEN.OR_ORDER_ACTIVITY oa
      SET     oa.PRODUCT_ID = regPoblacion.producto,
              oa.SUBSCRIPTION_ID = regPoblacion.contrato,
              oa.SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   oa.ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');

      UPDATE  OPEN.OR_EXTERN_SYSTEMS_ID
      SET     SERVICE_NUMBER = regPoblacion.producto,
              PRODUCT_ID = regPoblacion.producto,
              SUBSCRIPTION_ID = regPoblacion.contrato,
              SUBSCRIBER_ID = regPoblacion.cliente
      WHERE   ORDER_ID = regPoblacion.orden;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('OK (OR_EXTERN_SYSTEMS_ID) - Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    
    EXCEPTION
      WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('Fallo actualizando la Orden ['||regPoblacion.orden||'] - PRODUCT_ID ['||regPoblacion.producto||'] - SUBSCRIPTION_ID ['||regPoblacion.contrato||'] - SUBSCRIBER_ID ['||regPoblacion.cliente||']');
    END;
  END LOOP;
  COMMIT;

  dbms_output.put_line('---- Fin OSF-976 ----');
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-976 ----');
    DBMS_OUTPUT.PUT_LINE('OSF-976-Error no controlado --> '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/