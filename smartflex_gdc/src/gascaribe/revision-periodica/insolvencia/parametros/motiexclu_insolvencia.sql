declare

  cursor cuparametroexiste(IsbParametro ldc_pararepe.parecodi%type) is
    select count(1) from ldc_pararepe lp where lp.parecodi = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro INSOLVENCIA/CONTRATOS ESPEJOS
  nuexisteparametro := 0;
  open cuparametroexiste('MOTIEXCLU_INSOLVENCIA');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ldc_pararepe
      (parecodi, paradesc, parevanu, paravast)
    values
      ('MOTIEXCLU_INSOLVENCIA',
       'MOTIVO PARA EXCLUSION POR INSOLVENCIA OSF-582',
       NULL,
       'INSOLVENCIA/CONTRATOS ESPEJOS');
    commit;
    dbms_output.put_line('Parametro MOTIEXCLU_INSOLVENCIA creado...');
  else
    dbms_output.put_line('Parametro MOTIEXCLU_INSOLVENCIA ya existe...');
  end if;
  close cuparametroexiste;

END;
/
