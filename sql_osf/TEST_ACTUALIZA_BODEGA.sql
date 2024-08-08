declare
  sbCaso VARCHAR2(30) := 'OSF-2236';

  cursor cuBalance(inuoperatingUnit IN open.or_ope_uni_item_bala.operating_unit_id%TYPE,
                   inuItem          IN open.or_ope_uni_item_bala.items_id%TYPE) IS
    SELECT *
      FROM open.or_ope_uni_item_bala
     WHERE operating_unit_id = inuoperatingUnit --4247 
       AND items_id = inuItem; --10004070; 

  cursor cuInventario(inuoperatingUnit IN open.or_ope_uni_item_bala.operating_unit_id%TYPE,
                      inuItem          IN open.or_ope_uni_item_bala.items_id%TYPE) IS
    SELECT *
      FROM open.ldc_inv_ouib
     WHERE items_id = inuItem
       AND operating_unit_id = inuoperatingUnit;

  cursor cuActivo(inuoperatingUnit IN open.or_ope_uni_item_bala.operating_unit_id%TYPE,
                  inuItem          IN open.or_ope_uni_item_bala.items_id%TYPE) IS
    SELECT *
      FROM open.ldc_act_ouib
     WHERE items_id = inuItem
       AND operating_unit_id = inuoperatingUnit;

  rcBalance    cuBalance%rowtype;
  rcInventario cuInventario%rowtype;
  rccuActivo   cuActivo%rowtype;

begin
  dbms_output.put_line('Inicia Actualizar Bodega Unidad 4247 con item 10004070');
  dbms_output.put_line('');

  open cuBalance(4247, 10004070);
  fetch cuBalance
    into rcBalance;
  close cuBalance;

  dbms_output.put_line('BODEGA - BALANCE [' || rcBalance.balance ||
                       '] TOTAL_COSTS [' || rcBalance.total_costs || ']');

  dbms_output.put_line('');

  open cuInventario(4247, 10004070);
  fetch cuInventario
    into rcInventario;
  close cuInventario;

  dbms_output.put_line('Anterior INVENTARIO - BALANCE [' ||
                       rcInventario.balance || '] TOTAL_COSTS [' ||
                       rcInventario.total_costs || ']');

  /*--Balance Bodega Inventario
  UPDATE ldc_inv_ouib
     SET balance = rcBalance.balance, total_costs = rcBalance.total_costs
   WHERE operating_unit_id = rcBalance.operating_unit_id
     AND items_id = rcBalance.items_id;*/

  /*INSERT INTO ldc_logdatafix
  VALUES
    (seq_ldc_logdatafix.nextval,
     sbCaso,
     'U',
     UPPER('ldc_inv_ouib'),
     UPPER('balance, TOTAL_COSTS'),
     'BALANCE [' || rcInventario.balance || '] TOTAL_COSTS [' ||
     rcInventario.total_costs || ']',
     'BALANCE [' || rcBalance.balance || '] TOTAL_COSTS [' ||
     rcBalance.total_costs || ']',
     SYSDATE);
  COMMIT;*/

  open cuInventario(4247, 10004070);
  fetch cuInventario
    into rcInventario;
  close cuInventario;

  dbms_output.put_line('Actualizado INVENTARIO - BALANCE [' ||
                       rcInventario.balance || '] TOTAL_COSTS [' ||
                       rcInventario.total_costs || ']');

  dbms_output.put_line('');

  open cuActivo(4247, 10004070);
  fetch cuActivo
    into rccuActivo;
  close cuActivo;

  dbms_output.put_line('Anterior ACTIVO - BALANCE [' || rccuActivo.balance ||
                       '] TOTAL_COSTS [' || rccuActivo.total_costs || ']');

  /*--Balance Bodega Activo
  UPDATE ldc_act_ouib
     SET balance = 0, total_costs = 0
   WHERE operating_unit_id = rcBalance.operating_unit_id
     AND items_id = rcBalance.items_id;*/

  /*INSERT INTO ldc_logdatafix
  VALUES
    (seq_ldc_logdatafix.nextval,
     sbCaso,
     'U',
     UPPER('ldc_act_ouib'),
     UPPER('balance, TOTAL_COSTS'),
     'BALANCE [' || rccuActivo.balance || '] TOTAL_COSTS [' ||
     rccuActivo.total_costs || ']',
     'BALANCE [0] TOTAL_COSTS [0]',
     SYSDATE);

  COMMIT;*/

  open cuActivo(4247, 10004070);
  fetch cuActivo
    into rccuActivo;
  close cuActivo;

  dbms_output.put_line('Actualizado ACTIVO - BALANCE [' ||
                       rccuActivo.balance || '] TOTAL_COSTS [' ||
                       rccuActivo.total_costs || ']');
  dbms_output.put_line('');
  dbms_output.put_line('Fin Actualizar Bodega.');

exception

  when others then
    dbms_output.put_line(sqlerrm);
    --rollback;
  
END;
