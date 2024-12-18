CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_VALIDATE_BUDGET
FOR INSERT OR UPDATE ON  ldc_budgetbyprovider
COMPOUND TRIGGER
   rcBudgetbyprovider ldc_budgetbyprovider%ROWTYPE;
   nuSumValueBudget ldc_budget.budget_value%type;
   nuSumUsersBudget ldc_budget.budget_users%type;
   nuSumValueBpp ldc_budgetbyprovider.budget_value%type;
   nuSumUsersBpp ldc_budgetbyprovider.budget_users%type;

   nuLoc number := 0;

   AFTER EACH ROW IS
    BEGIN
       ut_trace.trace('ldc_trg_validate_budget -  Inicio -> AFTER EACH ROW ', 10);
       rcBudgetbyprovider.component_id := :NEW.COMPONENT_ID;
       rcBudgetbyprovider.component_id:= :NEW.component_id;
       rcBudgetbyprovider.budget_value := :NEW.budget_value;
       rcBudgetbyprovider.budget_users := :NEW.budget_users;
       rcBudgetbyprovider.BUDGET_MONTH := :NEW.BUDGET_MONTH;
       rcBudgetbyprovider.DEPT_ID := :NEW.DEPT_ID;
       rcBudgetbyprovider.location_id := :NEW.location_id;
       rcBudgetbyprovider.BUDGET_YEAR := :NEW.BUDGET_YEAR;
       ut_trace.trace('ldc_trg_validate_budget -  Fin -> AFTER EACH ROW Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']', 10);
   END AFTER EACH ROW;
   AFTER STATEMENT IS
     BEGIN
       ut_trace.trace('ldc_trg_validate_budget -  Inicio ->  AFTER STATEMENT', 10);
       -- Obtener configuración de la tabla de presupuesto general

       --AGORDILLO
       -- Se evalua si la localida esta configurada
        IF (rcBudgetbyprovider.location_id is not null) then
           ut_trace.trace('componente '||rcBudgetbyprovider.COMPONENT_ID||' Localida '||rcBudgetbyprovider.location_id, 10);
           ut_trace.trace('año '||rcBudgetbyprovider.BUDGET_YEAR||' Mes '||rcBudgetbyprovider.BUDGET_MONTH, 10);
           select count(1) into nuLoc
           from ldc_budget
           where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
           and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
           and nvl(location_id,-1) = nvl(rcBudgetbyprovider.location_id,-1)
           and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
           and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH ;
        END IF;


       -- Si no se inserta localida o la localida que se inserta no esta configurada,
       -- Evalua hasta departamento
       IF (rcBudgetbyprovider.location_id is null or nuLoc=0) then
       ut_trace.trace('Si no se inserta localida se evalua hasta departamento', 10);
       ut_trace.trace('localidad '||rcBudgetbyprovider.location_id||' nuLoc '||nuLoc, 10);

           select nvl(sum(budget_value),0) value, nvl(sum(budget_users),0) users
           into nuSumValueBudget, nuSumUsersBudget
           from ldc_budget
           where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
           and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
           and location_id is null
           and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
           and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH ;

        else
        ut_trace.trace('Si se coloca localida se evalua hasta localidad', 10);

           select nvl(sum(budget_value),0) value, nvl(sum(budget_users),0) users
           into nuSumValueBudget, nuSumUsersBudget
           from ldc_budget
           where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
           and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
           and nvl(location_id,-1) = nvl(rcBudgetbyprovider.location_id,-1)
           and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
           and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH ;

        end if;


       --Validar si en la tabla de presupuesto general ya se
       --realizó la configuración
       ut_trace.trace('ldc_trg_validate_budget -  Ejecucución ->  AFTER STATEMENT => '||nuSumValueBudget||' - '|| nuSumUsersBudget, 11);
       if nuSumValueBudget = 0 and nuSumUsersBudget = 0 then
               ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No se han insertado registros en la tabla de presupuesto general
               para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
       end if;

       -- Obtener configuración de la tabla de presupuesto por proveedor
       IF (rcBudgetbyprovider.location_id is null or nuLoc=0) then
       ut_trace.trace('Conf tabla presupuesto por provedor, hasta departamento', 10);
           --  Se excluyen las localidades que tienen configuracion especifica para que no se tome
           --- en la validacion
           select nvl(sum(ldc_budgetbyprovider.budget_value),0) value, nvl(sum(ldc_budgetbyprovider.budget_users),0)
           into nuSumValueBpp, nuSumUsersBpp
           from ldc_budgetbyprovider
           where ldc_budgetbyprovider.COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
           and ldc_budgetbyprovider.DEPT_ID =  rcBudgetbyprovider.DEPT_ID
           and (location_id is null or  location_id not in (select location_id from ldc_budget
                                                            where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
                                                            and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
                                                            and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
                                                            and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH
                                                            and location_id is not null))
           and ldc_budgetbyprovider.BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
           and ldc_budgetbyprovider.BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH;

       else
       ut_trace.trace('Conf tabla presupuesto por provedor, hasta localida', 10);
            select nvl(sum(budget_value),0) value, nvl(sum(budget_users),0)
           into nuSumValueBpp, nuSumUsersBpp
           from ldc_budgetbyprovider
           where COMPONENT_ID = rcBudgetbyprovider.COMPONENT_ID
           and DEPT_ID =  rcBudgetbyprovider.DEPT_ID
           and nvl(location_id,-1) = nvl(rcBudgetbyprovider.location_id,-1)
           and BUDGET_YEAR = rcBudgetbyprovider.BUDGET_YEAR
           and BUDGET_MONTH = rcBudgetbyprovider.BUDGET_MONTH ;
       end if;

       ut_trace.trace('ldc_trg_validate_budget -  Ejecucución ->  AFTER STATEMENT => '||nuSumValueBpp||' - '|| nuSumUsersBpp, 11);

       ut_trace.trace('nuSumValueBpp['||nuSumValueBpp||'] nuSumValueBudget['||nuSumValueBudget||']',5);
       ut_trace.trace('nuSumUsersBpp['||nuSumUsersBpp||'] nuSumUsersBudget['||nuSumUsersBudget||']',5);

       if nuSumValueBpp > nuSumValueBudget or nuSumUsersBpp > nuSumUsersBudget then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'Se excede el valor definido en el presupuesto general
             para el Producto ['||rcBudgetbyprovider.COMPONENT_ID||'] Departamento ['||rcBudgetbyprovider.DEPT_ID ||'] Localidad ['||rcBudgetbyprovider.location_id||'] Año ['||rcBudgetbyprovider.BUDGET_YEAR||'] Mes ['||rcBudgetbyprovider.BUDGET_MONTH||']');
           raise ex.CONTROLLED_ERROR;
       end if;
       ut_trace.trace('ldc_trg_validate_budget -  Fin ->  AFTER STATEMENT', 10);
       EXCEPTION
          when ex.CONTROLLED_ERROR then
              raise;
          when OTHERS then
              Errors.setError;
              raise ex.CONTROLLED_ERROR;
        null;
   END  AFTER STATEMENT;
END LDC_TRG_VALIDATE_BUDGET;
/
