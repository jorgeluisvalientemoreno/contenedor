CREATE OR REPLACE PROCEDURE prAjustePagosNoMigrados AS
  /*******************************************************************
  PROGRAMA    :	prAjustePagosNoMigrados
  FECHA		    :	30/04/2014
  AUTOR		    :	Heiber Marino Barco - Arquitecsoft S.A.S.
  DESCRIPCION	:	Aranda 3505: Identifica los Pagos no Migrados a la tabla Pagos pero
                que si estan en los cargos Migrados cuando se hace la
                distribuión de recaudos del dia. Se ejecuta de forma permanente
                mediante SYSDATE - 1

  HISTORIA DE MODIFICACIONES
  AUTOR	   FECHA	   DESCRIPCION
  *******************************************************************/

  nc          NUMBER;
  vaMensError VARCHAR2(1000);
  vcontIns    NUMBER := 0;
  nuCuenta    NUMBER := null;


  CURSOR cuValidaPago (inuCupo pagos.pagocupo%TYPE) IS
    SELECT COUNT(*) total
      FROM open.pagos
     WHERE pagocupo = inuCupo;

  CURSOR cuPagos IS
    SELECT *
      FROM pagos
     WHERE TRUNC(pagofegr) = TRUNC(SYSDATE - 1);


  CURSOR cuCuentasPagos(inuCupo pagos.pagocupo%TYPE) IS
    SELECT cargcuco
      FROM cargos
     WHERE cargcodo = inuCupo
       AND cargsign IN ('PA','SA');


  CURSOR cuCargosPA (inuCuenta cargos.cargcuco%TYPE , inuCupo pagos.pagocupo%TYPE) IS
    SELECT * FROM cargos
     WHERE cargsign IN ('PA','SA')
       AND (cargdoso LIKE 'PA%' OR cargdoso LIKE 'SA%')
       AND cargcuco = inuCuenta
       AND cargcodo <> inuCupo;

  CURSOR cuPagoCupon (inuCodo  cargos.cargcodo%TYPE) IS
    SELECT pagocupo, cuponume
      FROM pagos, cupon
     WHERE pagocupo = Cuponume
       AND pagocupo = inuCodo;

  CURSOR cuCargosPagoDet (inuCodo  cargos.cargcodo%TYPE) IS
    SELECT CARGCODO, CARGFECR, CONTRATO, SUM(valor) VALOR
      FROM (SELECT CARGCODO,
                   Trunc(CARGFECR) CARGFECR,
                   (SELECT SESUSUSC FROM servsusc WHERE SESUNUSE = cargnuse) contrato,
                   SUM(CARGVALO) valor
              FROM cargos
             WHERE cargcodo IN (inuCodo)
               AND cargsign IN ('PA', 'SA')
               AND (cargdoso LIKE 'PA%' OR cargdoso LIKE 'SA%')
             GROUP BY CARGCODO, TRUNC(CARGFECR), cargnuse)
     GROUP BY CARGCODO, CARGFECR, CONTRATO;

  rccuCargosPagoDet     cuCargosPagoDet%ROWTYPE;
  rccuCargosPagoDetNUll cuCargosPagoDet%ROWTYPE;

  rccuPagoCupon     cuPagoCupon%ROWTYPE;
  rccuPagoCuponNULL cuPagoCupon%ROWTYPE;

  rccucuValidaPago  cuValidaPago%ROWTYPE;

  BEGIN

  dbms_output.put_Line ('Inicio Procedure');

  /*Se genera la conciliacion correspondiente*/
  BEGIN

    SELECT sq_concilia_183049.nextval INTO nc FROM dual;

    INSERT INTO concilia (concbanc,concfepa,concnucu,conccapa,concvato,concfere,
                          concflpr,concprre,concfunc,concfeci,concsist,concciau,conccons)
    VALUES (136,'31/12/2013',0,0,0,'31/12/2013',
            'S',0,1096,'31/12/2013',99,'S',nc);
  END;

  Dbms_Output.Put_Line('Finaliza Insert Concilia ');

  /*Se inicia el recorrido e identificacion de los pagos afectados*/
  FOR rcPago IN cuPagos LOOP

    FOR rcCuenta IN cuCuentasPagos (rcPago.pagocupo) LOOP

      FOR rcCargoPA IN cuCargosPA (rcCuenta.cargcuco, rcPago.pagocupo) LOOP

        rccuPagoCupon:= rccuPagoCuponNULL;
        rccuCargosPagoDet:= rccuCargosPagoDetNUll;

        OPEN  cuPagoCupon(rcCargoPA.cargcodo);
        FETCH cuPagoCupon INTO rccuPagoCupon;
        CLOSE cuPagoCupon;

        IF rccuPagoCupon.cuponume IS null THEN

          nuCuenta:= rcCargoPA.cargcodo;

          OPEN  cuValidaPago(rcCargoPA.cargcodo);
          FETCH cuValidaPago INTO rccucuValidaPago;
          CLOSE cuValidaPago;

            IF rccucuValidaPago.total=0 THEN

              OPEN  cuCargosPagoDet(rcCargoPA.cargcodo);
              FETCH cuCargosPagoDet INTO rccuCargosPagoDet;
              CLOSE cuCargosPagoDet;

                BEGIN

                  /*Se debe desactivar el trigger para poder insertar en PAGOS*/
                  EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.TRGAIRLD_PAGOS DISABLE';

                    INSERT INTO pagos(pagoconc,pagosuba,pagobanc,pagosusc,pagofepa,pagovapa,pagofegr,
                                      pagousua,pagoterm,pagocupo,pagoprog,pagotdco,pagotipa,pagonutr,
                                      pagonufi,pagopref,pagoconf)
                    VALUES (nc,812,7,
                            rccuCargosPagoDet.CONTRATO,rccuCargosPagoDet.CARGFECR,rccuCargosPagoDet.VALOR,
                            rccuCargosPagoDet.CARGFECR,'INTEGRACIONES','000103',
                            rccuCargosPagoDet.CARGCODO,'AJRESURECA','EF',
                            'C',NULL,NULL,
                            NULL,NULL);

                    vcontIns := vcontIns + 1;

                    COMMIT;

                  EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.TRGAIRLD_PAGOS ENABLE';

                  dbms_output.put_Line (rccucuValidaPago.total|| ','||
                                        rccuCargosPagoDet.CARGCODO|| ','||
                                        rccuCargosPagoDet.CARGFECR|| ','||
                                        rccuCargosPagoDet.CONTRATO|| ','||
                                        rccuCargosPagoDet.VALOR);
                END;

            ELSE

                dbms_output.put_Line ('El pago ya esta insertado '||rcCargoPA.cargcodo);

            END IF;

        END IF;

      END LOOP;

    END LOOP;

  END LOOP;

  dbms_output.put_Line ('Pagos Insertados ['||vcontIns||']');
  dbms_output.put_Line ('Fin Procedure');

  EXCEPTION

     WHEN OTHERS THEN

        BEGIN

           vaMensError := ' - Error: '||SQLERRM||' -'||to_char(SQLCODE);

        END;

END prAjustePagosNoMigrados;
/
