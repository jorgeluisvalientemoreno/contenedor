CREATE OR REPLACE function LDC_FNUPROCESORECLAMOACTIVO(nudifenuse diferido.difenuse%type)
  return number is

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : LDC_FNUPROCESORECLAMOACTIVO
  DESCRIPCION    : Función que permitira retornar el valor total de la suma total de los
                   saldos pendientes de lso diferidoas asociados a un servicio y qeu estos
                   diferidos no esten asociados a un proceso en reclamo.
                   En caso de tener un valor mayor a 0 returna el total de la suma
                   En caso contrario retornara 0
  AUTOR          : JORGE VALIENTE
  FECHA          : 02/06/2016

  PARAMETROS              DESCRIPCION
  ============         ===================
   nudifenuse            Codigo del servicio a validar

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/

  cursor cutotalnoreclamo is
    SELECT --+ index(diferido IX_DIFE_NUSE)
     sum(decode(difesign, 'DB', difesape, -difesape)) valor_total
      FROM diferido
    /*+ pkBCDiferido.fnuBalanceFinanced */
     WHERE difenuse = nudifenuse
       AND difetire = 'D'
       AND difesign in ('DB', 'CR')
       AND difesape > 0
       and nvl(difeenre, 'N') = 'N';

  rfcutotalnoreclamo cutotalnoreclamo%rowtype;

begin

  Ut_Trace.TRACE('Inicio LDC_FNUPROCESORECLAMOACTIVO', 10);
  Ut_Trace.TRACE('nudifenuse[' || nudifenuse || ']', 10);

  open cutotalnoreclamo;
  fetch cutotalnoreclamo
    into rfcutotalnoreclamo;
  close cutotalnoreclamo;

  if rfcutotalnoreclamo.valor_total > 0 then
    Ut_Trace.TRACE('Retorna Valor [' || rfcutotalnoreclamo.valor_total || ']',
                   10);
    Ut_Trace.TRACE('Fin LDC_FNUPROCESORECLAMOACTIVO', 10);
    return rfcutotalnoreclamo.valor_total;
  else
    Ut_Trace.TRACE('Retorna Valor 0', 10);
    Ut_Trace.TRACE('Fin LDC_FNUPROCESORECLAMOACTIVO', 10);
    return 0;
  end if;

end LDC_FNUPROCESORECLAMOACTIVO;
/
GRANT EXECUTE on LDC_FNUPROCESORECLAMOACTIVO to SYSTEM_OBJ_PRIVS_ROLE;
/
