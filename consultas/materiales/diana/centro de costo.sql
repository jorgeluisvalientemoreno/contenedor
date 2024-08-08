select DOCU.OPERATING_UNIT_ID   as UNIDAD_OPERATIVA,
                    CECO.CECOCODI            as CENTRO_COSTO
                    --CLVA.CLASS_ASSESSMENT_ID as CLASE_VALORACION  --#OYM_CEV_3429_1
              from open.GE_ITEMS_DOCUMENTO DOCU,
									 open.LDCI_CECOUNIOPER CECO--,
									 --open.LDCI_CLVAUNOP    CLVA  --#OYM_CEV_3429_1
						where Docu.ID_ITEMS_DOCUMENTO = 249871
								and CECO.OPERATING_UNIT_ID = DOCU.OPERATING_UNIT_ID
                
select *
from open.LDCI_CLVAUNOP                
where operating_unit_id=3194;
