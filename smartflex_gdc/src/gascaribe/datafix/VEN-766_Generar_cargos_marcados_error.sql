DECLARE
  packageId NUMBER;
  productId NUMBER;
  packageTypeId NUMBER;
  quotationItemId NUMBER;
  unitValue NUMBER;
  unitTaxValue NUMBER;
  orderId NUMBER;
  taskTypeId NUMBER;

  CURSOR cuOrders IS
  SELECT ooa.ORDER_ID
  FROM "OPEN".OR_ORDER_ACTIVITY ooa
  INNER JOIN "OPEN".OR_ORDER oo ON oo.ORDER_ID = ooa.ORDER_ID
  INNER JOIN "OPEN".MO_PACKAGES mp ON mp.PACKAGE_ID = ooa.PACKAGE_ID
  WHERE ooa.ORDER_ID IN (
    286501001,286501004,286501009,286501022,286501020,286501030,286501010,286501021,286501097,286501033,286501034,286501046,286501047,286501072,286501081,286501083,
    286501095,286501100,286501107,286501043,286501060,286501044,286501049,286501038,286501055,286501062,286501069,286501067,286501078,286501085,286501090,286501105,
    286501074,286501089,286501016,286501036,286501080,286501032,286501018,286501031,286501059,286501103,286501058,286501014,286501048,286501073,286501068,286501007,
    286501122,286501008,286501027,286501039,286501070,286501088,294025071,294025073,294025076,294025081,294025092,294025098,294025099,294025131,294025179,294025180,
    294025182,294025219,294025231,294025232,294025255,294025288,294025318,294025319,294025341,294024661,294025342,294025357,294025358,294025362,294024674,294024705,
    294024706,294024707,294024708,294024757,294024758,294024790,294024802,294024815,294024816,294024838,294024839,294024840,294024863,294024865,294024887,294024898,
    294024918,294024934,294024960,294024975,294024981,294024983,294024998,294025034,294025048,294025049,294025053,294025070,289682047,289682053,289682058,289682060,
    289682063,289682067,289682068,289682070,289682073,289682075,289682077,289682079,289682810,280527489,280169472,280169476,280169499,280169514,280169479,280169440,
    280169470,280169487,280169445,280169454,280169490,280169520,280169432,280169485,280169465,280169480,280169507,280169489,280169430,280169509,280169506,280169428,
    280169447,280169452,280169471,280169481,280169495,280169505,280169523,280169486,280169511,280169435,280169512,280169459,280169484,280169500,280169427,280169444,
    280169462,280169494,280169446,280169488,280169429,280169515,280169437,280169453,280169513,280169433,280169521,280169443,280169518,280169441,280169463,280169482,
    280169455,280169473,280169493,280169442,280169491,280169468,280169502,280169461,280169496,280169510,280169466,280169508,280169469,280169460,280169450,280169477,
    280169501,280169436,280169426,280169431,280169451,280169456,280169458,280169475,280169497,280169498,280169516,280169519,280169439,280169478,280169517,280169467,
    280169504,280169438,280169474,280169457,280169503,280169449,280169434,280169464,280169492,280169522,283566641,283566683,283566664,283566635,283566631,283566628,
    283566625,283566660,283566650,283566601,283566589,283566620,283566655,283566689,283566674,283566695,283566668,283566686,283566592,283566653,283566687,283566633,
    283566679,283566671,283566575,283566667,283566634,283566629,283566652,283566581,283566596,283566610,283566666,283566678,283566692,283566617,283566624,283566616,
    283566643,283566618,283566648,283566681,283566651,283566677,283566574,283566630,292359522,292359499,292359500,292359536,292359549,292359503,292359544,292359552,
    292359564,292359540,292359507,292359545,292359567,292359557,292359505,292359523,292359525,292359533,292359566,292359569,292359547,292359537,292359520,292359528,
    292359524,292359535,292359526,292359568,292359550,292359548,292359541,292359498,292359551,292359563,292359532,292359555,292359501,292359504,292359518,292359543,
    292359521,292359506,292359502,292359534,292359556,292359565,293251707,293251742,285201343,285201336,285201335,285201345,285201344,285201341,285201338,285201333,
    285201349,285201340,285201339,285201342,285201346,285201347,285201334,285201337,285201332,285201350,285201348,287605569,287605571,287605589,287605566,287605595,
    287605581,287605580,287605526,287605562,287605582,287605561,287605537,287605576,287605568,287605591,287605531,287605560,287605577,287605585,287605515,287605593,
    287605584,287605564,287605588,287605578,287605579,287605583,287605519,287605539,287605559,287605565,287605572,287605570,287605574,287605587,287605575,287605567,
    287605586
  )
  AND ooa.TASK_TYPE_ID IN (12149, 12150, 12162)
  AND oo.CAUSAL_ID = 9944
  AND oo.ORDER_STATUS_ID IN (8)
  AND mp.PACKAGE_TYPE_ID = 323
  AND oo.LEGALIZATION_DATE >= '01-07-2023';
  nuSigue number:=1;

