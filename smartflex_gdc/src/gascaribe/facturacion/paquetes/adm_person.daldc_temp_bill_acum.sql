CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_TEMP_BILL_ACUM
IS
/*******************************************************************************
   Propiedad Intelectual de PETI

   Package     : DALDC_TEMP_BILL_ACUM
   Description : Paquete de primer nivel para la tabla LDC_TEMP_BILL_ACUM

   Author      : Sergio Mejía
   Date        : 08/08/2013

   REVISIONS:
   -------------------------------------------------------------------------
   Version      Date        Author                  Description
   -------------------------------------------------------------------------
     1.0      08/08/2013    Sergio Mejía            1. Created this package.
     2.0      05/06/2024    PAcosta                 OSF-2777: Cambio de esquema ADM_PERSON     
*******************************************************************************/

   CURSOR curecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
   IS
      SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.ROWID
        FROM open.LDC_TEMP_BILL_ACUM
       WHERE VARIABLE_ = isbVARIABLE_;

   CURSOR curecordbyrowid (irirowid IN VARCHAR2)
   IS
      SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.ROWID
        FROM open.LDC_TEMP_BILL_ACUM
       WHERE ROWID = irirowid;

   SUBTYPE styLDC_TEMP_BILL_ACUM IS curecord%ROWTYPE;

   TYPE tyrefcursor IS REF CURSOR;

   TYPE tytbLDC_TEMP_BILL_ACUM IS TABLE OF styLDC_TEMP_BILL_ACUM
      INDEX BY BINARY_INTEGER;

   TYPE tyrfrecords IS REF CURSOR
      RETURN styLDC_TEMP_BILL_ACUM;

   TYPE tytbVARIABLE_ IS TABLE OF open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tytbVALUE_ IS TABLE OF open.LDC_TEMP_BILL_ACUM.VALUE_%TYPE
      INDEX BY BINARY_INTEGER;

   TYPE tytbrowid IS TABLE OF ROWID
      INDEX BY BINARY_INTEGER;

   TYPE tyrcLDC_TEMP_BILL_ACUM IS RECORD (
      VARIABLE_   tytbVARIABLE_,
      VALUE_     tytbVALUE_,
      row_id     tytbrowid
   );

   --cnutableparameter   CONSTANT NUMBER (10) := ?????;
   csbtable_name         CONSTANT VARCHAR2 (150) := 'LDC_TEMP_BILL_ACUM';
   csbtable_comments     CONSTANT VARCHAR2 (250) := 'LDC_TEMP_BILL_ACUM';

   PROCEDURE clearmemory;

   FUNCTION fblexist (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN BOOLEAN;

   PROCEDURE acckey (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   );

   PROCEDURE acckeybyrowid (irirowid IN ROWID);

   PROCEDURE valduplicate (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   );

   PROCEDURE getrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      orcrecord     OUT NOCOPY styLDC_TEMP_BILL_ACUM
   );

   FUNCTION frcgetrcdata (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN styLDC_TEMP_BILL_ACUM;

   FUNCTION frcgetrcdata
      RETURN styLDC_TEMP_BILL_ACUM;

   FUNCTION frcgetrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN styLDC_TEMP_BILL_ACUM;

   PROCEDURE getrecords (
      isbquery    IN         VARCHAR2,
      otbresult   OUT NOCOPY tytbLDC_TEMP_BILL_ACUM
   );

   FUNCTION frfgetrecords (
      isbcriteria   IN   VARCHAR2 := NULL,
      ibllock       IN   BOOLEAN := FALSE
   )
      RETURN tyrefcursor;

   PROCEDURE insrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM);

   PROCEDURE insrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM, orirowid OUT VARCHAR2);

   PROCEDURE insrecords (iotbLDC_TEMP_BILL_ACUM IN OUT NOCOPY tytbLDC_TEMP_BILL_ACUM);

   PROCEDURE delrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      inulock       IN   NUMBER := 1
   );

   PROCEDURE delbyrowid (irirowid IN ROWID, inulock IN NUMBER := 1);

   PROCEDURE delrecords (
      iotbLDC_TEMP_BILL_ACUM   IN OUT NOCOPY   tytbLDC_TEMP_BILL_ACUM,
      inulock                    IN              NUMBER := 1
   );

   PROCEDURE updrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM, inulock IN NUMBER := 0);

   PROCEDURE updrecords (
      iotbLDC_TEMP_BILL_ACUM   IN OUT NOCOPY   tytbLDC_TEMP_BILL_ACUM,
      inulock                    IN              NUMBER := 1
   );

   PROCEDURE updVALUE_ (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      inuVALUE_$    IN   open.LDC_TEMP_BILL_ACUM.VALUE_%TYPE,
      inulock       IN   NUMBER := 0
   );

   FUNCTION fnugetVALUE_ (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN NUMBER;

   PROCEDURE lockbypk (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      orcLDC_TEMP_BILL_ACUM OUT  styLDC_TEMP_BILL_ACUM
   );

   PROCEDURE lockbyrowid (irirowid IN VARCHAR2, orcLDC_TEMP_BILL_ACUM OUT styLDC_TEMP_BILL_ACUM);

   PROCEDURE setusecache (iblusecache IN BOOLEAN);

END DALDC_TEMP_BILL_ACUM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_TEMP_BILL_ACUM
IS
/*******************************************************************************
   Propiedad Intelectual de PETI

   Package     : DALDC_TEMP_BILL_ACUM
   Description : Paquete de primer nivel para la tabla LDC_TEMP_BILL_ACUM

   Author      : Sergio Mejía
   Date        : 08/08/2013

   REVISIONS:
   -------------------------------------------------------------------------
   Version      Date        Author                  Description
   -------------------------------------------------------------------------
     1.0      08/08/2013    Sergio Mejía            1. Created this package.

*******************************************************************************/

   cnurecord_not_exist       CONSTANT NUMBER (1)         := 1;
   cnurecord_already_exist   CONSTANT NUMBER (1)         := 2;
   cnuapptablebussy          CONSTANT NUMBER (4)         := 6951;
   cnuins_pk_null            CONSTANT NUMBER (4)         := 1682;
   cnurecord_have_children   CONSTANT NUMBER (4)         := -2292;

   CURSOR culockrcbypk (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
   IS
      SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.ROWID
        FROM open.LDC_TEMP_BILL_ACUM
       WHERE VARIABLE_ = isbVARIABLE_
       FOR UPDATE NOWAIT;

   CURSOR culockrcbyrowid (irirowid IN VARCHAR2)
   IS
      SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.ROWID
        FROM open.LDC_TEMP_BILL_ACUM
       WHERE ROWID = irirowid
       FOR UPDATE NOWAIT;

   TYPE tyrfLDC_TEMP_BILL_ACUM IS REF CURSOR;

   rcrecoftab                         tyrcLDC_TEMP_BILL_ACUM;
   rcdata                             curecord%ROWTYPE;
   bldao_use_cache                    BOOLEAN            := NULL;

   PROCEDURE getdao_use_cache
   IS
   BEGIN
      IF (bldao_use_cache IS NULL)
      THEN
         bldao_use_cache := ge_boparameter.fsbget ('DAO_USE_CACHE') = 'Y';
      END IF;
   END;

   FUNCTION fsbprimarykey (rci IN styLDC_TEMP_BILL_ACUM := rcdata)
      RETURN VARCHAR2
   IS
      sbpk   VARCHAR2 (500);
   BEGIN
      sbpk := '[';
      sbpk := sbpk || ut_convert.fsbtochar (rci.VARIABLE_);
      sbpk := sbpk || ']';
      RETURN sbpk;
   END;

   PROCEDURE delrecordoftables (itbLDC_TEMP_BILL_ACUM IN OUT NOCOPY tytbLDC_TEMP_BILL_ACUM)
   IS
   BEGIN
      FOR n IN itbLDC_TEMP_BILL_ACUM.FIRST .. itbLDC_TEMP_BILL_ACUM.LAST
      LOOP
         rcrecoftab.VARIABLE_.DELETE;
         rcrecoftab.VALUE_.DELETE;
         rcrecoftab.row_id.DELETE;
      END LOOP;
   END;

   PROCEDURE fillrecordoftables (
      itbLDC_TEMP_BILL_ACUM   IN OUT NOCOPY tytbLDC_TEMP_BILL_ACUM,
      obluserowid   OUT             BOOLEAN
   )
   IS
   BEGIN
      delrecordoftables (itbLDC_TEMP_BILL_ACUM);

      FOR n IN itbLDC_TEMP_BILL_ACUM.FIRST .. itbLDC_TEMP_BILL_ACUM.LAST
      LOOP
         rcrecoftab.VARIABLE_ (n) := itbLDC_TEMP_BILL_ACUM (n).VARIABLE_;
         rcrecoftab.VALUE_ (n) := itbLDC_TEMP_BILL_ACUM (n).VALUE_;
         rcrecoftab.row_id (n) := itbLDC_TEMP_BILL_ACUM (n).ROWID;
         obluserowid := rcrecoftab.row_id (n) IS NOT NULL;
      END LOOP;
   END;

   PROCEDURE load (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
   IS
      rcrecordnull   curecord%ROWTYPE;
   BEGIN
      IF curecord%ISOPEN
      THEN
         CLOSE curecord;
      END IF;

      OPEN curecord (isbVARIABLE_);

      FETCH curecord
       INTO rcdata;

      IF curecord%NOTFOUND
      THEN
         CLOSE curecord;

         rcdata := rcrecordnull;
         RAISE NO_DATA_FOUND;
      END IF;

      CLOSE curecord;
   END;

   PROCEDURE loadbyrowid (irirowid IN VARCHAR2)
   IS
      rcrecordnull   curecordbyrowid%ROWTYPE;
   BEGIN
      IF curecordbyrowid%ISOPEN
      THEN
         CLOSE curecordbyrowid;
      END IF;

      OPEN curecordbyrowid (irirowid);

      FETCH curecordbyrowid
       INTO rcdata;

      IF curecordbyrowid%NOTFOUND
      THEN
         CLOSE curecordbyrowid;

         rcdata := rcrecordnull;
         RAISE NO_DATA_FOUND;
      END IF;

      CLOSE curecordbyrowid;
   END;

   FUNCTION fblalreadyloaded (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN BOOLEAN
   IS
   BEGIN
      IF (    isbVARIABLE_ = rcdata.VARIABLE_
         )
      THEN
         RETURN (TRUE);
      END IF;

      RETURN (FALSE);
   END;

   PROCEDURE clearmemory
   IS
      rcrecordnull   curecord%ROWTYPE;
   BEGIN
      rcdata := rcrecordnull;
   END;

   FUNCTION fblexist (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN BOOLEAN
   IS
   BEGIN
      load (isbVARIABLE_);
      RETURN (TRUE);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN (FALSE);
   END;

   PROCEDURE acckey (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;
      LOAD (isbVARIABLE_);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE acckeybyrowid (irirowid IN ROWID)
   IS
   BEGIN
      loadbyrowid (irirowid);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' rowid=['
                          || irirowid
                          || ']'
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE valduplicate (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
   IS
   BEGIN
      LOAD (isbVARIABLE_);
      ERRORS.seterror (cnurecord_already_exist,
                       --   dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                       || ' '
                       || fsbprimarykey
                      );
      RAISE ex.controlled_error;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   PROCEDURE getrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      orcrecord     OUT NOCOPY styLDC_TEMP_BILL_ACUM
   )
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;
      LOAD (isbVARIABLE_);
      orcrecord := rcdata;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   FUNCTION frcgetrcdata (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN styLDC_TEMP_BILL_ACUM
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;

      IF     bldao_use_cache
         AND fblalreadyloaded (isbVARIABLE_)
      THEN
         RETURN (rcdata);
      END IF;

      load (isbVARIABLE_);
      RETURN (rcdata);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   FUNCTION frcgetrcdata
      RETURN styLDC_TEMP_BILL_ACUM
   IS
   BEGIN
      RETURN (rcdata);
   END;

   FUNCTION frcgetrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN styLDC_TEMP_BILL_ACUM
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;
      LOAD (isbVARIABLE_);
      RETURN (rcdata);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE getrecords (
      isbquery    IN         VARCHAR2,
      otbresult   OUT NOCOPY tytbLDC_TEMP_BILL_ACUM
   )
   IS
      rfLDC_TEMP_BILL_ACUM       tyrfLDC_TEMP_BILL_ACUM;
      n                NUMBER (4)     := 1;
      sbfullquery      VARCHAR2 (500) := 'SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.rowid FROM open.LDC_TEMP_BILL_ACUM';
      numaxtbrecords   NUMBER (5)   := ge_boparameter.fnuget ('MAXREGSQUERY');
   BEGIN
      otbresult.DELETE;

      IF isbquery IS NOT NULL AND LENGTH (isbquery) > 0
      THEN
         sbfullquery := sbfullquery || ' WHERE ' || isbquery;
      END IF;

      OPEN rfLDC_TEMP_BILL_ACUM FOR sbfullquery;

      LOOP
         FETCH rfLDC_TEMP_BILL_ACUM
          INTO otbresult (n);

         EXIT WHEN (rfLDC_TEMP_BILL_ACUM%NOTFOUND);
         n := n + 1;
      END LOOP;

      CLOSE rfLDC_TEMP_BILL_ACUM;

      IF otbresult.COUNT = 0
      THEN
         RAISE NO_DATA_FOUND;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                         );
         RAISE ex.controlled_error;
   END;

   FUNCTION frfgetrecords (
      isbcriteria   IN   VARCHAR2 := NULL,
      ibllock       IN   BOOLEAN := FALSE
   )
      RETURN tyrefcursor
   IS
      rfquery   tyrefcursor;
      sbsql     VARCHAR2 (500) := 'SELECT open.LDC_TEMP_BILL_ACUM.*, open.LDC_TEMP_BILL_ACUM.rowid FROM open.LDC_TEMP_BILL_ACUM';
   BEGIN
      IF isbcriteria IS NOT NULL
      THEN
         sbsql := sbsql || ' WHERE ' || isbcriteria;
      END IF;

      IF ibllock
      THEN
         sbsql := sbsql || ' for update nowait';
      END IF;

      OPEN rfquery FOR sbsql;

      RETURN (rfquery);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE insrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM)
   IS
      rirowid   VARCHAR2 (200);
   BEGIN
      insrecord (ircLDC_TEMP_BILL_ACUM, rirowid);
   END;

   PROCEDURE insrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM, orirowid OUT VARCHAR2)
   IS
   BEGIN
      IF ircLDC_TEMP_BILL_ACUM.VARIABLE_ IS NULL
      THEN
         ERRORS.seterror (cnuins_pk_null,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                          || '|VARIABLE_'
                         );
         RAISE ex.controlled_error;
      END IF;

      INSERT INTO open.LDC_TEMP_BILL_ACUM
                  (VARIABLE_,
                   VALUE_
                  )
           VALUES (ircLDC_TEMP_BILL_ACUM.VARIABLE_,
                   ircLDC_TEMP_BILL_ACUM.VALUE_
                  )
        RETURNING ROWID
             INTO orirowid;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         ERRORS.seterror (cnurecord_already_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (ircLDC_TEMP_BILL_ACUM)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE insrecords (iotbLDC_TEMP_BILL_ACUM IN OUT NOCOPY tytbLDC_TEMP_BILL_ACUM)
   IS
      bluserowid   BOOLEAN;
   BEGIN
      fillrecordoftables (iotbLDC_TEMP_BILL_ACUM, bluserowid);
      FORALL n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
         INSERT INTO open.LDC_TEMP_BILL_ACUM
                     (VARIABLE_,
                      VALUE_
                     )
              VALUES (rcrecoftab.VARIABLE_ (n),
                      rcrecoftab.VALUE_ (n)
                    );
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
         ERRORS.seterror (cnurecord_already_exist,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE delrecord (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      inulock       IN   NUMBER := 1
   )
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;

      IF inulock = 1
      THEN
         lockbypk (isbVARIABLE_, rcdata);
      END IF;

      DELETE FROM open.LDC_TEMP_BILL_ACUM
            WHERE VARIABLE_ = isbVARIABLE_;

      IF SQL%NOTFOUND
      THEN
         RAISE NO_DATA_FOUND;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
      WHEN ex.record_have_children
      THEN
         ERRORS.seterror (cnurecord_have_children,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE delbyrowid (irirowid IN ROWID, inulock IN NUMBER := 1)
   IS
      rcrecordnull   curecord%ROWTYPE;
      rcerror        styLDC_TEMP_BILL_ACUM;
   BEGIN
      IF inulock = 1
      THEN
         lockbyrowid (irirowid, rcdata);
      END IF;

      DELETE FROM open.LDC_TEMP_BILL_ACUM
            WHERE ROWID = irirowid
        RETURNING VARIABLE_
             INTO rcerror.VARIABLE_;

      IF SQL%NOTFOUND
      THEN
         RAISE NO_DATA_FOUND;
      END IF;

      IF rcdata.ROWID = irirowid
      THEN
         rcdata := rcrecordnull;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' rowid=['
                          || irirowid
                          || ']'
                         );
         RAISE ex.controlled_error;
      WHEN ex.record_have_children
      THEN
         ERRORS.seterror (cnurecord_have_children,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' rowid=['
                          || irirowid
                          || ']'
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE delrecords (
      iotbLDC_TEMP_BILL_ACUM   IN OUT NOCOPY   tytbLDC_TEMP_BILL_ACUM,
      inulock                    IN              NUMBER := 1
   )
   IS
      bluserowid   BOOLEAN;
      rcaux        styLDC_TEMP_BILL_ACUM;
   BEGIN
      fillrecordoftables (iotbLDC_TEMP_BILL_ACUM, bluserowid);

      IF (bluserowid)
      THEN
         IF inulock = 1
         THEN
            FOR n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            LOOP
               lockbyrowid (rcrecoftab.row_id (n), rcaux);
            END LOOP;
         END IF;

         FORALL n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            DELETE FROM open.LDC_TEMP_BILL_ACUM
                  WHERE ROWID = rcrecoftab.row_id (n);
      ELSE
         IF inulock = 1
         THEN
            FOR n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            LOOP
               lockbypk (rcrecoftab.VARIABLE_ (n),
                         rcaux
                        );
            END LOOP;
         END IF;

         FORALL n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            DELETE FROM open.LDC_TEMP_BILL_ACUM
                  WHERE VARIABLE_ = rcrecoftab.VARIABLE_ (n);
      END IF;
   EXCEPTION
      WHEN ex.record_have_children
      THEN
         ERRORS.seterror (cnurecord_have_children,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE updrecord (ircLDC_TEMP_BILL_ACUM IN styLDC_TEMP_BILL_ACUM, inulock IN NUMBER := 0)
   IS
      sbVARIABLE_   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE;
   BEGIN
      IF ircLDC_TEMP_BILL_ACUM.ROWID IS NOT NULL
      THEN
         IF inulock = 1
         THEN
            lockbyrowid (ircLDC_TEMP_BILL_ACUM.ROWID, rcdata);
         END IF;

         UPDATE    open.LDC_TEMP_BILL_ACUM
               SET VALUE_ = ircLDC_TEMP_BILL_ACUM.VALUE_
             WHERE ROWID = ircLDC_TEMP_BILL_ACUM.ROWID
         RETURNING VARIABLE_
              INTO sbVARIABLE_;
      ELSE
         IF inulock = 1
         THEN
            lockbypk (ircLDC_TEMP_BILL_ACUM.VARIABLE_,
                      rcdata
                     );
         END IF;

         UPDATE    open.LDC_TEMP_BILL_ACUM
               SET VALUE_ = ircLDC_TEMP_BILL_ACUM.VALUE_
             WHERE VARIABLE_ = ircLDC_TEMP_BILL_ACUM.VARIABLE_
         RETURNING VARIABLE_
              INTO sbVARIABLE_;
      END IF;

      IF sbVARIABLE_ IS NULL
      THEN
         RAISE NO_DATA_FOUND;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --dage_message.fsbgetdescription (cnutableparameter)
                          csbtable_comments
                          || fsbprimarykey (ircLDC_TEMP_BILL_ACUM)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE updrecords (
      iotbLDC_TEMP_BILL_ACUM   IN OUT NOCOPY   tytbLDC_TEMP_BILL_ACUM,
      inulock                    IN              NUMBER := 1
   )
   IS
      bluserowid   BOOLEAN;
      rcaux        styLDC_TEMP_BILL_ACUM;
   BEGIN
      fillrecordoftables (iotbLDC_TEMP_BILL_ACUM, bluserowid);

      IF bluserowid
      THEN
         IF inulock = 1
         THEN
            FOR n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            LOOP
               lockbyrowid (rcrecoftab.row_id (n), rcaux);
            END LOOP;
         END IF;

         FORALL n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            UPDATE open.LDC_TEMP_BILL_ACUM
               SET VARIABLE_ = rcrecoftab.VARIABLE_ (n),
                   VALUE_ = rcrecoftab.VALUE_ (n)
             WHERE ROWID = rcrecoftab.row_id (n);
      ELSE
         IF inulock = 1
         THEN
            FOR n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            LOOP
               lockbypk (rcrecoftab.VARIABLE_ (n),
                         rcaux
                        );
            END LOOP;
         END IF;

         FORALL n IN iotbLDC_TEMP_BILL_ACUM.FIRST .. iotbLDC_TEMP_BILL_ACUM.LAST
            UPDATE open.LDC_TEMP_BILL_ACUM
               SET VARIABLE_ = rcrecoftab.VARIABLE_ (n),
                   VALUE_ = rcrecoftab.VALUE_ (n)
             WHERE VARIABLE_ = rcrecoftab.VARIABLE_ (n);
      END IF;
   END;

   PROCEDURE updVALUE_ (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      inuVALUE_$    IN   open.LDC_TEMP_BILL_ACUM.VALUE_%TYPE,
      inulock       IN   NUMBER := 0
   )
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;

      IF inulock = 1
      THEN
         lockbypk (isbVARIABLE_, rcdata);
      END IF;

      UPDATE open.LDC_TEMP_BILL_ACUM
         SET VALUE_ = inuVALUE_$
       WHERE VARIABLE_ = isbVARIABLE_;

      IF SQL%NOTFOUND
      THEN
         RAISE NO_DATA_FOUND;
      END IF;

      rcdata.VALUE_ := inuVALUE_$;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   FUNCTION fnugetVALUE_ (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE
   )
      RETURN NUMBER
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;

      IF     bldao_use_cache
         AND fblalreadyloaded (isbVARIABLE_)
      THEN
         RETURN (rcdata.VALUE_);
      END IF;

      LOAD (isbVARIABLE_);
      RETURN (rcdata.VALUE_);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
   END;

   PROCEDURE lockbypk (
      isbVARIABLE_   IN   open.LDC_TEMP_BILL_ACUM.VARIABLE_%TYPE,
      orcLDC_TEMP_BILL_ACUM OUT  styLDC_TEMP_BILL_ACUM
   )
   IS
      rcerror   styLDC_TEMP_BILL_ACUM;
   BEGIN
      rcerror.VARIABLE_ := isbVARIABLE_;

      OPEN culockrcbypk (isbVARIABLE_);

      FETCH culockrcbypk
       INTO orcLDC_TEMP_BILL_ACUM;

      IF culockrcbypk%NOTFOUND
      THEN
         CLOSE culockrcbypk;

         RAISE NO_DATA_FOUND;
      END IF;

      CLOSE culockrcbypk;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF culockrcbypk%ISOPEN
         THEN
            CLOSE culockrcbypk;
         END IF;

         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' '
                          || fsbprimarykey (rcerror)
                         );
         RAISE ex.controlled_error;
      WHEN ex.resource_busy
      THEN
         IF culockrcbypk%ISOPEN
         THEN
            CLOSE culockrcbypk;
         END IF;

         ERRORS.seterror (cnuapptablebussy,
                             fsbprimarykey (rcerror)
                          || '|'
                          --|| dage_message.fsbgetdescription (cnutableparameter)
                          || csbtable_comments
                         );
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         IF culockrcbypk%ISOPEN
         THEN
            CLOSE culockrcbypk;
         END IF;

         RAISE;
   END;

   PROCEDURE lockbyrowid (irirowid IN VARCHAR2, orcLDC_TEMP_BILL_ACUM OUT styLDC_TEMP_BILL_ACUM)
   IS
   BEGIN
      OPEN culockrcbyrowid (irirowid);

      FETCH culockrcbyrowid
       INTO orcLDC_TEMP_BILL_ACUM;

      IF culockrcbyrowid%NOTFOUND
      THEN
         CLOSE culockrcbyrowid;

         RAISE NO_DATA_FOUND;
      END IF;

      CLOSE culockrcbyrowid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF culockrcbyrowid%ISOPEN
         THEN
            CLOSE culockrcbyrowid;
         END IF;

         ERRORS.seterror (cnurecord_not_exist,
                          --   dage_message.fsbgetdescription (cnutableparameter)
                             csbtable_comments
                          || ' rowid=['
                          || irirowid
                          || ']'
                         );
         RAISE ex.controlled_error;
      WHEN ex.resource_busy
      THEN
         IF culockrcbyrowid%ISOPEN
         THEN
            CLOSE culockrcbyrowid;
         END IF;

         ERRORS.seterror (cnuapptablebussy,
                             'rowid=['
                          || irirowid
                          || ']|'
                          --|| dage_message.fsbgetdescription (cnutableparameter)
                          || csbtable_comments
                         );
         RAISE ex.controlled_error;
      WHEN OTHERS
      THEN
         IF culockrcbyrowid%ISOPEN
         THEN
            CLOSE culockrcbyrowid;
         END IF;

         RAISE;
   END;

   PROCEDURE setusecache (iblusecache IN BOOLEAN)
   IS
   BEGIN
      bldao_use_cache := iblusecache;
   END;

BEGIN
   getdao_use_cache;
END DALDC_TEMP_BILL_ACUM;
/
PROMPT Otorgando permisos de ejecucion a DALDC_TEMP_BILL_ACUM
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_TEMP_BILL_ACUM', 'ADM_PERSON');
END;
/