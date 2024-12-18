create or replace procedure adm_person.ldc_valida_apto_rp(inuContrato in pr_product.subscription_id%TYPE,
                                               nu_result   out number,
                                               fecha_max   out date) IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.
  Nombre del Servicio: LDC_VALIDA_APTO_RP
  Descripcion: procedimiento para validAR cuando el contrato y/o producto asociado, sea (apto)
         para generar la Revision Periodica y no se encuentre vencido en el tiempo de la misma.

    Autor    : HORBATH
    Caso     : 234
    Fecha    : 15/07/2020

    Historia de Modificaciones

   DD-MM-YYYY    <Autor>.              Modificacion
   -----------  -------------------    -------------------------------------
   09/09/2022   Jorge Valiente         OSF-542: Realizar el llamado del servicio LDC_FNUCUENTASSALDOSPRODUCTO.
                                                Si el valor devuelto por esta funcion es mayor o igual al valor
                                                del parametro CANT_CTA_SALDO_RESTR_RECON el proceso debe
                                                devolver 0 en la variable nu_result y no debe continuar con el
                                                resto de validaciones, esto para indicar que el producto no esta apto para RP.
	 19-04-2024	  Adrianavg		           OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON                                                
    ******************************************************************/

  nuProducto  number;
  valexiste   number;
  nuCantMeses number;
  nuValsupt   NUMBER;
  numerror    NUMBER;
  sbmessage   VARCHAR2(2000);

  PRAGMA AUTONOMOUS_TRANSACTION;
  cursor cuProducGas(NUCONTRATO NUMBER) is
    select product_id
      from pr_product
     where product_type_id = 7014
       and subscription_id = NUCONTRATO;

  cursor cuValsupt(NUPRODUCTI_ID NUMBER) is
    select 1
      from pr_product pr, pr_prod_suspension prs
     where pr.product_id = prs.product_id
       and pr.product_id = NUPRODUCTI_ID
       and pr.product_status_id = 2
       and prs.active = 'Y'
       and prs.suspension_type_id in
           (select to_number(column_value)
              from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('PAR_SUSPEN_TYPE',
                                                                                       NULL),
                                                      ',')));

  cursor cuFecMax(NUPRODUCTI_ID NUMBER) is
    select PLAZO_MAXIMO
      from ldc_plazos_cert
     where ID_PRODUCTO = NUPRODUCTI_ID;

  cursor cuValprogen(NUPRODUCTI_ID NUMBER) is
    select 1
      from LDC_PROGEN_SAC_RP
     where PRODUCT_ID = NUPRODUCTI_ID
       and estado != 'A';

  ---OSF-542
  --variable
  nuCANT_CTA_SALDO_RESTR_RECON open.ldc_pararepe.parevanu%type := open.daldc_pararepe.fnuGetPAREVANU('CANT_CTA_SALDO_RESTR_RECON',
                                                                                                     null);

  nuCantCuentasSaldo number; --Cantidad de cuentas con saldo
  ---Final OSF-542

BEGIN

  OPEN cuProducGas(inuContrato);
  FETCH cuProducGas
    INTO nuProducto;
  CLOSE cuProducGas;

  ---OSF-542
  --validacion del numero de cuantas mayor o igual al paremrto CANT_CTA_SALDO_RESTR_RECON
  nuCantCuentasSaldo := LDC_FNUCUENTASSALDOSPRODUCTO(nuProducto);
  ut_trace.trace('Producto [' || nuProducto || ']');
  ut_trace.trace('Cantidad de cuentas con saldo [' || nuCantCuentasSaldo || ']');
  ut_trace.trace('Cantidad de cuentas para restringir [' ||
                 nuCANT_CTA_SALDO_RESTR_RECON || ']');

  if nuCantCuentasSaldo < nvl(nuCANT_CTA_SALDO_RESTR_RECON, 0) then

    OPEN cuValprogen(nuProducto);
    FETCH cuValprogen
      INTO valexiste;
    CLOSE cuValprogen;

    IF nvl(valexiste, 0) != 1 AND fblaplicaentregaxcaso('0000234') THEN
      IF nuProducto is not null THEN

        nuCantMeses := LDC_GETEDADRP(nuProducto);

        OPEN cuValsupt(nuProducto);
        FETCH cuValsupt
          INTO nuValsupt;
        CLOSE cuValsupt;
        nuValsupt := nvl(nuValsupt, 0);

        IF nvl(nuCantMeses, 0) >= 55 AND nuValsupt != 1 THEN

          IF nvl(nuCantMeses, 0) >= 55 AND nvl(nuCantMeses, 0) <= 59 THEN
            nu_result := 1;
          ELSIF nvl(nuCantMeses, 0) >= 60 THEN
            nu_result := 2;
          END IF;
        ELSE
          nu_result := 0;
        END IF;
      ELSE
        nu_result := 0;
      END IF;
    ELSE
      nu_result := 0;
    END IF;

    --OSF-542 de la validacion del nmero de cuotas
  else
    nu_result := 0;
  end if;
  --Final OSF-542 de la validacion del nmero de cuotas

  IF nu_result = 1 THEN
    OPEN cuFecMax(nuProducto);
    FETCH cuFecMax
      INTO fecha_max;
    CLOSE cuFecMax;
  ELSE
    fecha_max := sysdate;
  END IF;
EXCEPTION
  when others then
    nu_result := 0;
    errors.geterror(numerror, sbmessage);
    ut_trace.trace(numerror || ' - ' || sbmessage);
    Errors.setError;
END LDC_VALIDA_APTO_RP;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_VALIDA_APTO_RP
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDA_APTO_RP', 'ADM_PERSON'); 
END;
/