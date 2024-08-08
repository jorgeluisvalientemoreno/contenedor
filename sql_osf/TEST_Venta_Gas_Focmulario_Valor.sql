declare

  errorNumber  NUMBER;
  errorMessage VARCHAR2(4000);

  V0                    NUMBER;
  sbValCuotaDig         VARCHAR2(4000);
  V1                    NUMBER;
  nuValCuotaDig         NUMBER;
  V2                    NUMBER;
  sbCurrentInstance     VARCHAR2(4000);
  V3                    NUMBER;
  sbFatherInstance      VARCHAR2(4000);
  V4                    NUMBER;
  V5                    VARCHAR2(4000);
  V6                    VARCHAR2(4000);
  nuFinanPlan           VARCHAR2(4000);
  V7                    NUMBER;
  V8                    VARCHAR2(4000);
  V9                    VARCHAR2(4000);
  sdRequestDate         VARCHAR2(4000);
  V10                   DATE;
  dtRequestDate         DATE;
  V11                   NUMBER;
  V12                   VARCHAR2(4000);
  V13                   VARCHAR2(4000);
  nuTotalValue          VARCHAR2(4000);
  V14                   NUMBER;
  V15                   VARCHAR2(4000);
  V16                   VARCHAR2(4000);
  nuQuotasNumber        VARCHAR2(4000);
  V17                   NUMBER;
  V18                   VARCHAR2(4000);
  V19                   VARCHAR2(4000);
  nuValToFin            VARCHAR2(4000);
  V20                   NUMBER;
  nuEmpresa             NUMBER;
  V21                   NUMBER;
  nuValCuotFinan        NUMBER;
  V22                   NUMBER;
  nuPsPackType          NUMBER;
  V23                   NUMBER;
  nuParamPercentRankLiq NUMBER;
  V24                   NUMBER;
  V25                   VARCHAR2(4000);
  V26                   BOOLEAN;
  nuPercentRankQuote    NUMBER;
  V27                   NUMBER;
  V28                   NUMBER;
  nuRankSuperior        NUMBER;
  V29                   NUMBER;
  V30                   NUMBER;
  nuRankInferior        NUMBER;
  V31                   NUMBER;
  V32                   NUMBER;
  V33                   VARCHAR2(4000);
  V34                   NUMBER;
  V35                   NUMBER;

BEGIN

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);  

  sbValCuotaDig := '62265.17';
  V0            := 0;
  V1            := UT_CONVERT.FNUCHARTONUMBER(sbValCuotaDig);
  nuValCuotaDig := V1;

  --GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);
  V2 := 0;
  --GE_BOINSTANCECONTROL.GETFATHERCURRENTINSTANCE(sbFatherInstance);
  V3 := 0;
  V5 := 'MO_PROCESS';
  V6 := 'VALUE_4';
  /*GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,
  null,
  V5,
  V6,
  nuFinanPlan);*/

  nuFinanPlan := 23;

  V4 := 0;
  V8 := 'MO_PACKAGES';
  V9 := 'REQUEST_DATE';
  /*GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,
  null,
  V8,
  V9,
  sdRequestDate);*/

  sdRequestDate := sysdate;

  V7            := 0;
  V10           := UT_CONVERT.FNUCHARTODATE(sdRequestDate);
  dtRequestDate := V10;
  V12           := 'MO_GAS_SALE_DATA';
  V13           := 'TOTAL_VALUE';
  /*GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,
  null,
  V12,
  V13,
  nuTotalValue);*/
  nuTotalValue := 2000256;

  V11 := 0;
  V15 := 'MO_PROCESS';
  V16 := 'VALUE_7';
  /*GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,
  null,
  V15,
  V16,
  nuQuotasNumber);*/
  nuQuotasNumber := 72;

  V14 := 0;
  V18 := 'MO_PROCESS';
  V19 := 'VALUE_6';
  /*GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,
  null,
  V18,
  V19,
  nuValToFin);*/
  nuValToFin := 2000256;

  V17            := 0;
  V20            := SA_BOSYSTEM.FNUGETUSERCOMPANYID;
  nuEmpresa      := V20;
  dbms_output.put_line('LD_BOGASSALEVALUE.FNUGETFINANQUOTAVALUE(nuFinanPlan['|| nuFinanPlan||'],
                                                            nuValToFin['|| nuValToFin||'],
                                                            nuQuotasNumber['||nuQuotasNumber ||'],
                                                            dtRequestDate['|| dtRequestDate||'],
                                                            nuEmpresa['|| nuEmpresa||'])');
  V21            := LD_BOGASSALEVALUE.FNUGETFINANQUOTAVALUE(nuFinanPlan,
                                                            nuValToFin,
                                                            nuQuotasNumber,
                                                            dtRequestDate,
                                                            nuEmpresa);
  nuValCuotFinan := V21;
  dbms_output.put_line('nuValCuotFinan: ' || nuValCuotFinan);

  V22                   := 271;
  nuPsPackType          := V22;
  V23                   := 49;
  nuParamPercentRankLiq := V23;
  V26                   := GE_BOCONSTANTS.GETTRUE;
  V25                   := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPackType,
                                                                  nuParamPercentRankLiq,
                                                                  V26);
  V24                   := UT_CONVERT.FNUCHARTONUMBER(V25);
  nuPercentRankQuote    := V24;
  dbms_output.put_line('nuPercentRankQuote: ' || nuPercentRankQuote);
  
  V27                   := nuValCuotFinan * nuPercentRankQuote;
  V28                   := nuValCuotFinan + V27;
  nuRankSuperior        := V28;
  V29                   := nuValCuotFinan * nuPercentRankQuote;
  V30                   := nuValCuotFinan - V29;
  nuRankInferior        := V30;
  --/*
  dbms_output.put_line('nuFinanPlan: ' || nuFinanPlan);
  IF (nuFinanPlan is not null) THEN
    dbms_output.put_line('IF (nuValCuotaDig['||nuValCuotaDig ||'] < nuRankInferior['|| nuRankInferior||'] OR nuValCuotaDig['|| nuValCuotaDig||'] > nuRankSuperior['|| nuRankSuperior||']) THEN');
    IF (nuValCuotaDig < nuRankInferior OR nuValCuotaDig > nuRankSuperior) THEN
      V32 := 2741;
      V33 := 'El valor de la Cuota Mensual digitada no se encuentra dentro del rango para el Plan de Financiacion';
      --GI_BOERRORS.SETERRORCODEARGUMENT(V32, V33);
      V31 := 0;
      V34 := V31;
      dbms_output.put_line('V33: ' || V33);
    ELSE
      null;
    END IF;
    V35 := V34;
  ELSE
    null;
  END IF;

  errorNumber  := 0;
  errorMessage := NULL;
  --*/

end;
