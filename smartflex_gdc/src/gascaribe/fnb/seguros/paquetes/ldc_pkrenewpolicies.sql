CREATE OR REPLACE PACKAGE LDC_PKRenewPolicies AS

  /*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKRenewPolicies
  Descripcion    : Paquete para el PB LDRPC el cual procesa LAS RENOVACIONES
                  Y ESTAS PUEDEN SER POR P?LIZAS, NUMERO DE COLECTIVO Y MES DEL COLECTIVO
  Autor          : Karem Baquero
  Fecha          : 18/09/2017 ERS 200-1480

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha      Autor                 	Modificacion
  ========== ===================== 	====================
  05/04/2023 cgonzalez (Horbath)	OSF-952: Ajuste a los servicios getPolByCollecAndProdLine, 
											 getPolByCollectAndProdLine y getPolBypolizaAndProdLine.
											 Se adicionan los metodos CountPolByCollecAndProdLine, 
											 CountPolByCollectAndProdLine y CountPolBypolizaAndProdLine
  ******************************************************************/
  ------------------
  -- Constantes
  ------------------
  csbYes constant varchar2(1) := 'Y';
  csbNo  constant varchar2(1) := 'N';
  -- cnuValorTopeAjuste constant number := 1;
  -- Error en la configuracion normal de cuotas
  -- cnuERROR_CUOTA constant number(6) := 10381;

  -----------------------
  -- Variables
  -----------------------

  nuDepa cuencobr.cucodepa%type;
  nuLoca cuencobr.cucoloca%type;
  --------------------Variables a extraer

  -----------------------
  -- Elementos Packages
  -----------------------
    PROCEDURE getValidateDatandtypren(inuMonth       in number,
                                    inudato in number) ;
  
	PROCEDURE CountPolByCollecAndProdLine(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE, onuRecords OUT NUMBER);
  
	PROCEDURE getPolByCollecAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor);
									  
	PROCEDURE CountPolByCollectAndProdLine(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE, onuRecords OUT NUMBER);
									  
	PROCEDURE getPolByCollectAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor);

	PROCEDURE CountPolBypolizaAndProdLine(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE, onuRecords OUT NUMBER);

	PROCEDURE getPolBypolizaAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor);
                                      
                           

END LDC_PKRenewPolicies;
/
create or replace package body LDC_PKRenewPolicies AS

/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : LDC_PKRenewPolicies
  Descripcion    : Paquete para el PB LDRPC el cual procesa LAS RENOVACIONES
                  Y ESTAS PUEDEN SER POR P?LIZAS, NUMERO DE COLECTIVO Y MES DEL COLECTIVO
  Autor          : Karem Baquero
  Fecha          : 18/09/2017 ERS 200-1480

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============   ===================
  Historia de Modificaciones
  Fecha         Autor                   Modificacion
  =========     =========               ====================

  ******************************************************************/

  ------------------
  -- Constantes
  ------------------
  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO
  csbVersion CONSTANT VARCHAR2(250) := 'OSF-952';

  -- Nombre del programa ejecutor Generate Invoice
  csbPROGRAMA constant varchar2(4) := 'ANDM';

  -- Maximo numero de registros Hash para Parametros o cadenas
  cnuHASH_MAX_RECORDS constant number := 100000;

  -- Constante de error de no Aplicacion para el API OS_generateInvoice
  cnuERRORNOAPLI number := 500;

  cnuNivelTrace constant number(2) := 5;
  -----------------------
  -- Variables
  -----------------------
  sbErrMsg varchar2(2000); -- Mensajes de Error

  -- Programa
  sbApplication varchar2(10);

  sbgUser     varchar2(50); -- Nombre usuario
  sbgTerminal varchar2(50); -- Terminal
  gnuPersonId ge_person.person_id%type; -- Id de la persona
  
  
  /*****************************************************************
   Propiedad intelectual de PETI (c).
  
   Unidad         : getValidateDatandtypren
   Descripcion    : Se valida el tipo de renovacion y el dato a renovar
   Autor          : JM-Gestion Informatica -- Karem Baquero
   Fecha          : 19-09-2017
  
   Parametros          Descripcion
   ============        ===================
   inuMonth            dato con el que se va a realizar la  renovacion
   inudato             Identificador de la linea de producto
   
  
   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   19-09-2017  Karem Baquero       Caso 200-1480 Creacion
  ******************************************************************/
  PROCEDURE getValidateDatandtypren(inuMonth       in number,
                                    inudato in number) IS

