select p.codigo,
       p.descripcion,
       p.valor_numerico,
       p.valor_cadena,
       p.valor_fecha,
       p.proceso,
       p.estado,
       p.obligatorio,
       p.fecha_creacion,
       p.fecha_actualizacion,
       p.usuario,
       p.terminal
from parametros  p
where p.codigo = 'VALIDA_INTERFAZ_GDGU'


--otros parámetros que usa el programa

--select pkg_parametros.fsbGetValorCadena('CLASE_ITEMS_DE_MATERIAL') from dual
/*select pkg_bcld_parameter.fnuobtienevalornumerico('COD_VALOR_IVA') from dual;--se le suma al valor sap
select pkg_bcld_parameter.fnuobtienevalornumerico('PORC_ADMIN_ITEM_MATERIAL') from dual;--se le suma a las actividades homologadas
select dage_parameter.fsbgetvalue('AIU_ADMIN_UTIL') from dual;--se le suma a los precios usuarios
select dage_parameter.fsbgetvalue('AIU_ADMIN_UNEXPECTED') from dual;
select dage_parameter.fsbgetvalue('AIU_ADMIN_ADMIN') from dual;
select pkg_bcld_parameter.fsbobtienevalorcadena('CORREO_INTERFAZ_LISTACOSTO') from dual */


-- jgutierrezfernandez@gascaribe.com,kmejia@gascaribe.com
/*
UPDATE parametros
SET valor_cadena = 'N'
WHERE codigo = 'VALIDA_INTERFAZ_GDGU';
*/
