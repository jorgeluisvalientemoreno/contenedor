column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	CURSOR cuDatosCateSubcate 
	IS
		SELECT premise_id,
			   pr.CATEGORY_ categoria_predio_id,
			   (SELECT c.CATEDESC FROM CATEGORI c WHERE c.CATECODI = pr.CATEGORY_) categoria_predio,
			   p.CATEGORY_ID categoria_producto_id,
			   (SELECT c.CATEDESC FROM CATEGORI c WHERE c.CATECODI = p.CATEGORY_ID) categoria_producto,
			   pr.SUBCATEGORY_ subcategoria_predio_id,
			   (SELECT c.sucadesc FROM subcateg c WHERE c.sucacate = pr.CATEGORY_ AND c.sucacodi = pr.SUBCATEGORY_) subcategoria_predio,
			   p.SUBCATEGORY_ID subcategoria_producto_id,
			   (SELECT c.sucadesc FROM subcateg c WHERE c.sucacate = p.CATEGORY_ID AND c.sucacodi = p.SUBCATEGORY_ID) subcategoria_producto,
			   p.PRODUCT_TYPE_ID,
			   p.PRODUCT_ID,
			   daab_address.fsbgetaddress_parsed(p.ADDRESS_ID,0) direccion
		FROM AB_PREMISE pr 
			 INNER JOIN AB_ADDRESS a ON pr.PREMISE_ID = a.ESTATE_NUMBER 
			 INNER JOIN PR_PRODUCT p ON a.ADDRESS_ID  = p.ADDRESS_ID
		WHERE pr.CATEGORY_ 		<> p.CATEGORY_ID 
		AND (p.PRODUCT_TYPE_ID 	= 7014)
		AND p.product_status_id NOT IN (3, 16);
		
	CURSOR cuServsusc(inuProductoId	IN NUMBER)
	IS 
		SELECT sesunuse, 
			   category_id, 
			   sesucate, 
			   subcategory_id, 
			   sesusuca 
		FROM pr_product, servsusc
		WHERE product_id = inuProductoId
		AND sesunuse 	 = product_id;

begin

	dbms_output.put_line('Inicia OSF-4132');
	
	execute immediate 'alter trigger TRGBIDURAB_PREMISE DISABLE';
	
	FOR reg IN cuDatosCateSubcate LOOP
	
		dbms_output.put_line('Inicia actualización del predio ' || reg.premise_id);
		
		dbms_output.put_line('Actualizando categoria ' || reg.categoria_predio_id || ' por la categoria ' || reg.categoria_producto_id);
		dbms_output.put_line('Actualizando subcategoria ' || reg.subcategoria_predio_id || ' por la subcategoria ' || reg.subcategoria_producto_id);
	
		UPDATE ab_premise
		SET category_ 	 = reg.categoria_producto_id,
			subcategory_ = reg.subcategoria_producto_id
		WHERE premise_id = reg.premise_id;
		
		FOR regServ	IN cuServsusc(reg.PRODUCT_ID) LOOP
		
			IF (regServ.category_id <> regServ.sesucate OR regServ.subcategory_id <> regServ.sesusuca) THEN
			
				dbms_output.put_line('Inicia actualización de servsusc ' || regServ.sesunuse);
		
				dbms_output.put_line('Actualizando categoria ' || regServ.sesucate || ' por la categoria ' || regServ.category_id);
				dbms_output.put_line('Actualizando subcategoria ' || regServ.sesusuca || ' por la subcategoria ' || regServ.subcategory_id);
			
				UPDATE servsusc
				SET	sesucate = regServ.category_id,
					sesusuca = regServ.subcategory_id
				WHERE sesunuse = regServ.sesunuse;
				
			END IF;
		
		END LOOP;		
		
		COMMIT;
		
		dbms_output.put_line('Finaliza actualización del predio ' || reg.premise_id);
		
	END LOOP;
	
	execute immediate 'alter trigger TRGBIDURAB_PREMISE ENABLE';
	
	dbms_output.put_line('Finaliza OSF-4132');
	
EXCEPTION
	when others THEN
		dbms_output.put_line('Error no controlado ' ||sqlerrm);
		rollback;
		execute immediate 'alter trigger TRGBIDURAB_PREMISE ENABLE';

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/