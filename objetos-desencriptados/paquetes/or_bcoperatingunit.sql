CREATE OR REPLACE PACKAGE BODY OR_BCOPERATINGUNIT IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO229029';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE GETOPERATUNITPACK( ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBUSER VARCHAR2( 100 );
    BEGIN
      SBUSER := PKGENERALSERVICES.FSBGETUSERNAME;
      OPEN ORFREFCURSOR FOR SELECT  OR_operating_unit.operating_unit_id,
                    OR_operating_unit.name,
                    or_uni_ope_empaqueta.operating_unit_id isPack
            FROM    OR_operating_unit,
                    or_uni_ope_empaqueta,
                    or_oper_unit_persons,
                    ge_person,
                    sa_user
            WHERE   /*nvl(es_externa, 'N') <> 'N'
            AND*/   sa_user.mask = sbUser
            AND     ge_person.user_id = sa_user.user_id
            AND     or_oper_unit_persons.person_id = ge_person.person_id
            AND     or_oper_unit_persons.operating_unit_id = OR_operating_unit.operating_unit_id
            AND     OR_operating_unit.operating_unit_id = or_uni_ope_empaqueta.operating_unit_id(+)
            AND     OR_operating_unit.oper_unit_classif_id = ge_boitemsconstants.cnuUNID_OP_TIENDA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETOPERATUNITPACK;
   PROCEDURE OBTUNIDADESPARAMUESTREO( INUBASEADMIN IN GE_CONF_MUES_UNIDAD.ID_BASE_ADMINISTRATIVA%TYPE, INUCONTRATISTA IN GE_CONTRATISTA.ID_CONTRATISTA%TYPE, OTBUNIDOPER OUT TBTYUNIDADMUESTREO )
    IS
      CURSOR CUUNIOPERBASECONT IS
SELECT /*+ index ( or_operating_unit IDX_OR_OPERATING_UNIT_04 ) */
                   operating_unit_id,
                   admin_base_id,
                   contractor_id
            FROM   or_operating_unit
            WHERE  es_inspeccionable = or_boconstants.csbSI
              AND  admin_base_id = inuBaseAdmin
              AND  contractor_id = inuContratista;
      CURSOR CUUNIOPERBASE IS
SELECT /*+ index ( or_operating_unit IDX_OR_OPERATING_UNIT_04 ) */
                   operating_unit_id,
                   admin_base_id,
                   contractor_id
            FROM   or_operating_unit
            WHERE  es_inspeccionable = or_boconstants.csbSI
              AND  admin_base_id = inuBaseAdmin;
      CURSOR CUUNIOPERCONT IS
SELECT /*+ index ( or_operating_unit IDX_OR_OPERATING_UNIT_04 ) */
                   operating_unit_id,
                   admin_base_id,
                   contractor_id
            FROM   or_operating_unit
            WHERE  es_inspeccionable = or_boconstants.csbSI
              AND  contractor_id = inuContratista;
      CURSOR CUUNIOPER IS
