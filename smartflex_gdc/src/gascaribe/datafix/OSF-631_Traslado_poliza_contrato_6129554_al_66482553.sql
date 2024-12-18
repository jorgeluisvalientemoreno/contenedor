column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  --cursor para identifica polizas del producto BRILLA Seguro Origen
  cursor cuPolizas is
    select p.policy_id Poliza, p.deferred_policy_id
      from open.ld_policy p, open.diferido d
     where p.product_id = 52171832
       and p.deferred_policy_id = d.difecodi
       and p.state_policy in (1, 5);

  rg cuPolizas%rowtype;

  --cursor para identifica poliza
  cursor cupoliza(nupoliza open.ld_policy.policy_id%type) is
    select * from open.ld_policy where policy_id = nupoliza;

  rgp open.ld_policy%rowtype;

  nuSeqPolicyTr number;
  nuFeesInvoiced number;
  nuFeesPaid    number;

begin

  FOR RG IN cuPolizas LOOP
    FOR rgp IN cupoliza(rg.Poliza) LOOP

      nuFeesInvoiced := LD_BCSecureManagement.FnuGetFessInvoiced(rgp.policy_id);
      nuFeesPaid     := LD_BCSecureManagement.FnuGetFessPaid(rgp.policy_id);

      dbms_output.put_line('nuFeesInvoiced: '|| nuFeesInvoiced);
      dbms_output.put_line('nuFeesPaid: '|| nuFeesPaid);
    
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
      'Poliza se traslado al Contrato ' || 66482553 || '. ' || rgp.comments,
      rgp.policy_exq,
      rgp.number_acta,       rgp.geograp_location_id, rgp.validity_policy_type_id,
      rgp.policy_number,     rgp.collective_number,   rgp.base_value,      rgp.porc_base_val,
      nuFeesInvoiced ,       nuFeesPaid);

      update ld_policy
         set suscription_id     = 66482553,
             product_id         = 52419072,
             deferred_policy_id = rgp.deferred_policy_id,
             comments           = 'Poliza viene trasladada del Contrato ' || 6129554 || '. ' || comments
       where policy_id = rg.Poliza;

      dbms_output.put_line('Poliza '|| rg.Poliza ||' del Contrato 6129554 se traslado al Contrato 66482553');
      commit;
      --rollback;
    
    END LOOP;  
  END LOOP;

exception 
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm );

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/