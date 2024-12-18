CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGMARUSURETATT  BEFORE INSERT
ON CARGOS
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (NEW.CARGCONC = 31 AND NEW.CARGCACA <> 15)
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGMARUSURETATT
  Descripcion : trigger que marca usuarios que tiene tarifa transiitoria y tienen ajustes
  Autor       : Luis Javier Lopez Barrios / Horbath
  Ticket      : 415
  Fecha       : 06-07-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========           ====================
06/07/2021          LJLB                CA 694 se coloca filtro de mercado relevante para el ajuste
21/10/2024          jpinedc             OSF-3450: Se migra a ADM_PERSON
**************************************************************************/
DECLARE
  nuError        NUMBER;
  sbError        VARCHAR2(4000);
  sbPrograma  VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PROGAJUFACT', NULL); --se almacena codigo del programa de ajuste
  nuExiste NUMBER;
  nuCiclo NUMBER;

  --INICIO CA 794
	sbMercaRele VARCHAR2(100) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PAMERCVALI', NULL);
	sbaplicaEntrega794 VARCHAR2(1);
  --FIN CA 794

  CURSOR cuExisteTariTran IS
  SELECT SESUCICL
  FROM (
	  SELECT SESUCICL, (SELECT m.lomrmeco
						FROM pr_product p,
						  ab_address A,
						  fa_locamere m
						WHERE p.product_id        = sesunuse
						AND A.geograp_location_id = m.lomrloid
						AND A.address_id          = P.address_id
						) MERCADO
	  FROM LDC_DEPRTATT , SERVSUSC, LDC_PRODTATT
	  WHERE DPTTSESU = :NEW.CARGNUSE
	   AND DPTTPECO = :NEW.CARGPECO
	   AND DPTTSESU = SESUNUSE
	   AND PRTTACTI = 'S'
	   AND PRTTSESU = DPTTSESU)
   WHERE --INICIO CA 794
		sbaplicaEntrega794 = 'S' AND
	    mercado IN ( SELECT to_number(regexp_substr(sbMercaRele,'[^,]+', 1, LEVEL)) AS mercado
					  FROM dual
					  CONNECT BY regexp_substr(sbMercaRele, '[^,]+', 1, LEVEL) IS NOT NULL
					);
		--FIN CA 794

  CURSOR cuExisteprodajus IS
  SELECT 1
  FROM LDC_PROAJUTT
  WHERE PRAJSESU = :NEW.CARGNUSE AND PRAJPECO = :NEW.CARGPECO
  ;

  --INICIO CA 501
   CURSOR cuGetExisteSusdadic IS
   SELECT SESUCICL
   FROM LDC_DEPRSUAD, SERVSUSC
   WHERE DPSASESU = :NEW.CARGNUSE
    AND DPSASESU = SESUNUSE
   -- AND DPSACUCO = :NEW.CARGCUCO
    AND	DPSAPECO = :NEW.CARGPECO
	AND NOT EXISTS ( SELECT 1
	                 FROM LDC_PRODTATT, LDC_DEPRTATT
					 WHERE DPTTSESU = :NEW.CARGNUSE
					   AND DPTTPECO = :NEW.CARGPECO
					   AND PRTTACTI = 'S' );
  --FIN CA 501


BEGIN
  IF FBLAPLICAENTREGAXCASO('0000415') THEN
     --INICIO CA 794
	 IF FBLAPLICAENTREGAXCASO('0000794') THEN
		sbaplicaEntrega794 := 'S';
     ELSE
		sbaplicaEntrega794 := 'N';
	 END IF;
	--FIN CA 794

      SELECT COUNT(1) INTO nuExiste
      FROM (SELECT to_number(regexp_substr(sbPrograma,'[^,]+', 1, LEVEL)) AS programa
             FROM dual
             CONNECT BY regexp_substr(sbPrograma, '[^,]+', 1, LEVEL) IS NOT NULL)
      WHERE programa = :NEW.CARGPROG;

      IF nuExiste > 0 THEN

         OPEN cuExisteTariTran;
         FETCH cuExisteTariTran INTO nuCiclo;
         CLOSE cuExisteTariTran;

         IF nuCiclo IS NOT NULL THEN

            OPEN cuExisteprodajus;
            FETCH cuExisteprodajus INTO nuExiste;
            IF cuExisteprodajus%NOTFOUND THEN
               INSERT INTO LDC_PROAJUTT
                (
                  PRAJSESU, PRAJFEAJ, PRAJPECO, PRAJESTA,  PRAJCICL, prajproc
                )
                VALUES
                (
                 :NEW.CARGNUSE,SYSDATE,:NEW.CARGPECO, 'N',nuCiclo , 'TARITRAN' );
            END IF;
            CLOSE cuExisteprodajus;
         END IF;
      END IF;
  END IF;

  OPEN cuGetExisteSusdadic;
  FETCH cuGetExisteSusdadic INTO nuCiclo;
  IF  cuGetExisteSusdadic%FOUND THEN
     OPEN cuExisteprodajus;
	 FETCH cuExisteprodajus INTO nuExiste;
	 IF cuExisteprodajus%NOTFOUND THEN
	   INSERT INTO LDC_PROAJUTT
		(
		  PRAJSESU, PRAJFEAJ, PRAJPECO, PRAJESTA,  PRAJCICL, prajproc
		)
		VALUES
		(
		 :NEW.CARGNUSE,SYSDATE,:NEW.CARGPECO, 'N',nuCiclo , 'SUBDADIC' );
	END IF;
	CLOSE cuExisteprodajus;
  END IF;
  CLOSE cuGetExisteSusdadic;

EXCEPTION
  When ex.controlled_error Then
     ERRORS.GETERROR(nuError,sbError);
      Raise ex.controlled_error;
  WHEN OTHERS THEN
      ERRORS.SETERROR;
      Raise ex.controlled_error;
END;
/
