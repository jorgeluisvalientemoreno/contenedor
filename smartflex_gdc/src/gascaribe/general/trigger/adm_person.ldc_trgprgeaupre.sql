CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGPRGEAUPRE
BEFORE INSERT OR UPDATE ON PROCEJEC FOR EACH ROW

/*******************************************************************************
    Metodo:       LDC_TRGPRGEAUPRE
    Descripcion:  TRIGGER que indica que los procesos de cierre de critica y generacion
                  de cargos hayan terminado de forma satisfactoria, para guardar los codigos
                  de periodo de facturacion y que puedan ser procesados por los respectivos
                  procesos de cada uno

    Autor:        Olsoftware/Miguel Ballesteros
    Fecha:        09/10/2019

    Historia de Modificaciones
    FECHA        AUTOR                      DESCRIPCION
	22/01/2021   LJLB                       CA 461 se actualiza tabla de programacion a T 
                                            cuando se reverse los cargos
	21/10/2024   jpined                     OSF-3450: Se migra a ADM_PERSON	
*******************************************************************************/

    -- Se lanzara despues de cada fila actualizada
DECLARE

    CURSOR CUGETCODPERFACT (nuPeriodo  PERIFACT.PEFACODI%TYPE)IS
        SELECT count(1)
            FROM OPEN.LDC_CODPERFACT P
                WHERE P.COD_PERFACT = nuPeriodo
                  AND P.TYPEPROCESS = 'FGCA'
				  AND p.ESTADPROCESS = 'P';

    nuexist    number;

    BEGIN

        dbms_output.put_line('Se realiza la actualizacion');
     if fblaplicaentregaxcaso('0000065') then
        -- aqui se valida que el proceso sea el de cierre de critica y que este terminado
        IF(:NEW.PREJESPR = 'T' AND :NEW.PREJPROG = 'FCRI')THEN

            insert into OPEN.LDC_CODPERFACT (COD_PERFACT, ESTADPROCESS, TYPEPROCESS, REGISTERDATE) values (:NEW.PREJCOPE, 'P', 'FCRI', sysdate);

        -- aqui se valida que el proceso sea el de generacion de cargos y que este terminado, es decir que los cargos se hayan generado
        ELSIF(:NEW.PREJESPR = 'T' AND :NEW.PREJPROG = 'FGCA')THEN

            OPEN CUGETCODPERFACT(:NEW.PREJCOPE);
            FETCH CUGETCODPERFACT INTO nuexist;
            CLOSE CUGETCODPERFACT;

            if nuexist = 0 THEN
                insert into OPEN.LDC_CODPERFACT (COD_PERFACT, ESTADPROCESS, TYPEPROCESS, REGISTERDATE) values (:NEW.PREJCOPE, 'P', 'FGCA', sysdate);
              	UPDATE LDC_PERIPROG SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE WHERE PEPRPEFA = :NEW.PREJCOPE;
            END IF;
        ELSIF (:NEW.PREJESPR IN ('E','T') AND :NEW.PREJPROG = 'FBCS' ) THEN

		    OPEN CUGETCODPERFACT(:NEW.PREJCOPE);
            FETCH CUGETCODPERFACT INTO nuexist;
            CLOSE CUGETCODPERFACT;

            if nuexist > 0 THEN
                UPDATE OPEN.LDC_CODPERFACT SET ESTADPROCESS = 'T' WHERE COD_PERFACT =:NEW.PREJCOPE and TYPEPROCESS = 'FGCA';

            END IF;
			UPDATE LDC_PERIPROG SET PEPRFLAG = 'T', PEPRFEFI = SYSDATE WHERE PEPRPEFA = :NEW.PREJCOPE;

		END IF;
	  end if;


EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
	 raise;
   WHEN OTHERS THEN
	 ERRORS.SETERROR;
   RAISE EX.CONTROLLED_ERROR;

END LDC_TRGPRGEAUPRE;
/
