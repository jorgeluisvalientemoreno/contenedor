CREATE OR REPLACE PROCEDURE trunc_ld_quota_by_subsc_temp
 IS
BEGIN
  execute immediate 'TRUNCATE TABLE LD_QUOTA_BY_SUBSC_TEMP';
END trunc_ld_quota_by_subsc_temp;
/
GRANT EXECUTE ON trunc_ld_quota_by_subsc_temp TO exebrillaapp;
GRANT EXECUTE ON trunc_ld_quota_by_subsc_temp TO Rexeinnova;
