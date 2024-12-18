CREATE OR REPLACE package                     PK_MIGRACION_GASPLUS_ESPECIAL as

  procedure MGR_LDC_MIG_CLIENTES_C;

  procedure MGR_LDC_MIG_CLIENTES_V;

  procedure MRG_LDC_MIG_CEDULA_C;

  procedure MRG_LDC_MIG_CEDULA_V;

  procedure LDC_MIG_DIRECCION_C;

  procedure LDC_MIG_DIRECCION_V;

  procedure LDC_MIG_PERIFACT_C;

  procedure LDC_MIG_PERIFACT_V;

  procedure PERIFACT_C;

  procedure PERIFACT_V;

   procedure PERIFACT_2004_C;

  procedure PERIFACT_2004_V;

  procedure PERICOSE;

  procedure AB_SYNONYM_C;

  procedure AB_SYNONYM_V;

  procedure AB_AWAY_BY_LOCATION_C;

  procedure AB_AWAY_BY_LOCATION_V;

  procedure LDC_MIG_FACTCUCO_C;

  procedure LDC_MIG_FACTCUCO_V;

  procedure AB_BLOCK_C;

  procedure AB_BLOCK_V;

  procedure LDC_MIG_CUCOHOMO_V;

  procedure AB_SEGMENTS_C;

  procedure AB_SEGMENTS_V  ;

  procedure AB_PREMISE;

  --procedure AB_PREMISE_V  ;

  procedure AB_ADDRESS_C (numInicio NUMBER, numFinal number )  ;
 -- procedure AB_ADDRESS_C;

  procedure AB_ADDRESS_V (numInicio NUMBER, numFinal number ) ;
  --procedure AB_ADDRESS_V ;

  procedure GE_SUBSCRIBER_C (numInicio NUMBER,numFinal NUMBER);

  procedure GE_SUBSCRIBER_V (numInicio NUMBER,numFinal NUMBER   );

  procedure SUSCRIPC_C (numInicio NUMBER,numFinal NUMBER   );

  procedure SUSCRIPC_V (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_PRODUCT_C (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_PRODUCT_V (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_PRODUCT_BRILLA_C;

  procedure PR_PRODUCT_BRILLA_V;

  procedure PR_COMPONENT_C (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_COMPONENT_V (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_COMPONENT_OTROS_C (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_COMPONENT_OTROS_V (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_PRODUCT_RETIRE_C;

  procedure PR_PRODUCT_RETIRE_V;

  procedure PR_PROD_SUSPENSION_C (numInicio NUMBER,numFinal NUMBER   );

  procedure PR_PROD_SUSPENSION_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure PR_COMP_SUSPENSION;

  procedure  PR_COMPONENT_RETIRE;

  procedure FACTURA_C (numInicio NUMBER,numFinal NUMBER   );

  procedure FACTURA_V (numInicio NUMBER,numFinal NUMBER   );

   procedure HICAESCO_C (NUMINICIO number,numFinal NUMBER   );

  procedure HICAESCO_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure HICAPLAN_C (numInicio NUMBER,numFinal NUMBER   );

  procedure HICAPLAN_V  (NUMINICIO number ,numFinal NUMBER   );

  procedure ELEMMEDI_C(NUMINICIO number,numFinal NUMBER   );

  procedure ELEMMEDI_V(NUMINICIO number,numFinal NUMBER   );

  procedure ELMESESU_C (NUMINICIO number,numFinal NUMBER   );

   procedure ELMESESU_V (NUMINICIO number,numFinal NUMBER   );

  procedure GE_ITEMS_SERIADO_C (NUMINICIO number,numFinal NUMBER   );

  procedure GE_ITEMS_SERIADO_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure TT_SERV_INTERRUP_C (numInicio NUMBER ,numFinal NUMBER   );

  procedure TT_SERV_INTERRUP_V (NUMINICIO number ,numFinal NUMBER   );

  procedure TT_COMPENSATION_C (NUMINICIO number ,numFinal NUMBER   );

  procedure TT_COMPENSATION_V (numInicio NUMBER,numFinal NUMBER   );

  procedure NOTAS_C (numInicio NUMBER ,numFinal NUMBER   );

  procedure NOTAS_V (NUMINICIO number ,numFinal NUMBER   );

  procedure SALDFAVO;

  procedure SUSPCONE_C (numInicio NUMBER,numFinal NUMBER   );

  procedure SUSPCONE_V (numInicio NUMBER,numFinal NUMBER   );

  procedure CONSSESU_C (numInicio NUMBER ,numFinal NUMBER   );

  procedure CONSSESU_V (numInicio NUMBER,numFinal NUMBER   );

  procedure CUENCOBR_C (numInicio NUMBER,numFinal NUMBER   );

  procedure CUENCOBR_V(numInicio NUMBER,numFinal NUMBER   );

  procedure CUENCOBR_BRILLA_C (numInicio NUMBER,numFinal NUMBER   );

  procedure CUENCOBR_BRILLA_V(numInicio NUMBER,numFinal NUMBER   );

  procedure DIFERIDO_C (NUMINICIO number,numFinal NUMBER   );

   procedure DIFERIDO_V (numInicio NUMBER,numFinal NUMBER   );

  procedure MOVIDIFE_C (numInicio NUMBER ,numFinal NUMBER   );

  procedure MOVIDIFE_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure CARGOS_C (numInicio NUMBER,numFinal NUMBER   );

  procedure CARGOS_V (numInicio NUMBER,numFinal NUMBER   );

  procedure FEULLICO;

  procedure LDC_MIG_CUCOFACT_V;

  procedure LDC_MIG_CUCOFACT_C;

  procedure CUPON_C (numInicio NUMBER,numFinal NUMBER   );

  procedure CUPON_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure LECTELME_C (numInicio NUMBER ,numFinal NUMBER   );

  procedure LECTELME_V (numInicio NUMBER ,numFinal NUMBER   );

  procedure ACTUALIZA_CUENCOBR;

  procedure ACTUALIZA_CUENCOBR_V;

  procedure GE_ITEMS;

  procedure GE_ITEMS_1;

  procedure or_route_c;

  procedure or_route_v;

  procedure or_route_premise_c;

   procedure or_route_premise_v;

   PROCEDURE PRACTUALIZA_TMP_PREDIO_GIS;

   procedure ACTUALIZA_ESTADOS_C (NUMINICIO number ,NUMFINAL number   );

  procedure ACTUALIZA_ESTADOS_V (NUMINICIO number ,NUMFINAL number   );

  PROCEDURE ACTUALIZA_LDC_MIG_DIRECCION;

  procedure LDC_MIG_DIRECCION_CALI(NUMINICIO number ,NUMFINAL number );

   procedure LDC_MIG_DIRECCION_VALLE(NUMINICIO number ,NUMFINAL number );

   procedure ACTUALIZA_CUENTAS_BRILLA;

   procedure PR_ACTUALIZA_SALDOS;

   procedure pr_crea_impuesto;

    procedure HICOPRPM_C;

    procedure HICOPRPM_V;

    procedure COPRSUCA;

    PROCEDURE LDC_QUOTA_BLOCK_C;

    PROCEDURE LDC_QUOTA_BLOCK_V;

    PROCEDURE PREJSEEJ;

    procedure CONCILIA_C;

    procedure CONCILIA_V;

    procedure PAGOS_C;

    PROCEDURE PAGOS_V;

  /* TODO enter package declarations (types, exceptions, methods etc) here */

END PK_MIGRACION_GASPLUS_ESPECIAL;
/
