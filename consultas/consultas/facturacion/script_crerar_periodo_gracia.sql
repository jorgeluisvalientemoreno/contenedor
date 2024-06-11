declare
	cursor cuDiferidos is
	select p.package_id,
       m.subscription_id contrato,
       difenuse,
       de.difecodi,
       de.difeconc,
       de.difevatd,
       de.difesape,
       (select e.emsscoem from open.elmesesu e where e.emsssesu =m.product_id and sysdate between e.emssfein and e.emssfere) medidor
	from open.mo_packages p
	inner join open.mo_motive m on m.package_id=p.package_id and (m.subscription_id=67347382 or  m.product_id=52522476)
	inner join open.pr_product pr on pr.product_id=m.product_id and pr.product_status_id=2
	inner join open.cc_sales_financ_cond fi  on fi.package_id=p.package_id
	inner join open.diferido de on de.difecofi=fi.finan_id
	where not exists(select null from open.cc_grace_peri_defe gr where gr.deferred_id=de.difecodi)
	;
	rcCC_Grace_Peri_Defe    DACC_Grace_Peri_Defe.styCC_Grace_Peri_Defe;
	-- Codigo del periodo de gracia
    cnuPERI_GRAC_PREP          CONSTANT cc_grace_period.grace_period_id%TYPE := 47;
    -- Dias de gracia del periodo
    cnuDIAS_GRACIA             CONSTANT cc_grace_period.Max_Grace_Days%TYPE := 30;
	-- Codigo proceso FIRPG	- Registro de Periodos de Gracia por Diferido
    cnuFIRPG                    CONSTANT procesos.proccons%TYPE := 309;
begin
	for reg in cuDiferidos loop
		begin
	
			rcCC_Grace_Peri_Defe.Grace_Peri_Defe_Id :=  SEQ_CC_GRACE_PERI_D_185489.NextVal;
			rcCC_Grace_Peri_Defe.Grace_Period_id    :=  cnuPERI_GRAC_PREP;
			rcCC_Grace_Peri_Defe.Deferred_id        :=  reg.difecodi;
			rcCC_Grace_Peri_Defe.Initial_Date       :=  TRUNC(SYSDATE);
			rcCC_Grace_Peri_Defe.End_Date           :=  TRUNC(SYSDATE) + cnuDIAS_GRACIA;
			rcCC_Grace_Peri_Defe.Program            :=  cnuFIRPG;
			rcCC_Grace_Peri_Defe.Person_Id          :=  GE_BOPersonal.fnuGetPersonId;

			DACC_Grace_Peri_Defe.insRecord( rcCC_Grace_Peri_Defe );
			commit;
		exception 
		 when others then 
			rollback;
			dbms_output.put_line('Error diferido: '||reg.difecodi||' '||sqlerrm);
		end;
end;
/