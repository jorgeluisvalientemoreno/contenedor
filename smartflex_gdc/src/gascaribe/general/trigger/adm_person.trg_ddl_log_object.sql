CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_DDL_LOG_OBJECT
AFTER INSERT ON OPEN.GE_DATABASE_VERSION for each row
/**************************************************************************************
 .   Autor           : Gabriel Garcia Trujillo                                        .
 .   DescripciÃ³n    : Procedimiento de aplicacion de entregas para control de        .
 .					   Auditoria y actualizacion en La Brujula	                      .
 .                                                                                    .
 .   Notas           :                                                                .
 .                                                                                    .
 .   Variables       :                                                                .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Modificaciones  :                                                                .
 .                                                                                    .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Quien             Cuando            Que                                          .
 .                                                                                    .
 .                                                                                    .
 .                                                                                    .
 **************************************************************************************
 .   Revision Historica                                                               .
 .   Version 1.0                                                                      .
 **************************************************************************************/
DECLARE
V_IDUSUARIO INTEGER;
V_SQL VARCHAR2(4000);
V_DB_NAME VARCHAR2(60);
V_SYSDATE DATE := SYSDATE;
V_COUNT INTEGER := 0;
V_CUR VARCHAR2(4000);
TYPE T_CUR IS REF CURSOR;
C_CUR T_CUR;

P_FROM VARCHAR2(30);
P_SUBJ VARCHAR2(50);
P_MESSAGE VARCHAR2(4000);
P_TYPE VARCHAR2(30) := 'text/plain; charset=us-ascii';
L_MAIL_CONN   UTL_SMTP.CONNECTION;

BEGIN
	FOR X IN (SELECT OWNER, OBJECT_TYPE, OBJECT_NAME, LAST_DDL_TIME FROM DBA_OBJECTS WHERE OWNER IN ('OPEN','GISPETI') AND OBJECT_TYPE NOT IN ('JOB','INDEX') AND LAST_DDL_TIME >= SYSDATE - INTERVAL '1' HOUR) LOOP
		BEGIN
			INSERT INTO SYSADM.DDL_LOG_OBJECTS (OWNER, OBJECT_TYPE, OBJECT_NAME, DDL_DATE, DDL_DATE_VERSION) VALUES (X.OWNER, X.OBJECT_TYPE, X.OBJECT_NAME, X.LAST_DDL_TIME, :NEW.INSTALL_END_DATE);
		EXCEPTION WHEN OTHERS THEN
			--DBMS_OUTPUT.PUT_LINE('ERROR : '||SQLERRM||' : [INSERT INTO SYSADM.DDL_LOG_OBJECTS (OWNER, OBJECT_TYPE, OBJECT_NAME, DDL_DATE, DDL_DATE_VERSION) VALUES ('||X.OWNER||','|| X.OBJECT_TYPE||', '|| X.OBJECT_NAME||', '|| X.LAST_DDL_TIME||', '|| :NEW.INSTALL_END_DATE||')]');
      NULL;
		END;
	END LOOP;
/*	SELECT NUMERIC_VALUE INTO V_IDUSUARIO FROM LD_PARAMETER WHERE PARAMETER_ID = 'DBA_ACTIVO_BRUJULA';
	SELECT SYS_CONTEXT('USERENV','DB_NAME') INTO V_DB_NAME FROM DUAL;
	BEGIN
		V_SQL := 'UPDATE ENTREGASXDB@LABRUJULA SET ESTADOS_ENTREGASDB_ID=2, RESULTADOS_IDRESULTADO=2, FECHA_EJECUCION='''||V_SYSDATE||''', USUARIOS_IDUSUARIO='||V_IDUSUARIO||' WHERE ENTREGAS_IDENTREGA IN (SELECT IDENTREGA FROM ENTREGAS@LABRUJULA WHERE ASUNTO = '''||:NEW.VERSION_NAME||''' ) AND DATABASES_IDDATABASE IN (SELECT IDDATABASE FROM DATABASES@LABRUJULA WHERE DATABASE = '''|| V_DB_NAME ||''')';
		EXECUTE IMMEDIATE V_SQL;
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('ERROR : '||SQLERRM||' : ['||V_SQL||']');
    NULL;
	END;

	V_CUR := 'SELECT COUNT(*) CANTIDAD FROM ENTREGASXDB@LABRUJULA WHERE ESTADOS_ENTREGASDB_ID=2 AND RESULTADOS_IDRESULTADO=2 AND FECHA_EJECUCION='''||V_SYSDATE||''' AND USUARIOS_IDUSUARIO='||V_IDUSUARIO||' AND ENTREGAS_IDENTREGA IN (SELECT IDENTREGA FROM ENTREGAS@LABRUJULA WHERE ASUNTO = '''||:NEW.VERSION_NAME||''' ) AND DATABASES_IDDATABASE IN (SELECT IDDATABASE FROM DATABASES@LABRUJULA WHERE DATABASE = '''|| V_DB_NAME ||''')';
	--DBMS_OUTPUT.PUT_LINE(V_CUR);
	OPEN C_CUR FOR V_CUR;
	LOOP
		FETCH C_CUR INTO V_COUNT;
	EXIT WHEN C_CUR%NOTFOUND;
	END LOOP;
	CLOSE C_CUR;

	IF V_COUNT = 0 THEN
    P_FROM := 'labrujula@gasesdeoccidente.com';
    P_SUBJ := 'Entrega SIN Actualizar en La Brujula';
    P_MESSAGE := 'La entrega con el Asunto ['|| :NEW.VERSION_NAME ||'] NO fue posible Actualizarle el Estado en La Brujula para la Base de Datos ['|| V_DB_NAME ||']';
		FOR X IN (SELECT USUARIO, CORREO FROM USUARIOS@LABRUJULA WHERE BITAND(TIPOS_USUARIO,512) =512 ) LOOP
			BEGIN
				SYS.UTL_MAIL.SEND (P_FROM, X.CORREO, NULL, NULL, P_SUBJ, P_MESSAGE, P_TYPE, NULL);
			EXCEPTION WHEN OTHERS THEN
				NULL;
			END;
		END LOOP;
	END IF;*/
END;
/
