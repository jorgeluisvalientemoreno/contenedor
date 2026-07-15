-- 1. Consulta previa para verificar los datos 
SELECT a.orga_area_seller_id,
       a.person_id,
       a.organizat_area_id,
       a.is_current
  FROM cc_orga_area_seller a
 WHERE a.person_id = 38963
   AND a.organizat_area_id = 64;

-- 2. Eliminar el registro
DELETE FROM cc_orga_area_seller a
 WHERE a.person_id = 38963
   AND a.organizat_area_id = 64;

-- 3. obtener secuencia   
SELECT NVL(MAX(orga_area_seller_id), 0) + 1 AS siguiente_id
FROM cc_orga_area_seller;


-- 4. Insertar nuevamente el registro con la misma información
INSERT INTO cc_orga_area_seller (
    orga_area_seller_id,
    person_id,
    organizat_area_id,
    is_current
)
VALUES (
    187891,   -- Reemplaza con el orga_area_seller_id original
    38963,    -- person_id
    64,       -- organizat_area_id
    'S'       -- is_current
);

-- 5. actualizar campos
UPDATE cc_orga_area_seller a
   SET is_current = 'S'
 WHERE a.person_id = 38963
   AND a.organizat_area_id = 64;

COMMIT;
