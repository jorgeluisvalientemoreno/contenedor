CREATE OR REPLACE FUNCTION count_pipe_characters(p_line IN VARCHAR2)
RETURN NUMBER IS
  v_count NUMBER := 0;
BEGIN
  FOR i IN 1..LENGTH(p_line) LOOP
    IF SUBSTR(p_line, i, 1) = '|' THEN
      v_count := v_count + 1;
    END IF;
  END LOOP;
  RETURN v_count;
END;