--
-- Archivo       : ins_GE_PARAMETER_PE_TRAZA_VALORPAGADO.sql
-- Autor         : Jorge Reina
-- Fecha         : 04-12-2024
--
-- Descripcion   : Inserting  Data ins_GE_PARAMETER_PE_TRAZA_VALORPAGADO.sql
-- Observaciones :
--
-- Historia de Modificaciones
-- Fecha          IDEntrega
--
-- 04-12-2024    jreina.SAO604282
-- Creación
--

INSERT INTO GE_PARAMETER
(
    PARAMETER_ID,
    DESCRIPTION,
    VALUE,
    VAL_FUNCTION,
    MODULE_ID,
    DATA_TYPE,
    ALLOW_UPDATE
)
VALUES
(
    'PE_TRAZA_VALORPAGADO',
    'Modo de traza cuando disminuye valor total pagado contrato (S-Genera Error;N-Guardar info openfltr)',
    'S',
    'pkGeneralServices.ValidateYesOrNot',
    92,
    'VARCHAR2',
    'Y'
)
/

COMMIT
/
