declare
    nuError      number;
    sbMessage    varchar2(2000);
    nuUnitOper   number;
    nuCausal     number;
    rcOrder      daor_order.styor_order;
    nucant       number;
    nuwidx  number;
      nuwpoli number;
      nuwdfan number;
      nuwdfnu  number;
    ----------------

    inususcori  ge_boInstanceControl.stysbValue;
    inunuseori  ge_boInstanceControl.stysbValue;
    inususcdes  ge_boInstanceControl.stysbValue;
    inunusedes   ge_boInstanceControl.stysbValue;


   ----------------

    nudifecodi   diferido.difecodi%type;
    nudifecofi   diferido.difecofi%type;
    nudifenucu   diferido.difenucu%type;
    sbdifenudo   diferido.difenudo%type;
    sbmodidoso   movidife.modidoso%type;
    procesado    varchar2(1);

    sbProg       varchar2(4) := 'FTCS';
    sbUser       varchar2(200);
    sbTerm       varchar2(200);
    nuPerson     number;
    nuCausTras   number      :=  dald_parameter.fnuGetNumeric_Value('CAUSCAR_TRANSF_CARTERA');
    nuCausCanc   number      :=  dald_parameter.fnuGetNumeric_Value('CAUSCAR_CANC_DIFERIDO');
    nuccante     cuencobr.cucocodi%type;
    nuRegs       number;
    nuFeesInvoiced number;
    nuFeesPaid    number;
    nuSeqPolicyTr number;
    nudifepoliza  diferido.difecodi%type;

    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    sbLineLog        varchar2(1000) :=null;

    cursor cuProductos (nuprodori servsusc.sesunuse%type, nuproddes servsusc.sesunuse%type) is
      select count(1)
        from servsusc
       where sesunuse in (nuprodori, nuproddes)
         and sesuserv =7053;

    cursor cuDiferidos is
     select *
       from diferido
      where difenuse=inunuseori
        and difesape > 0;

    cursor cuCuentas is
     select cucocodi,cucovato,cucovaab,cucosacu,cucofeve
       from cuencobr
      where cuconuse=inunuseori
        and cucosacu > 0
      order by cucocodi;

    cursor cuPolizas is
     select p.policy_id, p.deferred_policy_id, fnuPolizaPend(inunuseori,p.deferred_policy_id) saldoen
      from ld_policy  p , diferido d
     where p.product_id = inunuseori
       and p.deferred_policy_id = d.difecodi
       and p.state_policy in (1,5);

    cursor cupoliza (nupoliza ld_policy.policy_id%type) is
     select *
      from ld_policy
     where policy_id=nupoliza;

    rgp ld_policy%rowtype;

  cursor cuCargos (nucuco cuencobr.cucocodi%type) is
   select cargcuco,cargconc,sum(decode(cargsign,'DB',cargvalo,-cargvalo)) cargvalo
     from cargos
    where cargcuco=nucuco
      and cargsign not in ('PA','SA','AS')
  group by cargcuco,cargconc;

  BEGIN
      /*obtener los valores ingresados en la aplicacion PB */
    inususcori := 6129554;--ge_boInstanceControl.fsbGetFieldValue('SUSCRIPC','SUSCCODI');
    inunuseori := 6129554;--ge_boInstanceControl.fsbGetFieldValue('SERVSUSC', 'SESUNUSE');
    inususcdes := 66482553;-- ge_boInstanceControl.fsbGetFieldValue('SERVSUSC', 'SESUSUSC');
    inunusedes := ;--ge_boInstanceControl.fsbGetFieldValue('CONSSESU', 'COSSSESU');

    procesado := 'N';

    -- valida que los productos sean de seguro brilla
    open cuProductos (inunuseori, inunusedes);
    fetch cuProductos into nucant;
    if cuProductos%notfound then
      nucant := 0;
    end if;
    close cuProductos;

    if nvl(nucant,0) != 2 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Al menos uno de los productos no es de Seguros Brilla');
      return;
    end if;

    -- guarda en tabla en memoria los diferidos de las polizas activas o renovadas con saldo
    tdife.delete;
    for rg in cuPolizas loop
      if rg.saldoen in ('D','C') then
       sbidxdif := rg.deferred_policy_id;
       tdife(sbidxdif).poli := rg.policy_id;
       tdife(sbidxdif).dfan := rg.deferred_policy_id;
       tdife(sbidxdif).dfnu := null;
       tdife(sbidxdif).sden := rg.saldoen;
      end if;
    end loop;

    -- cancela diferidos en ori y crea en des
    for rg in cuDiferidos loop
      procesado := 'S';
      -- Obtiene proximo numero de diferido y de financiacion
      pkDeferredMgr.GetNewDefNumber(nudifecodi);
      pkDeferredMgr.nuGetNextFincCode(nudifecofi);

      nudifenucu := rg.difenucu - rg.difecupa;
      sbdifenudo := 'TC'||rg.difecodi;


      -- Obtiene usuario funcionario y terminal
      sbUser       := pkGeneralServices.fsbGetUserName;
      sbTerm       := pkGeneralServices.fsbGetTerminal;
     -- nuPerson     := GE_BOPersonal.fnuGetPersonId;

      select funccodi into nuPerson from FUNCIONA where funcusba=sbUser;


      sbmodidoso := 'DF-'||nudifecodi;
      -- crea nuevo diferido en contrato destino
      insert into diferido (difecodi,    difesusc,     difeconc,    difevatd,    difevacu,
                            difecupa,    difenucu,     difesape,    difenudo,    difeinte,
                            difeinac,    difeusua,     difeterm,    difesign,    difenuse,
                            difemeca,    difecoin,     difeprog,    difepldi,    difefein,
                            difefumo,    difespre,     difetain,    difefagr,    difecofi,
                            difetire,    difefunc,     difelure,    difeenre)
                    values (nudifecodi,  inususcdes,   rg.difeconc, rg.difesape, rg.difevacu,
                            0,           nudifenucu,   rg.difesape, sbdifenudo,  rg.difeinte,
                            rg.difeinac, sbUser,       sbTerm,      rg.difesign, inunusedes,
                            rg.difemeca, rg.difecoin,  sbProg,      rg.difepldi, sysdate,
                            sysdate,     rg.difespre,  rg.difetain, rg.difefagr, nudifecofi,
                            rg.difetire, nuPerson,     rg.difelure, rg.difeenre);

      insert into movidife (modidife,   modisusc,    modisign,   modifech,   modifeca,
                            modicuap,   modivacu,    modidoso,   modicaca,   modiusua,
                            moditerm,   modiprog,    modinuse,   modidiin,   modipoin,
                            modivain,   modicodo)
                    values (nudifecodi, inususcdes, 'DB',        sysdate,    sysdate,
                            0,          rg.difesape, sbmodidoso, nuCausTras, sbUser,
                            sbTerm,     sbProg,      inunusedes, 0,          0,
                            0,          null);

       -- cancela diferido en contrato anterior
       update diferido
          set difecupa = rg.difenucu,
              difesape = 0,
              difefumo = sysdate
        where difecodi = rg.difecodi;

        sbmodidoso := 'Ca-'||rg.difecodi;
        insert into movidife (modidife,   modisusc,    modisign,   modifech,   modifeca,
                            modicuap,     modivacu,    modidoso,   modicaca,   modiusua,
                            moditerm,     modiprog,    modinuse,   modidiin,   modipoin,
                            modivain,     modicodo)
                    values (rg.difecodi,  inususcori,  'CR',        sysdate,    sysdate,
                            rg.difenucu,  rg.difesape, sbmodidoso, nuCausCanc, sbUser,
                            sbTerm,     sbProg,      inunuseori, 0,          0,
                            0,          null);

       -- guarda el nuevo diferido de la poliza
       sbidxdif := rg.difecodi;
       if tdife.exists(sbidxdif) then
         tdife(sbidxdif).dfnu := nudifecodi;
       end if;

    end loop;

    -- cancela cuentas con saldo en ori y crea en des
    FOR rg in cucuentas LOOP
     procesado := 'S';
     tcargo.delete;
     tpagos.delete;
     -- si cta pagada parcialmente halla los pagos aplicados a cada concepto
     if rg.cucovaab != 0 then
       LDC_PKTRASFNB.detpagos(rg.cucocodi,rg.cucofeve);
     end if;
     nucuentaori := rg.cucocodi;
     for rgc in cucargos(rg.cucocodi) loop
      if rgc.cargvalo != 0 then
       nuindice := rgc.cargconc;
       tcargo(nuindice).cuco := rg.cucocodi;
       tcargo(nuindice).conc := rgc.cargconc;
       tcargo(nuindice).valo := rgc.cargvalo - GetPagoConcepto(rgc.cargconc);
      end if;
     end loop;

     if tcargo.count > 0 then
       nuTipo := 1;
       nuSuscripcion := inususcdes;
       nuServsusc    := inunusedes;
       Generate (nuErrorCode,sbErrorMessage);

       if nuErrorCode != 0 then
          sbLineLog := nuErrorCode || ' - ' || sbErrorMessage;
          rollback;
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbLineLog);
       else
         nuTipo := 2;
         nuSuscripcion := inususcori;
         nuServsusc    := inunuseori;
         nucuentades := nuCuenta;
         Generate (nuErrorCode,sbErrorMessage);

         if nuErrorCode != 0 then
            sbLineLog := nuErrorCode || ' - ' || sbErrorMessage;
            rollback;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbLineLog);
         end if;
       end if;
     end if;
    END LOOP;

   -- crea poliza_trasl y actualiza ld_policy
    nuRegs   := tdife.count;
    sbidxdif := tdife.first;

   IF procesado = 'S' THEN
    FOR i IN 1 .. nuRegs LOOP
      nuFeesInvoiced := LD_BCSecureManagement.FnuGetFessInvoiced(tdife(sbidxdif).poli);
      nuFeesPaid     := LD_BCSecureManagement.FnuGetFessPaid(tdife(sbidxdif).poli);
      if tdife(sbidxdif).sden = 'D' then
        nudifepoliza := tdife(sbidxdif).dfnu;
      else
        nudifepoliza := tdife(sbidxdif).dfan;
      end if;

      open cupoliza(tdife(sbidxdif).poli);
      fetch cupoliza into rgp;
      close cupoliza;

      nuSeqPolicyTr := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_POLICY_TRASL');

      insert into ldc_policy_trasl  VALUES
      (nuSeqPolicyTr,        rgp.policy_id,          rgp.state_policy,    rgp.launch_policy,
      rgp.contratist_code,   rgp.product_line_id,    rgp.dt_in_policy,    rgp.dt_en_policy,
      rgp.value_policy,      rgp.prem_policy ,       rgp.name_insured,    rgp.suscription_id,
      rgp.product_id,        rgp.identification_id,  rgp.period_policy,   rgp.year_policy,
      rgp.month_policy,      rgp.deferred_policy_id, rgp.dtcreate_policy, rgp.share_policy,
      rgp.dtret_policy,      rgp.valueacr_policy,    rgp.report_policy,   rgp.dt_report_policy,
      rgp.dt_insured_policy, rgp.per_report_policy,  rgp.policy_type_id,  rgp.id_report_policy,
      rgp.cancel_causal_id,  rgp.fees_to_return,
      'Poliza se traslado al Contrato ' || inususcdes || '. ' || rgp.comments,
      rgp.policy_exq,
      rgp.number_acta,       rgp.geograp_location_id, rgp.validity_policy_type_id,
      rgp.policy_number,     rgp.collective_number,   rgp.base_value,      rgp.porc_base_val,
      nuFeesInvoiced ,       nuFeesPaid);

      update ld_policy
         set suscription_id     = inususcdes,
             product_id         = inunusedes,
             deferred_policy_id = nudifepoliza,
             comments           = 'Poliza viene trasladada del Contrato ' || inususcori || '. ' || comments
       where policy_id = tdife(sbidxdif).poli;

      sbidxdif := tdife.next(sbidxdif);
    END LOOP;
   END IF;

   tcargo.delete;
   tdife.delete;

   --commit;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

    when others then
      rollback;
      Errors.setError;
      raise ex.CONTROLLED_ERROR;


end;
/
