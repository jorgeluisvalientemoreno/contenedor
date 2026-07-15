select package_id,pkg_boConsultaEmpresa.fsbObtEmpresaDireccion (Mo_packages.address_id ),
pkg_BCSolicitudes.fnuGetPersona( Mo_packages.package_id) nuSalesmanId,
pkg_BCSolicitudes.fnuGetPuntoVenta( Mo_packages.package_id) nuOperatingUnitId,
pkg_BCUnidadOperativa.fsbGetEsExterna( pkg_BCSolicitudes.fnuGetPuntoVenta( Mo_packages.package_id) ) sbES_externa
from mo_packages
where package_id in
(
236581368,
236581363,
236581350,
236581345,
236581340

)
