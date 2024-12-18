CREATE OR REPLACE FUNCTION adm_person.fnu_ldc_getsaldconc (
    inusesu     IN  cuencobr.cuconuse%TYPE,
    inucuco     IN  cuencobr.cucocodi%TYPE,
    inuconc     IN  cargos.cargconc%TYPE
) RETURN VARCHAR2 IS

 /***************************************************************************
  Funcion: ldc_getsaldxconc

  Descripcion:    Obtiene el saldo a la fecha de un concepto en particular de una cuenta o de todas
                  las cuentas de un producto

  Autor: F.Castro
  Fecha: Abril 19 de 2018

  Parametros
  inusesu      Producto
  inucuco      -1 para todas las cuentas con saldo del producto,
               numero de cuenta: para buscar los conceptos con saldo de una cuenta
  inuconc      -1 para que devuelva cadena con concepto, descripcion y saldo a la fecha
                  de todos los conceptos con saldo a la fecha actual
               - 2 para que devuelva cadena solo con el saldo a la fecha de los conceptos de consumo
               codigo de concepto:  para que devuelva cadena solo con el saldo a la fecha del concepto dado

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  06/03/2023      Paola Acosta        OSF-2180: Se agregan permisos para REXEREPORTES
  
  21-02-2024     Paola Acosta    OSF-2180: Migraci�n del esquema OPEN al esquema ADM_PERSON
                                           Se agrega clasificaci�n de los parametros de la funci�n como IN.
                                           
  27-03-2019     F.Castro        Se contempla parametro inuconc = -2, lo que identificara
                                 que se debe devolver el saldo de los conceptos de consumo
                                 solamente (los que estan en parametro COD_CONCEPTO_CONSUMO)

  ***************************************************************************/

    TYPE rcconc IS RECORD (
        cargcuco NUMBER,
        cargconc NUMBER,
        cargvalo NUMBER,
        cargescc VARCHAR2(1)
    );
    TYPE tbconc IS
        TABLE OF rcconc INDEX BY VARCHAR2(14);
    tconc          tbconc;
    sbindice       VARCHAR2(14);
    TYPE rcconcres IS RECORD (
        cargconc NUMBER,
        cargvrve NUMBER,
        cargvrnv NUMBER,
        difesape NUMBER
    );
    TYPE tbconcres IS
        TABLE OF rcconcres INDEX BY PLS_INTEGER;
    tconcres       tbconcres;
    nuindice       PLS_INTEGER;
    nusaldocc      NUMBER := 0;
    sbcadena       VARCHAR2(2000) := NULL;
    sbconcconsumo  ld_parameter.value_chain%TYPE;
    nusaldoconsumo NUMBER;
    CURSOR cucargos IS
    SELECT
        cargcuco,
        cargconc,
        CASE
            WHEN cucofeve < sysdate THEN
                'V'
            ELSE
                'N'
        END                    estadocc,
        SUM(decode(cargsign, 'CR', - cargvalo, 'PA', - cargvalo,
                   'AS', - cargvalo, 'TS', - cargvalo, 'NS',
                   - cargvalo, cargvalo)) cargvalo
    FROM
        cargos,
        cuencobr
    WHERE
            cargcuco = cucocodi
        AND cuconuse = inusesu
        AND cucocodi = decode(inucuco, - 1, cucocodi, inucuco)
        AND cucosacu > 0
        AND cargconc NOT IN ( 9, 145, 123 )
    GROUP BY
        cargcuco,
        cargconc,
        cucofeve
    ORDER BY
        cargcuco,
        cargconc;

    CURSOR cucargosres IS
    SELECT
        cargconc,
         /*sum(decode(cargsign,'CR',-cargvalo,'PA',-cargvalo,'AS',-cargvalo,'TS',-cargvalo,'NS',-cargvalo,cargvalo))*/
        0 cargvalo
    FROM
        cargos,
        cuencobr
    WHERE
            cargcuco = cucocodi
        AND cuconuse = inusesu
        AND cucocodi = decode(inucuco, - 1, cucocodi, inucuco)
        AND cucosacu > 0
        AND cargconc NOT IN ( 9, 145, 123 )
    GROUP BY
        cargconc
    ORDER BY
        cargconc;

    CURSOR cucuentas IS
    SELECT DISTINCT
        ( cucocodi ) cucocodi
    FROM
        cuencobr
    WHERE
            cuconuse = inusesu
        AND cucocodi = decode(inucuco, - 1, cucocodi, inucuco)
        AND cucosacu > 0
    ORDER BY
        cucocodi;

    CURSOR cupagos (
        nucuco NUMBER
    ) IS
    SELECT
        cargcuco,
        cucofeve,
        cargsign,
        cargfecr,
        cargvalo,
        cargcodo
    FROM
        cargos,
        cuencobr
    WHERE
            cargcuco = cucocodi
        AND cucocodi = nucuco
        AND cargsign IN ( 'PA', 'AS' )
    ORDER BY
        cargfecr;

    CURSOR curesureca (
        nucupon NUMBER,
        cdtfeve DATE
    ) IS
    SELECT
        r.rereconc,
        r.rerevalo
    FROM
        resureca r
    WHERE
            r.rerecupo = nucupon
        AND r.rerefeve = cdtfeve;
