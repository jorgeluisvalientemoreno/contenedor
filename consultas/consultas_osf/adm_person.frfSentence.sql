create or replace FUNCTION adm_person.frfSentence(isbSelect varchar2)
  return constants.tyrefcursor IS
  rfSelect constants.tyrefcursor;
begin
  open rfSelect for isbSelect;
  return rfSelect;
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
  
END frfSentence;
