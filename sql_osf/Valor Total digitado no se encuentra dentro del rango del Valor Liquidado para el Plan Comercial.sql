DECLARE
  errorNumber           NUMBER;
  errorMessage          VARCHAR2(4000);
  V0                    NUMBER;
  sbTotalDigitado       VARCHAR2(4000);
  V1                    NUMBER;
  nuTotalDigitado       NUMBER;
  V2                    NUMBER;
  V3                    NUMBER;
  V4                    NUMBER;
  V5                    VARCHAR2(4000);
  V6                    NUMBER;
  V7                    NUMBER;
  sbCurrentInstance     VARCHAR2(4000);
  V8                    NUMBER;
  sbFatherInstance      VARCHAR2(4000);
  V9                    NUMBER;
  V10                   VARCHAR2(4000);
  V11                   VARCHAR2(4000);
  nuCommercialPlanId    VARCHAR2(4000);
  V12                   NUMBER;
  V13                   VARCHAR2(4000);
  V14                   VARCHAR2(4000);
  sbRequestDate         VARCHAR2(4000);
  V15                   DATE;
  dtRequestDate         DATE;
  V16                   NUMBER;
  V17                   VARCHAR2(4000);
  V18                   VARCHAR2(4000);
  nuCategoryId          VARCHAR2(4000);
  V19                   NUMBER;
  V20                   VARCHAR2(4000);
  V21                   VARCHAR2(4000);
  nuSubcategoryId       VARCHAR2(4000);
  V22                   NUMBER;
  V23                   VARCHAR2(4000);
  V24                   VARCHAR2(4000);
  nuAddressId           VARCHAR2(4000);
  V25                   NUMBER;
  V26                   VARCHAR2(4000);
  V27                   VARCHAR2(4000);
  nuPersonId            VARCHAR2(4000);
  V28                   NUMBER;
  V29                   VARCHAR2(4000);
  V30                   VARCHAR2(4000);
  nuSaleChannelId       VARCHAR2(4000);
  V31                   NUMBER;
  V32                   VARCHAR2(4000);
  V33                   VARCHAR2(4000);
  nuSubscriberId        VARCHAR2(4000);
  V34                   NUMBER;
  V35                   VARCHAR2(4000);
  V36                   VARCHAR2(4000);
  nuCiclo               VARCHAR2(4000);
  V37                   NUMBER;
  V38                   VARCHAR2(4000);
  V39                   VARCHAR2(4000);
  nuIdentTypeId         VARCHAR2(4000);
  V40                   NUMBER;
  V41                   VARCHAR2(4000);
  V42                   VARCHAR2(4000);
  nuIdentification      VARCHAR2(4000);
  V43                   NUMBER;
  nuPsPackType          NUMBER;
  V44                   NUMBER;
  nuParamPercentRankLiq NUMBER;
  V45                   NUMBER;
  nuParamClientType     NUMBER;
  V46                   VARCHAR2(4000);
  V47                   BOOLEAN;
  sbTipoCliente         VARCHAR2(4000);
  V48                   NUMBER;
  V49                   VARCHAR2(4000);
  V50                   VARCHAR2(4000);
  sbpromociones         VARCHAR2(4000);
  V51                   NUMBER;
  nuTotalLiquidado      NUMBER;
  V52                   NUMBER;
  V53                   VARCHAR2(4000);
  V54                   BOOLEAN;
  nuPercentRankLiq      NUMBER;
  V55                   NUMBER;
  V56                   NUMBER;
  nuRangoSuperior       NUMBER;
  V57                   NUMBER;
  V58                   NUMBER;
  nuRangoInferior       NUMBER;
  V59                   NUMBER;
  V60                   NUMBER;
  V61                   VARCHAR2(4000);
  V62                   NUMBER;

