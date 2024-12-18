CREATE OR REPLACE PACKAGE        "PK_MIGRA_ORDERGASP_1" AS
/* *********************************************************************
Propiedad intelectual de Gases de Occidente

United        : PK_MIGRA_ORDERGASP
Description   : Realiza migracion de ordenes en estado cerrado
Autor         : Manuel Alejandro Palomares // Olsoftware
Fecha         : 08-11-2012
Proyecto   	  : Frente de Datos - Migracion SmartFlex

HISTORIA DE DEPURACION
FECHA         AUTOR      DESCRIPCION
=====         =======    ================================================

***********************************************************************/


  procedure proCarga_ORDENES(NUMINICIO in number,NUMFINAL in number,nuBd in number);

  procedure proCarga_OR_ORDER(nuse in number, susc in number,bd in number,sbErr out varchar2);

  procedure proCarga_OR_ORDER_ACTIVITY(nuOrderID in number,
										 nuTypetask in number,
										 nuSubscriber in  number,
										 nuSusc in number,
										 nuIdproduc in number,
										 orMessage out varchar2,
										 nuSeqActivity out number,
                     nuTypeActivityItem in number default null);

  procedure proCarga_OR_ORDER_COMMENT(ORDER_ID NUMBER,LEGALIZE_COMMENT VARCHAR2);

  procedure proCarga_prCertificate(  PRODUCT_ID in number,
									 ORDER_ACT_CERTIF_ID in number,
									 REGISTER_DATE in date,
									 REVIEW_DATE in date,
									 ESTIMATED_END_DATE in date,
									 END_DATE in date,
									 ORDER_ACT_REVIEW_ID in number,
									 sbOk out varchar2);


procedure proCarga_Mo_package(nuSusc in number,
									 REQUEST_DATE in date,
									 MESSAG_DELIVERY_DATE in DATE,
									 PACKAGE_TYPE_ID in number,
									 SUBSCRIBER_ID in number,
									 ATTENTION_DATE in date,
									 ORDER_ID in number,
									 CERTIFICATE_ID in varchar2,
									 sbOk out varchar2);

PROCEDURE pr_sequences_cache;

END PK_MIGRA_ORDERGASP_1;
/