-------------------------------------------------------
    FUNCTION isconsumo (
        inucons concepto.conccodi%TYPE
    ) RETURN VARCHAR2 IS
        sbval VARCHAR2(1) := NULL;
    BEGIN
        BEGIN
            SELECT
                'S'
            INTO sbval
            FROM
                dual
            WHERE
                inucons IN (
                    SELECT
                        to_number(column_value)
                    FROM
                        TABLE ( ldc_boutilities.splitstrings((sbconcconsumo), ',') )
                );

        EXCEPTION
            WHEN OTHERS THEN
                sbval := 'N';
        END;

        RETURN ( sbval );
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'N';
    END;
-------------------------------------------------------
    FUNCTION fnugetsaldocc (
        inucuenta NUMBER
    ) RETURN NUMBER IS
        sbindex VARCHAR2(14);
        nusaldo NUMBER := 0;
    BEGIN
        sbindex := tconc.first;
        LOOP
            EXIT WHEN ( sbindex IS NULL );
            IF tconc(sbindex).cargcuco = lpad(inucuenta, 10, '0') THEN
                nusaldo := nusaldo + tconc(sbindex).cargvalo;
            END IF;

            sbindex := tconc.next(sbindex);
        END LOOP;

        RETURN ( nusaldo );
    END;
-------------------------------------------------------
    FUNCTION fnugetsaldife (
        inuconc NUMBER
    ) RETURN NUMBER IS

        nusaldife NUMBER := 0;
        CURSOR cudife IS
        SELECT
            SUM(difesape)
        FROM
            diferido
        WHERE
                difenuse = inusesu
            AND difesape > 0
            AND difeconc = inuconc;

    BEGIN
        OPEN cudife;
        FETCH cudife INTO nusaldife;
        IF cudife%notfound THEN
            nusaldife := 0;
        END IF;
        CLOSE cudife;
        RETURN ( nvl(nusaldife, 0) );
    END;
-------------------------------------------------------
    FUNCTION fsbdescconc (
        inuconce NUMBER
    ) RETURN VARCHAR IS
        sbdesc concepto.concdesc%TYPE;
        CURSOR cuconcepto IS
        SELECT
            concdesc
        FROM
            concepto
        WHERE
            conccodi = inuconce;

    BEGIN
        OPEN cuconcepto;
        FETCH cuconcepto INTO sbdesc;
        IF cuconcepto%notfound THEN
            sbdesc := NULL;
        END IF;
        CLOSE cuconcepto;
        RETURN ( sbdesc );
    END;
-------------------------------------------------------

    PROCEDURE praplicaas (
        inucuenta  NUMBER,
        inusaldo   NUMBER,
        inucargoas NUMBER
    ) IS
        sbindex   VARCHAR2(14);
        nuvlrapli NUMBER := 0;
    BEGIN
        sbindex := tconc.first;
        LOOP
            EXIT WHEN ( sbindex IS NULL );
            IF tconc(sbindex).cargcuco = lpad(inucuenta, 10, '0') THEN
                nuvlrapli := inucargoas * ( tconc(sbindex).cargvalo * 100 / inusaldo ) / 100;

                tconc(sbindex).cargvalo := tconc(sbindex).cargvalo - nuvlrapli;
            END IF;

            sbindex := tconc.next(sbindex);
        END LOOP;

    END;
-------------------------------------------------------

