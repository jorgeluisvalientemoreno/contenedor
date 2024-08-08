SELECT /*nvl (sum( nvl (cucovare, 0)), 0) AS ClaimValue */
 *
  FROM open.cuencobr, open.servsusc
 WHERE cuconuse = sesunuse
   AND sesususc = 17159698
   and (nvl(cucovare, 0)) > 0;
SELECT /*nvl (sum( nvl (cucovare, 0)), 0) AS ClaimValue */
 *
  FROM open.cuencobr, open.servsusc
 WHERE cuconuse = sesunuse
   AND sesususc = 17159698
   and (nvl(cucosacu, 0)) > 0;
select * from open.cargtram c where c.catrcuco = 2977334889;
select mp.*
  from open.mo_packages mp, open.mo_motive mm
 where mp.package_id = mm.package_id
   and mm.motive_id = 58155155;
select a.*, rowid from open.cuencobr a where a.cucocodi = 1113210865;
SELECT * FROM OPEN.FACTURA F WHERE F.FACTSUSC = 583046;
SELECT *
  FROM OPEN.FACTURA F
 WHERE F.FACTCODI IN
       (select a.Cucofact from open.cuencobr a where a.cucocodi = 1113210865);
select a.*, rowid
  from open.cargos a
 where a.cargcuco = 1113210865
   AND A.CARGCONC IN (31, 37, 820, 822);
select a.*, rowid from open.cargtram a where a.catrcuco = 1113210865; --.catrvare
select DISTINCT a.*, rowid
  from open.cargtram a
 where a.catrcuco = 1113210865; --.catrvare
select mM.*
  from open.mo_motive mm, open.mo_PACKAGES mP
 where mm.motive_id IN (29545522, 29633400, 29785272)
   AND MP.PACKAGE_ID = MM.PACKAGE_ID
   AND MP.PACKAGE_TYPE_ID = 545;
