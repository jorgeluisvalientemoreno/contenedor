column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

    nuProducto NUMBER := 50894095;
    	
    CURSOR cuProd
    IS
    SELECT pr.RowId rIdPr, pr.product_status_id
    FROM pr_product pr
    WHERE pr.product_id = nuProducto;

    CURSOR cuSeSu
    IS
    SELECT ss.RowId rIdSS, ss.sesuesco
    FROM servsusc ss
    WHERE ss.sesunuse = nuProducto;
    
begin

    dbms_output.put_line( 'product_id = ' || nuProducto );
                
    FOR rgProd IN cuProd  LOOP

        dbms_output.put_line( 'Antes product_status_id = ' || rgProd. product_status_id );
            
        update pr_product 
        set product_status_id = 16 
        where rowId = rgProd.rIdPr;

        dbms_output.put_line( 'Desp product_status_id = 16');
            
    END LOOP;
    
    FOR rgSeSu IN cuSeSu  LOOP

        dbms_output.put_line( 'Antes sesuesco = ' || rgSeSu.sesuesco );
                    
        update servsusc 
        set sesuesco = 110 
        where ROWID = rgSeSu.rIdSS;

        dbms_output.put_line( 'Desp sesuesco = 110' );

    END LOOP;
    
    COMMIT;
       
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line( 'Error[' || sqlerrm || ']');
            ROLLBACK;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/