--Cod_Subcategoria>3>>>
WITH estructuracadena AS
 (SELECT instr(&isbcadena, '>') indice, LENGTH(&isbcadena) tamanio FROM dual),
atributos AS
 (SELECT substr(&isbcadena, 1, indice - 1) nombre_atributo,
         substr(&isbcadena, indice + 1, tamanio) valor_atributo
    FROM estructuracadena)
SELECT nombre_atributo,
       substr(valor_atributo, 1, instr(valor_atributo, '>') - 1) SubCategoria
  FROM atributos
 WHERE nombre_atributo IS NOT NULL;
