select b.coblcoba cod_base , cc.concdesc desc_base , cc.conccore, cc.conccoin , b.coblconc cod_impuesto , c.concdesc desc_impuesto  , c.concticl tipo_concept_liquid , upper(tt.ticldesc) desc_tipo_concepto_imp 
from open.concbali b
inner join open.concepto cc on cc.conccodi= b.coblcoba 
inner join open.concepto c on c.conccodi= b.coblconc and ((c.concticl=4 and upper(&sbimpuesto)='S')or (c.concticl!=4 and upper(&sbimpuesto)!='S'))
left join  open.tipocoli tt on tt.ticlcons= c.concticl 