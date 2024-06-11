DECLARE
CURSOR CUDATOS IS
select 
a.operating_unit_id,
open.daor_operating_unit.fsbgetname(a.operating_unit_id), 
open.daor_operating_unit.fsbgetes_externa(a.operating_unit_id, null) EXTERNA,
a.items_id, 
open.dage_items.fsbgetdescription(a.items_id,null) desc_item,
open.dage_items.fnugetitem_classif_id(a.items_id,null) clasificacion,
a.balance, (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,
a.total_costs, (select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,
A.TRANSIT_IN,A.TRANSIT_OUT
from OPEN.OR_OPE_UNI_ITEM_BALA a
where (
a.balance!=nvl((select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)+
nvl((select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id),0)
)
and items_id not like '4%'
and items_id not in (100003008 , 100003011)
and a.operating_unit_id not in (799,77)
and a.balance!=0
AND A.TOTAL_COSTS>0


order by operating_unit_id, items_id
;


CURSOR CUVALIDACION(NUUDIDAD NUMBER, NUITEM NUMBER) IS
--reservas

select  null tipo_documento,null description,  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I') TIPO, sum(decode( mmitnatu,'+',1,'-',-1,0)*dmitcant) cantidad
from open.ldci_intemmit, open.ldci_dmitmmit, open.ge_items_documento d
where mmitcodi=dmitmmit
and mmitnudo=to_char(d.id_items_documento)
and dmitcoin=NUITEM
and d.operating_unit_id=NUUDIDAD
and mmitdsap is not null
and mmitesta=2
and d.document_type_id!=105
group by  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I')

--anulaciones devoluciones
union all
select  null tipo_documento,null description,  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I') TIPO, sum(decode( mmitnatu,'+',1,'-',-1,0)*dmitcant) cantidad
from open.ldci_intemmit, open.ldci_dmitmmit, open.ge_items_documento d
where mmitcodi=dmitmmit
and mmitnudo=to_char(d.id_items_documento)
and dmitcoin=NUITEM
and d.operating_unit_id=NUUDIDAD
and mmitdsap is not null
and mmitesta=2
and d.document_type_id=105
 and mmitnatu='+'
group by  d.operating_unit_id, dmitcoin, decode(MMITTIMO,'Z14','A','Z13','A','Z01','I','Z02','I','Z03','I','Z04','I')
--pedidos de venta
union all

select  null tipo_documento,null description,  d.trsmunop, dmitcoin, 'I' TIPO, sum(decode( mmitnatu,'+',1,'-',-1,0)*dmitcant) cantidad
from open.ldci_intemmit, open.ldci_dmitmmit, open.ldci_transoma d, OPEN.GE_ITEMS I
where mmitcodi=dmitmmit
and mmitnupe ='GDC-'||to_char(d.trsmcodi)
and dmitcoin=NUITEM
and d.trsmunop=NUUDIDAD
and mmitdsap is not null
AND I.ITEMS_ID=DMITITEM
AND I.ITEM_CLASSIF_ID=21
and mmitesta=2
group by  d.trsmunop, dmitcoin, 'I'
--migracion
union all
SELECT  null tipo_documento, null description,  B.CUADHOMO, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) item, eixbtipo, sum(eixbdisu)
FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B
WHERE A.EIXBBCUA = B.CUADCODI
AND A.BASEDATO = B.BASEDATO
and nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=NUITEM
and B.CUADHOMO=NUUDIDAD
group by B.CUADHOMO, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) , eixbtipo

union all        
---legalizacion
select o.task_type_id tipo_documento, null description, o.operating_unit_id unidad, oi.items_id,  tb.warehouse_type,  sum(DECODE(NVL(oi.out_,'Y'),'Y',-1,0)*oi.legal_item_amount)
from open.or_order o, open.or_order_items oi, open.LDC_TT_TB tb
where o.operating_unit_id=NUUDIDAD
and oi.order_id=o.order_id
and oi.items_id= NUITEM     
and tb.task_type_id=o.task_type_id
AND NOT EXISTS(SELECT NULL FROM OPEN.GE_ITEMS_DOCUMENTO D, OPEN.OR_UNI_ITEM_BALA_MOV MOV WHERE DOCUMENTO_EXTERNO=TO_CHAR(O.ORDER_ID) AND MOV.ID_ITEMS_DOCUMENTO=D.ID_ITEMS_DOCUMENTO AND D.DOCUMENT_TYPE_ID=118 AND MOVEMENT_TYPE!='N' and MOV.ITEMS_ID=OI.ITEMS_ID)
and not exists(select null from open.or_order_activity a where a.order_id=oi.order_id and a.activity_id=102400)
group by  o.task_type_id,oi.out_, tb.warehouse_type, o.operating_unit_id , oi.items_id

union all
--movimientos osf

select  D.document_type_id, t.description, d.operating_unit_id, m.items_id,
CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3369 THEN 'I'
WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID=3368 THEN 'A'
WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
WHEN D.DOCUMENT_TYPE_ID IN (105,103,115) AND D.CAUSAL_ID IS NULL THEN 'X'
WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'
WHEN D.DOCUMENT_TYPE_ID=118 THEN (SELECT TB.WAREHOUSE_TYPE FROM OPEN.OR_ORDER O, OPEN.LDC_TT_TB tb WHERE TB.TASK_TYPE_ID=O.TASK_TYPE_ID AND O.ORDEr_ID=D.DOCUMENTO_EXTERNO)
ELSE 'X' END TIPO,
SUM(DECODE(MOVEMENT_TYPE,'D',-1,1)*AMOUNT) CANTIDAD
from open.ge_items_documento d, open.ge_document_type t, open.or_uni_item_bala_mov m
where m.operating_unit_id=NUUDIDAD
and d.document_type_id=t.document_type_id
and m.id_items_documento=d.id_items_documento
and not exists(select null from open.ldci_intemmit where documento_externo like '%'||mmitdsap and documento_externo is not null and mmitdsap is not null)

and movement_type!='N'
and items_id=NUITEM

GROUP BY D.document_type_id, t.description, d.operating_unit_id, m.items_id, D.CAUSAL_ID,M.TARGET_OPER_UNIT_ID,D.DOCUMENTO_EXTERNO,
CASE WHEN M.ITEMS_ID=10004070 THEN 'I'
WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3369 THEN 'I'
WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID=3368 THEN 'A'
WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID NOT IN (3368,3369) THEN 'N/A'
WHEN D.DOCUMENT_TYPE_ID IN (105,103) AND D.CAUSAL_ID IS NULL THEN 'X'
WHEN D.DOCUMENT_TYPE_ID = 113 THEN 'AJUSTE'
WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1773,1774,1775) THEN 'I'
WHEN OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(M.TARGET_OPER_UNIT_ID,NULL) =11 AND M.TARGET_OPER_UNIT_ID IN (1931,1932,1933) THEN 'A'  
ELSE 'X' END 

