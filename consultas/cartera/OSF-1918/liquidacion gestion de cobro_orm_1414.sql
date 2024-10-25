--liquidacion gestion de cobro_orm_1414
SELECT (Select uo.name
                  From open.or_operating_unit uo
                 Where uo.operating_unit_id = UNIDAD_OPERATIVA) unidad_trabajo_desc,
               Decode(grupo,1, 'GAS',  'BRILLA') Tipo_Producto,
                 OPEN.LDC_METAS_CONT_GESTCOBR.*
FROM OPEN.LDC_METAS_CONT_GESTCOBR
where ano= 2024 
and Mes in (5)
