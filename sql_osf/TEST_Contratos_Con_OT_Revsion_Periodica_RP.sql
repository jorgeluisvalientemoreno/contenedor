declare

  nuNumber number;

  cursor cuContratos is
    select s.susccodi
      from suscripc s
     where s.susccodi >= 6000000
       and rownum <= 5000;

  rfContratos cuContratos%rowtype;

begin

  for rfContratos in cuContratos loop
  
    /*SELECT orden
     FROM (SELECT ldcretornaotrevpersolsac(dald_parameter.fnuGetNumeric_Value('SOL_REVPER_SAC',
                                                                              0),
                                           a.items_id,
                                           rfContratos.susccodi) orden
             FROM ge_items a, ldc_activi_by_pack_type b
            WHERE a.items_id = b.activity_id
              AND b.package_type_id =
                  dald_parameter.fnuGetNumeric_Value('SOL_REVPER_SAC', 0)
              and B.ACTIVIDADES_REV_PER is not null)
    WHERE orden > 0;*/
  
    nuNumber := ldc_fnugetValidOrdeRp(rfContratos.susccodi);
  
    if nuNumber > 0 then
      dbms_output.put_line('Contrato: ' || rfContratos.susccodi);
    end if;
  
  end loop;

end;
