SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4723"
prompt "-----------------"
DECLARE
    
    nuEstadoProd NUMBER := 1;
    nuEstadoComp NUMBER := 5;
       
    CURSOR cuProductos IS
    SELECT *
    FROM OPEN.pr_product
    WHERE product_id in (51176673,50734500,51869663);
    
    CURSOR cuComponentes IS
    SELECT *
    FROM OPEN.pr_component
    WHERE product_id in (51176673,50734500,51869663);
   
    CURSOR cuServicio IS
    SELECT *
    FROM OPEN.servsusc
    WHERE sesunuse in (51176673,50734500,51869663);
    
BEGIN    
   
    FOR rcProd IN cuProductos LOOP
        UPDATE pr_product
        SET product_status_id = nuEstadoProd
        WHERE product_id = rcProd.product_id;
        
        dbms_output.put_line('El estado del producto '||rcProd.product_id||' cambio de '||rcProd.product_status_id||' a '||nuEstadoProd);       
        commit;
    END LOOP;
   
    FOR rcComp IN cuComponentes LOOP
        UPDATE pr_component
        SET component_status_id = nuEstadoComp
        WHERE product_id = rcComp.product_id;
        
        dbms_output.put_line('El estado del componente del producto '||rcComp.product_id||' cambio de '||rcComp.component_status_id||' a '||nuEstadoComp);       
        commit;
    END LOOP;
    
    FOR rcServ IN cuServicio LOOP
        UPDATE servsusc
        SET sesuesco = nuEstadoProd
        WHERE sesunuse = rcServ.sesunuse;
        
        dbms_output.put_line('El estado del servicio '||rcServ.sesunuse||' cambio de '||rcServ.sesuesco||' a '||nuEstadoProd);       
        commit;
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo realizar la actualización de los estados de los productos 51176673, 50734500 y 51869663 - '||sqlerrm);
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4723-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/