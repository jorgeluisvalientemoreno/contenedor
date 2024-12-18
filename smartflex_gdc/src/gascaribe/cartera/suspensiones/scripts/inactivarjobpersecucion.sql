DECLARE

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);
  
  CURSOR cuGEMPS IS
	SELECT 	*
	FROM 	ge_process_schedule
	WHERE 	parameters_ LIKE 'OBJECT_ID=120791';
	
  TYPE tytbGEMPS IS TABLE OF cuGEMPS%ROWTYPE INDEX BY BINARY_INTEGER;
  tbGEMPS 	tytbGEMPS;
  nuIdx 	BINARY_INTEGER;

BEGIN

  dbms_output.put_Line('INICIO Inactivar programacion de GEMPS');
  
  IF (cuGEMPS%ISOPEN) THEN
	CLOSE cuGEMPS;
  END IF;
  
  OPEN cuGEMPS;
  FETCH cuGEMPS BULK COLLECT INTO tbGEMPS;
  CLOSE cuGEMPS;
  
  nuIdx := tbGEMPS.first;
  
  WHILE (nuIdx IS NOT NULL) LOOP
    dbms_output.put_Line('Inactivar process_schedule_id: '||tbGEMPS(nuIdx).process_schedule_id);
	
	GE_BOSchedule.DropSchedule(tbGEMPS(nuIdx).process_schedule_id);

	nuIdx := tbGEMPS.NEXT(nuIdx);
  END LOOP;
  
  dbms_output.put_Line('FIN Inactivar programacion de GEMPS');
  
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    Pkg_Error.SetError;
    Pkg_Error.GetError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    ROLLBACK;
  
END;
/