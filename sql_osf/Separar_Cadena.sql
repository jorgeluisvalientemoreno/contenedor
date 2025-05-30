WITH datos AS
 (SELECT (regexp_substr(&sbCADENA, '[^;]+', 1, LEVEL)) AS cadena
    FROM dual
  CONNECT BY regexp_substr(&sbCADENA, '[^;]+', 1, LEVEL) IS NOT NULL)
SELECT substr(cadena, 1, instr(cadena, '|') - 1) tipo_trabajo,
       substr(cadena, instr(cadena, '|') + 1, LENGTH(cadena)) concepto
  FROM datos;
