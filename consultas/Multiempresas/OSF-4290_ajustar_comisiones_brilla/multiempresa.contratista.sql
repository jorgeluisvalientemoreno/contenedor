--multiempresa.contratista
select mc.contratista, mc.empresa
from multiempresa.contratista  mc
where mc.contratista = 3989;

/*

--eliminar empresa y contratista

delete from multiempresa.contratista  mc where mc.contratista = 1829

--insertar empresa y contratista

INSERT INTO multiempresa.contratista (contratista, empresa)
SELECT 1829, 'GDCA'
FROM DUAL;

--actualizar empresa contratista

BEGIN
  UPDATE multiempresa.contratista mc
     SET mc.empresa = 'GDGU'
   WHERE mc.contratista = 3989;
  COMMIT;
END;


select c.contratista, 
       c.empresa
 from multiempresa.contratista  c 
 where c.contratista = 1829
 
 */