union all  
--datafix
select null tipo_documento, null description,  m.operating_unit_id, items_id item, 'NA', SUM(DECODE(MOVEMENT_TYPE,'D',-1,'I',1,0)* AMOUNt)
from open.or_uni_item_bala_mov m
where operating_unit_id=NUUDIDAD 
and items_id=NUITEM
and id_items_documento is  null
and M.Item_Moveme_Caus_Id=-1
GROUP BY   m.operating_unit_id, items_id  
;
cursor cuBodega(nuBodega number, nuItem number) is
select *
from open.or_ope_uni_item_bala
where items_id=nuitem
and operating_unit_id=nuBodega;
RGBODEGA CUBODEGA%ROWTYPE;

NUACTIVO NUMBER;
NUINVENTARIO NUMBER;
NUOTROS  NUMBER;
NUACTIVO2 NUMBER;
NUINVENTARIO2 NUMBER;
NUCOSTPROM  NUMBER(13,2);
NUCOSTACTI  NUMBER(13,2);
NUCOSTINVE  NUMBER(13,2);  
SBACTUALIZA VARCHAR2(1):='S';

BEGIN
  DBMS_OUTPUT.PUT_LINE('CODIGO UNIDAD'||'|'||'CODIGO_ITEM'||'|'||'TOTAL_BODEGA'||'|' ||'INVENTARIO'||'|'||'ACTIVO'||'|'||'OTROS'||'|'||'COSTO BODEGA'||'|'||'COSTO INV'||'|'||'COSTO ACT');
  FOR REG IN CUDATOS LOOP
    NUACTIVO:=0;
    NUINVENTARIO:=0;
    NUOTROS:=0;
    open cubodega(REG.OPERATING_UNIT_ID, REG.ITEMS_ID);
    FETCH CUBODEGA INTO RGBODEGA;
    CLOSE CUBODEGA;
    IF RGBODEGA.BALANCE = 0 THEN
	  IF SBACTUALIZA='S' THEN
		  UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
		  if sql%rowcount=0 then
		  insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
		  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
		  end if;
		  UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
		  if sql%rowcount=0 then
		  insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
		  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
		  end if;
	  END IF;
      NUACTIVO2 :=0;
      NUINVENTARIO2:=0;
      NUCOSTACTI :=0;
      NUCOSTINVE:=0;
    ELSE
    IF REG.EXTERNA = 'Y' and reg.clasificacion= 21 and reg.total_costs= 0 and reg.items_id!=10011198 then
      IF SBACTUALIZA ='S' THEN
		  DELETE OPEN.ldc_act_ouib b  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
		  DELETE OPEN.ldc_inv_ouib b  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
	  END IF;
      
      NUACTIVO2 :=0;
      NUINVENTARIO2:=0;
      NUCOSTACTI :=0;
      NUCOSTINVE:=0;
    else
      IF REG.ITEMS_ID=10004070 THEN
        NUACTIVO2 :=0;
        NUINVENTARIO2:=REG.BALANCE;
        NUCOSTACTI :=0;
        NUCOSTINVE:=REG.TOTAL_COSTS;
        IF SBACTUALIZA ='S' THEN
			 UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
			if sql%rowcount=0 then
			insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
			values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
			end if;
			UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=REG.BALANCE, B.TOTAL_COSTS=REG.TOTAL_COSTS  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
			if sql%rowcount=0 then
			insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
			values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, REG.BALANCE, REG.TOTAL_COSTS, 0,null,null);
			end if;
		END IF;
      ELSE
  
      
        FOR REG2 IN CUVALIDACION(REG.OPERATING_UNIT_ID, REG.ITEMS_ID) LOOP
          IF REG2.TIPO='A' THEN
            NUACTIVO:=NUACTIVO+REG2.CANTIDAD;
          ELSIF REG2.TIPO='I' THEN
            NUINVENTARIO:=NUINVENTARIO+REG2.CANTIDAD;
          ELSE 
            NUOTROS:=NUOTROS+REG2.CANTIDAD;
          END IF;
        END LOOP;
        ----aca
		open cubodega(REG.OPERATING_UNIT_ID, REG.ITEMS_ID);
		FETCH CUBODEGA INTO RGBODEGA;
		CLOSE CUBODEGA;
		
        NUCOSTPROM := RGBODEGA.TOTAL_COSTS/RGBODEGA.BALANCE;
        IF NUACTIVO < 0 THEN
          NUACTIVO2 :=0;
          NUINVENTARIO2:=RGBODEGA.BALANCE;
          NUCOSTACTI := 0;  
          NUCOSTINVE := RGBODEGA.TOTAL_COSTS;  
		  IF SBACTUALIZA='S' THEN
			   UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
			  if sql%rowcount=0 then
			  insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
			  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
			  end if;
			  UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=REG.BALANCE, B.TOTAL_COSTS=REG.TOTAL_COSTS  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
			  if sql%rowcount=0 then
			  insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
			  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, REG.BALANCE, REG.TOTAL_COSTS, 0,null,null);
			  end if;
		  END IF;
        ELSE
          IF NUINVENTARIO < 0 THEN
            NUACTIVO2 :=RGBODEGA.BALANCE;
            NUINVENTARIO2:=0;
            NUCOSTACTI := RGBODEGA.TOTAL_COSTS;  
            NUCOSTINVE := 0; 
		    IF SBACTUALIZA='S' THEN
				UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=0, B.TOTAL_COSTS=0  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
				if sql%rowcount=0 then
				insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA, 0, 0, 0,null,null);
				end if;
				UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=REG.BALANCE, B.TOTAL_COSTS=REG.TOTAL_COSTS  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id;
				if sql%rowcount=0 then
				insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA,REG.BALANCE, REG.TOTAL_COSTS, 0,null,null);
				end if;
			END IF;
          ELSE
            IF NUINVENTARIO>=NUACTIVO THEN
              
              NUINVENTARIO2 :=NUINVENTARIO+NUOTROS;
              NUACTIVO2:=NUACTIVO;
			  if (NUINVENTARIO2+NUACTIVO2)>RGBODEGA.BALANCE THEN
				 NUINVENTARIO2:=RGBODEGA.BALANCE-NUACTIVO2;
			  END IF;
              NUCOSTACTI := ROUND(NUACTIVO2*NUCOSTPROM,2);
              NUCOSTINVE := ROUND(NUINVENTARIO2*NUCOSTPROM,2);  
			  
			  
			  IF SBACTUALIZA ='S' THEN
				   UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=NUINVENTARIO2, b.total_costs=NUCOSTINVE  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id; 
				  if sql%rowcount=0 then
				  insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA,NUINVENTARIO2,NUCOSTINVE, 0,null,null);
				  end if;
				  UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=(NUACTIVO), b.total_costs=NUCOSTACTI  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id; 
				  if sql%rowcount=0 then
				  insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA,(NUACTIVO),NUCOSTACTI, 0,null,null);
				  end if;
		      END IF;
            ELSE
              NUINVENTARIO2  :=NUINVENTARIO;
              NUACTIVO2 :=NUACTIVO+NUOTROS; 
			  if (NUINVENTARIO2+NUACTIVO2)>RGBODEGA.BALANCE THEN
				 NUACTIVO2:=RGBODEGA.BALANCE-NUINVENTARIO2;
			  END IF;			  
              NUCOSTACTI := ROUND(NUACTIVO2*NUCOSTPROM,2);
              NUCOSTINVE := ROUND(NUINVENTARIO2*NUCOSTPROM,2);      
			  IF SBACTUALIZA ='S' THEN
				  UPDATE OPEN.ldc_inv_ouib b SET B.BALANCE=(NUINVENTARIO), b.total_costs=NUCOSTINVE  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id; 
				  if sql%rowcount=0 then
				  insert into OPEN.ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA,NUINVENTARIO,NUCOSTINVE, 0,null,null);
				  end if;
				  UPDATE OPEN.ldc_act_ouib b SET B.BALANCE=NUACTIVO2, b.total_costs=NUCOSTACTI  where b.items_id=reg.items_id and b.operating_unit_id=reg.operating_unit_id; 
				  if sql%rowcount=0 then
				  insert into OPEN.ldc_act_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
				  values(reg.items_id, reg.operating_unit_id, RGBODEGA.QUOTA,NUACTIVO2,NUCOSTACTI, 0,null,null);
				  end if;
			   END IF;
              
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    END IF;
	IF SBACTUALIZA ='S' THEN
		COMMIT;
    ELSE 
		ROLLBACK;
	END IF;
    DBMS_OUTPUT.PUT_LINE(REG.OPERATING_UNIT_ID||'|'||REG.ITEMS_ID||'|'||RGBODEGA.BALANCE||'|'||nvl(NUINVENTARIO,0)||'|'||nvl(NUACTIVO,0)||'|'||nvl(NUOTROS,0)||'|'||RGBODEGA.TOTAL_COSTS||'|'|| NUCOSTINVE||'|'|| NUCOSTACTI ||'|REAL');
    DBMS_OUTPUT.PUT_LINE(REG.OPERATING_UNIT_ID||'|'||REG.ITEMS_ID||'|'||RGBODEGA.BALANCE||'|'||nvl(NUINVENTARIO2,0)||'|'||nvl(NUACTIVO2,0)||'|'||nvl(0,0)||'|'||RGBODEGA.TOTAL_COSTS||'|'|| NUCOSTINVE||'|'|| NUCOSTACTI ||'|QUEDO');
  END LOOP;
END;    
/
