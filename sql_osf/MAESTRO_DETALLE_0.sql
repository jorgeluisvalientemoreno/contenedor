select distinct ex.executable_id,
                ex.name,
                e.name_,
                da.default_where,
                (SELECT COUNT(1)
                   FROM OPEN.GE_ENTITY_ATTRIBUTES EA
                  WHERE EA.ENTITY_ID = E.ENTITY_ID)
  from open.gi_attrib_disp_data  d,
       open.ge_entity_attributes at,
       open.ge_entity            e,
       open.sa_executable        ex,
       open.gi_entity_disp_data  da
 where d.executable_id = ex.executable_id
   and (name = upper(&nombre_ejecutable) or e.name_ = upper(&nombre_tabla))
   and d.entity_attribute_id = at.entity_attribute_id
   and d.entity_id = e.entity_id
   and da.executable_id = ex.executable_id;

SELECT DISTINCT EX.EXECUTABLE_ID, EX.NAME, E.NAME_, DA.DEFAULT_WHERE
  FROM OPEN.GI_ATTRIB_DISP_DATA  D,
       OPEN.GE_ENTITY_ATTRIBUTES AT,
       OPEN.GE_ENTITY            E,
       OPEN.SA_EXECUTABLE        EX,
       OPEN.GI_ENTITY_DISP_DATA  DA
 WHERE D.EXECUTABLE_ID = EX.EXECUTABLE_ID
   AND NAME = upper('LDCLEGO')
   AND D.ENTITY_ATTRIBUTE_ID = AT.ENTITY_ATTRIBUTE_ID
   AND D.ENTITY_ID = E.ENTITY_ID
      
   AND DA.EXECUTABLE_ID = EX.EXECUTABLE_ID
--  AND E.NAME_=upper('LDC_COTTCLAC')
;

SELECT DISTINCT EX.EXECUTABLE_ID,
                EX.NAME,
                E.NAME_,
                DA.DEFAULT_WHERE,
                AT.DISPLAY_NAME,
                D.LIST_OF_VALUES,
                VALPER.*
  FROM OPEN.GI_ATTRIB_DISP_DATA D, OPEN.GE_ENTITY_ATTRIBUTES AT
  LEFT JOIN OPEN.GE_ATTR_ALLOWED_VALUES VALPER
    ON VALPER.ENTITY_ATTRIBUTE_ID = AT.ENTITY_ATTRIBUTE_ID, OPEN.GE_ENTITY E,
 OPEN.SA_EXECUTABLE EX, OPEN.GI_ENTITY_DISP_DATA DA
 WHERE D.EXECUTABLE_ID = EX.EXECUTABLE_ID
   AND NAME = upper('LDCLEGO')
   AND D.ENTITY_ATTRIBUTE_ID = AT.ENTITY_ATTRIBUTE_ID
   AND D.ENTITY_ID = E.ENTITY_ID
      
   AND DA.EXECUTABLE_ID = EX.EXECUTABLE_ID
--  AND E.NAME_=upper('LDC_COTTCLAC')
;
