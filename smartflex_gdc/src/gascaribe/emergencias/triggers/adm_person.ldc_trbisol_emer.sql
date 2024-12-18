CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRBISOL_EMER
  BEFORE INSERT ON mo_motive
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
DECLARE
  nuPackageTypeId    mo_packages.package_type_id%type;
  sbCausalesXTramite open.ld_parameter.value_chain%type:=open.dald_parameter.fsbGetValue_Chain('CAUSAL_EMER_NOTIF_X_TIPO_TRAM', NULL);
  nuCausal           open.mo_motive.causal_id%type;
  dtRequest          open.mo_packages.request_date%type;
  sbComment          open.mo_packages.comment_%type;
  nuExiste           number;
  sbJob              varchar2(4000);
  nuError            number;
  sbError            varchar2(4000);
  sbInstance         varchar2(32767);
  v_out              number := 1;


  cursor cuValCausXTrami is
  select count(1)
  from (
  SELECT to_number(substr(column_value,1,instr(column_value,':')-1)) nuTram, to_number(substr(column_value,instr(column_value,':')+1))  nuCausalCon
        from table (ldc_boutilities.SPLITstrings(sbCausalesXTramite,'|')))
  WHERE nuTram = nuPackageTypeId
    AND nuCausalCon=nvl(nuCausal,-1);

    cursor cuSolicitud is
    select package_Type_id,
           request_date,
           comment_
      from open.mo_packages
      where package_id= :new.package_id;



BEGIN
  if fblaplicaentregaxcaso('OSF-113') then
    ut_trace.trace('INICIA LDC_TRBISOL_EMER',99);
    ut_trace.trace('LDC_TRBISOL_EMER->nuPackageTypeId:'||nuPackageTypeId,99);
    begin
		    IF cuSolicitud%ISOPEN THEN
          CLOSE cuSolicitud;
        END IF;
        OPEN cuSolicitud;
        FETCH cuSolicitud INTO nuPackageTypeId, dtRequest, sbComment;
        CLOSE cuSolicitud;
    exception
      when others then
        nuPackageTypeId := 0;
    end;

    nuCausal := :new.causal_id;
    ut_trace.trace('LDC_TRBISOL_EMER->nuCausal:'||nuCausal,99);
    if cuValCausXTrami%isopen then
      close cuValCausXTrami;
    end if;
    open cuValCausXTrami;
    fetch cuValCausXTrami into nuExiste;
    close cuValCausXTrami;
    ut_trace.trace('LDC_TRBISOL_EMER->nuExiste:'||nuExiste,99);
    if nuExiste > 0 then
      begin
        select value
          into sbJob
        from v$parameter
        where name='job_queue_processes';
      exception
        when others then
          sbJob := '0';
      end;

      if sbJob = '0' then
         LDC_ENVIANOTIFSOLEMERGENCIA(:New.Package_Id,:new.subscription_id, :new.causal_id, nuPackageTypeId, dtRequest, sbComment);
      else
         INSERT INTO LDC_SOLEMERNOT( PACKAGE_ID,PACKAGE_TYPE_ID,FECHA_REGISTRO) VALUES(:NEW.PACKAGE_ID,nuPackageTypeId, SYSDATE);
      end if;
    end if;
  end if;
  ut_trace.trace('INICIA LDC_TRBISOL_EMER',99);
EXCEPTION
  WHEN ex.Controlled_error then
    ERRORS.GETERROR(nuError, sbError);
    ut_trace.trace('LDC_TRBISOL_EMER->Exc controlada:'||sbError,99);

  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuError, sbError);
    ut_trace.trace('LDC_TRBISOL_EMER->Exc no controlada:'||sbError,99);

END;
/
