CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FRCGETFACTURABYPROG" 
  (
      INUSUBSCRIPTION     IN      SUSCRIPC.SUSCCODI%TYPE
  )
  RETURN FACTURA%ROWTYPE
  /**************************************************************************

  UNIDAD      :  LDC_FRCGETFACTURABYPROG
  Descripcion :  Obtiene la factura de la forma en como se obtiene la de Kiosko
  Autor       :  Antonio Benitez Llorente
  Fecha       :  03-10-2019

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================

  **************************************************************************/

  IS
      RCFACTURA                   FACTURA%ROWTYPE;
      CNUNO_BILL                  CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE :=  900839;
      RFBILLS                     PKCONSTANTE.TYREFCURSOR;
     sbEntrega varchar2(30):='0000086';

      --Cursor para octener la factura similar a como la obtiene KIOSKO
      cursor cufactura is
      SELECT f.*--.CUCOFACT
      FROM CUENCOBR cc, factura f
      WHERE f.factcodi = cc.CUCOFACT
       and cc.CUCOFACT IN
          (SELECT factu.factcodi
              FROM factura factu
             WHERE factu.factsusc = INUSUBSCRIPTION
               AND (SELECT SUM(CUCOSACU)
                      FROM CUENCOBR CCBR
                     WHERE CCBR.CUCOFACT = factu.factcodi) > 0
               AND factu.FACTPEFA =
                   (SELECT MAX(factusub.FACTPEFA)
                      FROM FACTURA factusub
                     WHERE factusub.factsusc = INUSUBSCRIPTION
                       AND (SELECT SUM(CUCOSACU)
                              FROM CUENCOBR CCBR
                             WHERE CUCOFACT = factusub.factcodi) > 0));

  BEGIN
     IF fblaplicaentregaxcaso(sbEntrega) THEN
     UT_TRACE.TRACE('INICIA ldc_frcGetFacturaByProg ', 5);

      --Se abre el cursor que obtiene la factura
      open cufactura;
      FETCH cufactura INTO RCFACTURA;
      CLOSE cufactura;

      IF ( RCFACTURA.FACTCODI IS NULL ) THEN
          UT_TRACE.TRACE('No existe factura de consumo para la suscripcion ' || INUSUBSCRIPTION, 15);
          --Si el cursor no obtiene la facura se busca como se hace actualmente
          RFBILLS := PKBCFACTURA.FRFGETBILLSBYSUBSPROG(INUSUBSCRIPTION,NULL);
          FETCH RFBILLS INTO RCFACTURA;
          CLOSE RFBILLS;

          --Si a pesar de eso no se obtiene la factura se manda error
          IF ( RCFACTURA.FACTCODI IS NULL ) THEN
            dbms_output.put_line('Error');
              ERRORS.SETERROR( CNUNO_BILL, INUSUBSCRIPTION );
              RAISE EX.CONTROLLED_ERROR;
          END IF;
      END IF;

      UT_TRACE.TRACE('FIN ldc_frcGetFacturaByProg ', 5);
      RETURN RCFACTURA;
     END IF;

  EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
          UT_TRACE.TRACE('Error (LOGIN_DENIED) ldc_frcGetFacturaByProg ', 6);
          RAISE;
      WHEN OTHERS THEN
          ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
  END LDC_FRCGETFACTURABYPROG;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FRCGETFACTURABYPROG', 'ADM_PERSON');
END;
/
