CREATE OR REPLACE FUNCTION adm_person.ldc_visualcondter (
    inucontrato IN suscripc.susccodi%TYPE
) RETURN NUMBER IS
  /***********************************************************************************************************
    Funcion     : LDC_VISUALCONDTER
    Descripcion : Procedimiento que validara si debe o no visualizar la opcion de configuracion
                  Retornara 1 si puede Visualizar o 0 si no puede Visualizar
    Autor       : Daniel Valiente
    Fecha       : 26/02/2019

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    29/02/2024          Paola Acosta       OSF-2104: Migracion del esquema OPEN al esquema ADM_PERSON 
  ************************************************************************************************************/
    sbmensa      VARCHAR2(4000);
    CURSOR cuoperacion IS
    SELECT
        ( nvl(to_number(c.cucosacu), 0) - nvl(to_number(c.cucovare), 0) - nvl(to_number(c.cucovrap), 0) ) resultado
    FROM
        cuencobr   c,
        pr_product p
    WHERE
            c.cuconuse = p.product_id
        AND p.subscription_id = inucontrato;

    numcuenta    NUMBER;
    numresultado NUMBER;
    validarshow  VARCHAR2(10) := dald_parameter.fsbgetvalue_chain('PAR_VISUALCONDTER', NULL);
BEGIN

    --se valida si se debe evaluar la validacion de visualizacion
    IF validarshow = 'S' THEN
        --se valida que el contrato no este nulo
        IF inucontrato IS NOT NULL THEN
            --recorremos el cursor con los totales e identificamos si todas son menores o iguales a 0
            numcuenta := 0;
            FOR dato IN cuoperacion LOOP
                
                --si se encuentra un resultado mayor que 0 tiene una cuenta de cobro pendiente
                DBMS_OUTPUT.PUT_LINE(TO_CHAR(DATO.resultado));
                IF dato.resultado > 0 THEN
                    numcuenta := 1;
                END IF;
            
            END LOOP;

            IF numcuenta > 0 THEN
                RETURN 0;
            END IF;
        ELSE
            sbmensa := 'El Contrato ['
                       || inucontrato
                       || '] no puede ser NULO';
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, sbmensa);
            RAISE ex.controlled_error;
        END IF;
    END IF;

    RETURN 1;
EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE;
    WHEN OTHERS THEN
        sbmensa := 'Proceso LDC_VISUALCONDTER termino con Errores. ' || sqlerrm;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, sbmensa);
        errors.seterror;
        RAISE ex.controlled_error;
END ldc_visualcondter;
/

BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VISUALCONDTER', 'ADM_PERSON');
END;
/