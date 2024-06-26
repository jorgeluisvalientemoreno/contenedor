SELECT a.pldicodi ID, a.pldidesc DESCRIPTION
FROM open.plandife a, open.LDC_TIPSOLPLANFINAN b
WHERE (GE_BOInstanceUtilities.fsbGetWorkInstanceAttribute(null,'MO_PROCESS' , 'INITIAL_DATE') between a.PLDIFEIN AND a.PLDIFEFI)
AND a.pldipmaf = 100
and a.pldicodi = b.pldicodi
and b.package_type_id = 271
ORDER BY a.pldicodi