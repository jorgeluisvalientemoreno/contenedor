DECLARE
  CURSOR cuCuadre(nuUnidad Number) is
    SELECT cu.operating_unit_id
        ,open.daor_operating_unit.fsbgetname(a.operating_unit_id) nombre
        ,cu.items_id
    ,open.dage_items.fsbgetdescription(cu.items_id)  descripcion
        ,a.balance
        ,(select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act
        ,(select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv
        ,a.total_costs
        ,(select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_act
        ,(select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv
        ,SUM(cantidad_activo) cantidad_activo
        ,SUM(valor_activo) valor_activo
        ,SUM(cantidad_inv) cantidad_inv
        ,SUM(valor_inven) valor_inven
        ,SUM(cantidad_x) cantidad_x
        ,SUM(valor_x) valor_x
        ,SUM(cantidad_ajuste) cantidad_ajuste
        ,SUM(valor_ajuste) valor_ajuste
    FROM (
          SELECT operating_unit_id, items_id
                ,SUM(DECODE(clasificacion, 'A', cantidad,0)) cantidad_activo
                ,SUM(DECODE(clasificacion, 'A', valor,0)) valor_activo
                ,SUM(DECODE(clasificacion, 'I', cantidad,0)) CANTIDAD_INV
                ,SUM(DECODE(clasificacion, 'I', VALOR,0))  VALOR_INVEN
                ,SUM(DECODE(clasificacion, 'X', CANTIDAD,0)) CANTIDAD_X
                ,SUM(DECODE(clasificacion, 'X', VALOR,0))  VALOR_X
                ,SUM(DECODE(clasificacion, 'AJUSTE', CANTIDAD,0)) CANTIDAD_AJUSTE
                ,SUM(DECODE(clasificacion, 'AJUSTE', VALOR,0))  VALOR_AJUSTE
            FROM(
                  SELECT o.operating_unit_id, items_id,
                       (CASE WHEN o.movement_type = 'D' AND o.item_moveme_caus_id = 4 THEN
                        (SELECT tt.warehouse_type
                           FROM open.ldc_tt_tb tt, open.or_order oo
                          WHERE oo.order_id = d.documento_externo
                            AND oo.task_type_id =tt.task_type_id
                         )
                   WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id,null)=11
                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id,null) like '%ACTIVO%' THEN 'A'
                        WHEN open.daor_operating_unit.fnugetoper_unit_classif_id(o.target_oper_unit_id,null)=11
                         AND open.daor_operating_unit.fsbgetname(o.target_oper_unit_id,null) like '%INVENTARIO%' THEN 'I'
                        WHEN d.causal_id=3368 THEN 'A'
                        WHEN d.causal_id=3369 THEN 'I'
                        WHEN ITEMS_ID=10004070 THEN 'I'
                        WHEN d.document_type_id=113  then
                          'AJUSTE'
                   ELSE 'X' END
                  ) clasificacion ,
                  SUM(DECODE(movement_type,'D',-1,1)*o.amount) cantidad
                , SUM(DECODE(movement_type,'D',-1,1)*o.total_value ) valor
             FROM open.or_uni_item_bala_mov o  LEFT JOIN
                  open.ge_items_documento   d  ON (o.id_items_documento = d.id_items_documento)
            WHERE items_id not like '4%'
              AND items_id NOT IN (100003008, 100003011)
         --     and items_id=10004228
              AND o.operating_unit_id = nuUnidad
              AND o.movement_type in ('I','D')
  GROUP BY  o.operating_unit_id, items_id, o.movement_type,document_type_id, o.item_moveme_caus_id , d.causal_id,o.target_oper_unit_id, d.documento_externo, o.id_items_documento
)
GROUP BY OPERATING_UNIT_ID, ITEMS_ID
UNION all
SELECT B.CUADHOMO OPERATING_UNIT_ID, I.ITEMS_ID ITEMS_ID,
       SUM(DECODE(EIXBTIPO, 'A', EIXBDISU,0)) CANTIDAD_ACTIVO, SUM(DECODE(EIXBTIPO, 'A', EIXBVLOR,0))  VALOR_ACTIVO,
       SUM(DECODE(EIXBTIPO, 'I', EIXBDISU,0)) CANTIDAD_INV, SUM(DECODE(EIXBTIPO, 'I', EIXBVLOR,0))  VALOR_INVEN,
       SUM(DECODE(EIXBTIPO, 'X', EIXBDISU,0)) CANTIDAD_X, SUM(DECODE(EIXBTIPO, 'X', EIXBVLOR,0))  VALOR_X,
       SUM(DECODE(EIXBTIPO, 'AJUSTE', EIXBDISU,0)) CANTIDAD_AJUSTE, SUM(DECODE(EIXBTIPO, 'X', EIXBVLOR,0))  VALOR_AJUSTE
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B, OPEN.GE_ITEMS I
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        and B.CUADHOMO in (nuUnidad)
        and nvl(MIGRA.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=I.ITEMS_ID
GROUP BY B.CUADHOMO, I.ITEMS_ID ) cu, OPEN.OR_OPE_UNI_ITEM_BALA a
where cu.operating_unit_id=a.operating_unit_id
and cu.items_id=a.items_id
and a.items_id not like '4%'
and a.items_id not in (100003008 , 100003011)
and a.operating_unit_id not in (799,77)
and a.operating_unit_id = nuUnidad
AND (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)<>0
having SUM(CANTIDAD_X) =0
  and  SUM(VALOR_X) = 0
  and  SUM(CANTIDAD_AJUSTE)=0
  and SUM(VALOR_AJUSTE)=0
   AND SUM(cantidad_activo)=0
   AND SUM(valor_activo) = 0
GROUP BY cu.OPERATING_UNIT_ID, cu.ITEMS_ID, a.balance, a.total_costs, a.items_id, a.operating_unit_id;

cursor cuUnidades is
 select distinct a.operating_unit_id
from OPEN.OR_OPE_UNI_ITEM_BALA a 
where (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)>0
  --and operating_unit_id=1863
  ;

nuSecuenciaReporte number:=SQ_REPORTES.NEXTVAL;
nuLinInco		number:=1;

	procedure proregistrarepoinco(CodigoReporte number,
								  sbMensaje1    varchar2,
								  sbMensaje2	varchar2) is
								  
	begin
		insert into repoinco(reinrepo,reincodi,reindat1,reindes1,reindes2,reindes5,reinobse) 
			values (CodigoReporte, SQ_REPOINCO_REINCODI.nextval, sysdate,'ANTES',sbMensaje1,'DESPUES',sbMensaje2);
	end;

begin
  --dbms_output.put_line('UNIDAD_OPER|NOMBRE|ITEM|DESCRIPCION|CANTIDAD_BODEGA|CANTIDAD_ACTIVO|CANTIDAD_INVENTARIO');
  pkReportsMgr.CreateReport ('OSS_MTTO_DSS_30022116_3' , nuSecuenciaReporte);
  proregistrarepoinco(
						nuSecuenciaReporte,
						'UNIDAD_OPER|NOMBRE|ITEM|DESCRIPCION|CANTIDAD_BODEGA|CANTIDAD_ACTIVO|CANTIDAD_INVENTARIO',
						'UNIDAD_OPER|NOMBRE|ITEM|DESCRIPCION|CANTIDAD_BODEGA|CANTIDAD_ACTIVO|CANTIDAD_INVENTARIO'
						);
	for reg in cuUnidades loop
    for reg2 in cuCuadre(reg.operating_unit_id) loop
		UPDATE OPEN.LDC_ACT_OUIB SET BALANCE=0, TOTAL_COSTS=0 
		 WHERE  OPERATING_UNIT_ID=REG2.OPERATING_UNIT_ID
		   AND ITEMS_ID=REG2.ITEMS_ID;
		UPDATE OPEN.LDC_INV_OUIB SET BALANCE=REG2.BALANCE, TOTAL_COSTS=REG2.TOTAL_COSTS
		 WHERE  OPERATING_UNIT_ID=REG2.OPERATING_UNIT_ID
		   AND ITEMS_ID=REG2.ITEMS_ID;
		  nuLinInco := nuLinInco+1;
		  --dbms_output.put_line(reg2.operating_unit_id||'|'||reg2.nombre||'|'||reg2.items_id||'|'||reg2.descripcion||'|'||reg2.balance||'|'||reg2.cantidad_activo||'|'||reg2.cantidad_inv);
		  proregistrarepoinco(
						nuSecuenciaReporte,
						reg2.operating_unit_id||'|'||reg2.nombre||'|'||reg2.items_id||'|'||reg2.descripcion||'|'||reg2.balance||'|'||reg2.cantidad_activo||'|'||reg2.cantidad_inv,
						reg2.operating_unit_id||'|'||reg2.nombre||'|'||reg2.items_id||'|'||reg2.descripcion||'|'||reg2.balance||'|'||0||'|'||reg2.balance
						);
		 
    end loop;
  end loop;
  commit;
exception
	when others then	
		rollback;
		dbms_output.put_line('Error :'||sqlerrm);
end;
/
