CREATE OR REPLACE FUNCTION adm_person.FNUSALDODIFERIDO (  NUSESUNUSE IN NUMBER ) RETURN NUMBER AS
/**************************************************************************
  Autor       : Xiomara Castillo Feria - Olsoftware SAS
  Fecha       : 2013-03-19
  Descripcion : obtener el valor del saldo pendiente por diferido  por servicio
                suscrito

  Parametros Entrada
     NUSESUNUSE Codigo del servicio suscrito

  Valor de Retorno
    nuSaldo  Valor del saldo del diferido


 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   	DESCRIPCION
   02/01/2024	cgonzalez	OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
***************************************************************************/

 CURSOR CUDIFERIDO
     IS
 SELECT NVL( SUM(DIFESAPE), 0) NUSALDO
   FROM DIFERIDO
  where difenuse = NUSESUNUSE
	AND   DIFESAPE > 0;

  NUSALDO  NUMBER;

begin
  open  CUDIFERIDO;
  fetch CUDIFERIDO into nuSaldo;
  if CUDIFERIDO%notfound then
     close CUDIFERIDO;
     return (0);
  end if;
  close CUDIFERIDO;
  return (NUSALDO);
exception
  when others then
    RETURN (-1);
END FNUSALDODIFERIDO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUSALDODIFERIDO', 'ADM_PERSON');
END;
/