CREATE OR REPLACE FUNCTION adm_person.FNUSALDOPENDIENTE (   NUSESUNUSE IN NUMBER ) RETURN NUMBER AS

/**************************************************************************
  Autor       : Xiomara Castillo Feria - Olsoftware SAS
  Fecha       : 2013-03-19
  Descripcion : obtener el valor del saldo pendiente por servicio suscrito

  Parametros Entrada
     NUSESUNUSE Codigo del servicio suscrito

  Valor de Retorno
    nuSaldo  Valor del saldo del servicio suscrito


 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   	DESCRIPCION
   02/01/2024	cgonzalez	OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
***************************************************************************/

 CURSOR cuSaldo
     IS
 SELECT NVL( SUM(CUCOSACU),0) NUSALDO
   FROM CUENCOBR
  where CUCONUSE = NUSESUNUSE
	AND   CUCOSACU > 0;

  NUSALDO  NUMBER;

begin
  open  cuSaldo;
  fetch cuSaldo into nuSaldo;
  if cuSaldo%notfound then
     close cuSaldo;
     return (0);
  end if;
  close cuSaldo;
  return (NUSALDO);
exception
  when others then
    RETURN (-1);
END FNUSALDOPENDIENTE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUSALDOPENDIENTE', 'ADM_PERSON');
END;
/