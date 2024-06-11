
begin
  delete from open.OR_UNI_ITEM_BALA_MOV_COPIA2 WHERE MOVEMENT_TYPE!='N' and operating_unit_id not in (1850,1854,1878,1910,2024,2445,1518,1512,1515,1520,1521,1522,1527,1885,2199,2302,2402) and id_items_documento!=418338;
  commit;
end;
/

declare
 /* CURSOR CUMOVIMIENTOS IS
  select o.order_id, o.legalization_Date, oi.items_id, oi.legal_item_amount, oi.value, d.id_items_documento, d.fecha, o.operating_unit_id
from open.or_order_items oi, open.ge_items i,open.or_order o, open.ge_items_documento d
where o.order_id=94982625
  and o.order_id=oi.order_id
  and oi.items_id=i.items_id
  and item_classif_id=8
  and d.documento_externo=to_char(o.order_id)
  and o.operating_unit_id=d.operating_unit_id;*/
  
  cursor cumovimientos2 is
  select d.operating_unit_id, m.items_id,m.amount, m.move_date,m.movement_type, m.item_moveme_caus_id, 'SE REGISTRA PORQUE NO SE REGISTRO EN DICIEMBRE' coment,D.DESTINO_OPER_UNI_ID, TOTAL_VALUE, M.ID_ITEMS_DOCUMENTO, M.ID_ITEMS_SERIADO,M.ID_ITEMS_ESTADO_INV, M.VALOR_VENTA, M.INIT_INV_STAT_ITEMS
from open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.id_items_documento in (418368, 418435, 418849, 418873, 418874, 418950, 419029)
  and m.id_items_documento=d.id_items_documento;

  i number:=1;
BEGIN
  /*for reg in CUMOVIMIENTOS loop
    insert into open.or_uni_item_bala_mov_copia2(UNI_ITEM_BALA_MOV_ID,ITEMS_ID,OPERATING_UNIT_ID,ITEM_MOVEME_CAUS_ID,MOVEMENT_TYPE,AMOUNT,COMMENTS,MOVE_DATE,TERMINAL,USER_ID,SUPPORT_DOCUMENT,TARGET_OPER_UNIT_ID,TOTAL_VALUE,ID_ITEMS_DOCUMENTO,ID_ITEMS_SERIADO,ID_ITEMS_ESTADO_INV,VALOR_VENTA,INIT_INV_STAT_ITEMS)
                values(open.SEQ_OR_UNI_ITEM_BALA_MOV.Nextval i,reg.items_id, reg.operating_unit_id, 4, 'D', reg.legal_item_amount,'Se registra debido a que movimientos de diciembre 2017 no se registraron',reg.legalization_Date,NVL(USERENV('TERMINAL'),'SCRIPT'), user, ' ', reg.operating_unit_id, reg.value, reg.id_items_documento, null, null,0 , null);
                i:=i+1;
    commit;
  end loop;*/
  for reg in CUMOVIMIENTOS2 loop
    insert into open.or_uni_item_bala_mov_copia2(UNI_ITEM_BALA_MOV_ID,ITEMS_ID,OPERATING_UNIT_ID,ITEM_MOVEME_CAUS_ID,MOVEMENT_TYPE,AMOUNT,COMMENTS,MOVE_DATE,TERMINAL,USER_ID,SUPPORT_DOCUMENT,TARGET_OPER_UNIT_ID,TOTAL_VALUE,ID_ITEMS_DOCUMENTO,ID_ITEMS_SERIADO,ID_ITEMS_ESTADO_INV,VALOR_VENTA,INIT_INV_STAT_ITEMS)
                values(/*open.SEQ_OR_UNI_ITEM_BALA_MOV.Nextval*/ i,reg.items_id, reg.operating_unit_id, reg.item_moveme_caus_id, 'D', reg.amount,'Se registra debido a que movimientos de diciembre 2017 no se registraron',reg.move_date,NVL(USERENV('TERMINAL'),'SCRIPT'), user, ' ', reg.DESTINO_OPER_UNI_ID, reg.total_value, reg.id_items_documento, reg.id_items_seriado, reg.ID_ITEMS_ESTADO_INV,0 , reg.INIT_INV_STAT_ITEMS);
                i:=i+1;
    commit;
  end loop;
