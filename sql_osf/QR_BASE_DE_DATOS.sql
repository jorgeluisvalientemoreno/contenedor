SELECT UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(SYSADM.get_qr_code('https://www.google.com.co'))) QRCODE
  FROM dual;
SELECT t.*, rowid FROM tempopen t;
