CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_CONSULTAVALDESMONTE" return constants_per.tyRefCursor IS
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_ConsultaValDesmonte
  Descripcion    : Función para consultar la info del valor de desmonte de la orden de aprobación
                   de ajustes de facturación.
  Fecha          : 24/11/2014

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  24/11/2014      KCienfuegos.RNP1225  Creación.
  ******************************************************************/

  cnuNULL_ATTRIBUTE constant number := 2126;

  sbORDER_ID ge_boInstanceControl.stysbValue;
  sbPACKAGE_ID ge_boInstanceControl.stysbValue;
  nuOrderId      or_order.order_id%type;
  nuPackageId    mo_packages.package_id%type;
  sbQuery        varchar(2000);
  rfcursor    constants_per.tyRefCursor;

BEGIN

    sbORDER_ID := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');
    sbPACKAGE_ID := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'PACKAGE_ID');

  ------------------------------------------------
  -- Required Attributes
  ------------------------------------------------

  if (sbORDER_ID is null and sbPACKAGE_ID is null) then
    Errors.SetError(cnuNULL_ATTRIBUTE, 'Orden');
    raise ex.CONTROLLED_ERROR;
  end if;

  ------------------------------------------------
  -- User code
  ------------------------------------------------


    if sbORDER_ID is not null then
      nuOrderId := to_number(sbORDER_ID);

      nuPackageId  := ldc_boutilities.fsbgetvalorcampotabla('OR_ORDER_ACTIVITY',
                                                                     'ORDER_ID',
                                                                 'PACKAGE_ID',
                                                                   nuOrderId);
    end if;

   if sbPACKAGE_ID is not null then
     nuPackageId := to_number(sbPACKAGE_ID);

   end if;

    nuPackageId := nvl(nuPackageId,-1);

    sbQuery := 'select ap.apmosoli "Solicitud", cp.caapconc ||'' - ''||co.concdesc "Concepto",cp.caapvalo "Valor", cp.caapsign "Signo", ap.apmofere "Fecha de Registro"' ||  chr(10) ||
                  'from fa_apromofa ap, fa_notaapro na, fa_cargapro cp, concepto co'||  chr(10) ||
                 'where ap.apmocons = na.noapapmo ' ||  chr(10) ||
                   'and ap.apmosoli ='|| nuPackageId ||  chr(10) ||
                   'and na.noapdoso = cp.caapdoso' ||  chr(10) ||
                   'and na.noapnume = cp.caapcodo'  ||  chr(10) ||
                   'and cp.caapconc = co.conccodi';


  ut_trace.trace('Ejecución LDC_ConsultaValDesmonte sbQuery => ' ||
                 sbQuery,
                 11);

  OPEN rfCursor FOR sbQuery;

  ut_trace.trace('Fin LDC_ConsultaValDesmonte', 10);

  return rfCursor;
EXCEPTION
  when no_data_found then
    if rfCursor%isopen then
      close rfCursor;
    end if;
    raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
    raise;

  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;

END LDC_ConsultaValDesmonte;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CONSULTAVALDESMONTE', 'ADM_PERSON');
END;
/