nulength number;  
nupoli number;                                  
               Begin
                 if      inuMonth =1 then
                   
                 select  length(inudato)into nulength from dual;
                  if nulength > 2 then
                        ge_boerrors.seterrorcodeArgument(ld_boconstans.cnuGeneric_Error,
                                               'El mes colectivo debe tener 2 digitos');
                    end if;
                   
                   elsif    inuMonth =2 then
                     select  length(inudato)into nulength from dual;
                  if nulength<> 4 then
                    ge_boerrors.seterrorcodeArgument(ld_boconstans.cnuGeneric_Error,
                                               'El colectivo debe tener 4 digitos');
                    end if;
                    
                    else
                     
                       select count(l.policy_id) into nupoli from ld_policy l where l.policy_id=nvl(inudato,null) and l.state_policy=1;
                       if nupoli =0 then
                            ge_boerrors.seterrorcodeArgument(ld_boconstans.cnuGeneric_Error,
                                               'Esta póliza no es valida o no se encuentra en un estado activo');
                         end if;
                   
                   end if;          
                                      
                                       EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getValidateDatandtypren;
  
  
	/*****************************************************************
	Propiedad intelectual de PETI (c).

	Unidad         : CountPolByCollecAndProdLine
	Descripcion    : Cuenta las polizas a renovar a partir del dato correspondiente para el mes colectivo
	Autor          : Carlos Gonzalez
	Fecha          : 20/04/2023

	Historia de Modificaciones
	Fecha       Autor          		Modificacion
	==========  =================== =======================
	20/04/2023  cgonzalez (Horbath) OSF-952: Creacion
	******************************************************************/
	PROCEDURE CountPolByCollecAndProdLine
	(
		inuMonth 		IN NUMBER, 
		inuProductLine 	IN ld_product_line.product_line_id%TYPE,
		onuRecords 		OUT NUMBER
	)
	IS
		CURSOR cuPolizas(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE)
		IS
			SELECT /*+ index (p IDX_LD_POLICY_01)*/
					COUNT(1)
			FROM 	ld_policy p
			WHERE 	TO_NUMBER(SUBSTR(collective_number, 3, 4)) = inuMonth
			AND 	state_policy = 1
			AND 	product_line_id = nvl(inuProductLine, product_line_id)
			AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
										index(c IDX_LD_SECURE_CANCELLA_02)
										index(s PK_MO_PACKAGES)
									*/ 'x' 
							FROM 	ld_secure_cancella c, mo_packages s 
							WHERE 	p.policy_id = c.policy_id 
							AND  	c.secure_cancella_id = s.package_id 
							AND  	s.motive_status_id = 13);
	BEGIN
		ut_trace.trace('INICIO CountPolByCollecAndProdLine',5);
		ut_trace.trace('inuMonth: '||inuMonth,5);
		ut_trace.trace('inuProductLine: '||inuProductLine,5);
		
		OPEN cuPolizas(inuMonth, inuProductLine);
		FETCH cuPolizas INTO onuRecords;
		CLOSE cuPolizas;
		
		ut_trace.trace('onuRecords: '||onuRecords,5);
		ut_trace.trace('FIN CountPolByCollecAndProdLine',5);
	
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR THEN
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END CountPolByCollecAndProdLine;
  
  /*****************************************************************
   Propiedad intelectual de PETI (c).
  
   Unidad         : getPolByCollecAndProdLine
   Descripcion    : Obtiene las polizas a renovar a partir del dato correspondiente para el mes colectivo
                    ingresado desde la forma
   Autor          : JM-Gestion Informatica -- Karem Baquero
   Fecha          : 19-09-2017
  
   Parametros          Descripcion
   ============        ===================
   inuMonth            dato con el que se va a realizar la  renovacion
   inuProductLine      Identificador de la linea de producto
   orfPolicies         CURSOR con las polizas que cumplen las condiciones
  
   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   19-09-2017  Karem Baquero       Caso 200-1480 Creacion
   05/04/2023  cgonzalez (Horbath) OSF-952: Se modifica la consulta orfPolicies
  ******************************************************************/
  PROCEDURE getPolByCollecAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor) IS
  BEGIN
  
    open orfPolicies for
      SELECT /*+ index (p IDX_LD_POLICY_01)*/
		   policy_id,
		   state_policy,
		   launch_policy,
		   contratist_code,
		   product_line_id,
		   dt_in_policy,
		   dt_en_policy,
		   value_policy,
		   prem_policy,
		   name_insured,
		   suscription_id,
		   product_id,
		   identification_id,
		   period_policy,
		   year_policy,
		   month_policy,
		   deferred_policy_id,
		   dtcreate_policy,
		   share_policy,
		   dtret_policy,
		   valueacr_policy,
		   report_policy,
		   dt_report_policy,
		   dt_insured_policy,
		   per_report_policy,
		   policy_type_id,
		   id_report_policy,
		   cancel_causal_id,
		   fees_to_return,
		   comments,
		   policy_exq,
		   number_acta,
		   geograp_location_id,
		   validity_policy_type_id,
		   policy_number
        FROM ld_policy p
		WHERE TO_NUMBER(SUBSTR(collective_number, 3, 4)) = inuMonth
        AND state_policy = 1
		AND product_line_id = nvl(inuProductLine, product_line_id)
		AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
									index(c IDX_LD_SECURE_CANCELLA_02)
									index(s PK_MO_PACKAGES)
								*/ 'x' 
						FROM 	ld_secure_cancella c, mo_packages s 
						WHERE 	p.policy_id = c.policy_id 
						AND  	c.secure_cancella_id = s.package_id 
						AND  	s.motive_status_id = 13);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getPolByCollecAndProdLine;
  
  
	/*****************************************************************
	Propiedad intelectual de PETI (c).

	Unidad         : CountPolByCollectAndProdLine
	Descripcion    : Cuenta las polizas a renovar a partir del dato correspondiente para el mes colectivo
	Autor          : Carlos Gonzalez
	Fecha          : 20/04/2023

	Historia de Modificaciones
	Fecha       Autor          		Modificacion
	==========  =================== =======================
	20/04/2023  cgonzalez (Horbath) OSF-952: Creacion
	******************************************************************/
	PROCEDURE CountPolByCollectAndProdLine
	(
		inuMonth 		IN NUMBER, 
		inuProductLine 	IN ld_product_line.product_line_id%TYPE,
		onuRecords 		OUT NUMBER
	)
	IS
		CURSOR cuPolizas(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE)
		IS
			SELECT /*+ index (p IDX_LD_POLICY_09)*/
					COUNT(1)
			FROM 	ld_policy p
			WHERE 	state_policy = 1
			AND 	collective_number = inuMonth
			AND 	product_line_id = nvl(inuProductLine, product_line_id)
			AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
										index(c IDX_LD_SECURE_CANCELLA_02)
										index(s PK_MO_PACKAGES)
									*/ 'x' 
							FROM 	ld_secure_cancella c, mo_packages s 
							WHERE 	p.policy_id = c.policy_id 
							AND  	c.secure_cancella_id = s.package_id 
							AND  	s.motive_status_id = 13);
	BEGIN
		ut_trace.trace('INICIO PolByCollectAndProdLine',5);
		ut_trace.trace('inuMonth: '||inuMonth,5);
		ut_trace.trace('inuProductLine: '||inuProductLine,5);
		
		OPEN cuPolizas(inuMonth, inuProductLine);
		FETCH cuPolizas INTO onuRecords;
		CLOSE cuPolizas;
		
		ut_trace.trace('onuRecords: '||onuRecords,5);
		ut_trace.trace('FIN PolByCollectAndProdLine',5);
	
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR THEN
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END CountPolByCollectAndProdLine;
  
  /*****************************************************************
   Propiedad intelectual de PETI (c).
  
   Unidad         : getPolByCollectAndProdLine
   Descripcion    : Obtiene las polizas a renovar a partir del dato correspondiente por el colectivo completo
                    ingresado desde la forma
   Autor          : JM-Gestion Informatica -- Karem Baquero
   Fecha          : 19-09-2017
  
   Parametros          Descripcion
   ============        ===================
   inuMonth            dato con el que se va a realizar la  renovacion
   inuProductLine      Identificador de la linea de producto
   orfPolicies         CURSOR con las polizas que cumplen las condiciones
  
   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   19-09-2017  Karem Baquero       Caso 200-1480 Creacion
   05/04/2023  cgonzalez (Horbath) OSF-952: Se modifica la consulta orfPolicies
  ******************************************************************/
  PROCEDURE getPolByCollectAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor) IS
  BEGIN
    open orfPolicies for
      SELECT /*+ index (p IDX_LD_POLICY_09) */
			   policy_id,
			   state_policy,
			   launch_policy,
			   contratist_code,
			   product_line_id,
			   dt_in_policy,
			   dt_en_policy,
			   value_policy,
			   prem_policy,
			   name_insured,
			   suscription_id,
			   product_id,
			   identification_id,
			   period_policy,
			   year_policy,
			   month_policy,
			   deferred_policy_id,
			   dtcreate_policy,
			   share_policy,
			   dtret_policy,
			   valueacr_policy,
			   report_policy,
			   dt_report_policy,
			   dt_insured_policy,
			   per_report_policy,
			   policy_type_id,
			   id_report_policy,
			   cancel_causal_id,
			   fees_to_return,
			   comments,
			   policy_exq,
			   number_acta,
			   geograp_location_id,
			   validity_policy_type_id,
			   policy_number
        FROM ld_policy p
		WHERE state_policy = 1
		AND collective_number = inuMonth
		AND product_line_id = nvl(inuProductLine, product_line_id)
        AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
									index(c IDX_LD_SECURE_CANCELLA_02)
									index(s PK_MO_PACKAGES)
								*/ 'x' 
						FROM 	ld_secure_cancella c, mo_packages s 
						WHERE 	p.policy_id = c.policy_id 
						AND  	c.secure_cancella_id = s.package_id 
						AND  	s.motive_status_id = 13);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getPolByCollectAndProdLine;
  
  
	/*****************************************************************
	Propiedad intelectual de PETI (c).

	Unidad         : CountPolBypolizaAndProdLine
	Descripcion    : Cuenta las polizas a renovar a partir del dato correspondiente para el mes colectivo
	Autor          : Carlos Gonzalez
	Fecha          : 20/04/2023

	Historia de Modificaciones
	Fecha       Autor          		Modificacion
	==========  =================== =======================
	20/04/2023  cgonzalez (Horbath) OSF-952: Creacion
	******************************************************************/
	PROCEDURE CountPolBypolizaAndProdLine
	(
		inuMonth 		IN NUMBER, 
		inuProductLine 	IN ld_product_line.product_line_id%TYPE,
		onuRecords 		OUT NUMBER
	)
	IS
		CURSOR cuPolizas(inuMonth IN NUMBER, inuProductLine IN ld_product_line.product_line_id%TYPE)
		IS
			SELECT 	/*+ index(p PK_LD_POLICY) */
					COUNT(1)
			FROM 	ld_policy p
			WHERE 	policy_id = inuMonth
			AND 	product_line_id = nvl(inuProductLine, product_line_id)
			AND 	state_policy = 1
			AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
										index(c IDX_LD_SECURE_CANCELLA_02)
										index(s PK_MO_PACKAGES)
									*/ 'x' 
							FROM 	ld_secure_cancella c, mo_packages s 
							WHERE 	p.policy_id = c.policy_id 
							AND  	c.secure_cancella_id = s.package_id 
							AND  	s.motive_status_id = 13);
	BEGIN
		ut_trace.trace('INICIO PolBypolizaAndProdLine',5);
		ut_trace.trace('inuMonth: '||inuMonth,5);
		ut_trace.trace('inuProductLine: '||inuProductLine,5);
		
		OPEN cuPolizas(inuMonth, inuProductLine);
		FETCH cuPolizas INTO onuRecords;
		CLOSE cuPolizas;
		
		ut_trace.trace('onuRecords: '||onuRecords,5);
		ut_trace.trace('FIN PolBypolizaAndProdLine',5);
	
	EXCEPTION
		WHEN ex.CONTROLLED_ERROR THEN
			RAISE ex.CONTROLLED_ERROR;
		WHEN OTHERS THEN
			Errors.setError;
			RAISE ex.CONTROLLED_ERROR;
	END CountPolBypolizaAndProdLine;

