CREATE OR REPLACE PACKAGE personalizaciones.PKG_TARIFATRANSITORIA IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    personalizaciones.PKG_TARIFATRANSITORIA
    Autor       :   Carlos Andres Gonzalez - HORBATH
    Fecha       :   07-03-2023
    Descripcion :   Paquete con las consultas de la funcionalidad LDCGCTT
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    cgonzalez   07-03-2023  OSF-943 Creacion
    adrianavg   06-10-2023  OSF-1709: Se reemplaza el llamado al servicio ldc_boConsGenerales.fnuGetPersonId
                            por el servicio pkg_bopersonal.fnuGetPersonaId
    adrianavg   24-10-2023  OSF-1709: Se reemplazan algunos metodos, variables por su homologo existente en
                            personalizaciones.homologacion_servicios. Se retira el esquema OPEN
                            antepuesto a los objetos: servsusc
    adrianavg   25-10-2023  OSF-1709: Se reemplaza el nombre de este paquete LDC_PKTARIFATRANSITORIA 
                            del esquema persolizaciones por PKG_TARIFATRANSITORIA                           
*******************************************************************************/

	-- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;

	FUNCTION GetDatosLDC_DEPRTATT(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor;

	FUNCTION GetInformacionCliente(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor;

	FUNCTION GetReceptiontype
	RETURN constants_per.tyRefCursor;

	FUNCTION GetResumenConcepto(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor;

	FUNCTION GetIdentificatype RETURN constants_per.tyRefCursor;

	FUNCTION GetValidaDocumento(Inutipodoc number, Inudoc varchar2)
    RETURN number;

END PKG_TARIFATRANSITORIA;
/


CREATE OR REPLACE PACKAGE BODY personalizaciones.PKG_TARIFATRANSITORIA IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    personalizaciones.PKG_TARIFATRANSITORIA
    Autor       :   Carlos Andres Gonzalez - HORBATH
    Fecha       :   07-03-2023
    Descripcion :   Paquete con las consultas de la funcionalidad LDCGCTT
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    cgonzalez   07-03-2023  OSF-943 Creacion
    adrianavg   06-10-2023  OSF-1709: En la función GetReceptiontype se reemplaza el llamado al servicio
							ldc_boConsGenerales.fnuGetPersonId por el servicio pkg_bopersonal.fnuGetPersonaId
    adrianavg   06-10-2023  OSF-1709: Se reemplazan algunos metodos, variables por su homologo existente en
                            personalizaciones.homologacion_servicios
    adrianavg   25-10-2023  OSF-1709: Se reemplaza el nombre de este paquete LDC_PKTARIFATRANSITORIA 
                            del esquema persolizaciones por PKG_TARIFATRANSITORIA                            
*******************************************************************************/

	-- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-1709';

	-- Constantes para el control de la traza
    csbNOMPKG      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.'; --Constante nombre método
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna el identificador del ultimo caso que hizo cambios en el paquete
    Autor       	: Carlos Andres Gonzalez - HORBATH
    Fecha       	: 07-03-2023
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   07-03-2023  OSF-943  Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

	FUNCTION GetDatosLDC_DEPRTATT(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor IS
	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
    Adrianavg   24-10-2023  OSF-1709 Modificación: Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                            Se reemplaza Errors.setError por PKG_ERROR.SETERROR
                            Se reemplaza ut_trace por PKG_TRAZA.TRACE. Se retira el esquema OPEN
                            antepuesto a los objetos: servsusc, ld_parameter, perifact, concepto, causcarg, ldc_deprtatt
  ***************************************************************************/

		rfcursor 		constants_per.tyRefCursor;
		nuConcepto  	ld_parameter.numeric_value%type;
        csbMetodo       CONSTANT VARCHAR(60) := csbNOMPKG||'GetDatosLDC_DEPRTATT';

	BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        pkg_traza.trace('inservsusc: '||inservsusc , csbNivelTraza);

		nuConcepto := ldc_bcConsGenerales.fsbValorColumna('LD_PARAMETER','NUMERIC_VALUE','PARAMETER_ID','LDC_CONCTATT') ;

		OPEN rfcursor FOR
			  select ld.dpttfact factura,
					 (select pf.pefacodi || ' - ' || pf.pefadesc
						from perifact pf
					   where pf.pefacodi = ld.dpttperi) periodo,
					 ld.dpttcuco cuenta,
					 (select c.conccodi || ' - ' || c.concdesc
						from concepto c
					   where c.conccodi = ld.dpttconc) concepto,
					 (select ccg.cacacodi || ' - ' || ccg.cacadesc
						from causcarg ccg
					   where ccg.cacacodi = ld.dpttcaca) causalcargo,
					 ld.dpttnume nota,
					 ld.dpttfere fecharegistro,
					 ld.dpttsign signonota,
					 ld.dpttvano valornota
				from LDC_DEPRTATT ld
			   where ld.dpttcont = inservsusc
			   AND   ld.dpttconc = nuConcepto
			   order by ld.dpttfere desc;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN rfcursor;

	EXCEPTION
		When PKG_ERROR.CONTROLLED_ERROR then
			raise PKG_ERROR.CONTROLLED_ERROR;
		When others then
			PKG_ERROR.SETERROR;
			raise PKG_ERROR.CONTROLLED_ERROR;
	END GetDatosLDC_DEPRTATT;

	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
	07-03-2023 	CGONZALEZ  	OSF-943: Se ajusta para consultar la direccion del cobro del contrato
    24-10-2023  Adrianavg   OSF-1709 Modificación: Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                            Se reemplaza Errors.setError por PKG_ERROR.SETERROR
                            Se reemplaza ut_trace por PKG_TRAZA.TRACE. Se retira el esquema OPEN
                            antepuesto a los objetos: servsusc, ld_parameter, suscripc, ldc_deprtatt, ldc_prodtatt, ge_subscriber,
                            ab_address
  ***************************************************************************/
	FUNCTION GetInformacionCliente(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor IS

		rfcursor 		constants_per.tyRefCursor;
		csbMetodo       CONSTANT VARCHAR(60) := csbNOMPKG||'GetInformacionCliente';
		sbCategorias 	ld_parameter.value_chain%TYPE := ldc_bcConsGenerales.fsbValorColumna('LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','COD_CAT_INV_TAR_TRA');
		sbEstratos 		ld_parameter.value_chain%TYPE := ldc_bcConsGenerales.fsbValorColumna('LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','COD_EST_INV_TAR_TRA');

		cursor cucategoria IS
			select 	nvl(
						(SELECT sv.sesucate
						FROM servsusc sv
						WHERE sv.sesunuse = ld.dpttsesu
						AND sv.sesucate NOT IN (NVL((SELECT TO_NUMBER(regexp_substr(sbCategorias,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(sbCategorias, '[^|,]+', 1, level) IS NOT NULL), 0))
						),
					 0) categoria
			from suscripc s, LDC_DEPRTATT ld
		   where ld.dpttcont = inservsusc
			 and s.susccodi = ld.dpttcont
			 and (select count(lp.prttsesu)
					from LDC_PRODTATT lp
				   where lp.prttsesu = ld.dpttsesu
					 and lp.prttacti = 'S') > 0
			 and rownum = 1;

		nucategoria number;

	BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		open cucategoria;
		fetch cucategoria into nucategoria;
		close cucategoria;

		if nucategoria > 0 then

			OPEN rfcursor FOR
				select ld.dpttsesu servicio,
				   gs.subscriber_name || ' - ' || gs.subs_last_name nombre,
				   gs.phone telefono,
				   ldc_bcConsGenerales.fsbValorColumna('AB_ADDRESS','ADDRESS','ADDRESS_ID',s.susciddi) direccion,
				   nvl((SELECT sv.sesusuca
						 FROM servsusc sv
						WHERE sv.sesunuse = ld.dpttsesu
						  and rownum = 1),
					   0) estrato
			  from suscripc s, ge_subscriber gs, LDC_DEPRTATT ld
			 where ld.dpttcont = inservsusc
			   and s.susccodi = ld.dpttcont
			   and gs.subscriber_id = s.suscclie
			   and (select count(lp.prttsesu)
					  from LDC_PRODTATT lp
					 where lp.prttsesu = ld.dpttsesu
					   and lp.prttacti = 'S') > 0
			   and rownum = 1;
		else

			open rfcursor for
				select ld.dpttsesu servicio,
					   gs.subscriber_name || ' - ' || gs.subs_last_name nombre,
					   gs.phone telefono,
					   ldc_bcConsGenerales.fsbValorColumna('AB_ADDRESS','ADDRESS','ADDRESS_ID',s.susciddi) direccion,
					   nvl((SELECT sv.sesusuca
							 FROM servsusc sv
							WHERE sv.sesunuse = ld.dpttsesu
							AND sv.sesusuca NOT IN (NVL((SELECT TO_NUMBER(regexp_substr(sbEstratos,'[^|,]+', 1, level))
										FROM DUAL A
										CONNECT BY regexp_substr(sbEstratos, '[^|,]+', 1, level) IS NOT NULL), 0))
							),
						   0) estrato
				  from suscripc s, ge_subscriber gs, LDC_DEPRTATT ld
				 where ld.dpttcont = inservsusc
				   and s.susccodi = ld.dpttcont
				   and gs.subscriber_id = s.suscclie
				   and (select count(lp.prttsesu)
						  from LDC_PRODTATT lp
						 where lp.prttsesu = ld.dpttsesu
						   and lp.prttacti = 'S') > 0
				   and rownum = 1;

		end if;

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN rfcursor;

	EXCEPTION
		When PKG_ERROR.CONTROLLED_ERROR then
			raise PKG_ERROR.CONTROLLED_ERROR;
		When others then
			PKG_ERROR.SETERROR;
			raise PKG_ERROR.CONTROLLED_ERROR;
	END GetInformacionCliente;

	FUNCTION GetReceptiontype RETURN constants_per.tyRefCursor IS

	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
    Adrianavg   24-10-2023  OSF-1709 Modificación: Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                            Se reemplaza Errors.setError por PKG_ERROR.SETERROR.
                            Se reemplaza ut_trace por PKG_TRAZA.TRACE
                            Se retira el esquema OPEN antepuesto a los objetos: ge_reception_type, or_ope_uni_rece_type
                            or_operating_unit, cc_orga_area_seller
  ***************************************************************************/

		rfcursor 	constants_per.tyRefCursor;
		csbMetodo   CONSTANT VARCHAR(60) := csbNOMPKG||'GetReceptiontype';

	BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		OPEN rfcursor FOR
			SELECT distinct r.RECEPTION_TYPE_ID id, r.description
			FROM ge_reception_type    r,
				 or_ope_uni_rece_type o,
				 or_operating_unit    u
			WHERE r.reception_type_id = o.reception_type_id
			and o.operating_unit_id = u.operating_unit_id
			and u.operating_unit_id IN
				(SELECT organizat_area_id
				FROM cc_orga_area_seller
				WHERE person_id = pkg_bopersonal.fnuGetPersonaId
				AND IS_current = 'Y')
				order by r.RECEPTION_TYPE_ID;

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN rfcursor;

	EXCEPTION
		When PKG_ERROR.CONTROLLED_ERROR then
			raise PKG_ERROR.CONTROLLED_ERROR;
		When others then
			PKG_ERROR.SETERROR;
			raise PKG_ERROR.CONTROLLED_ERROR;
	END GetReceptiontype;

	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
	07-03-2023 	CGONZALEZ  	OSF-943: Se ajusta para consultar la direccion del cobro del contrato
                            Se retira el esquema OPEN antepuesto a los objetos: servsusc
  ***************************************************************************/

	FUNCTION GetResumenConcepto(inservsusc IN servsusc.sesunuse%TYPE)
    RETURN constants_per.tyRefCursor IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : GetResumenConcepto
    Descripcion     : Retorna resumen de saldo de tarifa transitoria
    Autor       	: Carlos Andres Gonzalez - HORBATH
    Fecha       	: 07-03-2023
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    LJLB        21/04/2023  OSF-1042    se agrega condicion para que si el saldo del concepto es negativo se
                                        coloque cero
    cgonzalez   07-03-2023  OSF-943     Creacion
    Adrianavg   24-10-2023  OSF-1709    Modificación: Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                        Se reemplaza Errors.setError por PKG_ERROR.SETERROR
                                        Se reemplaza ut_trace por PKG_TRAZA.TRACE
                                        Se retira el esquema OPEN antepuesto a los objetos: ld_parameter, concepto, ldc_deprtatt
    ***************************************************************************/
		rfcursor 	constants_per.tyRefCursor;
		csbMetodo   CONSTANT VARCHAR(60) := csbNOMPKG||'GetResumenConcepto';
		nuConcepto  ld_parameter.numeric_value%TYPE;

	BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		nuConcepto := ldc_bcConsGenerales.fsbValorColumna('LD_PARAMETER','NUMERIC_VALUE','PARAMETER_ID','LDC_CONCTATT');

		OPEN rfcursor FOR
			SELECT concepto, CASE WHEN valornota < 0 THEN 0 ELSE valornota END valornota
      FROM (select concepto, sum((valornota )) valornota
			from (select 	(select c.conccodi || ' - ' || c.concdesc
							from concepto c
							where c.conccodi = ld.dpttconc) concepto,
							decode(ld.dpttsign, 'DB', -ld.dpttvano, ld.dpttvano) valornota
					from LDC_DEPRTATT ld
					where ld.dpttcont = inservsusc
					AND ld.dpttconc = nuConcepto)
			group by concepto);

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN rfcursor;

	EXCEPTION
		When PKG_ERROR.CONTROLLED_ERROR then
			raise PKG_ERROR.CONTROLLED_ERROR;
		When others then
			PKG_ERROR.SETERROR;
			raise PKG_ERROR.CONTROLLED_ERROR;
	END GetResumenConcepto;

	FUNCTION GetIdentificatype RETURN constants_per.tyRefCursor IS
	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
    24-10-2023  Adrianavg   OSF-1709 Modificación: Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                            Se reemplaza Errors.setError por PKG_ERROR.SETERROR
                            Se retira el esquema OPEN antepuesto a los objetos: GE_IDENTIFICA_TYPE
  ***************************************************************************/
		rfcursor 	constants_per.tyRefCursor;
		csbMetodo   CONSTANT VARCHAR(60) := csbNOMPKG||'GetIdentificatype';

	BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		OPEN rfcursor FOR
			select distinct t.ident_type_id id, t.description
			from GE_IDENTIFICA_TYPE t
			where t.ident_type_id <> -1
			order by 1;

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN rfcursor;

	EXCEPTION
		When PKG_ERROR.CONTROLLED_ERROR then
			raise PKG_ERROR.CONTROLLED_ERROR;
		When others then
			PKG_ERROR.SETERROR;
			raise PKG_ERROR.CONTROLLED_ERROR;
	END GetIdentificatype;

	FUNCTION GetValidaDocumento(Inutipodoc number, Inudoc varchar2)
	/**************************************************************************
	HISTORIA DE MODIFICACIONES
    FECHA 		AUTOR   	DESCRIPCION
    24-10-2023  Adrianavg   OSF-1709 Modificación: Se reemplaza ut_trace por PKG_TRAZA.TRACE
                            Se retira el esquema OPEN antepuesto a los objetos: ge_subscriber
  ***************************************************************************/
    RETURN number IS

		cursor cusubscriber IS
			select gs.subscriber_id subscriberid
			from ge_subscriber gs
			where gs.ident_type_id = Inutipodoc
			and gs.identification = Inudoc;

		nusubscriberid ge_subscriber.subscriber_id%TYPE := 0;
		csbMetodo   CONSTANT VARCHAR(60) := csbNOMPKG||'GetValidaDocumento';

	BEGIN
		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		open cusubscriber;
		fetch cusubscriber into nusubscriberid;
		close cusubscriber;

		pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

		RETURN nvl(nusubscriberid, 0);

	EXCEPTION
		When others then
			RETURN nvl(nusubscriberid, 0);
	END GetValidaDocumento;

END PKG_TARIFATRANSITORIA;
/
PROMPT Otorgando permisos de ejecución a PKG_TARIFATRANSITORIA
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_TARIFATRANSITORIA', 'PERSONALIZACIONES'); 
END;
/