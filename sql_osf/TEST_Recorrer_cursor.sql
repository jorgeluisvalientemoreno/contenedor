declare

  inususccodi      integer := 1042180;
  inusaldogen      integer := 60850;
  isbtiposaldo     varchar2(1) := '1';
  isbsistema       VARCHAR2(1) := 'N';
  osbseguroliberty VARCHAR2(1);
  osbordensusp     VARCHAR2(1);
  osbprocfact      VARCHAR2(1);
  osbimprimir      VARCHAR2(1);
  onuerrorcode     NUMBER(10);
  osberrormessage  VARCHAR2(100);

  cudatosbasic SYS_REFCURSOR;
  cuconcept    SYS_REFCURSOR;
  curevision   SYS_REFCURSOR;
  cuhistorico  SYS_REFCURSOR;
  culecturas   SYS_REFCURSOR;
  cutotales    SYS_REFCURSOR;
  curangos     SYS_REFCURSOR;
  cucompcost   SYS_REFCURSOR;
  cucodbar     SYS_REFCURSOR;
  cutasacamb   SYS_REFCURSOR;
  cuotros      SYS_REFCURSOR;
  cumarcas     SYS_REFCURSOR;

  sbEtiqueta    number(15);
  sbDesc_concep VARCHAR2(2000);
  sbSALDO_ANT   VARCHAR2(4000);
  sbCapital     VARCHAR2(4000);
  sbInteres     VARCHAR2(4000);
  sbTotal       VARCHAR2(4000);
  sbSaldo_Dif   VARCHAR2(4000);
  sbCuotas      VARCHAR2(4000);

  inuTipoSolicitud   NUMBER := 100231;
  inuEstadoSolicitud NUMBER := 13;
  inuProducto        NUMBER := 53163006;

  sbExiste         VARCHAR2(1) := 'N';
  rfSolicitudes    constants_per.tyrefcursor;
  rfSolicitudestmp mo_packages%ROWTYPE;

begin

  --Forma 1
  adm_person.ldci_pkfactkiosco_gdc.progenerafactgdc(inususccodi,
                                                    inusaldogen,
                                                    isbtiposaldo,
                                                    cudatosbasic,
                                                    cuconcept,
                                                    curevision,
                                                    cuhistorico,
                                                    culecturas,
                                                    cutotales,
                                                    curangos,
                                                    cucompcost,
                                                    cucodbar,
                                                    cutasacamb,
                                                    cuotros,
                                                    cumarcas,
                                                    osbseguroliberty,
                                                    osbordensusp,
                                                    osbprocfact,
                                                    osbimprimir,
                                                    onuerrorcode,
                                                    osberrormessage,
                                                    isbsistema);

  LOOP
    FETCH cuconcept
      INTO sbEtiqueta,
           sbDesc_concep,
           sbSALDO_ANT,
           sbCapital,
           sbInteres,
           sbTotal,
           sbSaldo_Dif,
           sbCuotas;
    EXIT WHEN cuconcept%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(sbEtiqueta || ' - ' || sbDesc_concep || ' - ' ||
                         sbSALDO_ANT);
  END LOOP;
  CLOSE cuconcept;

  --Forma 2
  rfSolicitudes := pkg_bcsolicitudes.frfObtSolPorTipoProdYEstado(inuTipoSolicitud,
                                                                 inuEstadoSolicitud,
                                                                 inuProducto);
  LOOP
    FETCH rfSolicitudes
      INTO rfSolicitudestmp;
    EXIT WHEN rfSolicitudes%NOTFOUND;
    sbExiste := 'S';
  END LOOP;

  pkg_traza.trace('Valor Final sbExiste: ' || sbExiste, 10);

end;
/
