CREATE OR REPLACE TRIGGER ADM_PERSON.trg_AftIns_TRCASESU
AFTER  INSERT ON TRCASESU
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  trg_AftIns_TRCASESU

  Descripcion  :

  Autor  : F.Castro
  Fecha  : 26-06-2017

    Historia de Modificaciones
    21/10/2024  jpinedc     OSF-3450    Se migra a ADM_PERSON
  **************************************************************/

DECLARE
nuserv      servsusc.sesuserv%type;
sbservfnb   ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO');

cursor cuServicio (nuprod servsusc.sesunuse%type) is
   select sesuserv
     from servsusc
    where sesunuse = nuprod;

cursor cuOrdenes (nunuse servsusc.sesunuse%type) is
select o.order_id, oa.activity_id
  from or_order o, or_order_Activity oa
 where o.order_id = oa.order_id
   and oa.subscription_id = (select sesususc from servsusc where sesunuse=nunuse)
   and o.order_status_id not in (8,12)
   and o.task_type_id in (select *
                             from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TT_A_CREAR_POR_TRASL_FNB'), '|')));

BEGIN

  open cuServicio (:new.tcsessfu);
  fetch cuServicio into nuserv;
  close cuServicio;

   -- SI ES PRODUCTO DE BRILLA EVALUA SI DEBE BLOQUEAR CUPO Y SI DEBE CERRAR ORDENES Y CREARLAS EN EL PRODUCTO DESTINO
  if PKEXPREG.fnuInStr(nuserv,sbservfnb) > 0 then
    if LDC_PKTRASFNB.fsbEvaluateBloqCupoTrasl(:new.tcsessfu) = 'Y' then
      LDC_PKTRASFNB.prBloqCupoFNB(:new.tcsessfu,:new.tcsessde);
    end if;

    for rg in cuOrdenes (:new.tcsessfu) loop
      LDC_PKTRASFNB.prLegOrdenesporTrFnb(rg.order_id,'SE CIERRA POR TRASLADO DE DEUDA AL PRODUCTO ' || :new.tcsessde);
      --if nuOk then
        LDC_PKTRASFNB.prCreOrdenesporTrFnb(:new.tcsessde,rg.activity_id,'SE CREA POR TRASLADO DE DEUDA DEL PRODUCTO ' || :new.tcsessfu);
      --end if;
    end loop;

  end if;

EXCEPTION WHEN OTHERS THEN

  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Error en trg_AftIns_TRCASESU: ' || sqlerrm);


END trg_AftIns_TRCASESU;
/
