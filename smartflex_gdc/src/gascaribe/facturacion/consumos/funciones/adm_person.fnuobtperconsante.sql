CREATE OR REPLACE FUNCTION "ADM_PERSON"."FNUOBTPERCONSANTE" (inusesu servsusc.sesunuse%type,
                                              inupecs lectelme.leempecs%type) return number is

  /**************************************************************************

      Autor       : F.castro
      Fecha       : 19-11-2018
      Ticket      : 200-2237
      Descripcion : Funcion que obtiene periodo de cobsumo anterior

      Parametros Entrada


      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

  nuperant lectelme.leempecs%type;
  begin
    begin
      nuperant := open.pkbcpericose.fnugetpreviousperiod(inusesu,open.pktblpericose.fdtgetpecsfeci(inupecs));
    exception when others then
      nuperant := null;
    end;
    return nuperant;
  exception when others then
      return null;
  end fnuObtPerConsAnte;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUOBTPERCONSANTE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FNUOBTPERCONSANTE TO REXEREPORTES;
/

