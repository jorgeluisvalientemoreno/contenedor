DECLARE

  cursor cuMuestraRequerida is
    select * from LDC_GRUPO lg where lg.GRUPMURE is null;

  rfMuestraRequerida cuMuestraRequerida%rowtype;

  nuConta number;
BEGIN

  for rfMuestraRequerida in cuMuestraRequerida loop
  
    begin
    
      update LDC_GRUPO lg
         set lg.GRUPMURE = rfMuestraRequerida.gruptamu
       where lg.grupcodi = rfMuestraRequerida.grupcodi;
    
      commit;
    
      dbms_output.put_line('Se actualiza en el grupo [' ||
                           rfMuestraRequerida.grupcodi ||
                           '] el valor del nuevo campo MUESTRAS REQUERIDAS con el valor [' ||
                           rfMuestraRequerida.gruptamu ||
                           '] existente del campo TAMANO DE LA MUESTRA');
    
    exception
    
      when others then
        rollback;
        dbms_output.put_line('Error al actualizar en el grupo [' ||
                             rfMuestraRequerida.grupcodi ||
                             '] el valor del nuevo campo MUESTRAS REQUERIDAS con el valor [' ||
                             rfMuestraRequerida.gruptamu ||
                             '] existente del campo TAMANO DE LA MUESTRA - ' ||
                             sqlerrm);
    end;
  
  end loop;

END;
/