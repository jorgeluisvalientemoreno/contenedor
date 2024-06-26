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
  cursor cuLDC_SUI_TIPSOL is
    select *
      from open.LDC_SUI_TIPSOL a
     where a.tipo_solicitud in (545, 50, 52);

  rfcuLDC_SUI_TIPSOL cuLDC_SUI_TIPSOL%rowtype;

  cursor cuLDC_SUI_TIPSOLExiste(InuTipoSolicitud open.LDC_SUI_TIPSOL.tipo_solicitud%type) is
    select *
      from open.LDC_SUI_TIPSOL a
     where a.tipo_solicitud = InuTipoSolicitud;

  rfcuLDC_SUI_TIPSOLExiste cuLDC_SUI_TIPSOLExiste%rowtype;

  nuTipoSol LDC_SUI_CAUS_EQU.tipo_solicitud%TYPE;
  --Nivel 2
  cursor cuLDC_SUI_RESPUESTA is
    select *
      from open.LDC_SUI_RESPUESTA a
     where a.tipo_solicitud in (545, 50, 52);

  rfcuLDC_SUI_RESPUESTA cuLDC_SUI_RESPUESTA%rowtype;

  cursor cuLDC_SUI_RESPUESTAExiste(InuTipoSolicitud open.LDC_SUI_RESPUESTA.tipo_solicitud%type,
                                   sbdescription    open.LDC_SUI_RESPUESTA.description%type) is
    select *
      from open.LDC_SUI_RESPUESTA a
     where a.tipo_solicitud = InuTipoSolicitud
       and a.description = sbdescription;

  rfcuLDC_SUI_RESPUESTAExiste cuLDC_SUI_RESPUESTAExiste%rowtype;

  nuSeqLDC_SEQRESPUESTA number;

  --Nivel 3  
  --Nivel 2
  cursor cuLDC_SUI_TITRCALE(nuRespuesta number) is
    select * from open.LDC_SUI_TITRCALE a where a.respuesta = nuRespuesta;

  rfcuLDC_SUI_TITRCALE cuLDC_SUI_TITRCALE%rowtype;
  ----------------------------------------

  NuDespliega varchar2(1) := 'N';

  Procedure PDBMS_OUTPUT(Sbmensaje varchar2) is
  begin
    if upper(NuDespliega) in ('S', 'Y') then
      Dbms_Output.put_line(Sbmensaje);
    end if;
  end;

