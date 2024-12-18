CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGCONTFEMA AFTER UPDATE OF FECHA_INICIAL, FECHA_FINAL, VALOR_TOTAL_CONTRATO, VALOR_ANTICIPO, PORCEN_FONDO_GARANT  ON GE_CONTRATO
REFERENCING NEW AS NEW
FOR EACH ROW
/**************************************************************************

      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 04-07-2017
      Ticket      : 200-810
      Descripcion : TRIGGER que inserta en la tabla LDC_CONTFEMA


      Parametros Entrada

      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      04/03/2019  dsaltarin    ca 200-2472. Se modifica para obligar que la hora de la fecha final
                               sea 11:59:59 pm
      13/05/2022 dsaltarin     osf-274: Se modifica la validacion que no permite modificar la fecha maxima de contrato
                               por una fecha menor a la acutal configurada, la validacion debe ser que no debe permitir
                               modificar por una fecha menor a la del sistema
							   osf-274: Se ajusta para contemplar que solo se realice la validacion de la fecha maxima
							   si la fecha que se esta colocando es diferente de la fecha anteriormente registrada
    ***************************************************************************/

DECLARE
   sbInstance       ge_boInstanceControl.stysbName; --Ticket 200-810  LJLB -- se almacena instancia del sistema
   sbContractId     ge_boutilities.styStatement; --Ticket 200-810  LJLB -- se almacena id del contrato
   nuIndex          ge_boInstanceControl.stynuIndex;
   nuContrato       ge_contrato.id_contrato%TYPE; --TICKET 200-810 LJLB -- se almacena codigo del contrato
   dtFechaMaxima    LDC_CONTFEMA.FECHA_MAXASIG%type; --TICKET 200-810 LJLB -- se almacena fecha maxima de asignacion del contratp
   dtFechamax_Contrato LDC_CONTFEMA.FECHA_MAXASIG%type; --TICKET 200-810 LJLB -- se almacena fecha maxima del contrato origial
   sberror VARCHAR2(4000); --TICKET 200-810 LJLB -- se almacena mensaje de error
   nuErrorCode NUMBER := 2; --TICKET 200-810 LJLB -- se almacena codigo de error

   sbdato           VARCHAR2(1); --TICKET 200-810 LJLB -- se almacena dato si existe registro
   sbFlagAsignar  VARCHAR2(2) := 'N'; --TICKET 200-810 LJLB -- se almacena valor del parametro LDC_ASIGCONT
   --TICKET 200-810 LJLB -- se consulta si existe el contrato
   CURSOR cuExisteContFecha IS
   SELECT 'X'
   FROM LDC_CONTFEMA
   WHERE id_contrato = nuContrato;

   regContFema      DALDC_CONTFEMA.styLDC_CONTFEMA; --TICKET 200-810 LJLB -- se crea registro de contrato por fecha maxima de cotratacion
   blExists   BOOLEAN;

   erFechaInvalida  EXCEPTION; --TICKET 200-810 LJLB -- error si hay datos invalidos}
   dtFecha date:=to_date('01/01/2015','dd/mm/yyyy');--200-2472