END;
/

declare
  cursor cuDatos is
  select m.*,s.balance saldo_cierre,s.total_costs valor_cierre,
		(select j.balance from open.ldc_osf_salbitemp j where j.nuano=2017 and j.numes=7 and j.items_id=m.items_id and j.operating_unit_id=m.operating_unit_id) cant_jul,
		(select j.total_costs from open.ldc_osf_salbitemp j where j.nuano=2017 and j.numes=7 and j.items_id=m.items_id and j.operating_unit_id=m.operating_unit_id) valor_jul
  from open.OR_OPE_UNI_ITEM_BALA m, oPEN.ldc_osf_salbitemp s
  --where m.operating_unit_id=3116
  where m.items_id not like '4%'
  AND m.OPERATING_UNIT_ID NOT IN (799,79)
  AND m.OPERATING_UNIT_ID not IN (1850,1854,1878,1910,2024,2445,1518,1512,1515,1520,1521,1522,1527,1885,2199,2302,2402)
  AND M.OPERATING_UNIT_ID IN (2846, 2726, 2847, 2705, 2876, 1879, 1853, 2878, 2658, 2684, 1516, 2646, 1864, 1875, 3362, 2845, 2456, 1866, 
							  2667, 1862, 2659, 2446,  3354,  1607, 1867,      1863,   2660)
  and s.operating_unit_id=m.operating_unit_id
  and s.items_id=m.items_id 
  and nuano=2018
  and numes=10
order by m.operating_unit_id,m.items_id
  ;
  cursor cuMovimientos(nuUnidad number, nuItem number) is
  select 	*
    from open.or_uni_item_bala_mov m
   where operating_unit_id=nuUnidad
     and items_id=nuItem
     and movement_type in ('D','I')
	  and move_date>='01/08/2017'
    -- AND MOVE_DATE<'01/08/2017'
	 order by items_id, move_date, 1;
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
         
         
   cursor cuDatosTrasladoSap(nuitem NUMBER, DOCUMENTO NUMBER) is
  select dmitcant cant , dmitcant*dmitcoun valor
        from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
        where id_items_documento=DOCUMENTO
         and dmitmmit=mmitcodi
         and dmititem=nuitem
         and mmitnudo=to_char(id_items_documento)
         and mmitdsap is not null
         and not exists(select null from open.ldci_seridmit where serimmit=mmitcodi and seridmit=dmitcodi)
    union
    select 1, dmitcoun
        from open.ge_items_documento d, open.ldci_intemmit i, open.ldci_dmitmmit s
        where id_items_documento=DOCUMENTO
         and dmitmmit=mmitcodi
         and dmititem=nuitem
         and mmitnudo=to_char(id_items_documento)
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
 
 
 cursor cuCuadres(NUNIDAD NUMBER, NUITEM NUMBER) is
 SELECT SUM(CANT) CANT, SUM(VALOR) VALOR
 FROM (
 select sum(decode(movement_type,'D',-1,'I',1)* AMOUNT) CANT,
		sum(decode(movement_type,'D',-1,'I',1)* AMOUNT) VALOR
	FROM OPEN.OR_UNI_ITEM_BALA_MOV_COPIA
	WHERE OPERATING_UNIT_ID=NUNIDAD
	  AND ITEMS_ID=NUITEM
    UNION
  select j.balance CANT,TOTAL_COSTS VALOR  
  from open.ldc_osf_salbitemp j 
  where j.nuano=2017 and j.numes=7 
  and j.items_id=NUITEM
  and j.operating_unit_id=NUNIDAD);
  
  cursor cuJulio(NUNIDAD NUMBER, NUITEM NUMBER) is
 SELECT SUM(CANT) CANT, SUM(VALOR) VALOR
 FROM (
  select j.balance CANT,TOTAL_COSTS VALOR  
  from open.ldc_osf_salbitemp j 
  where j.nuano=2017 and j.numes=7 
  and j.items_id=NUITEM
  and j.operating_unit_id=NUNIDAD);
    
    
    
  Cursor cuLegalizacion (nuOrden varchar2, nuitem number, sbserial varchar, cant number) is
  select legal_item_amount , value
    from open.or_order_items
    where order_id=to_number(nuorden)
      and items_id=nuitem
      and legal_item_amount=cant
      and nvl(serie,'-')=nvl(sbserial,'-')
  ;

  cursor cuModificacionAiosa(nuUnidad number, nuitem Number, dt_fecha date) is
  select cantidad_final, costo_final
  from open.LDC_LOG_ITEMS_MODIF_SIN_ACTA a, open.or_order o
  where o.order_id=a.orden_id
    and o.operating_unit_id=nuUnidad
    and a.item_id=nuitem
    and trunc(a.fecha_modif)=trunc(dt_fecha);
    
   rgMovimientos cuMovimientos2%rowtype;
   rgIncremento cuDatosIncremento%rowtype;
   sbDatosN varchar2(32000);
   sbDatosI varchar2(32000);
   sbRegistro varchar2(32000);
   CantidadItem number;
   ValorItem    number;
   CantidadJulio number:=0;
   ValorJulio   number:=0;
   ValorTraslado number;
   nuSigno number;
   rgModificacionAiosa cuModificacionAiosa%rowtype;
