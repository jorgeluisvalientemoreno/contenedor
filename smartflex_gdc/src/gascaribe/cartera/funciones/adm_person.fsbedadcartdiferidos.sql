CREATE OR REPLACE FUNCTION adm_person.fsbedadcartdiferidos (
    inunuse IN diferido.difenuse%TYPE,
    inudife IN diferido.difecodi%TYPE
) RETURN VARCHAR2 IS

 /*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Funcion que devuelve una cadena con los saldos pendientes de un diferido
                   a la fecha actual por edades de cartera

                   Se usa un vector de 6 posiciones y en ella se almacenan las edades de
                   cartera del diferido, siendo la posicion:
                   1  Presente Mes
                   2  30 Dias
                   3  60 Dias
                   4  90 Dias
                   5  120 Dias
                   6  Mas de 120 Dias

                   Devuelve una cadena con los saldos separados por el simbolo ";"

  Autor          : F.Castro
  Fecha          : 15-07-2016

  Fecha               Autor                Modificacion
  =========           =========          ====================
  22/02/2024          Paola Acosta       OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON 
                                                   En la consulta del cursor CUCUCO se convierte el tipo de la variable      
                                                   inudife de NUMBER a VARCHAR (to_char(inudife)) para controlar el error
                                                   en el que siempre estaba cayendo la funci�n por el tipo de variable.
  *******************************************************************************/

    TYPE array_t IS
        VARRAY(6) OF NUMBER(15, 2);
    array    array_t := array_t(0, 0, 0, 0, 0,
                            0);
    sbedades VARCHAR2(500);
    CURSOR cucuco IS
    SELECT
        cc.cucocodi,
        f.factfege,
        cc.cucofeve,
       /*cucofepa, cucovato, cucosacu, cargconc, cargsign, cargdoso, cargvalo, cargprog, cargfecr*/
        SUM(decode(cargsign, 'DB', cargvalo, - cargvalo)) cargvalo,
        trunc(sysdate - cc.cucofeve)                      dias
    FROM
        cuencobr cc,
        cargos   ca,
        factura  f
    WHERE
            cc.cuconuse = inunuse
        AND cc.cucocodi = ca.cargcuco
        AND f.factcodi = cc.cucofact
        AND cc.cucosacu > 0
        AND factprog = 6
        AND substr(ca.cargdoso, 4, 15) = to_char(inudife)
    GROUP BY
        cc.cucocodi,
        f.factfege,
        cc.cucofeve;

BEGIN
    FOR rg IN cucuco LOOP
        IF rg.dias <= 0 THEN
            array(1) := rg.cargvalo;
        ELSIF rg.dias <= 30 THEN
            array(2) := rg.cargvalo;
        ELSIF rg.dias <= 60 THEN
            array(3) := rg.cargvalo;
        ELSIF rg.dias <= 90 THEN
            array(4) := rg.cargvalo;
        ELSIF rg.dias <= 120 THEN
            array(5) := rg.cargvalo;
        ELSE
            array(6) := rg.cargvalo;
        END IF;
    END LOOP;

    sbedades := array(1)
                || ';'
                || array(2)
                || ';'
                || array(3)
                || ';'
                || array(4)
                || ';'
                || array(5)
                || ';'
                || array(6);

    RETURN sbedades;
    
EXCEPTION
    WHEN OTHERS THEN        
        RETURN ( '0;0;0;0;0;0' );
END fsbedadcartdiferidos;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBEDADCARTDIFERIDOS', 'ADM_PERSON');
END;
/