BEGIN
ut_trace.trace('INICIO LDC_TRGCONTFEMA', 10);
  --TICKET 200-810 LJLB -- se consulta si aplica la entrega en la gasera
  IF fblaplicaentrega(LDC_PKGASIGNARCONT.FSBVERSION) THEN
    -- sbFlagAsignar := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ASIGCONT', Null);  --TICKET 200-810 LJLB -- se consulta si se va asignar el contrato o no

  -- IF sbFlagAsignar = 'S' THEN
     ut_trace.trace('APLICA ENTREGA', 10);
     --TICKET 200-810 LJLB -- se obtiene instancia del contrato
     -- Valida si existe la instancia
      blExists := ge_boinstancecontrol.fblAcckeyInstanceStack('WORK_INSTANCE',nuIndex);

     IF blExists THEN
        ut_trace.trace('EXISTE INSTANCIA', 10);
         blExists := ge_boinstancecontrol.fblAcckeyAttributeStack('WORK_INSTANCE',NULL,'GE_CONTRATO','ID_CONTRATO',nuIndex);
        IF (blExists) THEN

          GE_BOInstanceControl.GetAttributeNewValue('WORK_INSTANCE',
                                                    Null,
                                                    'GE_CONTRATO',
                                                    'ID_CONTRATO',
                                                    sbContractId);
          ut_trace.trace('EXISTE CONTRATO '||sbContractId||' CONTRATO OLD '||:OLD.ID_CONTRATO, 10);
          IF sbContractId IS NOT NULL AND TO_NUMBER(sbContractId)  = :OLD.ID_CONTRATO   THEN

               ut_trace.trace('INGRESO A VALIDACION CONTRATO '||sbContractId, 10);
               nuContrato := TO_NUMBER(sbContractId);

              --INICIO CA 200-2391

              BEGIN
               dtFechaMaxima  := TO_DATE(ge_boInstanceControl.fsbGetFieldValue ('LDC_CONTFEMA', 'FECHA_MAXASIG'), 'DD/MM/YYYY HH24:MI:SS'); --TICKET 200-810 LJLB -- se obtiene fecha maxima de asigancion de los PB
              EXCEPTION
                WHEN OTHERS THEN
                     ut_trace.trace('SE FUE POR AQUI '||sbContractId, 10);
                   RETURN;
              END;
              --FIN CA 200-2391
                  ut_trace.trace('INGRESO FECHA DE ASIGNACION '||dtFechaMaxima, 10);
               dtFechamax_Contrato := DALDC_CONTFEMA.fdtFechaMaxima(nuContrato); --TICKET 200-810 LJLB -- se obtiene fecha maxima actual del contrato
               --TICKET 200-810 LJLB -- se valida que la fecha maxima no sea nula
               IF dtFechaMaxima IS NULL THEN
                 sberror := 'Fecha maxima de asignacion del contrato no puede ser nula';
                 RAISE erFechaInvalida;
               END IF;
               --TICKET 200-810 LJLB -- se valida que la nueva fecha no sea menor a la actual
               --INICIO OSF-274
               --IF dtFechaMaxima < dtFechamax_Contrato THEN
               IF dtFechaMaxima < sysdate and dtFechaMaxima!=nvl(dtFechamax_Contrato,sysdate)  THEN
                 sberror := 'Fecha maxima de asignacion del contrato no puede ser menor a la actual['||/*dtFechamax_Contrato*/ sysdate||']';
               --FIN OSF-274
                 RAISE erFechaInvalida;
               END IF;
               --TICKET 200-810 LJLB -- se valida que la fecha maxima de asigancion se encuentre en el rango de las fechas del contrato
               IF dtFechaMaxima  BETWEEN :NEW.FECHA_INICIAL AND  :NEW.FECHA_FINAL THEN
                  regContFema.ID_CONTRATO := nuContrato;
                  regContFema.FECHA_MAXASIG := dtFechaMaxima;
                  regContFema.USUARIO := user;
                  regContFema.FECHA_MODI := SYSDATE;

                   --TICKET 200-810 LJLB -- se consulta si existe el contrato pra versi se inserta o se actualiza
                   OPEN cuExisteContFecha;
                   FETCH cuExisteContFecha INTO sbdato;
                   IF cuExisteContFecha%NOTFOUND THEN
                      DALDC_CONTFEMA.insRecord(regContFema);
                   ELSE
                       DALDC_CONTFEMA.updRecord(regContFema, 0 );
                   END IF;
                   CLOSE cuExisteContFecha;
              ELSE
                 sberror := 'Fecha maxima de asignacion ['||dtFechaMaxima||'] del contrato debe estar entre el rango de la fecha inicial y fecha final';
                 RAISE erFechaInvalida;
              END IF;

          END IF;
        END IF;
      END IF;
   -- END IF;
  END IF;
	IF fblaplicaentrega('OSS_CONT_DSS_200_2472_2') THEN
			if nvl(:old.fecha_final,dtFecha)!=nvl(:new.fecha_final,dtFecha) then
				if to_char(:new.FECHA_FINAL, 'hh24:mi:ss')!='23:59:59' then
					sberror := 'La hora de la fecha final del contrato no es 11:59:59 p.m.';
					RAISE erFechaInvalida;
				end if;
			end if;
	END IF;
ut_trace.trace('fin LDC_TRGCONTFEMA', 10);
EXCEPTION
   WHEN erFechaInvalida THEN
       Errors.SetError(nuErrorCode);
       Errors.SETMESSAGE(sberror);
       RAISE ex.CONTROLLED_ERROR;

   WHEN EX.CONTROLLED_ERROR THEN
           ERRORS.GETERROR(nuErrorCode,sberror);
           DBMS_OUTPUT.put_line(sberror);
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
        Errors.setError;
        sberror := sqlerrm;
        Errors.SETMESSAGE(sberror);
        RAISE EX.CONTROLLED_ERROR;

END;
/