/*****************************************************************
   Propiedad intelectual de PETI (c).
  
   Unidad         : getPolByCollectAndProdLine
   Descripcion    : Obtiene las polizas a renovar a partir del dato correspondiente a la póliza
                    ingresado desde la forma
   Autor          : JM-Gestion Informatica -- Karem Baquero
   Fecha          : 19-09-2017
  
   Parametros          Descripcion
   ============        ===================
   inuMonth            dato con el que se va a realizar la  renovacion
   inuProductLine      Identificador de la linea de producto
   orfPolicies         CURSOR con las polizas que cumplen las condiciones
  
   Historia de Modificaciones
   Fecha            Autor          Modificacion
   ==========  =================== =======================
   19-09-2017  Karem Baquero       Caso 200-1480 Creacion
   05/04/2023  cgonzalez (Horbath) OSF-952: Se modifica la consulta orfPolicies
  ******************************************************************/
  PROCEDURE getPolBypolizaAndProdLine(inuMonth       in number,
                                      inuProductLine in ld_product_line.product_line_id%type,
                                      orfPolicies    out constants.tyrefcursor) IS
  BEGIN
    open orfPolicies for
      SELECT /*+ index(p PK_LD_POLICY) */
			   policy_id,
			   state_policy,
			   launch_policy,
			   contratist_code,
			   product_line_id,
			   dt_in_policy,
			   dt_en_policy,
			   value_policy,
			   prem_policy,
			   name_insured,
			   suscription_id,
			   product_id,
			   identification_id,
			   period_policy,
			   year_policy,
			   month_policy,
			   deferred_policy_id,
			   dtcreate_policy,
			   share_policy,
			   dtret_policy,
			   valueacr_policy,
			   report_policy,
			   dt_report_policy,
			   dt_insured_policy,
			   per_report_policy,
			   policy_type_id,
			   id_report_policy,
			   cancel_causal_id,
			   fees_to_return,
			   comments,
			   policy_exq,
			   number_acta,
			   geograp_location_id,
			   validity_policy_type_id,
			   policy_number
        FROM ld_policy p
		WHERE policy_id = inuMonth
        AND product_line_id = nvl(inuProductLine, product_line_id)
        AND state_policy = 1
        AND NOT EXISTS (SELECT 	/*+ use_nl(c s)
									index(c IDX_LD_SECURE_CANCELLA_02)
									index(s PK_MO_PACKAGES)
								*/ 'x' 
						FROM 	ld_secure_cancella c, mo_packages s 
						WHERE 	p.policy_id = c.policy_id 
						AND  	c.secure_cancella_id = s.package_id 
						AND  	s.motive_status_id = 13);
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END getPolBypolizaAndProdLine;
  

END LDC_PKRenewPolicies;
/
GRANT execute ON LDC_PKRenewPolicies TO SYSTEM_OBJ_PRIVS_ROLE;
/