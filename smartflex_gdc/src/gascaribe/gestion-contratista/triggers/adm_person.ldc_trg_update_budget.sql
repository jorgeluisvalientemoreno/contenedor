CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UPDATE_BUDGET
FOR update ON  ldc_budget
COMPOUND TRIGGER
   rcBudgetbyprovider ldc_budget%ROWTYPE;
   rcOLDBudgetbyprovider ldc_budget%ROWTYPE;
   nuSumValueBpp ldc_budgetbyprovider.budget_value%type;
   nuSumUsersBpp ldc_budgetbyprovider.budget_users%type;
   AFTER EACH ROW IS
    BEGIN
       ut_trace.trace('ldc_trg_update_budget -  Inicio -> AFTER EACH ROW ', 10);
       rcBudgetbyprovider.component_id := :NEW.COMPONENT_ID;
       rcBudgetbyprovider.budget_value := :NEW.budget_value;
       rcBudgetbyprovider.budget_users := :NEW.budget_users;
       rcBudgetbyprovider.BUDGET_MONTH := :NEW.BUDGET_MONTH;
       rcBudgetbyprovider.DEPT_ID := :NEW.DEPT_ID;
       rcBudgetbyprovider.location_id := :NEW.location_id;
       rcBudgetbyprovider.BUDGET_YEAR := :NEW.BUDGET_YEAR;
       --
       rcOLDBudgetbyprovider.component_id := :OLD.COMPONENT_ID;
       rcOLDBudgetbyprovider.budget_value := :OLD.budget_value;
       rcOLDBudgetbyprovider.budget_users := :OLD.budget_users;
       rcOLDBudgetbyprovider.BUDGET_MONTH := :OLD.BUDGET_MONTH;
       rcOLDBudgetbyprovider.DEPT_ID := :OLD.DEPT_ID;
       rcOLDBudgetbyprovider.location_id := :OLD.location_id;
       rcOLDBudgetbyprovider.BUDGET_YEAR := :OLD.BUDGET_YEAR;

       ut_trace.trace('ldc_trg_update_budget -  Fin -> AFTER EACH ROW Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']', 10);
   END AFTER EACH ROW;

   AFTER STATEMENT IS
     BEGIN
       ut_trace.trace('ldc_trg_update_budget -  Inicio -> AFTER STATEMENT ', 10);
       -- Obtener configuración de la tabla de presupuesto por proveedor
       select nvl(sum(budget_value),0) value, nvl(sum(budget_users),0)
       into nuSumValueBpp, nuSumUsersBpp
       from ldc_budgetbyprovider
       where COMPONENT_ID = rcOLDBudgetbyprovider.COMPONENT_ID
       and DEPT_ID =  rcOLDBudgetbyprovider.DEPT_ID
       and nvl(location_id,-1) = nvl(rcOLDBudgetbyprovider.location_id,-1)
       and BUDGET_YEAR = rcOLDBudgetbyprovider.BUDGET_YEAR
       and BUDGET_MONTH = rcOLDBudgetbyprovider.BUDGET_MONTH ;

       ut_trace.trace('ldc_trg_update_budget -  Fin -> AFTER STATEMENT ', 10);
       ut_trace.trace(rcOLDBudgetbyprovider.component_id ||' <> '|| rcBudgetbyprovider.component_id, 10);
       ut_trace.trace(rcOLDBudgetbyprovider.BUDGET_MONTH ||' <> '|| rcBudgetbyprovider.BUDGET_MONTH, 10);
       ut_trace.trace(rcOLDBudgetbyprovider.DEPT_ID ||' <> '|| rcBudgetbyprovider.DEPT_ID, 10);
       ut_trace.trace(rcOLDBudgetbyprovider.location_id ||' <> '|| rcBudgetbyprovider.location_id, 10);
       ut_trace.trace(rcOLDBudgetbyprovider.BUDGET_YEAR ||' <> '|| rcBudgetbyprovider.BUDGET_YEAR, 10);
       --Validar que no el nuevo valor del presupuesto y numero de usuarios no sea menor que al definido en presupuesto
       ---por proveedor
       if rcBudgetbyprovider.budget_users < nuSumUsersBpp then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El NÿMERO DE USUARIOS es menor a la sumatoria de las configuraciones definidas en Presupuesto por Proveedor
             para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
           raise ex.CONTROLLED_ERROR;
       end if;
       --
       if rcBudgetbyprovider.budget_value < nuSumValueBpp then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El VALOR EN PESOS es menor a la sumatoria de las configuraciones definidas en Presupuesto por Proveedor
             para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
           raise ex.CONTROLLED_ERROR;
       end if;
       --
       ut_trace.trace(nuSumValueBpp ||' - '|| nuSumUsersBpp, 10);
       if (nuSumValueBpp > 0 or nuSumUsersBpp > 0) and
          (rcOLDBudgetbyprovider.component_id <> rcBudgetbyprovider.component_id or
           rcOLDBudgetbyprovider.BUDGET_MONTH <> rcBudgetbyprovider.BUDGET_MONTH or
           rcOLDBudgetbyprovider.DEPT_ID <> rcBudgetbyprovider.DEPT_ID or
           rcOLDBudgetbyprovider.location_id <> rcBudgetbyprovider.location_id or
           rcOLDBudgetbyprovider.BUDGET_YEAR <> rcBudgetbyprovider.BUDGET_YEAR) then
                 ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No se puede actualizar el registro porque existe una configuración de Presupuesto por Proveedor
                   para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
                 raise ex.CONTROLLED_ERROR;
       end if;

       EXCEPTION
          when ex.CONTROLLED_ERROR then
              raise;
          when OTHERS then
              Errors.setError;
              raise ex.CONTROLLED_ERROR;
   END AFTER STATEMENT;
END LDC_TRG_UPDATE_BUDGET;
/
