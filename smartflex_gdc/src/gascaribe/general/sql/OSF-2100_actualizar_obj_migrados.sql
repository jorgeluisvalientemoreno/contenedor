update  master_personalizaciones set COMENTARIO = 'MIGRADO ADM_PERSON'
where  NOMBRE in (
'LDCFNCRETORNAFLAGDOCCOMPL',
'LDCFNCRETORNAMESLIQ',
'LDC_FNCRETORNAPRODMOTIVE',
'LDC_FNCVALCUMPLDIFSEGMCOM',
'LDC_FNPRODDISPOSUSPEDFNC',
'LDC_FNU_APLICAENTREGA',
'LDC_FNUCENTRMEDCOTI',
'LDC_FNUCOMODATO',
'LDC_FNUCONTROLVISUALANULSOLI',
'LDC_FNUGETEDADCC',
'LDC_FNUGETLASTSUSPTYPEBYPROD',
'LDCFNU_GETMEREBYLOCA',
'LDC_FNUGETNEWIDENTLODPD',
'LDC_FNUGETNUMBEREXPACCOUNTS',
'LDC_FNUGETPEFABYPECO');
commit;
/