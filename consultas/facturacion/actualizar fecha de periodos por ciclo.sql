declare

    v_ciclo       varchar2(50);
    v_pefacodi    perifact.pefacodi%type;
    
begin
   
    v_ciclo := '&ciclo_input';

    update perifact
    set pefaactu = 'N'
    where pefacicl = v_ciclo
    and pefaactu = 'S';

    select pefacodi
    into v_pefacodi
    from perifact
    where pefacicl = v_ciclo
    and trunc(sysdate) between trunc(pefafimo) and trunc(pefaffmo)
    and rownum = 1; 
    
    update perifact
    set pefaactu = 'S'
    where pefacodi = v_pefacodi;

   -- commit;

    dbms_output.put_line('actualización completada para el ciclo ' || v_ciclo);
    
exception
    when no_data_found then
        dbms_output.put_line('no se encontró un periodo válido para la fecha actual.');
    when others then
        dbms_output.put_line('ocurrió un error: ' || sqlerrm);
        
end;

