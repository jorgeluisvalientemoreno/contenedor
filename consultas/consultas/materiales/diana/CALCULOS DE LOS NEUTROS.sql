DECLARE 
CURSOR CUNEUTROS IS
SELECT *
  FROM OPEN.OR_UNI_ITEM_BALA_MOV M
  WHERE M.TARGET_OPER_UNIT_ID IN (1850,1854,1878,1910,2024,2445,1518,1512,1515,1520,1521,1522,1527,1885,2199,2302,2402)
    AND MOVE_DATE>='01/08/2017'
    AND MOVEMENT_TYPE='N'
    --AND SUPPORT_DOCUMENT=' '
    AND ITEM_MOVEME_CAUS_ID=20
    ORDER BY OPERATING_UNIT_ID, ITEMS_ID, MOVE_DATE, 1;
 CURSOR DECREMENTO(NUDOCUMENTO NUMBER, NUITEM NUMBER, NUSERIAL NUMBER ) IS
 SELECT *
 FROM OPEN.OR_UNI_ITEM_BALA_MOV 
 WHERE ID_ITEMS_DOCUMENTO=NUDOCUMENTO
   AND MOVEMENT_TYPE='D'
   AND ITEMS_ID=NUITEM
   AND NVL(ID_ITEMS_SERIADO,0)=NVL(NUSERIAL,0);    
   NUVALOR NUMBER:=0;
BEGIN
  DELETE FROM OPEN.OR_UNI_ITEM_BALA_MOV_COPIA2 WHERE MOVEMENT_TYPE='N';
  COMMIT;
  FOR REG IN CUNEUTROS LOOP
    NUVALOR:=0;
    FOR REG2 IN DECREMENTO(REG.ID_ITEMS_DOCUMENTO, REG.ITEMS_ID, REG.ID_ITEMS_SERIADO) LOOP
        NUVALOR:=ROUND(((REG2.TOTAL_VALUE/REG2.AMOUNT)*REG.AMOUNT),2);
        INSERT INTO  open.OR_UNI_ITEM_BALA_MOV_COPIA2
      (
  uni_item_bala_mov_id ,
  items_id             ,
  operating_unit_id    ,
  item_moveme_caus_id  ,
  movement_type        ,
  amount               ,
  comments             ,
  move_date            ,
  terminal             ,
  user_id              ,
  support_document     ,
  target_oper_unit_id  ,
  total_value          ,
  id_items_documento   ,
  id_items_seriado     ,
  id_items_estado_inv  ,
  valor_venta          ,
  init_inv_stat_items  
)
values (reg.uni_item_bala_mov_id ,
  reg.items_id             ,
  reg.operating_unit_id    ,
  reg.item_moveme_caus_id  ,
  reg.movement_type        ,
  reg.amount,
  reg.comments             ,
  reg.move_date            ,
  reg.terminal             ,
  reg.user_id              ,
  reg.support_document     ,
  reg.target_oper_unit_id  ,
  NUVALOR          ,
  reg.id_items_documento   ,
  reg.id_items_seriado     ,
  reg.id_items_estado_inv  ,
  reg.valor_venta          ,
  reg.init_inv_stat_items   );
   COMMIT;
    END LOOP;
  END LOOP;
END;
