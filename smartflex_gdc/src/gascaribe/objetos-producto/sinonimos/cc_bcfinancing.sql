BEGIN
  execute immediate 'CREATE OR REPLACE SYNONYM adm_person.CC_BCFINANCING FOR OPEN.CC_BCFINANCING';
END;
/