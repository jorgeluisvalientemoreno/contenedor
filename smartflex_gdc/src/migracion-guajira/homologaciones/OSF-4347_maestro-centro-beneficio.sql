begin
    insert into ldci_centrobenef
    with base as(
    select '6101' as codigo, 'RIOHACHA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6102' as codigo, 'MAICAO' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6103' as codigo, 'DISTRACCION' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6104' as codigo, 'URUMITA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6105' as codigo, 'LA JAGUA DEL PILAR' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6106' as codigo, 'DIBULLA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6107' as codigo, 'URIBIA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6108' as codigo, 'MANAURE' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6109' as codigo, 'HATONUEVO' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6110' as codigo, 'ALBANIA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6111' as codigo, 'BARRANCAS' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6112' as codigo, 'FONSECA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6113' as codigo, 'SAN JUAN DEL CESAR' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6114' as codigo, 'EL MOLINO' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6115' as codigo, 'VILLANUEVA' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6900' as codigo, 'Central General GDGU' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6992' as codigo, 'Ajustes Colgaap GDGU' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6999' as codigo, 'Cierre FI-GDGU' as descripcion, 'GDGU06100' as segmento, '' as bloqueado from dual union all
    select '6802' as codigo, 'DIVIDENDOS MANIZALES' as descripcion, '' as segmento, '' as bloqueado from dual union all
    select '6801' as codigo, 'DIVIDENDOS BARRANQUI' as descripcion, '' as segmento, '' as bloqueado from dual
    )
    select *
    from base
    where not exists(select null from open.ldci_centrobenef c where c.cebecodi=base.codigo and c.cebedesc=base.descripcion) ;
    dbms_output.put_line('Se insertaron '||sql%rowcount||' registros');
    commit;
exception
  when others then
    rollback;
    dbms_output.put_line('Error '||sqlerrm);


end;
/