begin
  dbms_output.enable(buffer_size => NULL);
  for reg in cuDatos loop
       --dbms_output.put_line('I '||'inicial'||' '|| CantidadItem);
       --dbms_output.put_line('I '||'inicial'||' '|| ValorItem);
       open cuJulio(reg.operating_unit_id, reg.items_id);
       fetch cuJulio into CantidadJulio, ValorJulio;
       if cuJulio%notfound then
          CantidadJulio :=0;
          ValorJulio :=0;
       end if;
       close cuJulio;
       if CantidadJulio is null then
         CantidadJulio:=0;
       end if; 
       if ValorJulio is null then
         ValorJulio:=0;
       end if;
      	
      for reg2 in cuMovimientos(reg.operating_unit_id, reg.items_id) loop
        
			  CantidadItem :=0;
			  ValorItem:=0;
          --if reg2.move_date<'01/08/2017' then
              IF reg2.movement_type = 'D' then
                nuSigno:=-1;
                IF OPEN.DAGE_ITEMS_DOCUMENTO.FNUGETDOCUMENT_TYPE_ID(REG2.ID_ITEMS_DOCUMENTO, NULL) = 118 THEN
                   open cuLegalizacion(open.dage_items_documento.fsbgetdocumento_externo(REG2.ID_ITEMS_DOCUMENTO),
                                       reg2.items_id,
                                       open.dage_items_seriado.fsbgetserie(reg2.id_items_seriado,null),
                                       reg2.amount);
                   fetch cuLegalizacion into rgIncremento;
                   if cuLegalizacion%found then
                     CantidadItem:=nvl(REG2.AMOUNT,0);
                     ValorItem:=nvl(rgIncremento.valor,0);
                   ELSE
                     dbms_output.put_line('D '||reg2.id_items_documento||' '|| nvl(REG2.AMOUNT,0));
                     dbms_output.put_line('D '||reg2.id_items_documento||' '|| NVL(REG2.TOTAL_VALUE,0));
                   end if;
                   close cuLegalizacion; 
                ELSE
                    /*OPEN cuCuadres(REG2.OPERATING_UNIT_ID, REG2.ITEMS_ID);
                    FETCH cuCuadres INTO rgIncremento;
                    if cuCuadres%found then
                      IF nvl(rgIncremento.cant,0)!=0 THEN
                       CantidadItem:=nvl(REG2.AMOUNT,0);
                       ValorItem:=((nvl(rgIncremento.valor,0))/(nvl(rgIncremento.cant,0)))*nvl(REG2.AMOUNT,0);
                            --dbms_output.put_line('D '||reg2.id_items_documento||' '||-reg2.amount);
                            --dbms_output.put_line('D '||reg2.id_items_documento||' '||-REG2.TOTAL_VALUE);
                      ELSE
                        CantidadItem:=nvl(REG2.AMOUNT,0);
                        ValorItem:=0;--((nvl(rgIncremento.valor,0))/(nvl(rgIncremento.cant,0)))*nvl(REG2.AMOUNT,0);
                        "OPEN".ldc_sendemail('dsaltarin@horbath.com','Valida','error cantidad cero|'||reg2.items_id||'|'||reg2.operating_unit_id||'|'||reg2.uni_item_bala_mov_id);
                        DBMS_OUTPUt.PUT_LINE('error cantidad cero|'||reg2.items_id||'|'||reg2.operating_unit_id||'|'||reg2.uni_item_bala_mov_id);
                      END IF;
                    end if;
                    CLOSE cuCuadres;*/
                    ValorTraslado:=null;
                    if open.daor_operating_unit.fsbgetes_externa(reg2.operating_unit_id, null) = 'Y' and reg2.item_moveme_caus_id=20 then
                       IF CantidadJulio>0 THEN
                         ValorTraslado :=(ValorJulio/CantidadJulio)*reg2.amount;
                       END IF;
                    end if;
                    if open.daor_operating_unit.fnugetoper_unit_classif_id(reg2.target_oper_unit_id,null)=11 and reg2.total_value=0 then 
                       open cuDatosTrasladoSap(reg2.items_id, reg2.id_items_documento);
                       fetch cuDatosTrasladoSap into rgIncremento;
                       if cuDatosTrasladoSap%found then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(rgIncremento.CANT,0);
                        ValorItem:=nvl(ValorItem,0) +nvl(rgIncremento.VALOR,0) ;
                        if nvl(ValorTraslado,0)!=ValorItem and ValorTraslado is not null then
                          dbms_output.put_line('Diferencia Traslado:'||reg2.id_items_documento||' Item:'||reg2.items_id||' Diferencia:'||ValorTraslado||'%'||ValorItem);
                          --dbms_output.put_line('Valor actual:'||ValorJulio||'-CantidadActual:'||CantidadJulio);
                          ValorItem := ValorTraslado;
                          /*if reg2.id_items_documento=451576 then
                            dbms_output.put_line('ENTRO');
                          end if;*/
                        else
                           null  ;
                        end if;
                        
                        --dbms_output.put_line('I7 '||reg2.id_items_documento|| ' ' ||rgIncremento.CANT);
                        --dbms_output.put_line('I7 '||reg2.id_items_documento|| ' ' ||rgIncremento.VALOR);
                        
                      else
                          if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
                            CantidadItem:=nvl(REG2.AMOUNT,0);
                            ValorItem:=ValorTraslado;
                            dbms_output.put_line('ENTRO4'||ValorItem);
                            --dbms_output.put_line('Diferencia Traslado:'||reg2.id_items_documento||' Item:'||reg2.items_id||' Diferencia:'||ValorTraslado||'%'||REG2.TOTAL_VALUE);
                          else
                            if reg2.item_moveme_caus_id=25 then
								CantidadItem:=nvl(REG2.AMOUNT,0);
								ValorItem:=NVL(REG2.TOTAL_VALUE,0);                            
						    else
								CantidadItem:=nvl(REG2.AMOUNT,0);
								ValorItem:=NVL(REG2.TOTAL_VALUE,0);
                            end if;

                            --dbms_output.put_line('ENTRO5'||ValorItem);
                          end if;

                      end if;
                      close cuDatosTrasladoSap;
                    else
                       if nvl(ValorTraslado,0)!=0 and ValorTraslado is not null  then
                            CantidadItem:=nvl(REG2.AMOUNT,0);
                            ValorItem:=ValorTraslado;
                            --dbms_output.put_line('ENTRO6'||ValorItem);
                            --dbms_output.put_line('Diferencia Traslado:'||reg2.id_items_documento||' Item:'||reg2.items_id||' Diferencia:'||ValorTraslado||'%'||REG2.TOTAL_VALUE);
                          else
                            CantidadItem:=nvl(REG2.AMOUNT,0);
                            ValorItem:=NVL(REG2.TOTAL_VALUE,0);                            
