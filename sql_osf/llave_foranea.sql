--Forma 1
SELECT uc.constraint_name   AS nombre_restriccion,
       uc.table_name        AS tabla_hija,
       ucc.column_name      AS columna_hija,
       uc.r_constraint_name AS nombre_restriccion_padre,
       uc2.table_name       AS tabla_padre
  FROM user_constraints uc
  JOIN user_cons_columns ucc
    ON ucc.constraint_name = uc.constraint_name
  LEFT JOIN user_constraints uc2
    ON uc2.constraint_name = uc.r_constraint_name
 WHERE 1 = 1
      --and uc.CONSTRAINT_NAME = 'FK_GE_ORGANIZ_AB_ADDRESS04'
      --and uc.constraint_type = 'R'
      --AND ucc.position = 1; --
   and uc2.table_name = UPPER('AB_ADDRESS');
   
--Forma 2
SELECT b.table_name        AS entidad_hija,
       b.column_name       AS campo_hijo,
       b.CONSTRAINT_NAME   Nomnbe_Llave_Foranea,
       uc.TABLE_NAME       AS padre_referenciada,
       a.r_constraint_name AS llave_padre_referenciada
  FROM user_constraints a
  JOIN user_cons_columns b
    ON a.constraint_name = b.constraint_name
  JOIN user_constraints uc
    on a.r_constraint_name = uc.constraint_name
   and uc.table_name = UPPER('AB_ADDRESS');

