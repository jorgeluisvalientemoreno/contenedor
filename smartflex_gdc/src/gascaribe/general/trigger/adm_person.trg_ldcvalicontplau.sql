CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCVALICONTPLAU
  FOR INSERT or DELETE or UPDATE  ON LDC_CONTPLAU COMPOUND TRIGGER
 /**************************************************************************
    Autor       : Olsoftware
    Fecha       : 2020-08-25
    Ticket      : 312
    Descripcion : trigger que valida los datos de la tabla LDC_CONTPLAU
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
 sbexiste    VARCHAR2(4);
 nuContrato  LDC_CONTPLAU.COPLCONT%type;
 nuproducto  LDC_CONTPLAU.COPLPROD%type;
 dtFechIni   LDC_CONTPLAU.COPLFEIN%type;
 dtFechFin   LDC_CONTPLAU.COPLFEFI%type;
  sbOperacion VARCHAR2(4);

  nuContraProd NUMBER;
  nuTipoProd NUMBER;
  nuconta number;
  --se valida solapamiento de fechas
  CURSOR cuvaliSolFecha is
  SELECT count(1)
  FROM LDC_CONTPLAU
  WHERE COPLCONT = nuContrato
  and COPLPROD = nuproducto
  and (dtFechIni between  COPLFEIN and COPLFEFI
    or dtFechFin  between  COPLFEIN and COPLFEFI)
    ;

  --se valida si existe contrato
  CURSOR cuexisteCont IS
  SELECT 'X'
  FROM suscripc
  WHERE susccodi = nuContrato;

    --se valida si existe contrato
  CURSOR cuexisteprod IS
  SELECT sesususc, SESUSERV
  FROM servsusc
  WHERE sesunuse = nuproducto;

 /* CURSOR cuvalidaMoti(inuServicioId number, numotivo number) is
  SELECT 'X'
FROM motiplde, motiplaz, funciona
WHERE motiplde.mopdserv = inuServicioId--inuServicioId
	AND motiplde.mopdmopl = motiplaz.moplcodi
	AND motiplde.mopddepe = funciona.funcdepe
	AND moplcodi = numotivo
	AND funciona.funcusba = sa_bosystem.getCurrentOracleUser;*/



-- Ejecuci¿¿n antes de cada fila, variables :NEW, :OLD son permitidas
  BEFORE EACH ROW IS
  BEGIN

    IF FBLAPLICAENTREGAXCASO('0000312') THEN
        nuContrato := :new.COPLCONT;
        nuproducto := :new.COPLPROD;
        dtFechIni  := :new.COPLFEIN;
        dtFechFin  := :new.COPLFEFI;

        IF inserting OR updating THEN

           IF :new.COPLDIPL <= 0 THEN
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'El numero de dia de la fecha de vencimiento debe ser mayor a cero');
           END IF;

           IF dtFechIni >=  dtFechFin THEN
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Fecha inicial ' ||dtFechIni||
                                       ' no puede ser mayor o igual a la fecha final '||dtFechFin);
           END IF;

           OPEN cuexisteCont;
           FETCH cuexisteCont INTO sbexiste;
           IF cuexisteCont%NOTFOUND THEN
              CLOSE cuexisteCont;
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Contrato [' ||nuContrato||
                                       '] No existe.');
           END IF;
           CLOSE cuexisteCont;

           OPEN cuexisteprod;
           FETCH cuexisteprod INTO nuContraProd, nuTipoProd;
           IF cuexisteprod%NOTFOUND THEN
              CLOSE cuexisteprod;
              ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Producto [' ||nuproducto||
                                       '] No existe.');
           END IF;
           CLOSE cuexisteprod;

           IF nuContraProd <> nuContrato THEN
               ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'Producto [' ||nuproducto||
                                       '] No esta relacionado al contrato ['||nuContrato||']');
           END IF;

           /*open cuvalidaMoti(nuTipoProd, :new.COPLMOPL);
           fetch cuvalidaMoti into sbexiste;
           if cuvalidaMoti%notfound then
              CLOSE cuvalidaMoti;
                   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                           'El motivo no esta asociado al tipo de producto ['||nuTipoProd|| '] y la dependencia del usuario ['||user||']');
           end if;
           close cuvalidaMoti;*/


        END IF;

        IF inserting THEN
           sbOperacion := 'I';
        END IF;

        IF updating THEN
           sbOperacion := 'U';
        END IF;

        IF deleting THEN
           sbOperacion := 'D';
        END IF;

        INSERT INTO  LDC_LOGCONTPLAU
          (
            COPLCOAC, COPLPRAC, COPLFIAC, COPLFFAC, COPLDPAC, COPLMPAC,
            COPLCOAN, COPLPRAN, COPLFIAN, COPLFFAN, COPLDPAN,
            COPLMPAN, COPLOPER, COPLTERM, COPLUSUA, COPLFERE
          )
          VALUES
          (
            nuContrato, nuproducto,dtFechIni,dtFechFin,:new.COPLDIPL, :new.COPLMOPL,
            :old.COPLCONT, :old.COPLPROD, :old.COPLFEIN, :old.COPLFEFI, :old.COPLDIPL, :old.COPLMOPL,
             sbOperacion, userenv('TERMINAL'), USER, SYSDATE
          );
    END IF;
  END BEFORE EACH ROW;

  /*Despues de la sentencia de insertar o actualizar*/
   AFTER STATEMENT IS

  BEGIN
        IF FBLAPLICAENTREGAXCASO('0000312') THEN
           IF inserting OR updating THEN
               OPEN cuvaliSolFecha;
               FETCH cuvaliSolFecha INTO nuconta;
               IF nuconta > 1 THEN
                   CLOSE cuvaliSolFecha;
                   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                           'Existe un registro para la misma vigencia, para el  Producto [' ||nuproducto||'] y contrato ['||nuContrato||']');
               END IF;
               CLOSE cuvaliSolFecha;
           end if;
     end if;
  END AFTER STATEMENT;


END TRG_LDCVALICONTPLAU;
/
