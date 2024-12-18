CREATE OR REPLACE PROCEDURE ADM_PERSON.LDCPRGENNOAPROV(SBPATHFILE   IN VARCHAR2,
													   SBFILE_NAME IN VARCHAR2) IS
/*****************************************************************
  Unidad         : LDCPRGENNOAPROV
  Descripcion    : Generacion de nota de aprovechamiento por archivo plano
  Fecha          : 25/03/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  20/05/2022       LJLB                CA OSF-304 se quita validaciones de venta anulados y estados de los productos
                                       Se ajusta calculo del saldo afavor pendiente por aplicar
  ******************************************************************/
  SUBTYPE STYSIZELINE           IS         VARCHAR2(32000);
  FPORDERSDATA        UTL_FILE.FILE_TYPE;
  SBLINE              STYSIZELINE;
  NURECORD            NUMBER;
  FPORDERERRORS       UTL_FILE.FILE_TYPE;
  SBERRORFILE         VARCHAR2(100);
  SBERRORLINE         STYSIZELINE;
  nuContrato          NUMBER;
  nuProducto          NUMBER;
  nuValor             NUMBER;

  NUERRORCODE         NUMBER;
  SBERRORMESSAGE      VARCHAR2(2000);

  TBSTRING   ut_string.TYTB_STRING;
  sbSeparador VARCHAR2(1) := ';';

  CNUMAXLENGTHTOASSIG         CONSTANT  NUMBER:=32000;
  sbSession  VARCHAR2(400) := USERENV('SESSIONID');
  sbTerminal  VARCHAR2(400) := USERENV('TERMINAL');
  sbTipoSolVenta VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TIPOSOLVENTAP',NULL);
  nuCausal  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSAPROV',NULL);

  --INICIO CA 304
   sbAplica304 VARCHAR2(1) := 'N';
  --FIN CA 304

  CURSOR cuGetProductos IS
  SELECT *
  FROM LDC_INPRAPROV D
  WHERE INPPSESI = sbSession;

  TYPE tblProductos IS TABLE OF cuGetProductos%ROWTYPE;

  vtblProductos tblProductos;

  CURSOR cuExisteProducto(InuProducto IN NUMBER) IS
  SELECT P.product_status_id, s.sesuesco, s.sesuserv, s.sesususc, s.SESUSAFA
  FROM pr_product p, servsusc s
  WHERE sesunuse = product_id
   AND product_id = InuProducto;

  CURSOR cuGetExisteVenta(inuproducto IN NUMBER) IS
  SELECT S.package_id
  FROM mo_packages s, mo_motive m
  WHERE s.package_id = m.package_id
   AND s.package_type_id in ( SELECT to_number(regexp_substr(sbTipoSolVenta,'[^,]+', 1, LEVEL)) AS causal
                               FROM dual
                               CONNECT BY regexp_substr(sbTipoSolVenta, '[^,]+', 1, LEVEL) IS NOT NULL)
   AND (s.motive_status_id = 32
     OR sbAplica304 = 'S' )
   AND m.product_id = inuproducto;

  nuSolicitud NUMBER;

  CURSOR cugetPago(inuSolicitud IN NUMBER, inuContrato IN NUMBER) IS
  SELECT 'X'
  FROM OPEN.CUPON
  WHERE CUPODOCU = to_char(inuSolicitud)
    AND CUPOTIPO ='DE'
    AND CUPOFLPA = 'S'
    AND CUPOSUSC = inuContrato;

  CURSOR cuGetSaldoFAvor(inuProducto IN NUMBER, inuSolicitud in number) IS
  select sum(MOSFVALO) MOSFVALO, max(SAFACONS) SAFACONS
	from OPEN.saldfavo  g, open.MOVISAFA H
	where g.safaorig = 'DE'
	  AND G.SAFASESU = inuProducto
	  and H.MOSFSESU = G.SAFASESU
	  AND H.MOSFSAFA = G.SAFACONS
    and SAFADOCU = to_char(inuSolicitud);
  /*select SAFAVALO, safacons
  from OPEN.saldfavo  g
  where g.safaorig = 'DE'
     AND G.SAFASESU = inuProducto
     AND G.SAFAVALO >= nvl((SELECT SUM(H.MOSFVALO)
                            FROM open.MOVISAFA H
                            WHERE H.MOSFSESU = G.SAFASESU
                              AND H.MOSFSAFA = G.SAFACONS),0)*/


  nuSaldFavorSol NUMBER;
  nuSadoAfId NUMBER;
  sbExistePago VARCHAR2(1);
  nuEstaProd NUMBER;
  nuEstacort NUMBER;
  nuContProd NUMBER;
  nuTipoProducto NUMBER;
  nuSaldoFavor NUMBER;
  CSBFILE_SEPARATOR           CONSTANT VARCHAR2(1) := '/';
  nuExito NUMBER;
  NUNOTANUME number;
  NUIDSAFA number;
  NUULTCUENTAPROD NUMBER;
  nuconcepto NUMBER := GE_BOPARAMETER.FNUVALORNUMERICO ('CONCEPTO_DEPOSITO');
  nuparano  NUMBER;
  nuparmes  NUMBER;
  nutsess  NUMBER;
  sbparuser VARCHAR2(400);

  PROCEDURE PRACTUALIZAPRODU(inuProducto IN NUMBER,
                             isbObservacion IN VARCHAR2,
                             isbEstado IN VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
     UPDATE LDC_INPRAPROV SET INPPFERE = sysdate,
                              INPPUSUA = user,
                              INPPTERM = sbTerminal,
                              INPPESTA = isbEstado,
                              INPPOBSE = SUBSTR(INPPOBSE||'|'||isbObservacion,1,3999)
     WHERE INPPSESI = sbSession
      AND INPPSESU = inuProducto;
      COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
       NULL;
  END PRACTUALIZAPRODU;

BEGIN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'LDCPRGENNOAPROV',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

  UT_TRACE.TRACE('[LDCPRGENNOAPROV] INICIO',3);
   pkErrors.SetApplication('CUSTOMER');
  DELETE FROM LDC_INPRAPROV WHERE INPPSESI = sbSession;
  COMMIT;

  --INICIO CA OSF-304
  IF FBLAPLICAENTREGAXCASO('OSF-304') THEN
    sbAplica304 := 'S';
  END IF;
  --FIN CA OSF-304

  GE_BOFILEMANAGER.CHECKFILEISEXISTING (SBPATHFILE||CSBFILE_SEPARATOR||sbFILE_NAME);
  SBERRORFILE := SUBSTR(sbFILE_NAME,1,INSTR(sbFILE_NAME,'.')-1);

  IF SBERRORFILE IS NULL THEN
     SBERRORFILE := sbFILE_NAME;
  END IF;

  SBERRORFILE := SBERRORFILE||'.err';

  GE_BOFILEMANAGER.FILEOPEN (FPORDERSDATA, SBPATHFILE, sbFILE_NAME, GE_BOFILEMANAGER.CSBREAD_OPEN_FILE, CNUMAXLENGTHTOASSIG);
  UT_FILE.FILEOPEN(FPORDERERRORS,SBPATHFILE,SBERRORFILE,'w',CNUMAXLENGTHTOASSIG);
  NURECORD := 0;
    WHILE TRUE LOOP
        GE_BOFILEMANAGER.FILEREAD (FPORDERSDATA, SBLINE);
        EXIT WHEN SBLINE IS NULL;
          nuContrato := null;
          nuProducto := null;
          nuValor := null;

         --SBLINE:=TRIM(SUBSTR(SBLINE,1, LENGTH(SBLINE)-1));
         ut_string.EXTSTRING(SBLINE, sbSeparador , TBSTRING);
         NURECORD := NURECORD + 1;

         IF TBSTRING.COUNT <> 4 THEN
            SBERRORLINE := '['||NURECORD ||'] Error estructura del archivo no es valida';
            UT_FILE.FILEWRITE(FPORDERERRORS,SBERRORLINE);
         ELSE
           BEGIN
                nuContrato :=  TBSTRING(1);
                nuProducto :=  TBSTRING(2);
                nuValor :=  TBSTRING(3);

                INSERT INTO LDC_INPRAPROV(INPPSESU, INPPSUSC, INPPVALO, INPPSESI)
                  VALUES (nuProducto, nuContrato, nuValor, sbSession);
                COMMIT;
           EXCEPTION
            WHEN OTHERS THEN
               SBERRORLINE := '['||NURECORD ||'] ERROR AL CONVERTIR EL CONTRATO, EL PRODUCTO O EL VALOR DE SALDO A FAVOR';
              UT_FILE.FILEWRITE(FPORDERERRORS,SBERRORLINE);
              SBERRORLINE := NULL;
              CONTINUE;
           END;
        END IF;
    END LOOP;

   OPEN cuGetProductos;
   LOOP
      FETCH cuGetProductos BULK COLLECT INTO  vtblProductos LIMIT 100;
        FOR idx IN 1..vtblProductos.COUNT LOOP
            nuEstaProd := NULL;
            nuEstacort := NULL;
            nuContProd := NULL;
            nuTipoProducto := NULL;
            nuSolicitud := NULL;
            nuSaldoFavor := NULL;
            nuExito := 0;
            NUNOTANUME := null;
            nuSadoAfId := NULL;
            NUULTCUENTAPROD := NULL;
            IF cuGetExisteVenta%ISOPEN THEN
               CLOSE cuGetExisteVenta;
            END IF;
            IF cuExisteProducto%ISOPEN THEN
               CLOSE cuExisteProducto;
            END IF;
            IF cugetPago%ISOPEN THEN
               CLOSE cugetPago;
            END IF;

            --se valida que producto exista
            OPEN cuExisteProducto(vtblProductos(idx).INPPSESU);
            FETCH cuExisteProducto INTO nuEstaProd, nuEstacort, nuTipoProducto,nuContProd, nuSaldoFavor;
            IF cuExisteProducto%NOTFOUND THEN
               PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'producto no existe', 'I');
               CLOSE cuExisteProducto;
               CONTINUE;
            END IF;
            CLOSE cuExisteProducto;

           --Se valida saldo a favor
            IF NVL(nuSaldoFavor,0) <= 0 THEN
               PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'producto no tiene saldo a favor', 'I');
               nuExito := -1;
            ELSE
                 --Se valida saldo a favor
                IF NVL(nuSaldoFavor,0) <> vtblProductos(idx).INPPVALO  THEN
                   PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'Valor de saldo a favor del producto ['||NVL(nuSaldoFavor,0)||'] no es igual al ingresado ['||vtblProductos(idx).INPPVALO||']', 'I');
                   nuExito := -1;
                END IF;
            END IF;

            --se valida que contrato exista
            IF nuContProd <> vtblProductos(idx).INPPSUSC THEN
               PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'contrato no existe o no esta asociado al producto', 'I');
               nuExito := -1;
            END IF;
            --se valida que producto sea de gas
            IF nuTipoProducto not in  (7014, 6121) THEN
               PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'Tipo de producto es diferente a Gas', 'I');
               nuExito := -1;
            END IF;

		   IF sbAplica304 = 'N' THEN
			   --se valida estado del producto
			   IF nuEstaProd <> 16 THEN
				   PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'Estado del producto es diferente 16- Retirado sin instalacion', 'I');
					nuExito := -1;
			   END IF;
			   --se valida estado del producto
			   IF nuEstacort <> 110 THEN
				   PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'Estado de corte es diferente a 110- Retirado sin Instalaci��n', 'I');
				   nuExito := -1;
			   END IF;
		   END IF;

           IF nuExito = 0 THEN
              --se valida que el producto tenga venta de gas anulada con deposito en saldo a favor
              OPEN cuGetExisteVenta(vtblProductos(idx).INPPSESU);
              FETCH cuGetExisteVenta INTO nuSolicitud;
              IF cuGetExisteVenta%NOTFOUND THEN
                  PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'producto no tiene solicitudes de venta', 'I');
                  nuExito := -1;
              ELSE
                  OPEN cugetPago(nuSolicitud,vtblProductos(idx).INPPSUSC);
                  FETCH cugetPago INTO sbExistePago;
                  IF cugetPago%NOTFOUND THEN
                    PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'no existe pago para la solicitud ['||nuSolicitud||']', 'I');
                    nuExito := -1;
                  ELSE
                      OPEN cuGetSaldoFAvor(vtblProductos(idx).INPPSESU, nuSolicitud);
                      FETCH cuGetSaldoFAvor INTO nuSaldFavorSol, nuSadoAfId;
                      CLOSE cuGetSaldoFAvor;

                      IF NVL(nuSaldFavorSol,0) > 0  THEN
                         IF NVL(nuSaldFavorSol,0) > NVL(nuSaldoFavor,0) THEN
                            PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'Valor de saldo a favor del producto ['||NVL(nuSaldoFavor,0)||'] no es mayor o igual al saldo favor por deposito ['||nvl(nuSaldFavorSol,0)||']', 'I');
                            nuExito := -1;
                         END IF;
                      ELSE
                         PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, 'el producto no tiene saldo a favor por deposito', 'I');
                         nuExito := -1;
                      END IF;
                  END IF;
                  CLOSE cugetPago;

                  IF nuExito = 0 THEN
                    BEGIN
                        SELECT MAX(cucocodi) INTO NUULTCUENTAPROD
                        FROM cuencobr
                        WHERE cuconuse =  vtblProductos(idx).INPPSESU;

                        PKBILLINGNOTEMGR.CREATEBILLINGNOTE (
                                                            vtblProductos(idx).INPPSESU,
                                                            NUULTCUENTAPROD,
                                                            NULL,
                                                            SYSDATE,
                                                            CC_BOCONSTANTS.CSBPREFIJODOC || PKCONSTANTE.NULLSB || TO_CHAR( nuSolicitud ),
                                                            PKBILLCONST.DEVOLUCION || '-',
                                                            NUNOTANUME
                                                            );
                        fa_bobillingnotes.detailregister(
                                               NUNOTANUME,
                                               vtblProductos(idx).INPPSESU,
                                               vtblProductos(idx).INPPSUSC,
                                               NUULTCUENTAPROD,
                                               nuconcepto,
                                               nuCausal,
                                               nuSaldFavorSol,
                                               NULL,
                                               TRIM(PKBILLCONST.DEVOLUCION)||'-' || NUNOTANUME,
                                               PKBILLCONST.DEVOLUCION,
                                               pkConstante.SI,
                                               NULL,
                                               pkConstante.SI);


                       PKBCMOVISAFA.CREATERECORD (
                                                vtblProductos(idx).INPPSESU,
                                                nuSadoAfId,
                                                SYSDATE,
                                                nuSaldFavorSol * -1,
                                                NUULTCUENTAPROD,
                                                NUNOTANUME,
                                                'AS'
                                            );


                        UPDATE LDC_INPRAPROV SET INPPFERE = sysdate,
                              INPPUSUA = user,
                              INPPTERM = sbTerminal,
                              INPPESTA = 'P',
                              INPPOBSE ='Aplicado con Exito',
                              INPPCUCO = NUULTCUENTAPROD,
                              INPPNOTA = NUNOTANUME
                         WHERE INPPSESI = sbSession
                          AND INPPSESU = vtblProductos(idx).INPPSESU;
                          COMMIT;
                  EXCEPTION
                    WHEN OTHERS THEN
                       errors.seterror;
                       ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);
                       PRACTUALIZAPRODU(vtblProductos(idx).INPPSESU, SBERRORMESSAGE, 'I');
                       continue;
                  END;
                  END IF;

              END IF;
              CLOSE cuGetExisteVenta;

          END IF;


        END LOOP;
      EXIT WHEN cuGetProductos%NOTFOUND;
    END LOOP;
    CLOSE cuGetProductos;

    IF UTL_FILE.IS_OPEN (FPORDERSDATA) THEN
        GE_BOFILEMANAGER.FILECLOSE (FPORDERSDATA);
    END IF;

    IF UTL_FILE.IS_OPEN (FPORDERERRORS) THEN
        GE_BOFILEMANAGER.FILECLOSE (FPORDERERRORS);
    END IF;
    COMMIT;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENNOAPROV', 'Ok');
    UT_TRACE.TRACE('[LDCPRGENNOAPROV] FIN',3);
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);
      ROLLBACK;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENNOAPROV', 'Ok');
      RAISE EX.CONTROLLED_ERROR;

  WHEN OTHERS THEN
     ERRORS.SETERROR;
      ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENNOAPROV', 'Ok');
      RAISE EX.CONTROLLED_ERROR;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPRGENNOAPROV', 'ADM_PERSON');
END;
/
