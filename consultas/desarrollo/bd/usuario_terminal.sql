SELECT  userenv('TERMINAL'),
         USER ,
         ut_session.getmodule
    FROM dual;
