CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_DELETE_BUDGET
FOR delete ON  ldc_budget
COMPOUND TRIGGER
   rcBudgetbyprovider ldc_budget%ROWTYPE;
   nuSumValueBpp ldc_budgetbyprovider.budget_value%type;
   nuSumUsersBpp ldc_budgetbyprovider.budget_users%type;
   BEFORE EACH ROW IS
    BEGIN
       ut_trace.trace('ldc_trg_delete_budget -  Inicio -> BEFORE EACH ROW ', 10);
       rcBudgetbyprovider.component_id := :OLD.COMPONENT_ID;
       rcBudgetbyprovider.component_id:= :OLD.component_id;
       rcBudgetbyprovider.budget_value := :OLD.budget_value;
       rcBudgetbyprovider.budget_users := :OLD.budget_users;
       rcBudgetbyprovider.BUDGET_MONTH := :OLD.BUDGET_MONTH;
       rcBudgetbyprovider.DEPT_ID := :OLD.DEPT_ID;
       rcBudgetbyprovider.location_id := :OLD.location_id;
       rcBudgetbyprovider.BUDGET_YEAR := :OLD.BUDGET_YEAR;
       ut_trace.trace('ldc_trg_delete_budget -  Fin -> BEFORE EACH ROW Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']', 10);
   END BEFORE EACH ROW;

   AFTER STATEMENT IS
     BEGIN
       -- Obtener configuración de la tabla de presupuesto por proveedor
       select nvl(sum(budget_value),0) value, nvl(sum(budget_users),0)
       into nuSumValueBpp, nuSumUsersBpp
       from ldc_budgetbyprovider
       where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
       and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
       and nvl(location_id,-1) = nvl(rcBudgetbyprovider.location_id,-1)
       and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
       and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH ;
       if nuSumValueBpp > 0 or nuSumUsersBpp > 0 then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No se puede eliminar el registro porque existe una configuración de Presupuesto por Proveedor
             para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
           raise ex.CONTROLLED_ERROR;
       end if;
       EXCEPTION
          when ex.CONTROLLED_ERROR then
              raise;
          when OTHERS then
              Errors.setError;
              raise ex.CONTROLLED_ERROR;
   END  AFTER STATEMENT;
END ldc_trg_delete_budget;
/