BEGIN
  ---Inicio Homologacion DATA de la Forma LDCTTCLRE
  --Nivel 1
  NuDespliega := 'S';
  for rfcuLDC_SUI_TIPSOL in cuLDC_SUI_TIPSOL loop
  
    nuTipoSol := 0;
  
    IF (rfcuLDC_SUI_TIPSOL.tipo_solicitud = 545) THEN
      nuTipoSol := 100335;
      OPEN cuLDC_SUI_TIPSOLExiste(nuTipoSol);
      FETCH cuLDC_SUI_TIPSOLExiste
        INTO rfcuLDC_SUI_TIPSOLExiste;
      IF (cuLDC_SUI_TIPSOLExiste%FOUND) THEN
        PDBMS_OUTPUT('El tipo de solicitud ' || nuTipoSol ||
                     ' ya esta registrada.');
      ELSE
        begin
          --/*
          insert into OPEN.LDC_SUI_TIPSOL
            (TIPO_SOLICITUD, USUARIO, FECHA, MAQUINA, TIPO_TRAMITE)
          values
            (nuTipoSol,
             rfcuLDC_SUI_TIPSOL.USUARIO,
             rfcuLDC_SUI_TIPSOL.FECHA,
             rfcuLDC_SUI_TIPSOL.MAQUINA,
             rfcuLDC_SUI_TIPSOL.TIPO_TRAMITE);
          --*/
          PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                       rfcuLDC_SUI_TIPSOL.tipo_solicitud ||
                       ' al tipo de solicitud ' || nuTipoSol);
          commit;
        EXCEPTION
          when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            PDBMS_OUTPUT('ERROR OTHERS ');
            PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
            PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                         ' - Error SQL: ' || sqlerrm);
        end;
      END IF;
      CLOSE cuLDC_SUI_TIPSOLExiste;
    END IF;
    IF (rfcuLDC_SUI_TIPSOL.tipo_solicitud = 50) THEN
      nuTipoSol := 100337;
      OPEN cuLDC_SUI_TIPSOLExiste(nuTipoSol);
      FETCH cuLDC_SUI_TIPSOLExiste
        INTO rfcuLDC_SUI_TIPSOLExiste;
      IF (cuLDC_SUI_TIPSOLExiste%FOUND) THEN
        Dbms_Output.Put_Line('El tipo de solicitud ' || nuTipoSol ||
                             ' ya esta registrada.');
      ELSE
        begin
          --/*
          insert into OPEN.LDC_SUI_TIPSOL
            (TIPO_SOLICITUD, USUARIO, FECHA, MAQUINA, TIPO_TRAMITE)
          values
            (nuTipoSol,
             rfcuLDC_SUI_TIPSOL.USUARIO,
             rfcuLDC_SUI_TIPSOL.FECHA,
             rfcuLDC_SUI_TIPSOL.MAQUINA,
             rfcuLDC_SUI_TIPSOL.TIPO_TRAMITE);
          --*/
          PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                       rfcuLDC_SUI_TIPSOL.tipo_solicitud ||
                       ' al tipo de solicitud ' || nuTipoSol);
          commit;
        EXCEPTION
          when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            PDBMS_OUTPUT('ERROR OTHERS ');
            PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
            PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                         ' - Error SQL: ' || sqlerrm);
        end;
      END IF;
      CLOSE cuLDC_SUI_TIPSOLExiste;
    END IF;
    IF (rfcuLDC_SUI_TIPSOL.tipo_solicitud = 52) THEN
      nuTipoSol := 100338;
      OPEN cuLDC_SUI_TIPSOLExiste(nuTipoSol);
      FETCH cuLDC_SUI_TIPSOLExiste
        INTO rfcuLDC_SUI_TIPSOLExiste;
      IF (cuLDC_SUI_TIPSOLExiste%FOUND) THEN
        PDBMS_OUTPUT('El tipo de solicitud ' || nuTipoSol ||
                     ' ya esta registrada.');
      ELSE
        begin
          --/*
          insert into OPEN.LDC_SUI_TIPSOL
            (TIPO_SOLICITUD, USUARIO, FECHA, MAQUINA, TIPO_TRAMITE)
          values
            (nuTipoSol,
             rfcuLDC_SUI_TIPSOL.USUARIO,
             rfcuLDC_SUI_TIPSOL.FECHA,
             rfcuLDC_SUI_TIPSOL.MAQUINA,
             rfcuLDC_SUI_TIPSOL.TIPO_TRAMITE);
          --*/
          PDBMS_OUTPUT('*************** Se registra homologacion del ' ||
                       rfcuLDC_SUI_TIPSOL.tipo_solicitud ||
                       ' al tipo de solicitud ' || nuTipoSol);
          commit;
        EXCEPTION
          when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            PDBMS_OUTPUT('ERROR OTHERS ');
            PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
            PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                         ' - Error SQL: ' || sqlerrm);
        end;
      END IF;
      CLOSE cuLDC_SUI_TIPSOLExiste;
    END IF;
  
  END loop;

  --Nivel 2
  NuDespliega := 'S';
  for rfcuLDC_SUI_RESPUESTA in cuLDC_SUI_RESPUESTA loop
  
    nuTipoSol := 0;
  
    IF (rfcuLDC_SUI_RESPUESTA.tipo_solicitud = -545) THEN
      nuTipoSol := 100335;
      --/*
      PDBMS_OUTPUT('RESPUESTA SOLICITUD ' ||
                   rfcuLDC_SUI_RESPUESTA.tipo_solicitud || ' - IDRESPU[' ||
                   rfcuLDC_SUI_RESPUESTA.IDRESPU || '],DESCRIPTION[' ||
                   rfcuLDC_SUI_RESPUESTA.DESCRIPTION || '],ATEN_INME[' ||
                   rfcuLDC_SUI_RESPUESTA.ATEN_INME || '],IMPU_CLIE[' ||
                   rfcuLDC_SUI_RESPUESTA.IMPU_CLIE || '],TIPO_RESPUESTA[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA || '],TIME_OUT[' ||
                   rfcuLDC_SUI_RESPUESTA.TIME_OUT || '],TIPO_SOLICITUD[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_SOLICITUD || ']');
      --*/
    
      --/*    
      begin
        /*
        nuSeqLDC_SEQRESPUESTA := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('LDC_SEQRESPUESTA');
        insert into OPEN.LDC_SUI_RESPUESTA
          (IDRESPU,
           DESCRIPTION,
           ATEN_INME,
           IMPU_CLIE,
           TIPO_RESPUESTA,
           TIME_OUT,
           TIPO_SOLICITUD)
        values
          (nuSeqLDC_SEQRESPUESTA,
           rfcuLDC_SUI_RESPUESTA.DESCRIPTION,
           rfcuLDC_SUI_RESPUESTA.ATEN_INME,
           rfcuLDC_SUI_RESPUESTA.IMPU_CLIE,
           rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA,
           rfcuLDC_SUI_RESPUESTA.TIME_OUT,
           nuTipoSol);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
      --*/
      --/*
      ---Nivel 3 Tipo de trabajo x causal de legalización para el reporte SUI
      open cuLDC_SUI_TITRCALE(rfcuLDC_SUI_RESPUESTA.IDRESPU);
      fetch cuLDC_SUI_TITRCALE
        into rfcuLDC_SUI_TITRCALE;
      if cuLDC_SUI_TITRCALE%FOUND then
        PDBMS_OUTPUT('REPORTE SUI - TIPO_TRABAJO[' ||
                     rfcuLDC_SUI_TITRCALE.TIPO_TRABAJO ||
                     '],CAUSAL_LEGALIZACION[' ||
                     rfcuLDC_SUI_TITRCALE.causal_legalizacion ||
                     '],NUVEA RESPUESTA[' || nuSeqLDC_SEQRESPUESTA ||
                     '],GRUPO_CAUSAL[' ||
                     rfcuLDC_SUI_TITRCALE.grupo_causal || '],CAUSAL_SSPD[' ||
                     rfcuLDC_SUI_TITRCALE.causal_sspd || ']');
        --/*    
        begin
          /*
          INSERT INTO LDC_SUI_TITRCALE
            (TIPO_TRABAJO,
             CAUSAL_LEGALIZACION,
             RESPUESTA,
             GRUPO_CAUSAL,
             CAUSAL_SSPD)
          VALUES
            (rfcuLDC_SUI_TITRCALE.TIPO_TRABAJO,
             rfcuLDC_SUI_TITRCALE.causal_legalizacion,
             nuSeqLDC_SEQRESPUESTA,
             rfcuLDC_SUI_TITRCALE.grupo_causal,
             rfcuLDC_SUI_TITRCALE.causal_sspd);
          --*/
          commit;
        EXCEPTION
          when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            PDBMS_OUTPUT('ERROR OTHERS ');
            PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
            PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                         ' - Error SQL: ' || sqlerrm);
        end;
        --*/                     
      end if;
      close cuLDC_SUI_TITRCALE;
      --------------------------------------------------------------------------
    END IF;
  
    IF (rfcuLDC_SUI_RESPUESTA.tipo_solicitud = 50) THEN
      nuTipoSol := 100337;
      --/*
      PDBMS_OUTPUT('IDRESPU[' || rfcuLDC_SUI_RESPUESTA.IDRESPU ||
                   '],DESCRIPTION[' || rfcuLDC_SUI_RESPUESTA.DESCRIPTION ||
                   '],ATEN_INME[' || rfcuLDC_SUI_RESPUESTA.ATEN_INME ||
                   '],IMPU_CLIE[' || rfcuLDC_SUI_RESPUESTA.IMPU_CLIE ||
                   '],TIPO_RESPUESTA[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA || '],TIME_OUT[' ||
                   rfcuLDC_SUI_RESPUESTA.TIME_OUT || '],TIPO_SOLICITUD[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_SOLICITUD || ']');
      --*/
    
      --/*    
      begin
        --/*
        nuSeqLDC_SEQRESPUESTA := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('LDC_SEQRESPUESTA');
        insert into OPEN.LDC_SUI_RESPUESTA
          (IDRESPU,
           DESCRIPTION,
           ATEN_INME,
           IMPU_CLIE,
           TIPO_RESPUESTA,
           TIME_OUT,
           TIPO_SOLICITUD)
        values
          (nuSeqLDC_SEQRESPUESTA,
           rfcuLDC_SUI_RESPUESTA.DESCRIPTION,
           rfcuLDC_SUI_RESPUESTA.ATEN_INME,
           rfcuLDC_SUI_RESPUESTA.IMPU_CLIE,
           rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA,
           rfcuLDC_SUI_RESPUESTA.TIME_OUT,
           nuTipoSol);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
      --*/
    
      --/*
      ---Nivel 3 Tipo de trabajo x causal de legalización para el reporte SUI
      open cuLDC_SUI_TITRCALE(rfcuLDC_SUI_RESPUESTA.IDRESPU);
      fetch cuLDC_SUI_TITRCALE
        into rfcuLDC_SUI_TITRCALE;
      if cuLDC_SUI_TITRCALE%FOUND then
        PDBMS_OUTPUT('REPORTE SUI - TIPO_TRABAJO[' ||
                     rfcuLDC_SUI_TITRCALE.TIPO_TRABAJO ||
                     '],CAUSAL_LEGALIZACION[' ||
                     rfcuLDC_SUI_TITRCALE.causal_legalizacion ||
                     '],NUVEA RESPUESTA[' || nuSeqLDC_SEQRESPUESTA ||
                     '],GRUPO_CAUSAL[' ||
                     rfcuLDC_SUI_TITRCALE.grupo_causal || '],CAUSAL_SSPD[' ||
                     rfcuLDC_SUI_TITRCALE.causal_sspd || ']');
        --/*    
        begin
          --/*
          INSERT INTO LDC_SUI_TITRCALE
            (TIPO_TRABAJO,
             CAUSAL_LEGALIZACION,
             RESPUESTA,
             GRUPO_CAUSAL,
             CAUSAL_SSPD)
          VALUES
            (rfcuLDC_SUI_TITRCALE.TIPO_TRABAJO,
             rfcuLDC_SUI_TITRCALE.causal_legalizacion,
             nuSeqLDC_SEQRESPUESTA,
             rfcuLDC_SUI_TITRCALE.grupo_causal,
             rfcuLDC_SUI_TITRCALE.causal_sspd);
          --*/
          commit;
        EXCEPTION
          when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            PDBMS_OUTPUT('ERROR OTHERS ');
            PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
            PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                         ' - Error SQL: ' || sqlerrm);
        end;
        --*/    
      end if;
      close cuLDC_SUI_TITRCALE;
    
    END IF;
  
    IF (rfcuLDC_SUI_RESPUESTA.tipo_solicitud = -52) THEN
      nuTipoSol := 100338;
      --/*
      PDBMS_OUTPUT('IDRESPU[' || rfcuLDC_SUI_RESPUESTA.IDRESPU ||
                   '],DESCRIPTION[' || rfcuLDC_SUI_RESPUESTA.DESCRIPTION ||
                   '],ATEN_INME[' || rfcuLDC_SUI_RESPUESTA.ATEN_INME ||
                   '],IMPU_CLIE[' || rfcuLDC_SUI_RESPUESTA.IMPU_CLIE ||
                   '],TIPO_RESPUESTA[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA || '],TIME_OUT[' ||
                   rfcuLDC_SUI_RESPUESTA.TIME_OUT || '],TIPO_SOLICITUD[' ||
                   rfcuLDC_SUI_RESPUESTA.TIPO_SOLICITUD || ']');
      --*/
    
      --/*    
      begin
        /*
          nuSeqLDC_SEQRESPUESTA := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('LDC_SEQRESPUESTA');
          insert into OPEN.LDC_SUI_RESPUESTA
            (IDRESPU,
             DESCRIPTION,
             ATEN_INME,
             IMPU_CLIE,
             TIPO_RESPUESTA,
             TIME_OUT,
             TIPO_SOLICITUD)
          values
            (nuSeqLDC_SEQRESPUESTA,
             rfcuLDC_SUI_RESPUESTA.DESCRIPTION,
             rfcuLDC_SUI_RESPUESTA.ATEN_INME,
             rfcuLDC_SUI_RESPUESTA.IMPU_CLIE,
             rfcuLDC_SUI_RESPUESTA.TIPO_RESPUESTA,
             rfcuLDC_SUI_RESPUESTA.TIME_OUT,
             nuTipoSol);
        --*/
        commit;
      EXCEPTION
        when OTHERS then
          Errors.setError;
          Errors.getError(nuErrorCode, sbErrorMessage);
          PDBMS_OUTPUT('ERROR OTHERS ');
          PDBMS_OUTPUT('error onuErrorCode: ' || nuErrorCode);
          PDBMS_OUTPUT('error osbErrorMess: ' || sbErrorMessage ||
                       ' - Error SQL: ' || sqlerrm);
      end;
      --*/
    END IF;
    --
  
  END loop;
  ---Fin Homologacion DATA de la Forma LDCTTCLRE

END;
/
