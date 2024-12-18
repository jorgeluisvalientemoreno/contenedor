CREATE OR REPLACE Package adm_person.pkLD_FA_BsApplicationPDDN IS

  /************************************************************************
  Propiedad intelectual de Ludycom S.A.

      Unidad         : pkLD_FA_BsApplicationPDDN
      Descripción    : componente de aplicación que permite gestionar la aplicación de los descuentos a los suscriptores
      Autor          : yennis.thorrens.SAOYennis thorrens
      Fecha          : 19/09/2012

      Métodos

      Nombre         : ApplyDiscount
      Parámetros     : Componente de aplicación que permite aplicar descuento a los suscriptores


      Nombre Parámetro     Tipo de Parámetro      Tipo de dato del Parámetro            Descripción
         inusesunuse         Entrada                servsusc.sesunuse%TYPE               Número del servicio
         inucargcuco         Entrada                cargos.cargcuco%TYPE                  Cuenta de cobro
         inunotacons         Entrada                notas.notacons%TYPE                   Tipo de documento
         idtnotafeco         Entrada                notas.notafeco%TYPE                   Fecha de facturacion
         isbnotaobse         Entrada                notas.notaobse%TYPE                   Observaciones
         isbnotadoso         Entrada                notas.notaDoso%TYPE                   Documento de soporte
         onunotanume         Salida                 notas.notanume%TYPE                   Número de la nota credito
         inunotadocu         Entrada                notas.notadocu%TYPE                   Documento

       ***************************************************************************************************************************************

      Historia de Modificaciones
      Fecha             Autor             Modificación
      =========         =========         ====================

      ******************************************************************/

  PROCEDURE ApplyDiscountN
  (
    Inususcripcion Suscripc.Susccodi%Type,       -- Contrato
    Inufactcodi    Factura.Factcodi%Type,        -- Factura
    Inununuse      Servsusc.Sesunuse%Type,       -- Producto
    Inucuencobr    Cuencobr.Cucocodi%Type,       -- Cuenta de Cobro
    Inuconcaplicar Ld_Fa_Critdesc.Crdecoap%Type, -- Concepto de Aplicación
    Inuvalodesc    Ld_Fa_Critdesc.Crdevade%Type, -- Valor del Descuento
    inuCodRegDeta  Ld_Fa_Detadepp.Dedpcodi%Type  -- Codigo del registro de Detalle
  );

  -- Obtiene la Version actual del Paquete
  FUNCTION fsbVersion RETURN varchar2;

