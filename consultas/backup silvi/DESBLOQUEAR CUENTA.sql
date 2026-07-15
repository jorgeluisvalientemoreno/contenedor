ALTER USER GASCARIBEAPP  ACCOUNT UNLOCK;

INSERT GRANT ON :TABLE TO ROLE_XX;

-- Grant/Revoke role privileges 
grant system_obj_privs_role to DIASAL with admin option;
-- Set the user's default roles 
alter user DIASAL
  default role connect_role, system_obj_privs_role;

