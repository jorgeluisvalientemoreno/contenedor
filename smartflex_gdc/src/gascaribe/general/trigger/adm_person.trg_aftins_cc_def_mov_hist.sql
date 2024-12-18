CREATE OR REPLACE TRIGGER ADM_PERSON.trg_AftIns_CC_Def_Mov_Hist
AFTER INSERT ON CC_DEFERRED_MOVS_HIST
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  trg_AftIns_CC_Def_Mov_Hist

  Descripcion  :

  Autor  : F.Castro
  Fecha  : 26-06-2017

    Historia de Modificaciones
    21/10/2024  jpinedc     OSF-3450    Se migra a ADM_PERSON    
  **************************************************************/

DECLARE
nuservori      servsusc.sesuserv%type;
nuservdes      servsusc.sesuserv%type;
nusesuori   servsusc.sesunuse%type;
nusesudes   servsusc.sesunuse%type;
sbservfnb   ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('COD_SERVFINBRPRO');

cursor cuServicio (nudife diferido.difecodi%type) is
   select sesunuse, sesuserv
     from diferido, servsusc
    where difecodi =  nudife
      and difenuse=sesunuse;

cursor cuOrdenes (nunuse servsusc.sesunuse%type) is
select o.order_id, oa.activity_id
  from or_order o, or_order_Activity oa
 where o.order_id = oa.order_id
   and oa.subscription_id = (select sesususc from servsusc where sesunuse=nunuse)
   and o.order_status_id not in (8,12)
   and o.task_type_id in (select *
                             from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TT_A_CREAR_POR_TRASL_FNB'), '|')));

BEGIN
  -- halla producto origen
  open cuServicio (:new.origin_deferred_id);
  fetch cuServicio into nusesuori, nuservori;
  close cuServicio;

  -- halla producto destino
  open cuServicio (:new.final_deferred_id );
  fetch cuServicio into nusesudes, nuservdes;
  close cuServicio;

   -- SI ES PRODUCTO DE BRILLA EVALUA SI DEBE BLOQUEAR CUPO
  if PKEXPREG.fnuInStr(nuservori,sbservfnb) > 0 then
    if LDC_PKTRASFNB.fsbEvaluateBloqCupoTrasl(nusesuori) = 'Y' then
      LDC_PKTRASFNB.prBloqCupoFNB(nusesuori,nusesudes);
    end if;

    for rg in cuOrdenes (nusesuori) loop
      LDC_PKTRASFNB.prLegOrdenesporTrFnb(rg.order_id,'SE CIERRA POR TRASLADO DE DEUDA AL PRODUCTO ' || nusesudes);
      --if nuOk then
        LDC_PKTRASFNB.prCreOrdenesporTrFnb(nusesudes,rg.activity_id,'SE CREA POR TRASLADO DE DEUDA DEL PRODUCTO ' || nusesuori);
      --end if;
    end loop;

  end if;


EXCEPTION WHEN OTHERS THEN

  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Error en trg_AftIns_CC_Def_Mov_Hist: ' || sqlerrm);

END trg_AftIns_CC_Def_Mov_Hist;
/