--                            dbms_output.put_line('AJUSTE');
                             open cuModificacionAiosa(reg2.operating_unit_id, reg2.items_id, reg2.move_date);
                             fetch cuModificacionAiosa into rgModificacionAiosa;
                             if cuModificacionAiosa%found then
                               ValorItem:=rgModificacionAiosa.costo_final;
                               --dbms_output.put_line('ENTRO10');
                             end if;
                             close cuModificacionAiosa;
                            --dbms_output.put_line('ENTRO7'||ValorItem);
                          end if;
                    --dbms_output.put_line('D '||reg2.id_items_documento||' '|| nvl(REG2.AMOUNT,0));
                    --dbms_output.put_line('D '||reg2.id_items_documento||' '|| NVL(REG2.TOTAL_VALUE,0));
                    end if;
                    
                END IF;
               
              END IF;
              if reg2.movement_type = 'I' then
                nuSigno:=1;
                 if open.daor_operating_unit.fnugetoper_unit_classif_id(reg2.target_oper_unit_id, null)!=11 then
                      OPEN cuDatosIncremento(reg2.items_id, reg2.id_items_seriado,reg2.id_items_documento, reg2.TARGET_OPER_UNIT_ID);
                      fetch cuDatosIncremento into rgIncremento;
                      if cuDatosIncremento%found and rgIncremento.CANT is not null  then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                        ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0);   
                        --dbms_output.put_line('I1 '||reg2.id_items_documento||' '|| reg2.amount);
                        --dbms_output.put_line('I1 '||reg2.id_items_documento||' '|| (rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount);
                      elsif open.dage_items_documento.fnugetdocument_type_id(reg2.id_items_documento,null) in (118,112) then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                        ValorItem:=nvl(ValorItem,0) +nvl(reg2.total_value,0);   
                        --dbms_output.put_line('I2 '||reg2.id_items_documento||' '|| reg2.amount);
                        --dbms_output.put_line('I2 '||reg2.id_items_documento||' '|| reg2.total_value);
                      elsif open.dage_items_documento.fnugetdocument_type_id(reg2.id_items_documento,null) in (115) then
                          open cuDatosRechazoOsf(reg2.items_id, reg2.id_items_seriado,reg2.id_items_documento, reg2.operating_unit_id);
                          fetch cuDatosRechazoOsf into rgIncremento;
                          if cuDatosRechazoOsf%found then
                             CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                             ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0) ;   
                             --dbms_output.put_line('I3 '||reg2.id_items_documento||' '|| reg2.amount);
                             --dbms_output.put_line('I3 '||reg2.id_items_documento||' '|| (rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount);

                          ELSE
                            dbms_output.put_line('I4 '||reg2.id_items_documento||' '|| reg2.amount);
                            dbms_output.put_line('I4 '||reg2.id_items_documento||' '||reg2.total_value);
                          end if;
                          close cuDatosRechazoOsf;
                      ELSIF REG2.ITEM_MOVEME_CAUS_ID = 28 THEN
                      
                            CantidadItem:=nvl(REG2.AMOUNT,0);
                            ValorItem:=NVL(REG2.TOTAL_VALUE,0);
                            --dbms_output.put_line('I5 '||reg2.id_items_documento||' '|| nvl(REG2.AMOUNT,0));
                            --dbms_output.put_line('I5 '||reg2.id_items_documento||' '|| NVL(REG2.TOTAL_VALUE,0));
                                
                      ELSE
                        dbms_output.put_line('I6 '||reg2.id_items_documento||' '|| reg2.amount);
                        dbms_output.put_line('I6 '||reg2.id_items_documento||' '|| reg2.total_value);
                      end if;
                      close cuDatosIncremento;
                 else
                      open cuDatosIncrementoSap(reg2.items_id, reg2.id_items_documento);
                      fetch cuDatosIncrementoSap into rgIncremento;
                      if cuDatosIncrementoSap%found then
                        CantidadItem:=nvl(CantidadItem,0)+nvl(rgIncremento.CANT,0);
                        ValorItem:=nvl(ValorItem,0) +nvl(rgIncremento.VALOR,0) ;
                        --dbms_output.put_line('I7 '||reg2.id_items_documento|| ' ' ||rgIncremento.CANT);
                        --dbms_output.put_line('I7 '||reg2.id_items_documento|| ' ' ||rgIncremento.VALOR);
                      else
                        open cuRechazoSap(reg2.items_id, reg2.id_items_documento, reg2.operating_unit_id );
                        fetch cuRechazoSap into rgIncremento;
                        if cuRechazoSap%found then
                           CantidadItem:=nvl(CantidadItem,0)+nvl(reg2.amount,0);
                           ValorItem:=nvl(ValorItem,0) +nvl((rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount,0); 
                           --dbms_output.put_line('I8 '||reg2.id_items_documento|| ' ' ||reg2.amount);
                           --dbms_output.put_line('I8 '||reg2.id_items_documento|| ' ' ||(rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount);
                        ELSE
                           dbms_output.put_line('I9 '||reg2.id_items_documento|| ' ' ||reg2.amount);
                           dbms_output.put_line('I9 '||reg2.id_items_documento|| ' ' ||(rgIncremento.VALOR/rgIncremento.CANT)*reg2.amount);
                        end if;
                        close cuRechazoSap;
                      end if;
                      close cuDatosIncrementoSap;
                 end if;
              end if;
          --end if;
        --dbms_output.put_line(reg2.uni_item_bala_mov_id ||'|'||reg2.id_items_documento||'|'||reg2.movement_type||'|'||CantidadItem||'|'||ValorItem);
        
      CantidadJulio :=CantidadJulio+nvl(CantidadItem,0)*nuSigno;
      ValorJulio :=ValorJulio+nvl(ValorItem,0)*nuSigno;
      --dbms_output.put_line('Valor actual:'||ValorJulio||'-CantidadActual:'||CantidadJulio);
      insert into open.OR_UNI_ITEM_BALA_MOV_COPIA2
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
values (reg2.uni_item_bala_mov_id ,
  reg2.items_id             ,
  reg2.operating_unit_id    ,
  reg2.item_moveme_caus_id  ,
  reg2.movement_type        ,
  CantidadItem,
  reg2.comments             ,
  reg2.move_date            ,
  reg2.terminal             ,
  reg2.user_id              ,
  reg2.support_document     ,
  reg2.target_oper_unit_id  ,
  ValorItem          ,
  reg2.id_items_documento   ,
  reg2.id_items_seriado     ,
  reg2.id_items_estado_inv  ,
  reg2.valor_venta          ,
  reg2.init_inv_stat_items   );
COMMIT;
      end loop;
      if sbDatosN is not null or sbDatosI is not null then
       -- dbms_output.put_line(sbRegistro ||' Diferencias en :'||sbDatosN||'-'||sbDatosI);
        sbDatosN:=null;
        sbDatosI:=null;
      end if;
    --dbms_output.put_line(reg.operating_unit_id||'|'||reg.items_id||'|'||nvl(CantidadItem,0)||'|'||nvl(ValorItem,0));
    CantidadItem:=0;
    ValorItem:=0; 
  end loop;
  --commit;
end;

  
