PROMPT OSF-1393: Borrando procedimiento JOB_SUSPENSION_XNO_CERT_GDC
DECLARE

   sbObject_Name VARCHAR2(30) := 'JOB_SUSPENSION_XNO_CERT_GDC';

   CURSOR cuUser_Object
   IS
   SELECT object_name
   FROM User_Objects
   WHERE object_name = sbObject_Name
   AND object_type = 'PROCEDURE';

   rcUser_Object cuUser_Object%ROWTYPE;

BEGIN

   OPEN cuUser_Object;
   FETCH cuUser_Object INTO rcUser_Object;
   CLOSE cuUser_Object;

   IF rcUser_Object.Object_Name IS NOT NULL THEN
      EXECUTE IMMEDIATE 'DROP PROCEDURE ' || USER || '.' || sbObject_Name;
      DBMS_OUTPUT.PUT_LINE('Se borró el procedimiento ' || USER || '.' || sbObject_Name);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No existe el procedimiento ' || USER || '.' || sbObject_Name);
   END IF;

END;
/