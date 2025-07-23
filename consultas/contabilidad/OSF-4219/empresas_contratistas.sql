select contratista.contratista, contratista.empresa
from ge_acta, ge_contrato, contratista
where id_acta = 242949
and ge_contrato.id_contrato = ge_acta.id_contrato
and ge_contrato.id_contratista = contratista.contratista;