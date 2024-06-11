declare
  cursor cuDatos is
  select m.*,s.balance saldo_cierre,s.total_costs valor_cierre
  from open.OR_OPE_UNI_ITEM_BALA m, oPEN.ldc_osf_salbitemp s
  --where m.operating_unit_id=3116
  where m.items_id not like '4%'
  AND m.OPERATING_UNIT_ID NOT IN (799,79)
  AND m.OPERATING_UNIT_ID IN (3005)
  and s.operating_unit_id=m.operating_unit_id
  and s.items_id=m.items_id 
  and nuano=2017 	

  and numes=10
  and m.items_id in (10003861)
order by m.operating_unit_id,m.items_id
  
  /*SELECT ITEMS_ID,  OPERATING_UNIT_ID,  BALANCE,  TOTAL_COSTS
 FROM OPEN.ldc_osf_salbitemp
where operating_unit_id=3206
and nuano=2017
and numes=7
and items_id not like '4%'*/
  ;
  cursor cuMovimientos(nuUnidad number, nuItem number) is
  select 	ITEMS_ID, OPERATING_UNIT_ID, ITEM_MOVEME_CAUS_ID, MOVEMENT_TYPE, trunc(MOVE_DATE) MOVE_DATE,	TERMINAL,
  	USER_ID,	SUPPORT_DOCUMENT,	TARGET_OPER_UNIT_ID,	iD_ITEMS_DOCUMENTO,	ID_ITEMS_SERIADO,	ID_ITEMS_ESTADO_INV,	INIT_INV_STAT_ITEMS,
    sum(amount) amount, sum(total_value) total_value
    from open.or_uni_item_bala_mov m
   where operating_unit_id=nuUnidad
     and items_id=nuItem
     and movement_type in ('D','I')
     AND MOVE_DATE<'01/11/2017'
   group  by ITEMS_ID, OPERATING_UNIT_ID, ITEM_MOVEME_CAUS_ID, MOVEMENT_TYPE, trunc(MOVE_DATE),	TERMINAL,
  	USER_ID,	SUPPORT_DOCUMENT,	TARGET_OPER_UNIT_ID,	iD_ITEMS_DOCUMENTO,	ID_ITEMS_SERIADO,	ID_ITEMS_ESTADO_INV,	INIT_INV_STAT_ITEMS
   order by items_id, move_date;
   cursor cuMovimientos2(nuItem number, documento number) is
  select *
    from open.or_uni_item_bala_mov m
   where items_id=nuItem
     and id_items_documento=documento
     and movement_type='D'
   order by items_id,1;
   
    cursor cuMovimientos3(nuItem number, documento number, cantidad number,VALIDA VARCHAR2) is
  select *
    from open.or_uni_item_bala_mov m
   where items_id=nuItem
     and support_document=to_char(documento)
     and movement_type='N'
     and amount=decode(valida,'S',cantidad,amount)
   order by items_id,1;
   
   cursor cuSaldoInicial(nuUnidad number, nuItem number) is
    SELECT sum(EIXBDISU), sum(EIXBVLOR)
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        and nvl(MIGRA.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)= nuItem
        and B.CUADHOMO=nuUnidad;
  
  cursor cuDatosIncremento(nuitem NUMBER, SERIADO NUMBER, DOCUMENTO NUMBER, target number) is
  Select sum(cant) cant, sum(valor) valor
  from (
  SELECT SUM(M2.AMOUNT) CANT, SUM(M2.TOTAL_VALUE) VALOR
FROM OPEN.or_uni_item_bala_mov M, OPEN.or_uni_item_bala_mov M2
WHERE M.SUPPORT_DOCUMENT=TO_CHAR(DOCUMENTO)
 AND M.ITEMS_ID=nuitem
 AND M.ITEMS_ID=M2.ITEMS_ID
 AND M2.ID_ITEMS_DOCUMENTO=M.ID_ITEMS_DOCUMENTO
 AND M2.MOVEMENT_TYPE='D'
 And m.TARGET_OPER_UNIT_ID=target
 and NVL(M.ID_ITEMS_SERIADO,0)=NVL(SERIADO,0)
 AND NVL(M.ID_ITEMS_SERIADO,0)=NVL(M2.ID_ITEMS_SERIADO,0)
 /*union
 SELECT SUM(-1*M2.AMOUNT) CANT, SUM(-1*M2.TOTAL_VALUE) VALOR
FROM OPEN.or_uni_item_bala_mov M, open.or_uni_item_bala_mov m2
where m.support_document=TO_CHAR(DOCUMENTO)
  and m.items_id=nuitem
  and m2.id_items_documento=m.id_items_documento
  and m2.items_id=m.items_id
  and m2.movement_type='N'
  And m.TARGET_OPER_UNIT_ID=target
  --and m.support_document!=m2.support_document
  and NVL(M.ID_ITEMS_SERIADO,0)=NVL(SERIADO,0)
  AND NVL(M.ID_ITEMS_SERIADO,0)=NVL(M2.ID_ITEMS_SERIADO,0)
  and not exists(select null from open.or_uni_item_bala_mov m3 where m3.movement_type='D' and m3.id_items_documento=m2.id_items_documento and m3.amount=m2.amount and m3.items_id=m2.items_id)
*/)
 ;
 
 cursor cuDatosRechazoOsf(nuitem NUMBER, SERIADO NUMBER, DOCUMENTO NUMBER, nuunidad number) is 
 /*select SUM(m2.AMOUNT) CANT, SUM(m2.TOTAL_VALUE) VALOR
from open.or_uni_item_bala_mov m, open.or_uni_item_bala_mov m2
where m.support_document=TO_CHAR(DOCUMENTO)
  and m.id_items_documento=m2.id_items_documento
  and m2.movement_type='D'
  AND M2.ITEMS_ID=nuitem
  AND M2.ITEMS_ID=M.ITEMS_ID
  and NVL(M2.ID_ITEMS_SERIADO,0)=nvl(seriado,0)
  AND NVL(M2.ID_ITEMS_SERIADO,0)=NVL(M.ID_ITEMS_SERIADO,0)*/
  
   select sum(m2.amount) cant, sum((m.total_value/m.amount)*m2.amount) valor
 from OPEN.or_uni_item_bala_mov m, OPEN.GE_ITEMS_DOC_REL r , open.or_uni_item_bala_mov m2
 where m.id_items_documento =r.id_items_doc_destino
   and r.id_items_doc_origen=DOCUMENTO
   and m2.id_items_documento=r.id_items_doc_origen
 and m.items_id=nuitem
 and m.operating_unit_id=nuunidad
 and  m.items_id=m2.items_id
 and m.operating_unit_id=m2.operating_unit_id
 and NVL(M2.ID_ITEMS_SERIADO,0)=nvl(seriado,0)
  AND NVL(M2.ID_ITEMS_SERIADO,0)=NVL(M.ID_ITEMS_SERIADO,0) ;
  
  
 cursor cuDatosIncrementoSap(nuitem NUMBER, DOCUMENTO NUMBER) is
  select dmitcant cant , dmitcant*dmitcoun valor
        from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
        where id_items_documento=DOCUMENTO
         and dmitmmit=mmitcodi
         and dmititem=nuitem
         and documento_externo like '%'||MMITDSAP
         and mmitdsap is not null
         and not exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
    union
    select 1, dmitcoun
        from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
        where id_items_documento=DOCUMENTO
         and dmitmmit=mmitcodi
         and dmititem=nuitem
         and documento_externo like '%'||MMITDSAP
         and mmitdsap is not null
         and exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi);

   cursor cuRechazoSap(nuitem NUMBER, DOCUMENTO NUMBER, nuunidad number ) is
   select sum(m2.amount) cant, sum((m.total_value/m.amount)*m2.amount) valor
 from OPEN.or_uni_item_bala_mov m, OPEN.GE_ITEMS_DOC_REL r , open.or_uni_item_bala_mov m2
 where m.id_items_documento =r.id_items_doc_destino
   and r.id_items_doc_origen=DOCUMENTO
   and m2.id_items_documento=r.id_items_doc_origen
 and m.items_id=nuitem
 and m.operating_unit_id=nuunidad
 and  m.items_id=m2.items_id
 and m.operating_unit_id=m2.operating_unit_id ;
 
   rgMovimientos cuMovimientos2%rowtype;
   rgIncremento cuDatosIncremento%rowtype;
   sbDatosN varchar2(32000);
   sbDatosI varchar2(32000);
   sbRegistro varchar2(32000);
   CantidadItem number;
   ValorItem    number;
