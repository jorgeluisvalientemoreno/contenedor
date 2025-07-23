SELECT ID_CONTRATISTA     "CÓDIGO",
       NOMBRE_CONTRATISTA "NOMBRE",
       DESCRIPCION        "DESCRIPCIÓN"
  FROM GE_CONTRATISTA
 WHERE ID_CONTRATISTA IN
       (SELECT CONTRACTOR_ID
          FROM OR_OPERATING_UNIT, OR_OPER_UNIT_PERSONS, GE_PERSON, SA_USER
         WHERE OR_OPER_UNIT_PERSONS.OPERATING_UNIT_ID =
               OR_OPERATING_UNIT.OPERATING_UNIT_ID
           AND GE_PERSON.PERSON_ID = OR_OPER_UNIT_PERSONS.PERSON_ID
           AND GE_PERSON.USER_ID = SA_USER.USER_ID
           AND GE_PERSON.USER_ID =
               (select a1.user_id
                  from OPEN.SA_USER a1
                 where a1.mask = 'JSAADESM')
              --SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER)
           AND CONTRACTOR_ID IS NOT NULL);

SELECT OPERATING_UNIT_ID "UNIDAD DE TRABAJO", NAME "NOMBRE"
  FROM OR_OPERATING_UNIT
 WHERE CONTRACTOR_ID = 19 --[ TRSMCONT ]
   AND OPER_UNIT_CLASSIF_ID NOT IN
       (SELECT TO_NUMBER(COLUMN_VALUE)
          FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_CLASE_OPER_LOGIST',
                                                                                   NULL),
                                                  ',')));

select a1.mask || ' - ' || a.name_, a.person_id, a1.user_id
  from OPEN.GE_PERSON a
 inner join OPEN.SA_USER a1
    on a1.user_id = a.user_id
   and a1.mask = 'RICMAR';

SELECT ID_CONTRATISTA || ' - ' || NOMBRE_CONTRATISTA "CONTRATISTA",
       ID_CONTRATISTA "C¿DIGO",
       NOMBRE_CONTRATISTA "NOMBRE",
       DESCRIPCION "DESCRIPCI¿N"
  FROM open.GE_CONTRATISTA
 WHERE ID_CONTRATISTA IN
       (SELECT CONTRACTOR_ID
          FROM open.OR_OPERATING_UNIT,
               open.OR_OPER_UNIT_PERSONS,
               open.GE_PERSON,
               open.SA_USER
         WHERE OR_OPER_UNIT_PERSONS.OPERATING_UNIT_ID =
               OR_OPERATING_UNIT.OPERATING_UNIT_ID
           AND GE_PERSON.PERSON_ID = OR_OPER_UNIT_PERSONS.PERSON_ID
           AND GE_PERSON.USER_ID = SA_USER.USER_ID
           AND GE_PERSON.USER_ID = 6336 --SA_BOUSER.FNUGETUSERID(UT_SESSION.GETUSER)
           AND CONTRACTOR_ID IS NOT NULL);

select distinct a.operating_unit_id || ' - ' || a.name Unidad_Operativa,
                c.id_contrato || ' - ' || c.descripcion Contrato,
                b.id_contratista || ' - ' || b.nombre_contratista Contratista
  from open.or_operating_unit a, open.ge_contratista b, open.ge_contrato c
 where a.contractor_id = b.id_contratista
   and b.id_contratista = c.id_contratista
   and c.fecha_inicial > '01/01/2022'
      --and a.operating_unit_id = 1599
   and a.contractor_id = 2029
   and c.status = 'AB';
