--eliminar tildes
utl_raw.cast_to_varchar2(nlssort('Aéíóu', 'nls_sort=binary_ai'))

SELECT TRANSLATE('ácento con ó ídd',
   'áéíóúàèìòùãõâêîôôäëïöüçÁÉÍÓÚÀÈÌÒÙÃÕÂÊÎÔÛÄËÏÖÜÇ',
   'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')
FROM dual;