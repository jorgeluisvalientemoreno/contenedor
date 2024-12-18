declare
  cursor cuventasanu is
    select *
    from open.LDC_SOLIANECO;

sbmensaje		VARCHAR2(4000);
nuCont         NUMBER:= 0;

begin
 for reg in cuventasanu loop
    update pr_product set address_id = reg.DIRECCION where product_id = reg.PRODUCTO ;
    update suscripc set susciddi = reg.DIRECCION where susccodi = reg.CONTRATO;
    commit;
    nuCont := nuCont + 1;
     sbMensaje := 'Direccion actualizada producto:'||reg.producto;
     dbms_output.put_line(sbMensaje); 
     
 end loop;
 sbMensaje := 'Total Productos Actualizados: '||to_char(nuCont);
 dbms_output.put_line(sbMensaje); 
end;
/