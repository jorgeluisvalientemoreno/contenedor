CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUCOMODATO" (v_subscription_id ld_manual_quota.subscription_id%TYPE) RETURN NUMBER IS
/**************************************************************************************
Propiedad Intelectual de SINCECOMP (C).

Funcion     : ldc_fnucomodato
Descripcion : Funcion que retorna:
              (1) --> Para las subscripciones que estan registradas en la tabla LD_SUBS_COMO_DATO y estan dentro de un rango de fechas validos.
              (0) --> Para aquellos que NO.
Autor       : Sebastian Tapias
Fecha       : 10-05-2017

***Variables de Entrada***

v_subscription_id -- Ingresa el codigo del contrato a consultar.

***Variables de Salida***

v_comodato -- Variable de retorno

Historia de Modificaciones

  Fecha               Autor                Modificacion
=========           =========          ====================
***************************************************************************************/
v_comodato NUMBER := 0; -- Variable de Retorno
vt_subscription_id NUMBER; -- Varibale temporal para almacenar el resultado de la consulta.
BEGIN
 BEGIN
    /*Consultamos si el contrato se encuentra registrado y con un campo de fechas vigentes*/
   SELECT CODACONT INTO vt_subscription_id
    FROM  LD_SUBS_COMO_DATO
   WHERE TRUNC (codafivi) < = TRUNC (sysdate)
     AND TRUNC (codaffvi) > = TRUNC (sysdate)
     AND TRUNC (codacont) = TRUNC (v_subscription_id);
   /*Comparamos la variable de entrada con la obtenida de la consulta.

   Si el contratista cumple con las condiciones nos arroja 1

   Si el contratista no existe o no cumple las condiciones mandara 0
   */
  IF vt_subscription_id = v_subscription_id THEN
    v_comodato := 1;
  ELSE
    v_comodato := 0;
  END IF;
  /* En caso de que no se generen registros nos aseguramos de mandar 0 */
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    v_comodato := 0;
 END;
 RETURN v_comodato; -- Retornamos la variable.
EXCEPTION
 WHEN OTHERS THEN
   /* En caso de un error inesperado mandaremos tambien 0*/
  RETURN 0;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUCOMODATO', 'ADM_PERSON');
END;
/