CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGHISTPRODEX  BEFORE
 INSERT OR UPDATE OR DELETE  ON LDC_PRODEXCLRP
FOR EACH ROW
  /**************************************************************************
  Proceso     : LDC_TRGHISTPRODEX
  Autor       : Luis Javier Lopez/ Horbath
  Fecha       : 2020-12-07
  Ticket      : 337
  Descripcion : trigger para que se encarga de llenar la tabla de log LDC_LOG_PRODEXCLRP

  Parametros Entrada

  Parametros de salida

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  18/10/2024    jpinedc     OSF-3383: Se migra a ADM_PERSON
  ***************************************************************************/
declare

  sboperacion VARCHAR2(1);
  nuProducto   LDC_LOG_PRODEXCLRP.PRODUCT_ID%type;
  nuOrden 	   LDC_LOG_PRODEXCLRP.ORDER_ID%type;
  sbObservacion   LDC_LOG_PRODEXCLRP.OBSERVACION%type;

   sbMotivo  LDC_LOG_PRODEXCLRP.MOTIVO%type;
   dtfecha  LDC_LOG_PRODEXCLRP.FECH_EXCLU%type;

begin
  IF fblaplicaentregaxcaso('0000337') THEN
    IF INSERTING THEN
	  sboperacion := 'I';
	  nuProducto := :new.PRODUCT_ID;
	  nuOrden := :new.ORDER_ID;
	  sbObservacion := 'INGRESO DE PRODUCTO PARA EXCLUSION DE RP';
	  sbMotivo  := :new.MOTIVO;
	  dtfecha  := :new.FECH_EXCLU;
	END IF;

	IF UPDATING THEN
	  sboperacion := 'U';
	  nuProducto := :new.PRODUCT_ID;
	  nuOrden := :new.ORDER_ID;
	  sbObservacion := 'MODIFICACION DE PRODUCTO DE EXCLUSION DE RP';
      sbMotivo  := :new.MOTIVO;
	  dtfecha  := :new.FECH_EXCLU;
	END IF;

	IF DELETING THEN
	  sboperacion := 'R';
	  nuProducto := :OLD.PRODUCT_ID;
	  nuOrden := :OLD.ORDER_ID;
	  sbObservacion := 'RETIRO DE PRODUCTO DE EXCLUSION DE RP';
	  sbMotivo  := :OLD.MOTIVO;
	  dtfecha  := :OLD.FECH_EXCLU;
	END IF;

	INSERT INTO LDC_LOG_PRODEXCLRP
	  (
		PRODUCT_ID,
		TIPO_MOVI,
		FEHA_MOVI,
		ORDER_ID,
		USUARIO,
		TERMINAL,
		OBSERVACION,
		MOTIVO,
		FECH_EXCLU
	  )
	  VALUES
	  (
		nuProducto,
		sboperacion,
		sysdate,
		nuOrden,
		user,
		userenv('TERMINAL'),
		sbObservacion,
		sbMotivo,
		dtfecha
	  );
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ERRORS.seterror;
    RAISE EX.CONTROLLED_ERROR;
end LDC_TRGHISTPRODEX;
/