BEGIN
    tconc.DELETE;
    tconcres.DELETE;

    -- carga saldos de conceptos por cuenta
    FOR rg IN cucargos LOOP
        sbindice := lpad(rg.cargcuco, 10, '0')
                    || lpad(rg.cargconc, 4, '0');

        tconc(sbindice).cargcuco := rg.cargcuco;
        tconc(sbindice).cargconc := rg.cargconc;
        tconc(sbindice).cargescc := rg.estadocc;
        tconc(sbindice).cargvalo := rg.cargvalo;
    END LOOP;

    FOR rg IN cucargosres LOOP
        nuindice := rg.cargconc;
        tconcres(nuindice).cargconc := rg.cargconc;
        tconcres(nuindice).cargvrve := 0;
        tconcres(nuindice).cargvrnv := 0;
        tconcres(nuindice).difesape := fnugetsaldife(rg.cargconc);
    END LOOP;

    FOR rg IN cucuentas LOOP
        FOR rg2 IN cupagos(rg.cucocodi) LOOP
            IF rg2.cargsign = 'PA' THEN
                FOR rg3 IN curesureca(rg2.cargcodo, rg2.cucofeve) LOOP
                    sbindice := lpad(rg2.cargcuco, 10, '0')
                                || lpad(rg3.rereconc, 4, '0');

                    IF tconc.EXISTS(sbindice) THEN
                        tconc(sbindice).cargvalo := tconc(sbindice).cargvalo - rg3.rerevalo;

                    END IF;

                END LOOP;

            ELSE -- cargsign AS
                nusaldocc := fnugetsaldocc(rg2.cargcuco);
                praplicaas(rg2.cargcuco, nusaldocc, rg2.cargvalo);
            END IF;
        END LOOP;
    END LOOP;

    -- arma salida para cuando es cc -conce - valor
    /*sbIndice :=  tconc.first;
    loop exit when (sbIndice IS null);
     sbcadena := sbcadena || tconc(sbIndice).cargconc || ';' ||
                 fsbdescconc(tconc(sbIndice).cargconc) || ';' ||
                 tconc(sbIndice).cargvalo || ';';
     sbIndice := tconc.next(sbIndice);
    end loop;*/

    -- resume conceptos
    sbindice := tconc.first;
    LOOP
        EXIT WHEN ( sbindice IS NULL );
        nuindice := tconc(sbindice).cargconc;
        IF tconcres.EXISTS(nuindice) THEN
            IF tconc(sbindice).cargescc = 'V' THEN
                tconcres(nuindice).cargvrve := tconcres(nuindice).cargvrve + tconc(sbindice).cargvalo;

            ELSE
                tconcres(nuindice).cargvrnv := tconcres(nuindice).cargvrnv + tconc(sbindice).cargvalo;
            END IF;
        END IF;

        sbindice := tconc.next(sbindice);
    END LOOP;

    -- arma salida para cuando es conce - valor
    IF inuconc = -1 THEN -- todos los conceptos
        nuindice := tconcres.first;
        LOOP
            EXIT WHEN ( nuindice IS NULL );
            sbcadena := sbcadena
                        || tconcres(nuindice).cargconc
                        || ';'
                        || fsbdescconc(tconcres(nuindice).cargconc)
                        || ';'
                        || tconcres(nuindice).cargvrve
                        || ';'
                        || tconcres(nuindice).cargvrnv
                        || ';'
                        || tconcres(nuindice).difesape
                        || '|';

            nuindice := tconcres.next(nuindice);
        END LOOP;

    ELSIF inuconc = -2 THEN -- todos los conceptos de consumo
        BEGIN
            SELECT
                p.value_chain
            INTO sbconcconsumo
            FROM
                ld_parameter p
            WHERE
                p.parameter_id = 'COD_CONCEPTO_CONSUMO';

        EXCEPTION
            WHEN OTHERS THEN
                sbconcconsumo := '31';
        END;

        nuindice := tconcres.first;
        nusaldoconsumo := 0;
        LOOP
            EXIT WHEN ( nuindice IS NULL );
            IF nvl(isconsumo(tconcres(nuindice).cargconc), 'N') = 'S' THEN
                nusaldoconsumo := nusaldoconsumo + tconcres(nuindice).cargvrve + tconcres(nuindice).cargvrnv;

            END IF;

            nuindice := tconcres.next(nuindice);
        END LOOP;

        sbcadena := nusaldoconsumo;
    ELSE -- vencido de un concepto en particular
        nuindice := inuconc;
        IF tconcres.EXISTS(nuindice) THEN
            sbcadena := tconcres(nuindice).cargvrve + tconcres(nuindice).cargvrnv;
        ELSE
            sbcadena := 0;
        END IF;

    END IF;

    tconc.DELETE;
    tconcres.DELETE;
    RETURN sbcadena;
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END fnu_ldc_getsaldconc;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNU_LDC_GETSALDCONC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON adm_person.fnu_ldc_getsaldconc TO REXEREPORTES;
/
