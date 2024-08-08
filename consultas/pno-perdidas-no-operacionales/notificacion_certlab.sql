declare
nuOrden number;
NUCERTIFICADO NUMBER;
NUNOTIFICA NUMBER;
    FUNCTION fnugetTipoLab
    (
      inuOrderId        in      OPEN.OR_order.order_id%type
    ) return varchar2
    IS

      nuPlan                    OPEN.ldc_plantemp.pltevate%type;
      sbTiCl                    OPEN.ldc_plantemp.pltetipo%type;
      nuTipoLab                 OPEN.ldc_plantemp.pltelabo%type;
      --  Variables para manejo de Errores
      exCallService             EXCEPTION;
      sbCallService             varchar2(2000);
      sbErrorMessage            varchar2(2000);
      nuErrorCode               number;
      nuOrderAj                 number;

      -- CURSOR
      CURSOR cuCertifica(inuPlan in OPEN.ldc_plantemp.pltevate%type,
                         inTipoCl in OPEN.ldc_plantemp.pltetipo%type) IS
        select PLTELABO FROM  OPEN.ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
         AND pltelabo not like '%AJUSTE'
        AND rownum  = 1;

      CURSOR cuCertificaAju(inuPlan in OPEN.ldc_plantemp.pltevate%type,
                         inTipoCl in OPEN.ldc_plantemp.pltetipo%type)   IS
        select PLTELABO FROM  OPEN.ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
        AND pltelabo LIKE  '%AJUSTE'
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdCertificado ',8) ;
      -- Obtiene la planilla que se utilizo
      nuPlan := OPEN.ldc_bometrologia.fnugetIdPlanilla(inuOrderId);
      sbTiCl := OPEN.ldc_bometrologia.fsbTipoClienteCertif(inuOrderId);

      -- Valida si el Certificado tiene una orden de ajuste
      nuOrderAj := OPEN.ldc_bometrologia.valCertAjuste(inuOrderId);

      if nuOrderAj <> 0 then
        for e in cuCertificaAju(nuPlan,sbTiCl) loop
          nuTipoLab := e.PLTELABO;
        end loop;
      else
        for e in cuCertifica(nuPlan,sbTiCl) loop
          nuTipoLab := e.PLTELABO;
        end loop;
      END if;

      return nuTipoLab;
      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdCertificado ',8) ;

    EXCEPTION
      when "OPEN".ex.CONTROLLED_ERROR then
        raise "OPEN".ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or OPEN.pkConstante.exERROR_LEVEL2 then
        "OPEN".pkErrors.pop;
        raise;
      when OTHERS then
        "OPEN".pkErrors.NotifyError("OPEN".pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
        "OPEN".pkErrors.pop;
      raise_application_error(OPEN.pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetTipoLab;
    
    FUNCTION fnugetIdCertificado
    (
      inuOrderId        in      open.OR_order.order_id%type
    ) return number
    IS

      nuPlan                    open.ldc_plantemp.pltevate%type;
      sbTiCl                    open.ldc_plantemp.pltetipo%type;
      nuIdCertif                open.ldc_plantemp.pltexste%type;
      nuOrderAj                 open.OR_ORDER.order_id%type;
      --  Variables para manejo de Errores
      exCallService             EXCEPTION;
      sbCallService             varchar2(2000);
      sbErrorMessage            varchar2(2000);
      nuErrorCode               number;
      sbTipoLab                 varchar2(2000);

      -- CURSOR
      CURSOR cuCertifica(inuPlan in open.ldc_plantemp.pltevate%type,
                         inTipoCl in open.ldc_plantemp.pltetipo%type) IS
        select PLTEXSTE FROM  open.ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
         AND pltelabo not like '%AJUSTE'
        AND rownum  = 1;

      CURSOR cuCertificaAju(inuPlan in open.ldc_plantemp.pltevate%type,
                         inTipoCl in open.ldc_plantemp.pltetipo%type)   IS
        select PLTEXSTE FROM  open.ldc_plantemp
        WHERE  pltevate = nuPlan
        AND pltetipo =  inTipoCl
        AND pltelabo LIKE  '%AJUSTE'
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdCertificado ',8) ;
      -- Obtiene el Item seriado dada la orden
      nuPlan := open.ldc_bometrologia.fnugetIdPlanilla(inuOrderId);
      sbTiCl := open.ldc_bometrologia.fsbTipoClienteCertif(inuOrderId);
      sbTipoLab := fnugetTipoLab (inuOrderId);

      -- Valida si el Certificado tiene una orden de ajuste
      nuOrderAj := open.ldc_bometrologia.valCertAjuste(inuOrderId);

      if nuOrderAj <> 0 then
        for e in cuCertificaAju(nuPlan,sbTiCl) loop
          nuIdCertif := e.PLTEXSTE;
        end loop;
      else
        for e in cuCertifica(nuPlan,sbTiCl) loop
          nuIdCertif := e.PLTEXSTE;
        end loop;
      END if;

      if nuIdCertif is null then
            "OPEN".ge_boerrors.seterrorcodeargument(2741,'No se ha configurado el certificado '||sbTipoLab||
                                                  ', en el Maestro Detalle CERPLA.');
      end if;

      return nuIdCertif;

      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdCertificado ',8) ;

    EXCEPTION
      when "OPEN".ex.CONTROLLED_ERROR then
        raise "OPEN".ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        "OPEN".pkErrors.pop;
        raise;
      when OTHERS then
        "OPEN".pkErrors.NotifyError("OPEN".pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
      "OPEN".pkErrors.pop;
      raise_application_error(OPEN.pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetIdCertificado;
    FUNCTION fnugetIdNotificacion
    (
      inuIdCertif          in       open.ldc_plantemp.pltexste%type
    ) return number
    IS

      nuIdNotificacion              open.ge_notification.notification_id%type;

      --  Variables para manejo de Errores
      exCallService                 EXCEPTION;
      sbCallService                 varchar2(2000);
      sbErrorMessage                varchar2(2000);
      nuErrorCode                   number;

      -- CURSOR que busca el Id de la notificaci?n
      CURSOR cuNotificacion(inuXSL_temp in open.ldc_plantemp.pltevate%type ) IS
        select notification_id FROM open.ge_notification
        WHERE xsl_template_id = inuXSL_temp
        AND rownum  = 1;

    BEGIN
      --.trace ('Inicia LDC_BOmetrologia.fnugetIdNotificacion ',8) ;

      for e in cuNotificacion(inuIdCertif) loop
        nuIdNotificacion := e.notification_id;
      end loop;

      return nuIdNotificacion;
      --.trace ('Finaliza LDC_BOmetrologia.fnugetIdNotificacion ',8) ;

    EXCEPTION
      when "OPEN".ex.CONTROLLED_ERROR then
        raise "OPEN".ex.CONTROLLED_ERROR;
      when LOGIN_DENIED or OPEN.pkConstante.exERROR_LEVEL2 then
        "OPEN".pkErrors.pop;
        raise;
      when OTHERS then
        "OPEN".pkErrors.NotifyError("OPEN".pkErrors.fsbLastObject, sqlerrm, sbErrorMessage);
	    "OPEN".pkErrors.pop;
	    raise_application_error("OPEN".pkConstante.nuERROR_LEVEL2, sbErrorMessage);

    END fnugetIdNotificacion;    
BEGIN

  nuOrden:=&orden;
  NUCERTIFICADO:=fnugetIdCertificado(nuOrden);
  NUNOTIFICA:=fnugetIdNotificacion(NUCERTIFICADO);
  
  DBMS_OUTPUT.PUT_LINE(NUCERTIFICADO);
  DBMS_OUTPUT.PUT_LINE(NUNOTIFICA);
END;
/