begin
  dbms_output.enable(buffer_size => NULL);
  for reg in cuDatos loop
      open cuSaldoInicial(reg.operating_unit_id, reg.items_id);
      fetch cuSaldoInicial INTO CantidadItem,ValorItem;
      close  cuSaldoInicial;
      sbRegistro:= reg.operating_unit_id||'|'||reg.items_id;
       --dbms_output.put_line('I '||'inicial'||' '|| CantidadItem);
       dbms_output.put_line('I '||'inicial'||' '|| ValorItem);
      for reg2 in cuMovimientos(reg.operating_unit_id, reg.items_id) loop
          --if reg2.move_date<'01/08/2017' then
              IF reg2.movement_type = 'D' then
                CantidadItem:=NVL(CantidadItem,0) -nvl(REG2.AMOUNT,0);
                ValorItem:=NVL(ValorItem,0) -nvl(REG2.TOTAL_VALUE,0);
                --dbms_output.put_line('D '||reg2.id_items_documento||' '||-reg2.amount);
                dbms_output.put_line('D '||reg2.id_items_documento||' '||-REG2.TOTAL_VALUE);
              END IF;
              if reg2.movement_type = 'I' then
                 if open.daor_operating_unit.fnugetoper_unit_classif_id(reg2.target_oper_unit_id, null)!=11 then
                      OPEN cuDatosIncremento(reg2.items_id, reg2.id_items_seriado,reg2.id_items_documento, reg2.TARGET_OPER_UNIT_ID);
                      fetch cuDatosIncremento into rgIncremento;
                      if cuDatosIncremento%found and rgIncremento.CANT is not null  then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                        ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0);   
                        --dbms_output.put_line('I '||reg2.id_items_documento||' '|| reg2.amount);
                        dbms_output.put_line('I '||reg2.id_items_documento||' '|| nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0));
                      elsif open.dage_items_documento.fnugetdocument_type_id(reg2.id_items_documento,null) in (118,112) then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                        ValorItem:=nvl(ValorItem,0) +nvl(reg2.total_value,0);   
                        --dbms_output.put_line('I2 '||reg2.id_items_documento||' '|| reg2.amount);
                       dbms_output.put_line('I2 '||reg2.id_items_documento||' '|| reg2.total_value);
                      elsif open.dage_items_documento.fnugetdocument_type_id(reg2.id_items_documento,null) in (115) then
                          open cuDatosRechazoOsf(reg2.items_id, reg2.id_items_seriado,reg2.id_items_documento,reg2.operating_unit_id);
                          fetch cuDatosRechazoOsf into rgIncremento;
                          if cuDatosRechazoOsf%found then
                             CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                             ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0) ;   
                             --dbms_output.put_line('I '||reg2.id_items_documento||' '|| reg2.amount);
                             dbms_output.put_line('I '||reg2.id_items_documento||' '|| nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0));
                          end if;
                          close cuDatosRechazoOsf;
                      end if;
                      close cuDatosIncremento;
                 else
                      open cuDatosIncrementoSap(reg2.items_id, reg2.id_items_documento);
                      fetch cuDatosIncrementoSap into rgIncremento;
                      if cuDatosIncrementoSap%found then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(rgIncremento.CANT,0);
                        ValorItem:=nvl(ValorItem,0) +nvl(rgIncremento.VALOR,0) ;
                        --dbms_output.put_line('I3 '||reg2.id_items_documento|| ' ' ||rgIncremento.CANT);
                        dbms_output.put_line('I3 '||reg2.id_items_documento|| ' ' ||rgIncremento.VALOR);
                      else
                        open cuRechazoSap(reg2.items_id, reg2.id_items_documento, reg2.operating_unit_id );
                        fetch cuRechazoSap into rgIncremento;
                        if cuRechazoSap%found then
                           CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                           ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0); 
                           --dbms_output.put_line('I4 '||reg2.id_items_documento|| ' ' ||reg2.amount);
                           dbms_output.put_line('I4 '||reg2.id_items_documento|| ' ' ||(rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount);
                        end if;
                        close cuRechazoSap;
                      end if;
                      close cuDatosIncrementoSap;
                 end if;
              end if;
          --end if;
      end loop;
      /*if sbDatosN is not null or sbDatosI is not null then
        dbms_output.put_line(sbRegistro ||' Diferencias en :'||sbDatosN||'-'||sbDatosI);
        sbDatosN:=null;
        sbDatosI:=null;
      end if;*/
    dbms_output.put_line(reg.operating_unit_id||'|'||reg.items_id||'|'||nvl(CantidadItem,0)||'|'||nvl(ValorItem,0));
    CantidadItem:=0;
    ValorItem:=0; 
  end loop;
end;

  
