create or replace function LDC_FSBCERTIFICADOSN(nuProduct in open.pr_product.product_id%type)
/**************************************************************************
    Autor       : dsaltarin
    Fecha       : 06/10/2022
    Descripcion : SN:610: funcion para validar si un usuario instalado por servicios nuevos,
                  debe cobrar cargo fijo o no.
                  Si esta certificado o pasaron x días 
                  desde su instalación debe cobrar
                  

    Parametros Entrada
        nuProduct: Producto que se esta facturANDo
    Valor de salida
        S: Se debe cobrar cargo fijo
        N: No se debe cobrar cargo fijo.

	HISTORIA DE MODIFICACIONES
    FECHA       AUTOR   	DESCRIPCION
***************************************************************************/
  RETURN VARCHAR2 IS
  
  CURSOR cuValMarcado IS
  SELECT distinct p.package_id
   FROM open.mo_motive m
   INNER JOIN open.mo_packages p on p.package_type_id = 271
   INNER JOIN open.mo_comment  c on c.package_id = p.package_id AND c.comment_ like '%PLAN_PILOTO_2_VISITAS_V2%'
  WHERE m.product_id = nuProduct
    AND m.package_id=p.package_id;
    
  CURSOR cuOtlegalizada(nuTitr open.or_task_type.task_type_id%type,
                        nuSoli open.mo_packages.package_id%type) IS
  SELECT min(o.legalization_date) legalization_date
   FROM open.or_order o
   INNER JOIN open.or_order_activity a on o.order_id=a.order_id AND a.package_id = nuSoli
   WHERE o.task_type_id=nuTitr
   AND o.order_status_id=8
   AND o.causal_id=9944;
    
  nuPackage           open.mo_packages.package_id%type;
  nuSuspendido        NUMBER;
  dtFechaInst         open.or_order.legalization_date%type;
  dtFechaCert         open.or_order.legalization_date%type;
  nuCantDias          open.ld_parameter.numeric_value%type := open.dald_parameter.fnugetnumeric_value('NUM_DIAS_INSTALA_COBRA_CFIJO', null);
  
  
BEGIN
  BEGIN
    SELECT count(1)
    into nuSuspendido
    FROM open.pr_prod_suspension
    WHERE product_id = nuProduct
      AND suspension_type_id = 15
      AND active='Y';
  EXCEPTION
    WHEN OTHERS THEN
      nuSuspendido := 0;
  END;
  --Si ya se reconecto debe cobrar cargo fijo
  IF nuSuspendido = 0 THEN
    RETURN 'S';
  END IF;
  IF cuValMarcado%isopen THEN
    close cuValMarcado;
  END IF;
  --Se valida si el producto esta marcado, si no esta marcado debe cobrar cargo fijo
  open cuValMarcado;
  fetch cuValMarcado into nuPackage;
  IF cuValMarcado%notfound THEN
     RETURN 'S';
  END IF;
  close cuValMarcado;
  
  dtFechaCert := null;
  open cuOtlegalizada(12162, nuPackage);
  fetch cuOtlegalizada into dtFechaCert;
  close cuOtlegalizada;
  --ya estoy certificado cobro
  IF dtFechaCert IS not null THEN
    RETURN 'S';
  END IF;
  dtFechaInst := null;
  open cuOtlegalizada(12150, nuPackage);
  fetch cuOtlegalizada into dtFechaInst;
  close cuOtlegalizada;
  --Si ya pasaron 15 dias debe cobrar
  IF trunc(sysdate - dtFechaInst) > nuCantDias AND dtFechaInst IS not null THEN
    RETURN 'S';
  END IF;
  
  RETURN 'N';
EXCEPTION
WHEN OTHERS THEN
    errors.seterror;
    RETURN 'S';
END LDC_FSBCERTIFICADOSN;
/

GRANT EXECUTE ON LDC_FSBCERTIFICADOSN TO "SYSTEM_OBJ_PRIVS_ROLE";
/