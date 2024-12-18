CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGRGCOMABI
 BEFORE INSERT OR UPDATE OR DELETE ON LDC_RGCOMA FOR EACH ROW

/*******************************************************************************
    Propiedad intelectual de GDC

    Trigger   : LDC_TRGRGCOMABI

    Descripcion  : Trigger para validar los datos digitados en el MD LDCRGCOMA para actualizar la tabla LDCRGCOMA y asigna consecutivo
                   de la tabla y halla usuario fecha y maquina
                   Ademas restringe que no s epeuda modificar producto o periodo, y que las modificaciones o borrado de registros se
                   realicen antes de n minutos (paametro nuMinMod) de haber sido ingresados

    Autor     : HB
    Fecha     : 15/03/2021

    Historia de Modificaciones
    Fecha           Autor       ID Entrega      Modificacion
    18/10/2024      jpinedc     OSF-3383        Se migra a ADM_PERSON
*******************************************************************************/

DECLARE

 nuProducto servsusc.sesunuse%type;
 numedidor  elmesesu.emsselme%type;
 nuperiodo  perifact.pefacodi%type;
 sbuser     LDC_RGCOMA.cossusua%type;
 sbmaquina  LDC_RGCOMA.cossterm%type;
 nuMinMod   CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('NRO_MIN_MOD_REGCOMA');
 nuMesAnt   CONSTANT ld_parameter.numeric_value%TYPE := Dald_parameter.fnuGetNumeric_Value('NRO_MESANT_ING_REGCOMA');

 cursor cuProducto (nuprod servsusc.sesunuse%type) is
    select sesunuse
      from servsusc
     where sesunuse = nuprod
       and sesuserv = 7014;

   cursor cumedidor (nuprod servsusc.sesunuse%type, nuelme elmesesu.emsselme%type) is
    select e.emsselme
      from elmesesu e
     where e.emsssesu = nuprod
       and e.emsselme = nuelme;

   cursor cuperifact (nuprod servsusc.sesunuse%type, nupefa perifact.pefacodi%type) is
    select pefacodi
      from perifact e
     where pefacodi = nupefa
       and pefacicl = (select sesucicl from servsusc where sesunuse=nuprod)
       and pefafimo < sysdate  -- periodo no posterior
       and pefafimo > add_months(Sysdate,-nuMesAnt); -- de 6 meses hacia aca



BEGIN

  IF INSERTING THEN
    -- valida si producto es de gas
    open cuProducto(:new.cosssesu);
    fetch cuProducto into nuproducto;
    if cuProducto%notfound then
      nuproducto := -1;
    end if;
    close cuProducto;

    if nvl(nuproducto,-1) = -1 then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El producto no existe o no es de Gas' );
    end if;

    -- valida si el elemento de medicion es del producto
    open cumedidor(:new.cosssesu, :new.cosselme);
    fetch cumedidor into numedidor;
    if cumedidor%notfound then
      numedidor := -1;
    end if;
    close cumedidor;

    if nvl(numedidor,-1) = -1 then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El medidor no existe o no pertenece al producto' );
      Raise ex.controlled_error;
    end if;


    -- valida que el periodo no sea posterior a la fecha actual
    open cuperifact(:new.cosssesu, :new.cosspefa);
    fetch cuperifact into nuperiodo;
    if cuperifact%notfound then
      nuperiodo := -1;
    end if;
    close cuperifact;

    if nvl(nuperiodo,-1) = -1 then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El periodo no es del ciclo del producto, o es de mas de ' || nuMesAnt || ' meses atras o posterior a la fecha actual' );
    end if;

    -- Busca usuario y maquina
    select MACHINE, USERNAME
      into sbmaquina, sbuser
      from V$SESSION
     where sid=(select sys_context('USERENV','SID') from dual);

    -- Halla consecutivo
    :new.cosscons := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_CM_CONSMANUAL');

    -- Asigna columnas
     :new.cossusua := sbuser;
     :new.cossfech := sysdate;
     :new.cossterm := sbmaquina;
  ELSE
    IF ((sysdate - :old.cossfech) * 24 * 60) > nuMinMod then
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Ya no puede modificar o eliminar el registro');
    ELSE
      IF UPDATING THEN
        if :old.cosssesu != :new.cosssesu or :old.cosspefa != :new.cosspefa then
          :new.cosssesu := :old.cosssesu;
          :new.cosspefa := :old.cosspefa;
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'No ¿puede modificar el producto o el periodo ... debe eliminar el registro');
        end if;
      END IF;
    END IF;
  END IF;


EXCEPTION
  WHEN  EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END LDC_TRGRGCOMABI;
/
