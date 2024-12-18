CREATE OR REPLACE FUNCTION adm_person.fnusubs935 (
    inucuco IN NUMBER
) RETURN NUMBER IS
 /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FNUSUBS935
  Descripcion    : 

  Autor          : 
  Fecha          : 

  Parametros                      Descripcion
  ============                 ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  21-02-2024      Paola Acosta        OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON
                                                Se corrige el m�todo, se agrega al IF nuvalor IS NULL ya que la funci�n 
                                                no estaba entrando al IF cuando el valor retornado por el cursor daba null 
                                                y no estaba devolviendo cero como se esperaba.

  ******************************************************************/

    nuvalor        NUMBER := 0;
    nucaussubadi   NUMBER := dald_parameter.fnugetnumeric_value('LDC_CACASUBADI', NULL);
    nuporcsubadi   NUMBER := dald_parameter.fnugetnumeric_value('LDC_PORCSUBADI', NULL);
    nuconcsubadctt NUMBER := dald_parameter.fnugetnumeric_value('LDC_CONSUBADITT', NULL); --se alamacena subsidio adicional transitorio
    inucausal      NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSCARGTT', NULL); --se almacena causal de cargos
    nuconcsubadi   NUMBER := dald_parameter.fnugetnumeric_value('LDC_CONSUBADI', NULL);
    CURSOR cusubs935 IS
    SELECT
        SUM(decode(cargsign, 'DB', cargvalo, - cargvalo)) cargvalo
    FROM
        cargos
    WHERE
            cargcuco = inucuco
        AND cargconc IN ( nuconcsubadctt, nuconcsubadi )
        AND cargcaca IN ( nucaussubadi, inucausal );

BEGIN
    OPEN cusubs935;
    FETCH cusubs935 INTO nuvalor;
    CLOSE cusubs935;
    
    IF (cusubs935%notfound) OR (nuvalor IS NULL) THEN
        nuvalor := 0;
    END IF;
    
    RETURN nuvalor;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN ( 0 );
END fnusubs935;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUSUBS935', 'ADM_PERSON');
END;
/