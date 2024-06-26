SELECT pldicodi ID, pldidesc DESCRIPTION
FROM plandife
WHERE (/*GE_BOInstanceUtilities.fsbGetWorkInstanceAttribute(null,'MO_PROCESS' , 'INITIAL_DATE')*/sysdate between PLDIFEIN AND PLDIFEFI)
AND pldipmaf = 100
ORDER BY pldicodi
