/*:PACKAGE_STATUS: = '13 - REGISTRADO' AND 
LDC_BOORDENES.FNUCONTROLVISUALANULSOLI(:PACKAGE_TYPE:) IN (1,2,3) AND 
LDC_BCSALESCOMMISSION.fnuGetPackagesVR(:PACKAGE_ID:)=:PACKAGE_ID:*/
select mp.*,rowid from open.mo_packages mp where mp.package_id=62616923;  
select LDC_BOORDENES.FNUCONTROLVISUALANULSOLI(62616923),
LDC_BCSALESCOMMISSION.fnuGetPackagesVR(62616923) from dual