END pkLD_FA_BsApplicationPDDN;
/
CREATE OR REPLACE Package Body adm_person.pkLD_FA_BsApplicationPDDN IS

	csbVersion constant varchar2(250) := 'OSF-2884';

	/**********************************************************************

	 	Propiedad intelectual de OPEN International Systems
	 	Nombre              ApplyDiscountN

	 	Autor				Ludycom

	 	Fecha               01-ene-2013

	 	Descripción         Procedimiento para la Aplicación del Descuento por Pronto Pago

	 	***Parametros***
	 	Nombre				Descripción
		Inususcripcion		Contrato
		Inufactcodi			Factura
		Inununuse			Producto
		Inucuencobr			Cuenta de Cobro
		Inuconcaplicar		Concepto de Aplicación
		Inuvalodesc			Valor del Descuento
		inuCodRegDeta		Codigo del registro de Detalle

	 	***Historia de Modificaciones***
	 	Fecha Modificación				Autor

	 	12-06-2014						aesguerra.3841
	 	Se modifica para que no deje cuentas negativas

	***********************************************************************/
	PROCEDURE ApplyDiscountN
	(
		Inususcripcion Suscripc.Susccodi%Type,       -- Contrato
		Inufactcodi    Factura.Factcodi%Type,        -- Factura
		Inununuse      Servsusc.Sesunuse%Type,       -- Producto
		Inucuencobr    Cuencobr.Cucocodi%Type,       -- Cuenta de Cobro
		Inuconcaplicar Ld_Fa_Critdesc.Crdecoap%Type, -- Concepto de Aplicación
		Inuvalodesc    Ld_Fa_Critdesc.Crdevade%Type, -- Valor del Descuento
		inuCodRegDeta  Ld_Fa_Detadepp.Dedpcodi%Type  -- Codigo del registro de Detalle
	)
	IS

		Nucausnota    Cargos.Cargcaca%Type;
		Nucreditno    Notas.Notacons%Type;
		Sbobservacion Ld_Fa_Paragene.Pagevate%Type;
		Sbsigno       Cargos.Cargsign%Type;
		Sbtnota       Notas.Notatino%Type;
		Sbajust       Parafact.Pafareca%Type;
		Sbnotadocus   Notas.Notadocu%Type;
		Orcnota       Notas%Rowtype;
		Dtpefafeco    Date := sysdate;
		Nuano         Number (10);
		Numes         Number (10);
		Isbnotadoso   Varchar2 (15);
		boRetorno     boolean := TRUE;  -- Procesado con Éxito
		Gsberrmsg     Ge_Error_Log.description%Type;

	BEGIN

		pkErrors.Push ('pkLD_FA_BsApplicationPDDN.ApplyDiscountN');

		Pkerrors.Setapplication('FGDP');

		/* Causal de la Nota Credito */
		Nucausnota := Ld_Fa_Fnu_Paragene('CAUSAL_NOTA_CREDITO');

		/* Nota de Crédito */
		Nucreditno := 71;

		/* Observación de la Nota */
		Sbobservacion := Ld_Fa_Fsb_Paragene('OBSERVACION_NOTA_DESCUENTO');

		/* Signo */
		Sbsigno := 'CR';

		/* Tipo de Nota */
		Sbtnota := 'C';

		/* Ajusta los cargos ? */
		Sbajust     := pkConstante.SI;

		Sbnotadocus := Null;

		-- Se concatena el Id del registro de Detalle del Descuento
		Isbnotadoso := 'DPP-' || inuCodRegDeta;

		FA_BOBillingNotes.SetUpdateDatabaseFlag;

		-- Registra la Nota de Facturación
		FA_BOBillingNotes.CreateBillingNote (
			Inususcripcion,	-- Contrato
			Inufactcodi,	-- Factura
			Nucreditno,		-- Tipo de Documento
			Dtpefafeco,		-- Fecha de Contabilizacion
			Sbobservacion,	-- Observacion
			'NC-',			-- Documento de Soporte
			Sbtnota,		-- Tipo de Nota
			Sbnotadocus,	-- Documento
			Orcnota			-- Registro de la Nota
		);

		pkBillingNoteMgr.setnotenumbercreated(Orcnota.Notanume);

		-- Registra el Cargo de la Nota
		FA_BOBillingNotes.DetailRegister (
			Orcnota.Notanume,	-- Numero de la Nota
			Inununuse,			-- Numero del Servicio
			Orcnota.Notasusc,	-- Contrato
			Inucuencobr,		-- Cuenta de Cobro
			Inuconcaplicar,		-- Concepto de Aplicación
			Nucausnota,			-- Causal de la Nota
			Inuvalodesc,		-- Valor del Descuento
			Inuvalodesc,		-- Saldo base del Diferido o Cuenta
			Isbnotadoso,		-- Documento de Soporte con Token 'DPP-' de Descuento Pronto Pago
			Sbsigno,			-- Signo
			Sbajust,			-- Ajuste ?(Y)
			Orcnota.Notadocu,	-- Documento de la Nota
			pkConstante.SI      -- Genera saldo a favor
		);

		FA_BOBillingNotes.SetUpdateDatabaseFlag(false);

		pkErrors.Pop;

	EXCEPTION
		When LOGIN_DENIED Then
			Pkerrors.Pop;
			raise LOGIN_DENIED;
		When pkConstante.exERROR_LEVEL2 Then
			Pkerrors.Pop;
			raise pkConstante.exERROR_LEVEL2;
		When OTHERS Then
			Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
			Pkerrors.Pop;
			Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
	END ApplyDiscountN;

	/**********************************************************************
	 	Propiedad intelectual de OPEN International Systems
	 	Nombre			fsbVersion

	 	Autor			OpenSystems

	 	Fecha			01-ene-2013

	 	Descripción		Obtiene el SAO que identifica la version asociada a la
						ultima entrega del paquete
	***********************************************************************/
	FUNCTION fsbVersion RETURN varchar2 IS
	BEGIN
		return (csbVersion);
	END fsbVersion;

END pkLD_FA_BsApplicationPDDN;
/
Prompt Otorgando permisos sobre ADM_PERSON.pkLD_FA_BsApplicationPDDN
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkLD_FA_BsApplicationPDDN'), 'ADM_PERSON');
END;
/
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BSAPPLICATIONPDDN to REXEOPEN;
GRANT EXECUTE on ADM_PERSON.PKLD_FA_BSAPPLICATIONPDDN to RSELSYS;
/
