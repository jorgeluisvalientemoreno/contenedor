CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGRGCOMAAI
 AFTER INSERT OR UPDATE OR DELETE ON LDC_RGCOMA
 REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW

/*******************************************************************************
    Propiedad intelectual de GDC

    Trigger   : LDC_TRGRGCOMAAI

    Descripcion  : Trigger para ingresar los consumos en la tabla CONSSESU y el log de quien y en que maquina
                   se hicieron los ingresos, modificacions o eliminaciones de registros.

    Autor     : HB
    Fecha     : 15/03/2021

    Historia de Modificaciones
    Fecha        Autor      ID Entrega      Modificacion
    18/10/2024   jpinedc    OSF-3383        Se migra a ADM_PERSON
*******************************************************************************/

DECLARE

nupecs   pericose.pecscons%type;
nufaco number  := -1;
nufacosesu number := -1;
nufacoloca number := -1;
nulocalidad number := -1;
nucossmecc conssesu.cossmecc%type;

nuRegla    CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_REGLA_REGCOMA');
nuCalifAVC CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_CALIF_AVC_REGCOMA');
sbfufa    CONSTANT ld_parameter.value_chain%TYPE   :=  Dald_parameter.fsbGetValue_Chain('COD_FUNCCALC_REGCOMA');

cursor cupericose (nupefa perifact.pefacodi%type) is
 SELECT PC.PECSCONS
   FROM PERIFACT, PERICOSE PC
  WHERE PC.PECSFECF BETWEEN PEFAFIMO AND PEFAFFMO
    AND PC.PECSCICO = PEFACICL
    AND PEFACODI=nupefa;

cursor cufacosesu (inunuse number, inupecs number) is
 select t.fccocons
   from open.cm_facocoss t
  where t.fccosesu = inunuse
    and t.fccopecs = inupecs;

cursor cufacoLOCA (inuloca number, inupecs number) is
 select t.fccocons
   from open.cm_facocoss t
  where t.fccoubge = inuloca
    and t.fccopecs = inupecs
    and rownum=1;

cursor culocalidad (inunuse number) is
 select d.geograp_location_id
   from open.pr_product p, open.ab_Address d
  where p.address_id = d.address_id
    and p.product_id = inunuse;

cursor cuCons (inunuse number, inupecs number) is
 select *
   from conssesu c
  where c.cosssesu =  inunuse
    and c.cosspecs = inupecs;



BEGIN

IF INSERTING THEN
  -- halla periodo de consumo
  open cupericose (:new.cosspefa);
  fetch cupericose into nupecs;
  if cupericose%notfound then
    nupecs := -1;
  end if;
  close cupericose;

    -- halla factor de correccion
  open cufacosesu (:new.cosssesu, nupecs);
  fetch cufacosesu into nufacosesu;
  if cufacosesu%notfound or nvl(nufacosesu,-1) < 0 then
    nufacosesu := -1;
  end if;
  close cufacosesu;

  if  nufacosesu = -1 then
     open cuLocalidad (:new.cosssesu);
     fetch cuLocalidad into nulocalidad;
     if cuLocalidad%notfound then
       nulocalidad := -1;
     end if;
     close cuLocalidad;

  if nulocalidad != -1 then
      open cufacoLOCA (nulocalidad,nupecs);
      fetch cufacoLOCA into nufacoloca;
      if cufacoLOCA%notfound or nvl(nufacoloca,-1) < 0 then
        nufacoloca := -1;
      end if;
      close cufacoLOCA;
    end if;
  end if;

  if nufacosesu != -1 then
    nufaco := nufacosesu;
  elsif nufacoloca != -1 then
    nufaco := nufacoloca;
  else
    nufaco := -1;
  end if;


  if nufaco =  -1 then
    nufaco := null;
  end if;

  if nufaco != -1 then
    -- ingresa en conssesu
      insert into conssesu (cosssesu,         cosstcon,     cosspefa,       cosscoca,       cossnvec,
                            cosselme,         cossmecc,     cossflli,       cosspfcr,       cossdico,
                            cossidre,         cosscmss,     cossfere,       cossfufa,       cosscavc,
                            cossfunc,         cosspecs,     cosscons,       cossfcco)

                    values (:new.cosssesu,    1,            :new.cosspefa,  :new.cosscoca,  0,
                            :new.cosselme,    1,            'N',            null,          :new.cossdico,
                            nuRegla,          null,         :new.cossfere,  sbfufa,        nuCalifAVC,
                            1,                nupecs,       null,           nufaco);

      insert into conssesu (cosssesu,         cosstcon,     cosspefa,       cosscoca,       cossnvec,
                            cosselme,         cossmecc,     cossflli,       cosspfcr,       cossdico,
                            cossidre,         cosscmss,     cossfere,       cossfufa,       cosscavc,
                            cossfunc,         cosspecs,     cosscons,       cossfcco)

                    values (:new.cosssesu,    1,            :new.cosspefa,  :new.cosscoca,  NULL,
                            :new.cosselme,    4,            :new.cossflli,  null,          :new.cossdico,
                            nuRegla,          null,         :new.cossfere,  sbfufa,        nuCalifAVC,
                            1,                nupecs,       null,           nufaco);

   -- ingresa en tabla de log
      insert into LDC_RGCOMA_LOG values ('I', :new.cosscons, :new.cosssesu, :new.cosspefa, :new.cosscoca, :new.cosselme, :new.cossflli,
                                              :new.cossdico, :new.cossfere, :new.cossusua, :new.cossfech, :new.cossterm);
  end if;

ELSE
  IF UPDATING THEN
    update conssesu
       set cosscoca = :new.cosscoca,
           cosselme = :new.cosselme,
           cossflli = 'N',
           cossdico = :new.cossdico,
           cossfere = :new.cossfere
    where cosssesu =  :old.cosssesu
      and cosspefa =  :old.cosspefa
      and cossfunc =  1
      and cossmecc =  1
      and cosscoca = :old.cosscoca
      and cossfere = :old.cossfere;

    update conssesu
       set cosscoca = :new.cosscoca,
           cosselme = :new.cosselme,
           cossflli = :new.cossflli,
           cossdico = :new.cossdico,
           cossfere = :new.cossfere
    where cosssesu =  :old.cosssesu
      and cosspefa =  :old.cosspefa
      and cossfunc =  1
      and cossmecc =  4
      and cosscoca = :old.cosscoca
      and cossfere = :old.cossfere;

   -- ingresa en tabla de log
      insert into LDC_RGCOMA_LOG values ('U', :new.cosscons, :new.cosssesu, :new.cosspefa, :new.cosscoca, :new.cosselme, :new.cossflli,
                                              :new.cossdico, :new.cossfere, :new.cossusua, :new.cossfech, :new.cossterm);

ELSE
  IF DELETING THEN
    delete
      from conssesu
     where cosssesu =  :old.cosssesu
       and cosspefa =  :old.cosspefa
       and cossfunc =  1
       and cossmecc in (1,4)
       and cosscoca = :old.cosscoca
       and cossfere = :old.cossfere;

      -- ingresa en tabla de log
      insert into LDC_RGCOMA_LOG values ('D', :old.cosscons, :old.cosssesu, :old.cosspefa, :old.cosscoca, :old.cosselme, :old.cossflli,
                                              :old.cossdico, :old.cossfere, :old.cossusua, :old.cossfech, :old.cossterm);

  END IF;
 END IF;
END IF;

EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END LDC_TRGRGCOMAAI;
/
