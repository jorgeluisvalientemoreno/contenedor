--maestro_interfaz_listas_de_precio
select lp.codigo,
       lp.descripcion,
       lp.fecha_ini_vigen,
       lp.fecha_final_vige,
       lp.fecha_registro,
       lp.fecha_procesado,
       lp.usuario,
       lp.estado,
       lp.mensaje,
       lp.empresa
from ldci_intelistpr lp
where 1 = 1
and    trunc(lp.fecha_ini_vigen) = '1/09/2025'
and    trunc(lp.fecha_final_vige) = '31/12/2025'
order by lp.codigo

---actualizar mes de la fecha inicial y final

/*
UPDATE ldci_intelistpr
SET fecha_ini_vigen = TO_DATE('09' || TO_CHAR(fecha_ini_vigen, '-DD-YYYY'), 'MM-DD-YYYY'),
    fecha_final_vige = TO_DATE('12' || TO_CHAR(fecha_final_vige, '-DD-YYYY'), 'MM-DD-YYYY')
WHERE codigo in (64);  , 65

-- ---actualizar otros campos 

UPDATE ldci_intelistpr
SET estado = 1,
    mensaje = 'Registro ok.',
    fecha_procesado = null
WHERE codigo in (64); 64, 65, 

--2
--Se encontro mas de una interfaz para procesar con fechas de vigencia de: 01-07-2025 00:00:00 a : 31-08-2025 23:59:59 para empresa GDGU
--28/07/2025 3:10:07 p. m.

-- insertar registros en la tabla

INSERT INTO ldci_intelistpr (
    codigo,
    descripcion,
    fecha_ini_vigen,
    fecha_final_vige,
    fecha_registro,
    fecha_procesado,
    usuario,
    estado,
    mensaje,
    empresa
)
SELECT
    66,                        -- nuevo código
    descripcion,
    fecha_ini_vigen,
    fecha_final_vige,
    SYSDATE,                   -- nueva fecha de registro
    fecha_procesado,
    usuario,
    estado,
    mensaje,
    empresa
FROM ldci_intelistpr
WHERE codigo = 65;

*/

--lp.fecha_registro >= '01/07/2025'
--lp.empresa, 

--where lp.estado = 1

--and lp.codigo = 60
--and   lp.estado in (1, 2, 3)


/*and    trunc(lp.fecha_ini_vigen) = '4/04/2025'
and    trunc(lp.fecha_final_vige) = '1/05/2025'*/
