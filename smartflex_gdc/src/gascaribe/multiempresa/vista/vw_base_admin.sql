-- OSF-4268
CREATE OR REPLACE FORCE VIEW VW_BASE_ADMIN
(
    BASE_ADMINISTRATIVA,
    EMPRESA
)
AS
SELECT BASE_ADMINISTRATIVA, EMPRESA
FROM multiempresa.base_admin
/
Prompt Otorgando permisos sobre VW_BASE_ADMIN a SYSTEM_OBJ_PRIVS_ROLE
GRANT SELECT ON OPEN.VW_BASE_ADMIN TO SYSTEM_OBJ_PRIVS_ROLE
/