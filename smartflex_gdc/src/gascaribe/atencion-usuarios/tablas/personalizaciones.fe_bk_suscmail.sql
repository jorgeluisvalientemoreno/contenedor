BEGIN

 EXECUTE IMMEDIATE 'create table PERSONALIZACIONES.FE_BK_SUSCMAIL AS (
                          select susccodi, suscclie, suscmail
                          from suscripc 
                          inner join servsusc on sesususc = susccodi and sesuserv <> 7057
                          where suscmail is not null
                          group by susccodi, suscclie, suscmail
                      ) ';
  pkg_utilidades.praplicarpermisos('FE_BK_SUSCMAIL', 'PERSONALIZACIONES');
END;

/