BEGIN
  FOR reg IN cuOrders LOOP
    nuSigue :=1;
    -- reset vars
    packageId := NULL;
    productId := NULL;
    packageTypeId := NULL;
    quotationItemId := NULL;
    unitValue := NULL;
    unitTaxValue := NULL;
    taskTypeId := NULL;

    -- start generate charge process
    orderId := reg.ORDER_ID;

    SELECT PACKAGE_ID, TASK_TYPE_ID
      into packageId, taskTypeId
      FROM OPEN.OR_ORDER_ACTIVITY
    WHERE ORDER_ID = orderId
      AND ROWNUM = 1;

    IF packageId IS NULL THEN
      RETURN;
    END IF;

    SELECT PACKAGE_TYPE_ID
    INTO packageTypeId
    FROM OPEN.MO_PACKAGES
    WHERE PACKAGE_ID = packageId;

    IF packageTypeId NOT IN (323) THEN
      RETURN;
    END IF;

    SELECT PRODUCT_ID
    INTO productId
    FROM OPEN.MO_MOTIVE mm
    WHERE mm.PACKAGE_ID = packageId
    AND mm.PRODUCT_TYPE_ID = 6121 -- tipo producto contrato padre
    AND ROWNUM = 1;

    BEGIN
      SELECT QI.QUOTATION_ITEM_ID, QI.UNIT_VALUE, QI.UNIT_TAX_VALUE
        INTO quotationItemId, unitValue, unitTaxValue
        FROM OPEN.CC_QUOTATION Q
        LEFT JOIN OPEN.CC_QUOTATION_ITEM QI
          ON QI.QUOTATION_ID = Q.QUOTATION_ID
      WHERE Q.PACKAGE_ID = packageId
        AND Q.STATUS IN ('A', 'C')
        AND QI.TASK_TYPE_ID = taskTypeId
        AND QI.REMAINING_ITEMS > 0
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
       nuSigue := 0;
       dbms_output.put_line(packageId||'|no se encontro cotizacion');
    END;
    if nuSigue = 1 then
        UPDATE OPEN.CC_QUOTATION_ITEM
          SET REMAINING_ITEMS = REMAINING_ITEMS - 1
        WHERE QUOTATION_ITEM_ID = quotationItemId;

        "OPEN".PKERRORS.SETAPPLICATION('CUSTOMER');

        -- Generate charges
        IF (taskTypeId = 12149) THEN
          "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                            INUCUCOCODI  => -1,
                                            INUCONCCODI  => 30,
                                            INUCAUSCARG  => 53,
                                            IONUCARGVALO => unitValue,
                                            ISBCARGSIGN  => 'DB',
                                            ISBCARGDOSO  => 'PP-' || packageId,
                                            ISBCARGTIPR  => 'A',
                                            INUCARGCODO  => orderId,
                                            INUCARGUNID  => 1,
                                            INUCARGCOLL  => null,
                                            INUSESUCARG  => null,
                                            IBOKEEPTIPR  => true,
                                            IDTCARGFECR  => sysdate);
          "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                            INUCUCOCODI  => -1,
                                            INUCONCCODI  => 287,
                                            INUCAUSCARG  => 53,
                                            IONUCARGVALO => unitTaxValue,
                                            ISBCARGSIGN  => 'DB',
                                            ISBCARGDOSO  => 'PP-' || packageId,
                                            ISBCARGTIPR  => 'A',
                                            INUCARGCODO  => orderId,
                                            INUCARGUNID  => 1,
                                            INUCARGCOLL  => null,
                                            INUSESUCARG  => null,
                                            IBOKEEPTIPR  => true,
                                            IDTCARGFECR  => sysdate);
        ELSIF (taskTypeId = 12162) THEN
          "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                            INUCUCOCODI  => -1,
                                            INUCONCCODI  => 674,
                                            INUCAUSCARG  => 53,
                                            IONUCARGVALO => unitValue,
                                            ISBCARGSIGN  => 'DB',
                                            ISBCARGDOSO  => 'PP-' || packageId,
                                            ISBCARGTIPR  => 'A',
                                            INUCARGCODO  => orderId,
                                            INUCARGUNID  => 1,
                                            INUCARGCOLL  => null,
                                            INUSESUCARG  => null,
                                            IBOKEEPTIPR  => true,
                                            IDTCARGFECR  => sysdate);
          "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                            INUCUCOCODI  => -1,
                                            INUCONCCODI  => 137,
                                            INUCAUSCARG  => 53,
                                            IONUCARGVALO => unitTaxValue,
                                            ISBCARGSIGN  => 'DB',
                                            ISBCARGDOSO  => 'PP-' || packageId,
                                            ISBCARGTIPR  => 'A',
                                            INUCARGCODO  => orderId,
                                            INUCARGUNID  => 1,
                                            INUCARGCOLL  => null,
                                            INUSESUCARG  => null,
                                            IBOKEEPTIPR  => true,
                                            IDTCARGFECR  => sysdate);
        ELSIF (taskTypeId = 12150) THEN
          "OPEN".PKCHARGEMGR.GENERATECHARGE(INUNUMESERV  => productId,
                                            INUCUCOCODI  => -1,
                                            INUCONCCODI  => 19,
                                            INUCAUSCARG  => 53,
                                            IONUCARGVALO => unitValue,
                                            ISBCARGSIGN  => 'DB',
                                            ISBCARGDOSO  => 'PP-' || packageId,
                                            ISBCARGTIPR  => 'A',
                                            INUCARGCODO  => orderId,
                                            INUCARGUNID  => 1,
                                            INUCARGCOLL  => null,
                                            INUSESUCARG  => null,
                                            IBOKEEPTIPR  => true,
                                            IDTCARGFECR  => sysdate);
        END IF;
     end if;
  END LOOP;
  --
  COMMIT;
  --
  DBMS_OUTPUT.PUT_LINE('Proceso termina ok');
EXCEPTION
  WHEN others THEN
      ROLLBACK;
      ERRORS.SETERROR();
      RAISE EX.CONTROLLED_ERROR;
END;
/