BEGIN
  dbms_output.enable(1000000);
  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);
  --GE_BOINSTANCECONTROL.GETENTITYATTRIBUTE(sbTotalDigitado);
  sbTotalDigitado := 3612290;
  dbms_output.put_line('Saldo Total: ' || sbTotalDigitado);
  V0              := 0;
  V1              := UT_CONVERT.FNUCHARTONUMBER(sbTotalDigitado);
  nuTotalDigitado := V1;
  V2              := 0;
  IF (nuTotalDigitado < V2) THEN
    V4 := 2741;
    V5 := 'El valor ingresado debe ser mayor que cero';
    GI_BOERRORS.SETERRORCODEARGUMENT(V4, V5);
    V3 := 0;
    V6 := V3;
  ELSE
    null;
  END IF;
  --GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);
  --V7 := 0;
  --GE_BOINSTANCECONTROL.GETFATHERCURRENTINSTANCE(sbFatherInstance);
  --V8  := 0;
  --V10 := 'MO_MOTIVE';
  --V11 := 'COMMERCIAL_PLAN_ID';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance,null,V10,V11,nuCommercialPlanId);
  nuCommercialPlanId := 4;
  dbms_output.put_line('Plan Comercial: ' || nuCommercialPlanId);
  --V9  := 0;
  --V13 := 'MO_PACKAGES';
  --V14 := 'REQUEST_DATE';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V13,V14,sbRequestDate);
  sbRequestDate := sysdate;
  --V12           := 0;
  V15           := UT_CONVERT.FNUCHARTODATE(sbRequestDate);
  dtRequestDate := V15;
  dbms_output.put_line('Fecha Registro: ' || dtRequestDate);
  --V17           := 'MO_PROCESS';
  --V18           := 'USE';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V17,V18,nuCategoryId);
  nuCategoryId := 1;
  dbms_output.put_line('Categoria: ' || nuCategoryId);
  --V16 := 0;
  --V20 := 'MO_PROCESS';
  --V21 := 'STRATUM';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V20,V21,nuSubcategoryId);
  nuSubcategoryId := 2;
  dbms_output.put_line('SubCategoria: ' || nuSubcategoryId);
  --V19 := 0;
  --V23 := 'MO_PROCESS';
  --V24 := 'ADDRESS_MAIN_MOTIVE';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V23,V24,nuAddressId);
  nuAddressId := 259152;
  dbms_output.put_line('Codigo Direccion: ' || nuAddressId);
  --V22         := 0;
  --V26         := 'MO_PACKAGES';
  --V27         := 'PERSON_ID';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V26,V27,nuPersonId);
  nuPersonId := 13549;
  dbms_output.put_line('Codigo Persona: ' || nuPersonId);
  --V25 := 0;
  --V29 := 'MO_PACKAGES';
  --V30 := 'POS_OPER_UNIT_ID';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V29,V30,nuSaleChannelId);
  nuSaleChannelId := 4320;
  dbms_output.put_line('Canal Venta: ' || nuSaleChannelId);
  --V28 := 0;
  --V32 := 'MO_PACKAGES';
  --V33 := 'SUBSCRIBER_ID';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V32,V33,nuSubscriberId);
  nuSubscriberId := 3417747;
  dbms_output.put_line('Codigo Suscriptor: ' || nuSubscriberId);
  --V31 := 0;
  --V35 := 'SUSCRIPC';
  --V36 := 'SUSCCICL';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V35,V36,nuCiclo);
  nuCiclo := 7814;
  dbms_output.put_line('Ciclo: ' || nuCiclo);
  --V34 := 0;
  --V38 := 'GE_SUBSCRIBER';
  --V39 := 'IDENT_TYPE_ID';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V38,V39,nuIdentTypeId);
  nuIdentTypeId := 1;
  dbms_output.put_line('Tipo de identificacion: ' || nuIdentTypeId);
  --V37 := 0;
  --V41 := 'GE_SUBSCRIBER';
  --V42 := 'IDENTIFICATION';
  --GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance,null,V41,V42,nuIdentification);
  nuIdentification := 1043675975;
  dbms_output.put_line('Tipo de identificacion: ' || nuIdentification);
  --V40                   := 0;
  V43          := 271;
  nuPsPackType := V43;
  dbms_output.put_line('Tipo Solicitud: ' || nuPsPackType);
  V44                   := 49;
  nuParamPercentRankLiq := V44;
  dbms_output.put_line('Parametro porcentaje de rango de liquidacion: ' ||
                       nuParamPercentRankLiq);
  V45               := 6003;
  nuParamClientType := V45;
  dbms_output.put_line('Parametro Tipo de cliente: ' || nuParamClientType);
  V47           := GE_BOCONSTANTS.GETTRUE;
  V46           := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPackType,
                                                          nuParamClientType,
                                                          V47);
  sbTipoCliente := V46;
  dbms_output.put_line('Tipo de cliente: ' || sbTipoCliente);
  --V49                   := 'MO_MOT_PROMOTION';
  --V50                   := 'PROMOTION_ID';
  --GETPROMGRID(V49, V50, sbpromociones);
  sbpromociones := 180588;
  dbms_output.put_line('Promocion: ' || sbpromociones);
  V48 := 0;
  
  
  /*dbms_output.put_line('V51              := FNUGETSALEVALBYFORM(nuCommercialPlanId['||nuCommercialPlanId||'],
                                            nuCategoryId['||nuCategoryId||'],
                                            nuSubcategoryId['||nuSubcategoryId||'],
                                            nuAddressId['||nuAddressId||'],
                                            nuCiclo['||nuCiclo||'],
                                            nuPersonId['||nuPersonId||'],
                                            nuSaleChannelId['||nuSaleChannelId||'],
                                            dtRequestDate['||dtRequestDate||'],
                                            nuIdentTypeId['||nuIdentTypeId||'],
                                            nuIdentification['||nuIdentification||'],
                                            sbTipoCliente['||sbTipoCliente||'],
                                            sbpromociones['||sbpromociones||'])');*/
  

  V51              := FNUGETSALEVALBYFORM(nuCommercialPlanId,
                                          nuCategoryId,
                                          nuSubcategoryId,
                                          nuAddressId,
                                          nuCiclo,
                                          nuPersonId,
                                          nuSaleChannelId,
                                          dtRequestDate,
                                          nuIdentTypeId,
                                          nuIdentification,
                                          sbTipoCliente,
                                          sbpromociones);
  nuTotalLiquidado := V51;
  --/*
  dbms_output.put_line('Total Liquidado: ' || nuTotalLiquidado);
  V54              := GE_BOCONSTANTS.GETTRUE;
  V53              := PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(nuPsPackType,
                                                             nuParamPercentRankLiq,
                                                             V54);
  V52              := UT_CONVERT.FNUCHARTONUMBER(V53);
  nuPercentRankLiq := V52;
  V55              := nuTotalLiquidado * nuPercentRankLiq;
  V56              := nuTotalLiquidado + V55;
  nuRangoSuperior  := V56;
  V57              := nuTotalLiquidado * nuPercentRankLiq;
  V58              := nuTotalLiquidado - V57;
  nuRangoInferior  := V58;
  IF (nuTotalDigitado < nuRangoInferior OR
     nuTotalDigitado > nuRangoSuperior) THEN
    V60 := 2741;
    V61 := 'El Valor Total digitado no se encuentra dentro del rango del Valor Liquidado para el Plan Comercial';
    GI_BOERRORS.SETERRORCODEARGUMENT(V60, V61);
    V59 := 0;
    V62 := V59;
  ELSE
    null;
  END IF;
  errorNumber  := 0;
  errorMessage := NULL;
  --*/
END;
