declare

  nureal open.OR_OPERATING_UNIT.USED_ASSIGN_CAP%type;

  cursor cuUnidades is
    SELECT sysdate hora,
           unidad,
           (SELECT U.USED_ASSIGN_CAP
              FROM OPEN.OR_OPERATING_UNIT U
             WHERE U.OPERATING_UNIT_ID = UNIDAD) CAPAC_USADA,
           REAL_USADA
      FROM (SELECT OPERATING_UNIT_ID UNIDAD,
                   SUM(NVL(OPEN.OR_BCOptimunRoute.fnuCalcularDuracion(O.ORDER_ID) / 60,
                           0)) REAL_USADA
              FROM OPEN.OR_ORDER O
             WHERE ORDER_STATUS_ID IN (5, 6, 7)
              AND O.OPERATING_UNIT_ID in (3633)
             GROUP BY O.OPERATING_UNIT_ID);

begin
  for rg in cuUnidades loop
    if rg.REAL_USADA > 0 and rg.REAL_USADA != rg.CAPAC_USADA then
      /*update or_operating_unit
         set used_assign_Cap = rg.REAL_USADA
       where operating_unit_id = rg.unidad;
      commit;*/
      dbms_output.put_line('Hora ' || rg.hora || ' - Unidad ' || rg.unidad ||
                           ' - Capac Tabla ' || rg.CAPAC_USADA ||
                           ' - Real Usada ' || rg.REAL_USADA);
    end if;
  end loop;

  dbms_output.put_line('EL PROCESO TERMINO CORRECTAMENTE');
exception
  when others then
    rollback;
    dbms_output.put_line('Error ' || sqlerrm);
end;
/
