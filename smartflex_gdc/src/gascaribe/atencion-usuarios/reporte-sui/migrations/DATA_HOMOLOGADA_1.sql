DECLARE
  /*
  Se requiere homologar los datos configurados en las formas LDCCCRCS y LDCTTCLRE de las solicitudes:
  Base  Solicitud  Nombre
  545  100335  Reclamos
  50  100337  Recurso de Reposicion
  52  100338  Recurso de Reposicion con Subsidio de Apelacion
  */
  ---------------------------

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  ---Homologacion DATA de la Forma LDCTTCLRE
  --Nivel 1
  cursor cuLDC_SUI_CAUS_EQU is
    select *
      from open.LDC_SUI_CAUS_EQU a
     where a.tipo_solicitud in (545, 50, 52);

  rfcuLDC_SUI_CAUS_EQU LDC_SUI_CAUS_EQU%rowtype;

  NuDespliega varchar2(1) := 'N';
  nuTipoSol   number := 0;

  Procedure PDBMS_OUTPUT(Sbmensaje varchar2) is
  begin
    if upper(NuDespliega) in ('S', 'Y') then
      Dbms_Output.put_line(Sbmensaje);
    end if;
  end;

BEGIN
  -------
  for rfcuLDC_SUI_CAUS_EQU in cuLDC_SUI_CAUS_EQU loop
  
    nuTipoSol := 0;
  
    IF (rfcuLDC_SUI_CAUS_EQU.tipo_solicitud = 545) THEN
      NuDespliega := 'N';
      nuTipoSol   := 100335;
      PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                   rfcuLDC_SUI_CAUS_EQU.tipo_solicitud ||
                   ' al tipo de solicitud ' || nuTipoSol);
    
      begin
        --/*
        insert into ldc_sui_caus_equ
          (causal_registro, tipo_solicitud, grupo_causal, causal_sspd)
        values
          (rfcuLDC_SUI_CAUS_EQU.causal_registro,
           nuTipoSol,
           rfcuLDC_SUI_CAUS_EQU.grupo_causal,
           rfcuLDC_SUI_CAUS_EQU.causal_sspd);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          NuDespliega := 'S';
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
    END IF;
  
    IF (rfcuLDC_SUI_CAUS_EQU.tipo_solicitud = 50) THEN
      NuDespliega := 'N';
      nuTipoSol   := 100337;
      PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                   rfcuLDC_SUI_CAUS_EQU.tipo_solicitud ||
                   ' al tipo de solicitud ' || nuTipoSol);
      begin
        --/*
        insert into ldc_sui_caus_equ
          (causal_registro, tipo_solicitud, grupo_causal, causal_sspd)
        values
          (rfcuLDC_SUI_CAUS_EQU.causal_registro,
           nuTipoSol,
           rfcuLDC_SUI_CAUS_EQU.grupo_causal,
           rfcuLDC_SUI_CAUS_EQU.causal_sspd);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          NuDespliega := 'S';
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
    
    END IF;
  
    IF (rfcuLDC_SUI_CAUS_EQU.tipo_solicitud = 52) THEN
      NuDespliega := 'N';
      nuTipoSol   := 100338;
      PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                   rfcuLDC_SUI_CAUS_EQU.tipo_solicitud ||
                   ' al tipo de solicitud ' || nuTipoSol);
      begin
        --/*
        insert into ldc_sui_caus_equ
          (causal_registro, tipo_solicitud, grupo_causal, causal_sspd)
        values
          (rfcuLDC_SUI_CAUS_EQU.causal_registro,
           nuTipoSol,
           rfcuLDC_SUI_CAUS_EQU.grupo_causal,
           rfcuLDC_SUI_CAUS_EQU.causal_sspd);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          NuDespliega := 'S';
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
    
    END IF;
  
  END loop;

END;
/
