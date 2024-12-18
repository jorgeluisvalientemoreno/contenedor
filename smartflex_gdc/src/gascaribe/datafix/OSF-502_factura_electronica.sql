begin
delete open.LDCI_FACTEACTASENV l
 where l.faceaeidacta = 177226;
 commit;
exception
 WHEN OTHERS THEN
 ROLLBACK;
 DBMS_OUTPUT.PUT_LINE('ERROR : '||SQLERRM);
END;
/