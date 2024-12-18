CREATE OR REPLACE PACKAGE        "PK_MIGRACION_GARANTIAS" AS
/* *********************************************************************
Propiedad intelectual de Gases de Occidente

United        : PK_MIGRACION_GARANTIAS
Description   : Realiza la migracion de las garantias de los medidores de GAPSLUS
Autor         : Manuel Alejandro Palomares // Olsoftware
Fecha         : 17-01-2013
Proyecto   	  : Frente de Datos - Migracion a SmartFlex

HISTORIA DE DEPURACION
FECHA         AUTOR      DESCRIPCION
=====         =======    ================================================
***********************************************************************/

	procedure pr_carga_garantias(nuInicial in  number,nuFinal in number,basedato in number);

	procedure pr_carga_garantia(nuSusc in number, nuBasedato in number,sbError out varchar2);

	procedure pr_carga_garantiasConexiones(nuSesunuse number,nuBaseDato  number);

	procedure pr_registraWarranty(sqSEQ_GE_ITEM_WARRANTY number, nuitem number, nuIDproduct number, fechaFeco date, sActivo varchar2, sbError out varchar2);

END PK_MIGRACION_GARANTIAS;
/
