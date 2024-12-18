column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuPolizaId			ld_policy.policy_id%type := 1196138;
	nuFeesInvoiced 		number;
    nuFeesPaid    		number;	
	nuSeqPolicyTr 		number;
	nuContratoOrigen	servsusc.sesususc%type := 1083318;
	nuContratoDestino	servsusc.sesususc%type := 66745054;
	nuProductoDestino	servsusc.sesunuse%type := 52791897;
	rgp 				ld_policy%rowtype;
	
	cursor cupoliza (nupoliza ld_policy.policy_id%type) is
    select *
    from ld_policy
    where policy_id = nupoliza;

begin
	dbms_output.put_line('Inicio OSF-2440');
  
	nuFeesInvoiced := LD_BCSecureManagement.FnuGetFessInvoiced(nuPolizaId);
    nuFeesPaid     := LD_BCSecureManagement.FnuGetFessPaid(nuPolizaId);
	
    open cupoliza(nuPolizaId);
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
    'Poliza se traslado al Contrato ' || nuContratoDestino || '. ' || rgp.comments,
    rgp.policy_exq,
    rgp.number_acta,       rgp.geograp_location_id, rgp.validity_policy_type_id,
    rgp.policy_number,     rgp.collective_number,   rgp.base_value,      rgp.porc_base_val,
    nuFeesInvoiced ,       nuFeesPaid);
	
	dbms_output.put_line('Inserta ldc_policy_trasl');

    update ld_policy
    set suscription_id     = nuContratoDestino,
		product_id         = nuProductoDestino,
        deferred_policy_id = 107902841,
        comments           = 'Poliza viene trasladada del Contrato ' || nuContratoOrigen || '. ' || comments
    where policy_id = nuPolizaId;
	
	dbms_output.put_line('Actualiza ld_policy');
  
	dbms_output.put_line('Finaliza OSF-2440');
	
	commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/