SELECT /*+ index ( or_operating_unit IDX_OR_OPERATING_UNIT_04 ) */
                   operating_unit_id,
                   admin_base_id,
                   contractor_id
            FROM   or_operating_unit
            WHERE  es_inspeccionable = or_boconstants.csbSI;
    BEGIN
      IF ( INUBASEADMIN IS NULL AND INUCONTRATISTA IS NULL ) THEN
         OPEN CUUNIOPER;
         FETCH CUUNIOPER
            BULK COLLECT INTO OTBUNIDOPER;
         CLOSE CUUNIOPER;
       ELSIF ( INUBASEADMIN IS NOT NULL AND INUCONTRATISTA IS NOT NULL ) THEN
         OPEN CUUNIOPERBASECONT;
         FETCH CUUNIOPERBASECONT
            BULK COLLECT INTO OTBUNIDOPER;
         CLOSE CUUNIOPERBASECONT;
       ELSIF ( INUBASEADMIN IS NULL ) THEN
         OPEN CUUNIOPERCONT;
         FETCH CUUNIOPERCONT
            BULK COLLECT INTO OTBUNIDOPER;
         CLOSE CUUNIOPERCONT;
       ELSE
         OPEN CUUNIOPERBASE;
         FETCH CUUNIOPERBASE
            BULK COLLECT INTO OTBUNIDOPER;
         CLOSE CUUNIOPERBASE;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUUNIOPER%ISOPEN THEN
            CLOSE CUUNIOPER;
         END IF;
         IF CUUNIOPERCONT%ISOPEN THEN
            CLOSE CUUNIOPERCONT;
         END IF;
         IF CUUNIOPERBASE%ISOPEN THEN
            CLOSE CUUNIOPERBASE;
         END IF;
         IF CUUNIOPERBASECONT%ISOPEN THEN
            CLOSE CUUNIOPERBASECONT;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUUNIOPER%ISOPEN THEN
            CLOSE CUUNIOPER;
         END IF;
         IF CUUNIOPERCONT%ISOPEN THEN
            CLOSE CUUNIOPERCONT;
         END IF;
         IF CUUNIOPERBASE%ISOPEN THEN
            CLOSE CUUNIOPERBASE;
         END IF;
         IF CUUNIOPERBASECONT%ISOPEN THEN
            CLOSE CUUNIOPERBASECONT;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTUNIDADESPARAMUESTREO;
   FUNCTION FBLEXISTECOMBINACION( INUBASEADMIN IN OR_OPERATING_UNIT.ADMIN_BASE_ID%TYPE, INUCONTRATISTA IN OR_OPERATING_UNIT.CONTRACTOR_ID%TYPE, INUUNIDADOPER IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN BOOLEAN
    IS
      RFREFCURSOR CONSTANTS.TYREFCURSOR;
      SBCONSULTA VARCHAR2( 1000 );
      BLPRIMERACONDICION BOOLEAN := TRUE;
      NUNUMEROCOINCIDENCIAS NUMBER;
    BEGIN
      IF INUBASEADMIN IS NULL AND INUCONTRATISTA IS NULL AND INUUNIDADOPER IS NULL THEN
         ERRORS.SETERROR( 9701 );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      SBCONSULTA := 'SELECT   count(1)
                       FROM     OR_operating_unit
                       WHERE    ';
      IF INUBASEADMIN IS NOT NULL THEN
         SBCONSULTA := SBCONSULTA || 'admin_base_id = ' || INUBASEADMIN || CHR( 10 );
         BLPRIMERACONDICION := FALSE;
      END IF;
      IF INUCONTRATISTA IS NOT NULL THEN
         IF NOT BLPRIMERACONDICION THEN
            SBCONSULTA := SBCONSULTA || 'AND      ';
         END IF;
         SBCONSULTA := SBCONSULTA || 'contractor_id = ' || INUCONTRATISTA || CHR( 10 );
         BLPRIMERACONDICION := FALSE;
      END IF;
      IF INUUNIDADOPER IS NOT NULL THEN
         IF NOT BLPRIMERACONDICION THEN
            SBCONSULTA := SBCONSULTA || 'AND      ';
         END IF;
         SBCONSULTA := SBCONSULTA || 'operating_unit_id = ' || INUUNIDADOPER || CHR( 10 );
      END IF;
      OPEN RFREFCURSOR
           FOR SBCONSULTA;
      FETCH RFREFCURSOR
         INTO NUNUMEROCOINCIDENCIAS;
      CLOSE RFREFCURSOR;
      IF NUNUMEROCOINCIDENCIAS > 0 THEN
         RETURN TRUE;
       ELSE
         RETURN FALSE;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRFGETOPERUNITINFO( INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      CUGETOPERUNITINFO CONSTANTS.TYREFCURSOR;
    BEGIN
      OPEN CUGETOPERUNITINFO FOR SELECT  oper_unit.operating_unit_id || ' - '|| oper_unit.name || '  -  Tel: [' || nvl(oper_unit.phone_number,'-') || ']  -  Base: [' || oper_unit.admin_base_id || ' - ' || ge_base_administra.descripcion || ']' oper_unit_desc,
                    oper_unit.oper_unit_status_id || ' - ' || or_oper_unit_status.description oper_unit_stat_desc,
                    round(addr_start.shape.SDO_POINT.X, 10) startPointX,
                    round(addr_start.shape.SDO_POINT.Y, 10) startPointY,
                    round(oper_unit.CURRENT_POSITION.SDO_POINT.X, 10) currentPointX,
                    round(oper_unit.CURRENT_POSITION.SDO_POINT.Y, 10) currentPointY,
                    oper_unit.admin_base_id,
                    ge_base_administra.descripcion admin_base_desc
              FROM  or_operating_unit oper_unit,
                    ge_base_administra,
                    or_oper_unit_status,
                    ab_address addr_start
            WHERE  oper_unit.admin_base_id = ge_base_administra.id_base_administra (+)
               AND  oper_unit.oper_unit_status_id = or_oper_unit_status.oper_unit_status_id
               AND  oper_unit.operating_unit_id =  inuOperatingUnitId
               AND  oper_unit.starting_address  =  addr_start.address_id(+);
      RETURN CUGETOPERUNITINFO;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FTBGETOPEUNIBYPERSON( INUPERSONID IN OR_OPERATING_UNIT.PERSON_IN_CHARGE%TYPE := NULL, INUCLASSIFICATION IN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE := NULL )
    RETURN DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID
    IS
      NUPERSONID GE_PERSON.PERSON_ID%TYPE;
      TBOPERATINGUNIT DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
      NUCLASS OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID%TYPE;
      CURSOR CUOPEUNIBYPERSON( INUPERSON IN NUMBER, INUCLASS IN NUMBER ) IS
SELECT or_operating_unit.operating_unit_id
          FROM or_operating_unit,
               or_oper_unit_persons
         WHERE or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id
           AND or_operating_unit.oper_unit_classif_id = inuClass
           AND or_oper_unit_persons.person_id = inuPerson;
    BEGIN
      IF INUCLASSIFICATION IS NULL THEN
         NUCLASS := GE_BOPARAMETER.FNUGET( 'OR_DISPATCH_UNITCLAS' );
       ELSE
         NUCLASS := INUCLASSIFICATION;
      END IF;
      NUPERSONID := INUPERSONID;
      IF ( INUPERSONID IS NULL ) THEN
         NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
      END IF;
      IF CUOPEUNIBYPERSON%ISOPEN THEN
         CLOSE CUOPEUNIBYPERSON;
      END IF;
      OPEN CUOPEUNIBYPERSON( NUPERSONID, NUCLASS );
      FETCH CUOPEUNIBYPERSON
         BULK COLLECT INTO TBOPERATINGUNIT;
      CLOSE CUOPEUNIBYPERSON;
      RETURN TBOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FTBGETUNITBYPERSON( INUPERSONID IN OR_OPERATING_UNIT.PERSON_IN_CHARGE%TYPE := NULL )
    RETURN DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID
    IS
      NUPERSONID GE_PERSON.PERSON_ID%TYPE;
      TBOPERATINGUNIT DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
      NUDISPATCHUNITCLASS OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID%TYPE;
      NUPERSONSUPERFIELD OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID%TYPE;
      CURSOR CUOPEUNIBYPERSON( INUPERSON IN NUMBER ) IS
SELECT /*+ use_nl(or_operating_unit)
                       use_nl(or_oper_unit_persons)
                       index(or_oper_unit_persons pk_or_oper_unit_persons)
                       index(or_operating_unit pk_or_operating_unit)
                       leading(or_oper_unit_persons,or_operating_unit)
                    */
                    or_operating_unit.operating_unit_id
              FROM or_operating_unit,
                   or_oper_unit_persons
                   /*+ Ubicacion: OR_BCOperatingUnit.ftbGetUnitByPerson:*/
             WHERE or_operating_unit.operating_unit_id = or_oper_unit_persons.operating_unit_id
               AND or_oper_unit_persons.person_id = inuPerson
               AND  not exists
               (
                SELECT 1
                  FROM or_operating_unit a
                 WHERE a.oper_unit_classif_id in (nuDispatchUnitClass,nuPersonSuperField)
                   AND a.operating_unit_id = or_operating_unit.operating_unit_id
              );
    BEGIN
      UT_TRACE.TRACE( '[INICIO] OR_BCOperatingUnit.ftbGetUnitByPerson:
                        PersonId[' || INUPERSONID || ']', 10 );
      NUDISPATCHUNITCLASS := GE_BOPARAMETER.FNUGET( 'OR_DISPATCH_UNITCLAS' );
      NUPERSONSUPERFIELD := GE_BOPARAMETER.FNUGET( 'PERSON_SUPERV_FIELD' );
      NUPERSONID := INUPERSONID;
      IF ( INUPERSONID IS NULL ) THEN
         NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;
      END IF;
      IF ( CUOPEUNIBYPERSON%ISOPEN ) THEN
         CLOSE CUOPEUNIBYPERSON;
      END IF;
      OPEN CUOPEUNIBYPERSON( NUPERSONID );
      FETCH CUOPEUNIBYPERSON
         BULK COLLECT INTO TBOPERATINGUNIT;
      CLOSE CUOPEUNIBYPERSON;
      UT_TRACE.TRACE( '[FIN] OR_BCOperatingUnit.ftbGetUnitByPerson: ', 10 );
      RETURN TBOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'Error : ex.CONTROLLED_ERROR', 10 );
         RAISE;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'Error : others', 10 );
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETUNITBYPERSON;
   FUNCTION FRFGETOPERUNITINFO( ITBSCHEDIDS IN OR_TYTBSCHEDAVAILABLEID )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      CURFOPERUNITS CONSTANTS.TYREFCURSOR;
    BEGIN
      OPEN CURFOPERUNITS FOR SELECT /*+ ordered
                       use_nl(or_sched_available or_operating_unit)
                       index(or_sched_available pk_or_sched_available)
                       index(or_operating_unit pk_or_operating_unit)
                       index(or_oper_unit_classif pk_or_oper_unit_classif) */
                   DISTINCT
                   or_operating_unit.operating_unit_id,
                   or_operating_unit.name,
                   or_operating_unit.assign_type,
                   or_operating_unit.oper_unit_classif_id,
                   or_operating_unit.admin_base_id,
                   or_oper_unit_classif.description operUnitClassifDesc
              FROM table(cast(itbSchedIds AS OR_TYTBSCHEDAVAILABLEID)) sched,
                   or_sched_available,
                   or_operating_unit,
                   or_oper_unit_classif
             WHERE or_sched_available.sched_available_id = sched.Sched_Available_Id
               AND or_operating_unit.operating_unit_id = or_sched_available.operating_unit_id
               AND or_oper_unit_classif.oper_unit_classif_id = or_operating_unit.oper_unit_classif_id;
      RETURN CURFOPERUNITS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE GETGEOREFERENCE( INUOPERATINGUNIT IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, ONUPOINTX OUT AB_ADDRESS.SHAPE.SDO_POINT.X%TYPE, ONUPOINTY OUT AB_ADDRESS.SHAPE.SDO_POINT.Y%TYPE )
    IS
      CURSOR CUXY IS
SELECT /*+ ordered */
                   a.shape.SDO_POINT.X PointX,
                   a.shape.SDO_POINT.Y PointY
              FROM or_operating_unit,
                   ab_address a
             WHERE a.address_id = or_operating_unit.starting_address
               AND or_operating_unit.operating_unit_id = inuOperatingUnit;
    BEGIN
      IF CUXY%ISOPEN THEN
         CLOSE CUXY;
      END IF;
      OPEN CUXY;
      FETCH CUXY
         INTO ONUPOINTX, ONUPOINTY;
      CLOSE CUXY;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUXY%ISOPEN THEN
            CLOSE CUXY;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUXY%ISOPEN THEN
            CLOSE CUXY;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETGEOREFERENCE;
   FUNCTION FRCGETUNITBYORGAREA( INUORGAREAID IN GE_ORGANIZAT_AREA.ORGANIZAT_AREA_ID%TYPE )
    RETURN DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT
    IS
      RCOPERUNIT DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT;
      CURSOR CUUNITBYAREA IS
SELECT a.*, a.rowid
            FROM or_operating_unit a
            WHERE a.orga_area_id = inuOrgAreaId;
      PROCEDURE CLOSECURSOR
       IS
       BEGIN
         IF ( CUUNITBYAREA%ISOPEN ) THEN
            CLOSE CUUNITBYAREA;
         END IF;
       EXCEPTION
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END CLOSECURSOR;
    BEGIN
      CLOSECURSOR;
      OPEN CUUNITBYAREA;
      FETCH CUUNITBYAREA
         INTO RCOPERUNIT;
      CLOSE CUUNITBYAREA;
      RETURN RCOPERUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSOR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSOR;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FRCGETUNITBYORGAREA;
   FUNCTION FRFGETUNITLOVBYSECTANDITM( INUOPERATINGSECTORID IN OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%TYPE, INUACTIVITYID IN OR_ACTIVIDADES_ROL.ID_ACTIVIDAD%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      CUUNITBYSECTANDITM CONSTANTS.TYREFCURSOR;
      PROCEDURE CLOSEMYCURSOR
       IS
       BEGIN
         IF ( CUUNITBYSECTANDITM%ISOPEN ) THEN
            CLOSE CUUNITBYSECTANDITM;
         END IF;
       EXCEPTION
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END CLOSEMYCURSOR;
    BEGIN
      CLOSEMYCURSOR;
      OPEN CUUNITBYSECTANDITM FOR SELECT
                  /*+ INDEX(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 ) */
                  DISTINCT
                  operating_unit_id id
                , name description
             FROM ge_sectorope_zona,
                  or_zona_base_adm,
                  or_actividades_rol,
                  or_rol_unidad_trab,
                  or_operating_unit,
                  or_oper_unit_status
            WHERE or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
              AND or_actividades_rol.id_rol = or_rol_unidad_trab.id_rol
              AND or_rol_unidad_trab.id_unidad_operativa = or_operating_unit.operating_unit_id
              AND or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
              AND or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
              AND or_actividades_rol.id_actividad = inuActivityId
              AND ge_sectorope_zona.id_sector_operativo = inuOperatingSectorId
              AND or_oper_unit_status.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.valid_for_assign = ge_boconstants.csbYES
              AND or_operating_unit.assign_type not in (or_bcorderoperatingunit.csbASSIGN_SCHED,
                                                        or_bcorderoperatingunit.csbASSIGN_ROUTE
                                                        );
      RETURN CUUNITBYSECTANDITM;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSEMYCURSOR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSEMYCURSOR;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETUNITLOVBYSECTANDITM;
   PROCEDURE GETGEOREFXYBASEADM( INUOPERATINUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, ONUPOINTX OUT AB_ADDRESS.SHAPE.SDO_POINT.X%TYPE, ONUPOINTY OUT AB_ADDRESS.SHAPE.SDO_POINT.Y%TYPE )
    IS
      CURSOR CUXY IS
SELECT /*+ ordered */
                   nvl(round(a.shape.SDO_POINT.X, 10),0) PointX,
                   nvl(round(a.shape.SDO_POINT.Y, 10),0) PointY
              FROM or_operating_unit,
                   ge_base_administra,
                   ab_address a
             WHERE a.address_id = ge_base_administra.direccion
               AND ge_base_administra.id_base_administra =  or_operating_unit.admin_base_id
               AND or_operating_unit.operating_unit_id = inuOperatinUnitId;
    BEGIN
      IF CUXY%ISOPEN THEN
         CLOSE CUXY;
      END IF;
      OPEN CUXY;
      FETCH CUXY
         INTO ONUPOINTX, ONUPOINTY;
      CLOSE CUXY;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUXY%ISOPEN THEN
            CLOSE CUXY;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUXY%ISOPEN THEN
            CLOSE CUXY;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETGEOREFXYBASEADM;
   FUNCTION FRFGETLOCKORDERSBYDATE( INUPERSONID IN GE_PERSON.PERSON_ID%TYPE, INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, IDTINITDATE IN OR_PER_UNIT_BY_DATE.DATE_%TYPE, IDTFINALDATE IN OR_PER_UNIT_BY_DATE.DATE_%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      SBATTRIBUTES GE_BOINSTANCECONTROL.STYSBVALUE;
      SBSELECT GE_BOINSTANCECONTROL.STYSBVALUE;
      SBFROM GE_BOINSTANCECONTROL.STYSBVALUE;
      SBWHERE GE_BOINSTANCECONTROL.STYSBVALUE;
      SBSQL GE_BOINSTANCECONTROL.STYSBVALUE;
      NUCLASSDISPATCH OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID%TYPE;
      RFRESULT CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( 'INICIA - OR_BCOperatingUnit.frfGetLockOrdersByDate
                        inuPersonId := ' || INUPERSONID || '
                        inuOperatingUnitId := ' || IDTINITDATE || '
                        idtInitDate := ' || IDTINITDATE || '
                        idtFinalDate := ' || IDTFINALDATE, 15 );
      NUCLASSDISPATCH := OR_BCSCHED.GNUCLASDISPATCH;
      GE_BOUTILITIES.ADDATTRIBUTE( 'or_per_unit_by_date.per_unit_by_date_id', 'pk', SBATTRIBUTES );
      GE_BOUTILITIES.ADDATTRIBUTE( 'ge_person.person_id|| '' - '' || ge_person.name_', 'ORGDU_DESPACHANTE', SBATTRIBUTES );
      GE_BOUTILITIES.ADDATTRIBUTE( 'or_operating_unit.operating_unit_id||'' - ''||or_operating_unit.name', 'ORGDU_UNIDAD_TRABAJO', SBATTRIBUTES );
      GE_BOUTILITIES.ADDATTRIBUTE( 'or_per_unit_by_date.date_', 'ORGDU_FECHA', SBATTRIBUTES );
      GE_BOUTILITIES.ADDATTRIBUTE( 'or_per_unit_by_date.zones', 'ORGDU_ZONAS', SBATTRIBUTES );
      SBSELECT := ' SELECT ' || SBATTRIBUTES || CHR( 10 );
      SBFROM := ' FROM ge_person, or_per_unit_by_date, or_operating_unit ' || CHR( 10 );
      SBWHERE := ' WHERE ge_person.person_id = or_per_unit_by_date.person_id ' || CHR( 10 ) || ' AND or_per_unit_by_date.operating_unit_id = or_operating_unit.operating_unit_id ' || CHR( 10 );
      IF ( INUPERSONID IS NOT NULL ) THEN
         SBWHERE := SBWHERE || ' AND ge_person.person_id = :nuPersonId ' || CHR( 10 );
      END IF;
      IF ( INUOPERATINGUNITID IS NOT NULL ) THEN
         SBWHERE := SBWHERE || ' AND or_operating_unit.operating_unit_id = :nuOperatingUnitId ' || CHR( 10 );
      END IF;
      SBWHERE := SBWHERE || ' AND or_operating_unit.oper_unit_classif_id <> :nuClassDispatch ' || CHR( 10 ) || ' AND or_per_unit_by_date.date_ between :idtInitDate AND :idtInitDate ' || CHR( 10 ) || '          AND not exists' || CHR( 10 ) || '                        (' || CHR( 10 ) || '                            SELECT  1' || CHR( 10 ) || '                            FROM    gv$SESSION, sa_user' || CHR( 10 ) || '                            WHERE   gv$SESSION.username = sa_user.mask' || CHR( 10 ) || '                              AND   MODULE in (''ORPDO''' || ',' || '''ORDOP'')' || CHR( 10 ) || '                              AND   STATUS <> ''KILLED''' || CHR( 10 ) || '                              AND   user_id = ge_person.user_id' || CHR( 10 ) || '                        )' || CHR( 10 );
      SBSQL := SBSELECT || SBFROM || SBWHERE;
      UT_TRACE.TRACE( SBSQL, 15 );
      IF ( INUPERSONID IS NOT NULL AND INUOPERATINGUNITID IS NOT NULL ) THEN
         OPEN RFRESULT
              FOR SBSQL
              USING IN INUPERSONID, IN INUOPERATINGUNITID, IN NUCLASSDISPATCH, IN IDTINITDATE, IN IDTFINALDATE;
         RETURN RFRESULT;
      END IF;
      IF ( INUPERSONID IS NOT NULL ) THEN
         OPEN RFRESULT
              FOR SBSQL
              USING IN INUPERSONID, IN NUCLASSDISPATCH, IN IDTINITDATE, IN IDTFINALDATE;
         RETURN RFRESULT;
      END IF;
      IF ( INUOPERATINGUNITID IS NOT NULL ) THEN
         OPEN RFRESULT
              FOR SBSQL
              USING IN INUOPERATINGUNITID, IN NUCLASSDISPATCH, IN IDTINITDATE, IN IDTFINALDATE;
         RETURN RFRESULT;
      END IF;
      OPEN RFRESULT
           FOR SBSQL
           USING IN NUCLASSDISPATCH, IN IDTINITDATE, IN IDTFINALDATE;
      UT_TRACE.TRACE( 'FIN - OR_BOFW_UnlockOperUnits.frfGetLocks', 15 );
      RETURN RFRESULT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE GETOPERUNITBYCLASSIF( INUOPERUNITCLAS IN OR_OPER_UNIT_CLASSIF.OPER_UNIT_CLASSIF_ID%TYPE, ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( '[INICIO] OR_BCOperatingUnit.GetOperUnitByClassif: OperUnit:[' || INUOPERUNITCLAS || ']', 10 );
      OPEN ORFREFCURSOR FOR SELECT /*+ INDEX( OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_03 ) */
                 or_operating_unit.operating_unit_id, or_operating_unit.name
            FROM or_operating_unit
            /*+ OR_BCOperatingUnit.GetOperUnitByClassif */
           WHERE or_operating_unit.oper_unit_classif_id = inuOperUnitClas;
      UT_TRACE.TRACE( '[FIN] OR_BCOperatingUnit.GetOperUnitByClassif', 10 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( ORFREFCURSOR );
         UT_TRACE.TRACE( 'Error : ex.CONTROLLED_ERROR', 10 );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( ORFREFCURSOR );
         UT_TRACE.TRACE( 'Error : others', 12 );
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETOPERUNITBYCLASSIF;
   FUNCTION FSBISFIELDUNIT( INUUNITCLASSID IN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE )
    RETURN VARCHAR2
    IS
    BEGIN
      UT_TRACE.TRACE( '-- INICIA OR_BCOperatingUnit.fsbIsFieldUnit', 10 );
      UT_TRACE.TRACE( ' inuUnitClassId [' || INUUNITCLASSID || ']', 10 );
      IF ( FSBISNOTFIELDUNIT( INUUNITCLASSID ) = GE_BOCONSTANTS.CSBNO ) THEN
         UT_TRACE.TRACE( '-- Es una Unidad de Campo', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbIsFieldUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBYES;
       ELSE
         UT_TRACE.TRACE( '-- No es una Unidad de Campo', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbIsFieldUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBNO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '[CONTROLLED ERROR] OR_BCOperatingUnit.fsbIsFieldUnit', 10 );
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( '[OTHERS ERROR] OR_BCOperatingUnit.fsbIsFieldUnit', 10 );
         RAISE EX.CONTROLLED_ERROR;
   END FSBISFIELDUNIT;
   FUNCTION FSBISNOTFIELDUNIT( INUUNITCLASSID IN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE )
    RETURN VARCHAR2
    IS
    BEGIN
      UT_TRACE.TRACE( '-- INICIA OR_BCOperatingUnit.fsbIsNotFieldUnit', 10 );
      UT_TRACE.TRACE( ' inuUnitClassId [' || INUUNITCLASSID || ']', 10 );
      IF ( INUUNITCLASSID IN ( OR_BOCONSTANTS.CNUSUPLIEROPERUNITCLAS, OR_BOCONSTANTS.CNUMARKETOPERUNITCLAS, OR_BOCONSTANTS.CNUREPAIRCENTEROPERUNITCLAS, OR_BOCONSTANTS.CNUDISTRIUNITCLAS, OR_BOCONSTANTS.CNUDISPATCHOPERUNITCLAS, OR_BOCONSTANTS.CNUSUPEROPERUNITCLAS ) ) THEN
         UT_TRACE.TRACE( '-- No es una Unidad de Campo', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbIsNotFieldUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBYES;
       ELSE
         UT_TRACE.TRACE( '-- Es una Unidad de Campo', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbIsNotFieldUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBNO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '[CONTROLLED ERROR] OR_BCOperatingUnit.fsbIsNotFieldUnit', 10 );
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( '[OTHERS ERROR] OR_BCOperatingUnit.fsbIsNotFieldUnit', 10 );
         RAISE EX.CONTROLLED_ERROR;
   END FSBISNOTFIELDUNIT;
   FUNCTION FNUISPOSTOASSORDTOUNIT( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUOPERUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN VARCHAR2
    IS
      RCOPERATINGUNIT DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT;
      NUTOTALCAPACITY OR_OPERATING_UNIT.ASSIGN_TYPE%TYPE;
    BEGIN
      UT_TRACE.TRACE( '-- INICIA OR_BCOperatingUnit.OR_BCOperatingUnit', 10 );
      UT_TRACE.TRACE( ' inuOperUnitId [' || INUOPERUNITID || '] inuOrderId [' || INUORDERID || ']', 10 );
      DAOR_OPERATING_UNIT.GETRECORD( INUOPERUNITID, RCOPERATINGUNIT );
      IF ( ( RCOPERATINGUNIT.ASSIGN_CAPACITY * OR_BOCONSTANTS.CNUMINUTEPERHOUR ) >= ( OR_BCOPTIMUNROUTE.FNUCALCULARDURACION( INUORDERID ) + ( NVL( RCOPERATINGUNIT.USED_ASSIGN_CAP, 0 ) * OR_BOCONSTANTS.CNUMINUTEPERHOUR ) ) ) THEN
         UT_TRACE.TRACE( ' Tiene tiempo para realizar la Orden', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.OR_BCOperatingUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBYES;
       ELSE
         UT_TRACE.TRACE( ' No tiene tiempo para realizar la Orden', 10 );
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.OR_BCOperatingUnit', 10 );
         RETURN GE_BOCONSTANTS.CSBNO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '[CONTROLLED ERROR] OR_BCOperatingUnit.fnuIsPosToAssOrdToUnit', 10 );
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( '[OTHERS ERROR] OR_BCOperatingUnit.fnuIsPosToAssOrdToUnit', 10 );
         RAISE EX.CONTROLLED_ERROR;
   END FNUISPOSTOASSORDTOUNIT;
   FUNCTION FSBVALIFUNITASSIGN( INUOPERUNITSTATUS IN OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%TYPE )
    RETURN VARCHAR2
    IS
    BEGIN
      UT_TRACE.TRACE( '-- INICIA OR_BCOperatingUnit.fsbvalIfUnitassign', 10 );
      IF ( DAOR_OPER_UNIT_STATUS.FSBGETVALID_FOR_ASSIGN( INUOPERUNITSTATUS ) = GE_BOCONSTANTS.CSBYES ) THEN
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbvalIfUnitassign ? [' || GE_BOCONSTANTS.CSBYES || ']', 10 );
         RETURN GE_BOCONSTANTS.CSBYES;
       ELSE
         UT_TRACE.TRACE( '-- FINALIZA OR_BCOperatingUnit.fsbvalIfUnitassign ? [' || GE_BOCONSTANTS.CSBNO || ']', 10 );
         RETURN GE_BOCONSTANTS.CSBNO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '[CONTROLLED ERROR] OR_BCOperatingUnit.fsbvalIfUnitassign', 10 );
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         UT_TRACE.TRACE( '[OTHERS ERROR] OR_BCOperatingUnit.fsbvalIfUnitassign', 10 );
         RAISE EX.CONTROLLED_ERROR;
   END FSBVALIFUNITASSIGN;
   FUNCTION FRFGETOPEUNIBYPERSONANDCLASS( INUPERSONID IN OR_OPERATING_UNIT.PERSON_IN_CHARGE%TYPE, INUCLASSIFICATION IN OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%TYPE := NULL )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      RFOPERATINGUNIT CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( '--[INICIO] OR_BCOperatingUnit.frfGetOpeUniByPersonAndClass', 12 );
      IF INUCLASSIFICATION IS NULL THEN
         OPEN RFOPERATINGUNIT FOR SELECT  /*+ index(or_oper_unit_persons IDX_OR_OPER_UNIT_PERSONS_01) */
                        OR_operating_unit.operating_unit_id ID,
                        OR_operating_unit.name DESCRIPTION
                FROM    /*+ OR_BCLabOrders.frfGetLabs-1*/
                        OR_operating_unit,
                        or_oper_unit_persons
                WHERE   or_oper_unit_persons.person_id = inuPersonId
                        AND or_oper_unit_persons.operating_unit_id = OR_operating_unit.operating_unit_id;
       ELSE
         OPEN RFOPERATINGUNIT FOR SELECT  /*+ index(or_oper_unit_persons IDX_OR_OPER_UNIT_PERSONS_01) */
                        OR_operating_unit.operating_unit_id ID,
                        OR_operating_unit.name DESCRIPTION
                FROM    /*+ OR_BCLabOrders.frfGetLabs-2 */
                        OR_operating_unit,
                        or_oper_unit_persons
                WHERE   or_oper_unit_persons.person_id = inuPersonId
                        AND or_oper_unit_persons.operating_unit_id = OR_operating_unit.operating_unit_id
                        AND OR_operating_unit.oper_unit_classif_id = inuClassification;
      END IF;
      UT_TRACE.TRACE( '--[FIN] OR_BCOperatingUnit.frfGetOpeUniByPersonAndClass', 12 );
      RETURN RFOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '--[CONTROLLED_ERROR] OR_BCOperatingUnit.frfGetOpeUniByPersonAndClass', 12 );
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( '--[others] OR_BCOperatingUnit.frfGetOpeUniByPersonAndClass', 12 );
         ERRORS.SETERROR;
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETOPEUNIBYPERSONANDCLASS;
   FUNCTION FRFGETPARUNITSBYORDERUNIT( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      DTSYSDATE DATE;
      DTTRUNCSYSDATE DATE;
      NUCURRMINUTE NUMBER;
      RFOPERATINGUNIT CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( '--[INICIO] OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit', 12 );
      DTSYSDATE := UT_DATE.FDTSYSDATE;
      DTTRUNCSYSDATE := TRUNC( DTSYSDATE );
      NUCURRMINUTE := UT_DATE.FNUMINUTEOFDAY( DTSYSDATE );
      OPEN RFOPERATINGUNIT FOR WITH father AS (
                SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = inuOperatingUnitId
            ),
            sector AS (
                SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrderId
            )
            SELECT /*+ ordered
                       index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                       index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                       index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   ge_organizat_area.organizat_area_id OPERATING_UNIT_ID,
                   ge_organizat_area.name_ DESCRIPTION
              FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
                   /*+ OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit SAO180890 */
             WHERE ge_organizat_area.geo_area_father_id = father.id
               AND ge_organizat_area.organizat_area_id <> inuOperatingUnitId
               AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
               AND or_sched_available.date_ = dtTruncSysdate
               AND nuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
               AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
               AND ge_sectorope_zona.id_sector_operativo = sector.id
               AND OR_BCSched.fsbIsValidActOrder
                   ( or_sched_available.rol_exception_flag,
                     or_sched_available.sched_available_id,
                     inuOrderId,
                     or_sched_available.operating_unit_id
                   ) = ge_boconstants.csbYES;
      UT_TRACE.TRACE( '--[FIN] OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit', 12 );
      RETURN RFOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '--[CONTROLLED_ERROR] OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit', 12 );
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( '--[others] OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit', 12 );
         ERRORS.SETERROR;
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETPARUNITSBYORDERUNIT;
   FUNCTION FRFGETDWUNITSBYORDERUNIT( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      DTSYSDATE DATE;
      DTTRUNCSYSDATE DATE;
      NUCURRMINUTE NUMBER;
      RFOPERATINGUNIT CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( '--[INICIO] OR_BCOperatingUnit.frfGetDwUnitsbyOrderUnit', 12 );
      DTSYSDATE := UT_DATE.FDTSYSDATE;
      DTTRUNCSYSDATE := TRUNC( DTSYSDATE );
      NUCURRMINUTE := UT_DATE.FNUMINUTEOFDAY( DTSYSDATE );
      OPEN RFOPERATINGUNIT FOR WITH sector AS (
                SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrderId
            )
            SELECT /*+ ordered
                       index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                       index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                       index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   ge_organizat_area.organizat_area_id OPERATING_UNIT_ID,
                   ge_organizat_area.name_ DESCRIPTION
              FROM ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
                   /*+ OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit SAO180890 */
             WHERE ge_organizat_area.geo_area_father_id = inuOperatingUnitId
               AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
               AND or_sched_available.date_ = dtTruncSysdate
               AND nuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
               AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
               AND ge_sectorope_zona.id_sector_operativo = sector.id
               AND OR_BCSched.fsbIsValidActOrder
                   ( or_sched_available.rol_exception_flag,
                     or_sched_available.sched_available_id,
                     inuOrderId,
                     or_sched_available.operating_unit_id
                   ) = ge_boconstants.csbYES;
      UT_TRACE.TRACE( '--[FIN] OR_BCOperatingUnit.frfGetDwUnitsbyOrderUnit', 12 );
      RETURN RFOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '--[CONTROLLED_ERROR] OR_BCOperatingUnit.frfGetDwUnitsbyOrderUnit', 12 );
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( '--[others] OR_BCOperatingUnit.frfGetDwUnitsbyOrderUnit', 12 );
         ERRORS.SETERROR;
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETDWUNITSBYORDERUNIT;
   FUNCTION FRFGETUPUNITSBYORDERUNIT( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      DTSYSDATE DATE;
      DTTRUNCSYSDATE DATE;
      NUCURRMINUTE NUMBER;
      RFOPERATINGUNIT CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( '--[INICIO] OR_BCOperatingUnit.frfGetUpUnitsbyOrderUnit', 12 );
      DTSYSDATE := UT_DATE.FDTSYSDATE;
      DTTRUNCSYSDATE := TRUNC( DTSYSDATE );
      NUCURRMINUTE := UT_DATE.FNUMINUTEOFDAY( DTSYSDATE );
      OPEN RFOPERATINGUNIT FOR WITH father AS (
                SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = inuOperatingUnitId
            ),
            sector AS (
                SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrderId
            )
            SELECT /*+ ordered
                       index(ge_organizat_area PK_GE_ORGANIZAT_AREA)
                       index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                       index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   ge_organizat_area.organizat_area_id OPERATING_UNIT_ID,
                   ge_organizat_area.name_ DESCRIPTION
              FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
                   /*+ OR_BCOperatingUnit.frfGetParUnitsbyOrderUnit SAO180890 */
             WHERE ge_organizat_area.organizat_area_id = father.id
               AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
               AND or_sched_available.date_ = dtTruncSysdate
               AND nuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
               AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
               AND ge_sectorope_zona.id_sector_operativo = sector.id
               AND OR_BCSched.fsbIsValidActOrder
                   ( or_sched_available.rol_exception_flag,
                     or_sched_available.sched_available_id,
                     inuOrderId,
                     or_sched_available.operating_unit_id
                   ) = ge_boconstants.csbYES;
      UT_TRACE.TRACE( '--[FIN] OR_BCOperatingUnit.frfGetUpUnitsbyOrderUnit', 12 );
      RETURN RFOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( '--[CONTROLLED_ERROR] OR_BCOperatingUnit.frfGetUpUnitsbyOrderUnit', 12 );
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         UT_TRACE.TRACE( '--[others] OR_BCOperatingUnit.frfGetUpUnitsbyOrderUnit', 12 );
         ERRORS.SETERROR;
         GE_BOGENERALUTIL.CLOSE_REFCURSOR( RFOPERATINGUNIT );
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETUPUNITSBYORDERUNIT;
   FUNCTION FRFGETOPERUNITSLOV( INUOPERUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, ISBOPERUNITNAME IN OR_OPERATING_UNIT.NAME%TYPE )
    RETURN CONSTANTS.TYREFCURSOR
    IS
      RFOPERUNITS CONSTANTS.TYREFCURSOR;
    BEGIN
      UT_TRACE.TRACE( 'INICIO Or_BCOperatingUnit.frfGetOperUnitsLOV -  inuOperUnitId[' || INUOPERUNITID || '] - isbOperUnitName[' || ISBOPERUNITNAME || '] ', 15 );
      IF ( INUOPERUNITID IS NOT NULL AND ISBOPERUNITNAME IS NOT NULL ) THEN
         OPEN RFOPERUNITS FOR SELECT  /*+ index (OR_operating_unit pk_OR_operating_unit) */
                        operating_unit_id id,
                        upper(name) description
                FROM    OR_operating_unit /*+ Or_BOOperatingUnit.frfGetOperUnitsLOV SAO197223 */
                WHERE   operating_unit_id = inuOperUnitId
                AND     name like isbOperUnitName||'%'
                AND     assign_type in (or_boconstants.cnuAssignBySchedule,or_bcorderoperatingunit.csbASSIGN_ROUTE)
                AND     oper_unit_classif_id not in (or_bcsched.gnuClasDispatch, or_bcsched.gnuSUPV_DISPATC);
       ELSIF ( INUOPERUNITID IS NOT NULL ) THEN
         OPEN RFOPERUNITS FOR SELECT  /*+ index (OR_operating_unit pk_OR_operating_unit) */
                        operating_unit_id id,
                        upper(name) description
                FROM    OR_operating_unit /*+ Or_BOOperatingUnit.frfGetOperUnitsLOV SAO197223 */
                WHERE   operating_unit_id = inuOperUnitId
                AND     assign_type in (or_boconstants.cnuAssignBySchedule,or_bcorderoperatingunit.csbASSIGN_ROUTE)
                AND     oper_unit_classif_id not in (or_bcsched.gnuClasDispatch, or_bcsched.gnuSUPV_DISPATC);
       ELSIF ( ISBOPERUNITNAME IS NOT NULL ) THEN
         OPEN RFOPERUNITS FOR SELECT  /*+ index (OR_operating_unit IDX_OR_OPERATING_UNIT13) */
                        operating_unit_id id,
                        upper(name) description
                FROM    OR_operating_unit /*+ Or_BOOperatingUnit.frfGetOperUnitsLOV SAO197223 */
                WHERE   name like isbOperUnitName||'%'
                AND     assign_type in (or_boconstants.cnuAssignBySchedule,or_bcorderoperatingunit.csbASSIGN_ROUTE)
                AND     oper_unit_classif_id not in (or_bcsched.gnuClasDispatch, or_bcsched.gnuSUPV_DISPATC);
      END IF;
      RETURN RFOPERUNITS;
      UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.frfGetOperUnitsLOV ', 15 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FRFGETOPERUNITSLOV;
   FUNCTION FBLEXISTREASSIGOPERUN( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE )
    RETURN BOOLEAN
    IS
      DTSYSDATE DATE;
      DTTRUNCSYSDATE DATE;
      NUCURRMINUTE NUMBER;
      SBEXISTEDATO VARCHAR2( 1 );
      CURSOR CUUPUNITSBYORDERUNIT( INUORDID IN OR_ORDER.ORDER_ID%TYPE, INUOPERUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, IDTTRUNCSYSDATE IN DATE, INUCURRMINUTE IN NUMBER ) IS
WITH father AS ( SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = inuOperUnitId ),
                 sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrdId )
            SELECT /*+ ordered
                   index(ge_organizat_area PK_GE_ORGANIZAT_AREA)
                   index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                   index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   'X' existe
            FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuUpUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.organizat_area_id = father.id
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
            AND or_sched_available.date_ = idtTruncSysdate
            AND inuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
            AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 inuOrdId,
                 or_sched_available.operating_unit_id
               ) = ge_boconstants.csbYES
            AND rownum < 2;
      CURSOR CUPARUNITSBYORDERUNIT( INUORDID IN OR_ORDER.ORDER_ID%TYPE, INUOPERUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, IDTTRUNCSYSDATE IN DATE, INUCURRMINUTE IN NUMBER ) IS
WITH    father AS ( SELECT geo_area_father_id id FROM ge_organizat_area WHERE organizat_area_id = inuOperUnitId ),
                    sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrdId )
            SELECT  /*+ ordered
                    index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                    index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                    index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                    'X' existe
            FROM father, ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuParUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.geo_area_father_id = father.id
            AND ge_organizat_area.organizat_area_id <> inuOperUnitId
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
            AND or_sched_available.date_ = idtTruncSysdate
            AND inuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
            AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 inuOrdId,
                 or_sched_available.operating_unit_id
               ) = ge_boconstants.csbYES
            AND rownum < 2;
      CURSOR CUDWUNITSBYORDERUNIT( INUORDID IN OR_ORDER.ORDER_ID%TYPE, INUOPERUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, IDTTRUNCSYSDATE IN DATE, INUCURRMINUTE IN NUMBER ) IS
WITH sector AS ( SELECT operating_sector_id id FROM or_order WHERE order_id = inuOrdId )
            SELECT /*+ ordered
                   index(ge_organizat_area IX_GE_ORGANIZAT_AREA03)
                   index(or_sched_available IDX_OR_SCHED_AVAILABLE04)
                   index(ge_sectorope_zona IDX_GE_SECTOROPE_ZONA_02) */
                   'X' existe
            FROM ge_organizat_area, or_sched_available, sector, ge_sectorope_zona
               /*+ OR_BCOperatingUnit.fblExistReAssigOperUn <cuDwUnitsbyOrderUnit> SAO207207 */
            WHERE ge_organizat_area.geo_area_father_id = inuOperUnitId
            AND or_sched_available.operating_unit_id = ge_organizat_area.organizat_area_id
            AND or_sched_available.date_ = idtTruncSysdate
            AND inuCurrMinute between or_sched_available.hour_entrance AND or_sched_available.hour_exit
            AND or_sched_available.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND ge_sectorope_zona.id_sector_operativo = sector.id
            AND OR_BCSched.fsbIsValidActOrder
               ( or_sched_available.rol_exception_flag,
                 or_sched_available.sched_available_id,
                 inuOrdId,
                 or_sched_available.operating_unit_id
               ) = ge_boconstants.csbYES
            AND rownum < 2;
      PROCEDURE CLOSEALLCURSOR
       IS
       BEGIN
         IF CUUPUNITSBYORDERUNIT%ISOPEN THEN
            CLOSE CUUPUNITSBYORDERUNIT;
         END IF;
         IF CUPARUNITSBYORDERUNIT%ISOPEN THEN
            CLOSE CUPARUNITSBYORDERUNIT;
         END IF;
         IF CUDWUNITSBYORDERUNIT%ISOPEN THEN
            CLOSE CUDWUNITSBYORDERUNIT;
         END IF;
      END CLOSEALLCURSOR;
    BEGIN
      UT_TRACE.TRACE( 'INICIO Or_BCOperatingUnit.fblExistReAssigOperUn ', 15 );
      DTSYSDATE := UT_DATE.FDTSYSDATE;
      DTTRUNCSYSDATE := TRUNC( DTSYSDATE );
      NUCURRMINUTE := UT_DATE.FNUMINUTEOFDAY( DTSYSDATE );
      CLOSEALLCURSOR;
      OPEN CUUPUNITSBYORDERUNIT( INUORDERID, INUOPERATINGUNITID, DTTRUNCSYSDATE, NUCURRMINUTE );
      FETCH CUUPUNITSBYORDERUNIT
         INTO SBEXISTEDATO;
      CLOSE CUUPUNITSBYORDERUNIT;
      IF SBEXISTEDATO IS NOT NULL THEN
         UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.fblExistReAssigOperUn  <cuUpUnitsbyOrderUnit>', 15 );
         RETURN TRUE;
      END IF;
      OPEN CUPARUNITSBYORDERUNIT( INUORDERID, INUOPERATINGUNITID, DTTRUNCSYSDATE, NUCURRMINUTE );
      FETCH CUPARUNITSBYORDERUNIT
         INTO SBEXISTEDATO;
      CLOSE CUPARUNITSBYORDERUNIT;
      IF SBEXISTEDATO IS NOT NULL THEN
         UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.fblExistReAssigOperUn  <cuParUnitsbyOrderUnit>', 15 );
         RETURN TRUE;
      END IF;
      OPEN CUDWUNITSBYORDERUNIT( INUORDERID, INUOPERATINGUNITID, DTTRUNCSYSDATE, NUCURRMINUTE );
      FETCH CUDWUNITSBYORDERUNIT
         INTO SBEXISTEDATO;
      CLOSE CUDWUNITSBYORDERUNIT;
      IF SBEXISTEDATO IS NOT NULL THEN
         UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.fblExistReAssigOperUn  <cuDwUnitsbyOrderUnit>', 15 );
         RETURN TRUE;
      END IF;
      UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.fblExistReAssigOperUn ', 15 );
      RETURN FALSE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSEALLCURSOR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSEALLCURSOR;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLEXISTREASSIGOPERUN;
   FUNCTION GETUTBYORGAAREASELLER( INUORGAAREASELLERID IN CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE )
    RETURN DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID
    IS
      SBCURRENAREA VARCHAR2( 1 ) := CC_BOCONSTANTS.CSBISCURRENTORGA_AREA_SELLER;
      TBOPERATINGUNIT DAOR_OPERATING_UNIT.TYTBOPERATING_UNIT_ID;
      CURSOR CU_UT( INUOASID IN CC_ORGA_AREA_SELLER.ORGANIZAT_AREA_ID%TYPE ) IS
SELECT
          op.operating_unit_id
        FROM
          or_operating_unit op ,
          cc_orga_area_seller oas
        WHERE
            oas.organizat_area_id = op.orga_area_id
        AND oas.organizat_area_id = inuOASID
        AND oas.is_current        = sbCurrenArea
        AND ROWNUM  = 1;
    BEGIN
      UT_TRACE.TRACE( 'INICIA Or_BCOperatingUnit.GetUyByOrgaAreaSeller ', 5 );
      UT_TRACE.TRACE( 'inuOrgaAreaSellerId [' || INUORGAAREASELLERID || ']', 5 );
      OPEN CU_UT( INUORGAAREASELLERID );
      FETCH CU_UT
         BULK COLLECT INTO TBOPERATINGUNIT;
      CLOSE CU_UT;
      UT_TRACE.TRACE( 'FIN Or_BCOperatingUnit.GetUyByOrgaAreaSeller ', 5 );
      RETURN TBOPERATINGUNIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETUTBYORGAAREASELLER;
END OR_BCOPERATINGUNIT;
/


