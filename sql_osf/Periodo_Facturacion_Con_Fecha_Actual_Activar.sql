--Activar_Periodo_Facturacion_Con_Fecha_Actual
declare

  cursor cuperifactCantidad(InuCiclo number) is
    select count(a.pefacodi)
      from open.perifact a
     where a.pefacicl = InuCiclo
       and a.pefaactu = 'S'
     order by a.pefafimo desc;

  nuCantidad number;

  cursor cuperifact(InuCiclo number) is
    select a.*
      from open.perifact a
     where a.pefacicl = InuCiclo
       and trunc(sysdate) between a.pefafimo and a.pefaffmo
    --and a.pefaactu = 'S'
     order by a.pefafimo desc;

  rfcuperifact cuperifact%rowtype;

  /*select a.*, rowid
   from pericose a
  where a.pecscico = 6612
  order by a.pecsfeci desc;*/

  nuCiclo open.ciclo.ciclcodi%type;

begin

  nuCiclo := 8814;

  --dbms_output.put_line('Ciclo [' || nuCiclo || '] activar');

  open cuperifactCantidad(nuCiclo);
  fetch cuperifactCantidad
    into nuCantidad;
  close cuperifactCantidad;

  --dbms_output.put_line('Cantidad de periodos activios [' || nuCantidad || ']');

  if nvl(nuCantidad, 0) = 0 or nuCantidad > 1 then
    dbms_output.put_line('Exsiten [' || nuCantidad ||
                         '] periodos activos para el ciclo ' || nuCiclo ||
                         '. Validar la entidad PERIFACT');
  else
    for rfcuperifact in cuperifact(nuCiclo) loop
      if rfcuperifact.pefaactu = 'N' then
        dbms_output.put_line('Se activo periodo [' ||
                             rfcuperifact.pefacodi || '] del ciclo [' ||
                             rfcuperifact.pefacicl ||
                             '] comprendido entre la fecha inicial [' ||
                             trunc(rfcuperifact.pefafimo) || '] [' ||
                             trunc(rfcuperifact.pefaffmo) ||
                             '] con base a la fecha del sistema [' ||
                             trunc(sysdate) || ']');
        update open.perifact a
           set a.pefacodi = 'S'
         where a.pefacodi = rfcuperifact.pefacodi
           and a.pefacicl = rfcuperifact.pefacicl;
      
        commit;
      
      else
        begin
        
          dbms_output.put_line('Este ciclo ya tiene periodo [' ||
                               rfcuperifact.pefacodi || '] del ciclo [' ||
                               rfcuperifact.pefacicl ||
                               '] activo entre la fecha inicial [' ||
                               trunc(rfcuperifact.pefafimo) || '] [' ||
                               trunc(rfcuperifact.pefaffmo) ||
                               '] con base a la fecha del sistema [' ||
                               trunc(sysdate) || ']');
        exception
          when others then
            dbms_output.put_line('Error al actualizar periodo ' ||
                                 rfcuperifact.pefacodi);
        end;
      end if;
    end loop;
  end if;

end;
