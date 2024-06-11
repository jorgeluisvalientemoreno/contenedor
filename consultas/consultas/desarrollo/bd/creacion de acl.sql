-- Create ACL
BEGIN
 DBMS_NETWORK_ACL_ADMIN.CREATE_ACL (
  acl          => 'network_access_test.xml', 
  description  => 'Network access test', 
  principal    => 'OPEN', -- Must be in upper case
  is_grant     => TRUE,
  privilege    => 'connect',
  start_date   => NULL,
  end_date     => NULL);
END;
/

 -- Creates the second role privilege
BEGIN
 DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (
  acl          => 'network_access_test.xml',
  principal    => 'TEST_USER_2',
  is_grant     => TRUE, 
  privilege    => 'connect',
  position     => NULL,
  start_date   => NULL,
  end_date     => NULL);
END;
/



 -- Creates the first target host
BEGIN
 DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL (
  acl          => 'network_access_test.xml',
  host         => 'http://preview-osfintegrator-246.cl.innovacion-gascaribe.com/orders/create/v2',
  lower_port   => NULL,
  upper_port   => NULL); 
END;
/


select *
from RESOURCE_VIEW
where any_path like '/sys/acls/%';
 
-- List ACL privileges
select *
from DBA_NETWORK_ACL_PRIVILEGES;
 
-- List URLs
select *
from DBA_NETWORK_ACLS;
