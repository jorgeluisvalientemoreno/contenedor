CREATE OR REPLACE TRIGGER adm_person.ldctrg_ins_upd_pr_comp_suspens
BEFORE INSERT OR UPDATE ON pr_comp_suspension
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA SAS

  Trigger  :  ldctrg_ins_upd_pr_prod_suspens

  Descripci?n  : Se actualiza marca producto en ldc_marca_producto.

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 25-07-2017

  Historia de Modificaciones
  21/10/2024    jpinedc     OSF-3450: Se migra a ADM_PERSON  
**************************************************************/
DECLARE
 numotivo mo_motive.motive_id%TYPE;
BEGIN
 IF :old.suspension_type_id <> :new.suspension_type_id THEN
  BEGIN
   SELECT l.motive_id INTO numotivo
     FROM mo_component l
    WHERE l.component_id_prod = :new.component_id
      AND l.attention_date IS NULL
      AND l.motive_status_id = 15
      AND rownum = 1;
  EXCEPTION
   WHEN no_data_found THEN
   NULL;
  END;
  UPDATE mo_suspension mpo
     SET mpo.suspension_type_id = :new.suspension_type_id
   WHERE mpo.motive_id = numotivo
     AND mpo.ending_date IS NULL;
   IF SQL%FOUND THEN
    INSERT INTO ldc_comosuspprodact VALUES(:new.comp_suspension_id,'COMPONENTE',numotivo);
   END IF;
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/
