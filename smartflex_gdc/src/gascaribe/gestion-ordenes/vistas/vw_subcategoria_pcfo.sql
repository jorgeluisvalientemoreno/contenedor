Create or replace view vw_subcategoria_pcfo as
select sucacate, sucacodi, sucadesc
  from subcateg
 where sucacate != -1
union all
select catecodi, sucacodi, 'TODOS' sucadesc
  from categori
  left join subcateg a
    on sucacodi = -1;
/
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('vw_subcategoria_pcfo'), 'OPEN');
END;
/

