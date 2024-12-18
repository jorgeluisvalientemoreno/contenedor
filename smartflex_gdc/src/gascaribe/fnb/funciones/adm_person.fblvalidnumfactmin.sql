CREATE OR REPLACE FUNCTION adm_person.fblValidNumFactMin(inuSubscription in suscripc.susccodi%type)
  RETURN BOOLEAN

  /**************************************************************************
  Propiedad Intelectual de PETI
  Funcion     :  fblValidNumFactMin
  Descripcion :  Valida si el contrato cumple con el numero de facturas minimas
                 para la validacion de facturas en FIFAP.
  Autor       :  KCienfuegos
  Fecha       :  03-02-2015
  
  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  03-Mayo-2017    Jorge Valiente           CASO 200-882: Se retiro el desarrollo realizado en el CASO 200-85
                                                         por solicitud de los funcionarios Julia Gonzales (GDC) 
                                                         y Julio Cardona (EFI). Retornando al desarrollo original de 
                                                         KCienfuegos y modificando la logica para que tenga encuenta 
                                                         no solo prodcuto GAS sino otros tipos de prodcutos 
                                                         mediante un parametro COD_TIP_SER_CAN_FAC_MIN_FIFAP.
  04-03-2015      KCienfuegos.NC4821      Se trunca la fecha de vencimiento de la cuenta de cobro.
  03-02-2015      KCienfuegos.NC4820      Creacion.
  **************************************************************************/
 IS

  nuContFact   number := 0;
  nuMinFact    number := dald_parameter.fnuGetNumeric_Value('FACT_MIN_VENTAFNB',
                                                            0);
  nuProdGas    number := dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',
                                                            0);
  nuMesValFact number := nvl(dald_parameter.fnuGetNumeric_Value('NUM_MESES_VAFA_FNB'),
                             0);
  blResult     boolean := false;

  --Obtiene el numero de facturas
  cursor cuObtNumFact is
    SELECT COUNT(*)
      FROM cuencobr c, factura f
     WHERE f.factsusc = inuSubscription
       AND c.cucofact = f.factcodi
       AND C.CUCONUSE IN (SELECT distinct sesunuse
                           FROM servsusc s
                          WHERE s.sesususc = inuSubscription
                            AND sesuserv IN
                                (select to_number(column_value)
                                   from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIP_SER_CAN_FAC_MIN_FIFAP',
                                                                                                            NULL),
                                                                           
                                                                           ','))) --= nuProdGas
                         --AND rownum = 1
                         )
       AND abs(months_between(F.FACTFEGE, ldc_boconsgenerales.fdtgetsysdate)) <=
           nuMesValFact
       AND trunc(c.cucofeve) < trunc(ldc_boconsgenerales.fdtgetsysdate)
       AND ROWNUM <= nuMinFact;

BEGIN
  open cuObtNumFact;
  fetch cuObtNumFact
    into nuContFact;
  close cuObtNumFact;

  if nuContFact = nuMinFact then
    blResult := true;
  else
    blResult := false;
  end if;

  return blResult;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END fblValidNumFactMin;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FBLVALIDNUMFACTMIN', 'ADM_PERSON');
END;
/
