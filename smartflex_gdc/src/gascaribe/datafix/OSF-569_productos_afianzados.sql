declare

  cursor cuventaafianzada is
    select diferido.difenuse producto_brilla
      from diferido
     where diferido.difesape > 0
       and diferido.difepldi in (167)
     group by diferido.difenuse;

  rfcuventaafianzada cuventaafianzada%rowtype;

begin

  dbms_output.put_line('Inicio registtro productos Venta Plan Afianzado');
  for rfcuventaafianzada in cuventaafianzada loop
    begin
    
      insert into ldc_afianzado
        (product_id)
      values
        (rfcuventaafianzada.producto_brilla);
      commit;
      dbms_output.put_line('Registrar del producto ' ||
                           rfcuventaafianzada.producto_brilla ||
                           ' en la entidad LDC_AFIANZADO Ok.');
    exception
      when DUP_VAL_ON_INDEX then
        dbms_output.put_line('El producto ' ||
                             rfcuventaafianzada.producto_brilla ||
                             ' ya existe en la entidad LDC_AFIANZADO');
        rollback;
      when others then
        dbms_output.put_line('Fallo - No pudo registrar el producto ' ||
                             rfcuventaafianzada.producto_brilla ||
                             ' en la entidad LDC_AFIANZADO ' || sqlerrm);
        rollback;
    end;
  end loop;
  dbms_output.put_line('Fin registtro productos Venta Plan Afianzado');

end;
/
