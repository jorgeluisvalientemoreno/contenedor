CREATE OR REPLACE package ADM_PERSON.IDAUTOMATION as

function Postnet(p_data_to_encode    varchar2,
                 p_return_type       number    default 0) return varchar2;
/**************************************************************************
** Postnet       will return the properly formatted string for a Postnet **
** barcode.                  **
** Enter a single string of Zip, Zip + 4 or Zip + 4 + Delivery Point.    **
** specification string.                                                 **
** Parameters : p_data_to_encode : Data to be encoded                    **
**              p_return_type    : 0 - String to used with barcode font  **
**                                 1 - Human readable string with start  **
**                                     and end characters                **
**                                 2 - Check digit only                  **
***************************************************************************/

function I2of5  (p_data_to_encode    varchar2) return varchar2;
/***************************************************************************
** I2of5 will return the properly formatted string for a Interleave 2 of 5**
** barcode.                                                               **
** This function also "interleaves" numbers into pairs for high density   **
** without check digits.                                                  **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/

function I2of5Mod10  (p_data_to_encode    varchar2,
                      p_return_type       number  default 0) return varchar2;
/***************************************************************************
** I2of5 will return the properly formatted string for a Interleave 2 of 5**
** barcode with a Mod10 check digit                                       **
** This function also "interleaves" numbers into pairs for high density   **
** without check digits.                                                  **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
**              p_return_type    : 0 - String to used with barcode font   **
**                                 1 - Human readable string with start   **
**                                     and end characters                 **
**                                 2 - Check digit only                   **
****************************************************************************/

function Code128(p_data_to_encode    varchar2,
                 p_return_type       number    default 0) return varchar2;
/***************************************************************************
** Code128 will return the properly formatted string for a Code128        **
** barcode using the A, B, or C Specification                             **
** If you are not sure which Code 128 set is for your application, then   **
** use this one. This is a "Code 128 Auto" function that will             **
** automatically encode any data from ASCII 0 to ASCII 127. It will       **
** automatically switch to character set C for numbers also.              **
** To encode alpha-numeric UCC/EAN-128, ASCII 202 or character E is       **
** entered as the FNC1 before each AI. For example, the UCC number of     **
** (8100)712345(21)12WH5678 should be entered as: E8100712345E2112WH5678. **
** Parameters : p_data_to_encode : Data to be encoded                     **
**              p_return_type    : 0 - String to used with barcode font   **
**                                 1 - Human readable string with start   **
**                                     and end characters                 **
**                                 2 - Check digit only                   **
****************************************************************************/

function Code128A (data_to_encode    VARCHAR2) return VARCHAR2;
/********************************************************************************************
** This function will provide a string formatted for alpha-numeric values for Code 128A    **
** Parameters                                                                              **
** data_to_encode  : String that will be encoded without start and stop, checkdigit        **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/

function Code128B (data_to_encode    VARCHAR2) return VARCHAR2;
/********************************************************************************************
** This function will provide a string formatted for alpha-numeric values for Code 128B    **
** Parameters                                                                              **
** data_to_encode  : String that will be encoded without start and stop, checkdigit        **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/

function Code128C (data_to_encode    NUMBER) RETURN VARCHAR2;
/********************************************************************************************
** This function will provide a string formatted for numeric only values for Code 128C     **
** Parameters                                                                              **
** data_to_encode  : Value that will be encoded without start and stop, checkdigit         **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/

function Code39Mod43(p_data_to_encode    varchar2,
                     p_return_type       number    default 0) return varchar2;
/****************************************************************************
** Code39Mod43 will return the properly formatted string for a Code39Mod43 **
** barcode using the A, B, or C Specification                              **
** Parameters : p_data_to_encode : Data to be encoded                      **
**           p_return_type    : 1 - String to used with barcode font    **
**                   2 - Human readable string with start    **
**                       and end characters                  **
**                   3 - Check digit only                    **
****************************************************************************/

function UPCa  (p_data_to_encode    varchar2) return varchar2;
/***************************************************************************
** UPCa will return the properly formatted string for a UPCa              **
** barcode.                                                               **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/

function EAN8 (p_data_to_encode    varchar2) return varchar2;
/***************************************************************************
** EAN8 will return the properly formatted string for an EAN8 barcode     **
** This function only accepts 7 digits                                    **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/

function EAN13 (p_data_to_encode    varchar2) return varchar2;
/***************************************************************************
** EAN13 will return the properly formatted string for an EAN8 barcode     **
** This function only accepts 12 digits                                   **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/

end;
/
CREATE OR REPLACE package body ADM_PERSON.IDAUTOMATION as

function is_number(p_string varchar2) return boolean
/****************************************************************
** This function will return true if the character is a number **
** else return false                                           **
****************************************************************/
is

begin

for i in 1..length(p_string)
loop
  if substr(p_string, i, 1) not in ('1','2','3','4','5','6','7','8','9','0') then
    return false;
  end if;
end loop;
return true;  -- All the characters are numbers
end;

function Postnet(p_data_to_encode    varchar2,
                 p_return_type       number default 0) return varchar2
/**************************************************************************
** Postnet will return the properly formatted string for a Postnet       **
** barcode.                                                              **
** specification string.                                                 **
** Parameters : p_data_to_encode : Data to be encoded                    **
**           p_return_type    : 0 - String to used with barcode font  **
**                   1 - Human readable string with start  **
**                       and end characters                **
**                   2 - Check digit only                  **
***************************************************************************/
is

onlyCorrectData            varchar2(4000);  -- Make it big enough to handle any string
weightedTotal              number := 0;     -- Used for calculating Check Digit
check_digit                number;          -- Check digit variable

begin

-- Remove any non-numeric characters
for i in 1..length(p_data_to_encode)
loop
  if is_number(substr(p_data_to_encode,i,1)) then
    onlyCorrectData := onlyCorrectData || substr(p_data_to_encode,i,1);
  end if;
end loop;
-- Calculate Check Digit
-- Add each of the values in the string together
for i in 1..length(onlyCorrectData)
loop
  weightedTotal := weightedTotal + to_number(substr(onlyCorrectData,i,1));
end loop;
-- Find the remainder of the weightedTotal divided by 10
if mod(weightedTotal,10) <> 0 then
  check_digit := 10 - (mod(weightedTotal,10));
else
  check_digit := 0;
end if;

-- Return the correct value based on the p_return_type parameter
if p_return_type = 0 then
  return '('||onlyCorrectData||check_digit||')'||' ';
elsif p_return_type = 1 then
  return onlyCorrectData || check_digit;
elsif p_return_type = 2 then
  return check_digit;
else
  return null;
end if;

end postnet;

function I2of5(p_data_to_encode    varchar2) return varchar2
/***************************************************************************
** I2of5 will return the properly formatted string for a Interleaved 2of5 **
** barcode.                                                               **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/
is

startCode                    varchar2(1)  := chr(203);
endCode                      varchar2(1)  := chr(204);

onlyCorrectData              varchar2(4000);  -- Make it big enough to handle any string
weightedTotal                number := 0;     -- Used for calculating Check Digit
check_digit                  number;          -- Check digit variable
currentCharNum               number;          -- Temp character variable
printableString              varchar2(4000);  -- Variable to hold encoded string

begin

-- Only keep numbers; Leading and Trailing spaces will be removed as well
for i in 1..length(p_data_to_encode)
loop
  if is_number(substr(p_data_to_encode,i,1)) then
    onlyCorrectData := onlyCorrectData || substr(p_data_to_encode,i,1);
  end if;
end loop;

-- Check to make sure there is an even number of characters
-- If not then prepend a "0"
if mod(length(onlyCorrectData),2) = 1 then
  onlyCorrectData := '0'||onlyCorrectData;
end if;

for i in 1..length(onlyCorrectData)
loop
  -- Only execute this loop every second time eg. when i = 1,3,5,7, etc...
  if mod(i,2) = 1 then
    currentCharNum := to_number(substr(onlyCorrectData,i,2));
  -- Get the ASCII Value of the current char according to chart
  if currentCharNum < 94  then printableString := printableString || chr(currentCharNum + 33); end if;
  if currentCharNum >= 94 then printableString := printableString || chr(currentCharNum + 103); end if;
  end if; -- mod(i,2)
end loop;

return startCode || printableString || endCode|| ' ';

end I2of5;

function I2of5Mod10  (p_data_to_encode    varchar2,
                      p_return_type       number  default 0) return varchar2
/***************************************************************************
** I2of5 will return the properly formatted string for a Interleave 2 of 5**
** barcode with a Mod10 check digit                                       **
** This function also "interleaves" numbers into pairs for high density   **
** without check digits.                                                  **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
**              p_return_type    : 0 - String to used with barcode font   **
**                                 1 - Human readable string with start   **
**                                     and end characters                 **
**                                 2 - Check digit only                   **
****************************************************************************/
is

startCode                    varchar2(1)  := chr(203);
endCode                      varchar2(1)  := chr(204);

onlyCorrectData              varchar2(4000);  -- Make it big enough to handle any string
weightedTotal                number := 0;     -- Used for calculating Check Digit
check_digit                  number;          -- Check digit variable
currentCharNum               number;          -- Temp character variable
printableString              varchar2(4000);  -- Variable to hold encoded string

factor                       number := 3;

begin

-- Only keep numbers; Leading and Trailing spaces will be removed as well
for i in 1..length(p_data_to_encode)
loop
  if is_number(substr(p_data_to_encode,i,1)) then
    onlyCorrectData := onlyCorrectData || substr(p_data_to_encode,i,1);
  end if;
end loop;

-- Calculate the check digit
for i in reverse 1..length(onlyCorrectData)
loop
  -- Get the value of each number starting at the end
  currentCharNum := substr(onlyCorrectData, i, 1);
  -- Multiply by the weighting factor which is 3,1,3,1,...
  weightedTotal := weightedTotal + (currentCharNum * factor);
  -- Change the factor for the next calculation
  factor := 4 - factor;
end loop;

-- Find the check digit by finding the smallest number that = a multiple of 10
if mod(weightedTotal,10) <> 0 then
  check_digit := mod(weightedTotal,10);
else
  check_digit := 0;
end if;

-- Add check digit to onlyCorrectData
onlyCorrectData := onlyCorrectData || check_digit;

-- Check to make sure there is an even number of characters
-- If not then prepend a "0"
if mod(length(onlyCorrectData),2) = 1 then
  onlyCorrectData := '0'||onlyCorrectData;
end if;

for i in 1..length(onlyCorrectData)
loop
  -- Only execute this loop every second time eg. when i = 1,3,5,7, etc...
  if mod(i,2) = 1 then
    currentCharNum := to_number(substr(onlyCorrectData,i,2));
  -- Get the ASCII Value of the current char according to chart
  if currentCharNum < 94  then printableString := printableString || chr(currentCharNum + 33); end if;
  if currentCharNum >= 94 then printableString := printableString || chr(currentCharNum + 103); end if;
  end if; -- mod(i,2)
end loop;

if p_return_type = 0 then
  return startCode || printableString || endCode|| ' ';
elsif p_return_type = 1 then
  return onlyCorrectData;
elsif p_return_type = 2 then
  return check_digit;
else
  return null;
end if;

end I2of5Mod10;

function Code128(p_data_to_encode    varchar2,
                 p_return_type       number    default 0) return varchar2
/***************************************************************************
** Code128 will return the properly formatted string for a Code128        **
** barcode using the A, B, or C Specification                             **
** Parameters : p_data_to_encode : Data to be encoded                     **
**           p_return_type    : 1 - String to used with barcode font  **
**                   2 - Human readable string with start  **
**                       and end characters                **
**                   3 - Check digit only                  **
****************************************************************************/
is

dataToPrint     varchar2(4000);    --Data to be returned
dataToFormat    varchar2(4000);
dataToEncode    varchar2(4000);
c128Start       varchar2(1);
c128_StartA     varchar2(1)     := chr(203);
c128_StartB     varchar2(1)     := chr(204);
c128_StartC     varchar2(1)     := chr(205);
c128Stop        varchar2(1)     := chr(206);

HumanReadableText varchar2(4000);
currentCharNum    number;
currentChar       varchar2(1);
currentEncoding   varchar2(1);
weightedTotal     number;
checkDigitValue   number;
c128_CheckDigit   varchar2(2);
stringLength      number;

i             number := 1;
currentValue  number;
begin

dataToFormat := rtrim(ltrim(p_data_to_encode));
currentCharNum := ascii(substr(dataToFormat,1,1));

-- Select the start character
if currentCharNum < 32  then c128Start := c128_StartA; end if;
if currentCharNum >= 32 and currentCharNum < 127 then c128Start := c128_StartB; end if;
if length(dataToFormat) > 4 and is_number(substr(dataToFormat, 1, 4)) then c128Start := c128_StartC; end if;
-- 202 is the FNC1, character set C is mandatory
if currentCharNum = 202 then c128Start := c128_StartC; end if;
if c128Start = chr(203) then currentEncoding := 'A'; end if;
if c128Start = chr(204) then currentEncoding := 'B'; end if;
if c128Start = chr(205) then currentEncoding := 'C'; end if;

stringLength := length(dataToFormat);

while i <= stringLength
loop
  -- check for FNC1 in any set
  if substr(dataToFormat,i,1) = chr(202) then
    dataToEncode := dataToEncode || chr(202);
  -- check for switching to character set C
  elsif ((i < stringLength - 2) and (is_number(substr(dataToFormat, i, 1))) and (is_number(substr(dataToFormat, i+1, 1))) and (is_number(substr(dataToFormat,

i, 4))))
    or ((i < stringLength) and (is_number(substr(dataToFormat, i, 1))) and (is_number(substr(dataToFormat, i+1, 1))) and (currentEncoding = 'C'))

then
    -- switch to set C if not already in it
  if currentEncoding <> 'C' then
    dataToEncode := dataToEncode || chr(199);
  end if;
  currentEncoding := 'C';
  currentValue := to_number(substr(dataToFormat,i,2));
  -- set the currentValue to the number of String currentChar
  if currentValue < 95 and currentValue > 0 then
    dataToEncode := dataToEncode || chr(currentValue + 32);
  end if;
  if currentValue >= 95 then
    dataToEncode := dataToEncode || chr(currentValue + 100);
  end if;
  if currentValue = 0 then
    dataToEncode := dataToEncode || chr(194);
  end if;
  i := i + 1;
  -- check for switching to character set A
  elsif (i <= stringLength)
        and ((ascii(substr(dataToFormat,i,1)) < 31)
          or ((currentEncoding = 'A') and (ascii(substr(dataToFormat,i,1)) > 32 and (ascii(substr(dataToFormat,i,1))) < 96))) then
    -- switch to set A if not already in it
  if currentEncoding <> 'A' then
    dataToEncode := dataToEncode || chr(201);
  end if;
  currentEncoding := 'A';

  -- Get the ascii value of the next character
  currentCharNum := ascii(substr(dataToFormat,i,1));
  if currentCharNum = 32 then dataToEncode := dataToEncode || chr(194); end if;
  if currentCharNum < 32 then dataToEncode := dataToEncode || chr(currentCharNum + 96); end if;
  if currentCharNum > 32 then dataToEncode := dataToEncode || chr(currentCharNum); end if;

  -- check for switching to character set B
  elsif (i <= stringLength) and ((ascii(substr(dataToFormat,i,1))) > 31 and (ascii(substr(dataToFormat,i,1))) < 127) then
    --switch to character set B
  if currentEncoding <> 'B' then
    dataToEncode := dataToEncode || chr(200);
  end if;
  currentEncoding := 'B';
  -- get the ascii value of the next character
  currentCharNum := ascii(substr(dataToFormat,i,1));
  if currentCharNum = 32 then
    dataToEncode := dataToEncode || chr(194);
  else
    dataToEncode := dataToEncode || chr(currentCharNum);
  end if;
  end if;
  i := i + 1;
end loop;

--Format Text for AIs
-- reset cursor
i := 1;

while i <= length(dataToFormat)
loop
  -- get ascii value of each character
  currentCharNum := ascii(substr(dataToFormat,i,1));
  -- check for FNC1
  if i < length(dataToFormat) - 2 and currentCharNum = 202 then
    -- it appears that there is an AI
  -- get the value of each number pair (ex. 5 and 6 = 5*10+6 = 56)
    currentCharNum := to_number(substr(dataToFormat, i+1, 2));
  -- is 4 digit AI?
  if ((i < length(dataToFormat) - 4) and ((currentCharNum between 80 and 81) or (currentCharNum between 31 and 34))) then
    HumanReadableText := HumanReadableText || ' (' ||substr(dataToFormat, i+1, 4)||') ';
    i := i + 4;
    -- is 3 digit AI?
  elsif ((i < length(dataToFormat) - 3) and ((currentCharNum between 40 and 49) or (currentCharNum between 23 and 25))) then
    HumanReadableText := HumanReadableText || ' (' ||substr(dataToFormat, i+1, 3)||') ';
    i := i + 3;
    -- is 2 digit AI?
  elsif ((i < length(dataToFormat) - 2) and ((currentCharNum between 0 and 30) or (currentCharNum between 90 and 99))) then
    HumanReadableText := HumanReadableText || ' (' ||substr(dataToFormat, i+1, 2)||') ';
    i := i + 2;
    end if;
  elsif ascii(substr(dataToFormat, i, 1)) < 32 then
   HumanReadableText := HumanReadableText || ' ';
  elsif ascii(substr(dataToFormat, i, 1)) > 31 and ascii(substr(dataToFormat, i, 1)) < 128 then
  HumanReadableText := HumanReadableText || substr(dataToFormat, i, 1);
  end if;
  i := i + 1;
end loop;

-- Calculate Modulo 103 Check Digit
-- Set weightedTotal to the value of the start character
weightedTotal := ascii(c128Start) - 100;
for j in 1..length(dataToEncode)
loop
  -- Get the ascii value of each character
  currentCharNum := ascii(substr(dataToEncode,j ,1));
  -- Get the code 128 value of the CurrentChar according to chart
  if currentCharNum < 135  then currentValue := currentCharNum - 32;  end if;
  if currentCharNum >= 135 then currentValue := currentCharNum - 100; end if;
  if currentCharNum = 194  then currentValue := 0; end if;
  -- Multiply by the weighting character
  currentValue := currentValue * j;
  -- Add the values together
  weightedTotal := weightedTotal + currentValue;

end loop;

-- divide the weightedTotal by 103 and get the remainder, this is the CheckDigit
checkDigitValue := mod(weightedTotal, 103);
-- Now that we have the CheckDigit Value, find the corresponding ASCII character from the table
if checkDigitValue < 95 and checkDigitValue > 0 then c128_CheckDigit := chr(checkDigitValue + 32); end if;
if checkDigitValue >= 95 then c128_CheckDigit := chr(checkDigitValue + 100); end if;
if checkDigitValue = 0 then c128_CheckDigit := chr(194); end if;

for j in 1..length(dataToEncode)
loop
  currentChar := substr(dataToEncode, j, 1);
  -- Replace spaces with chr(194)
  if currentChar = ' ' then
    currentChar := chr(194);
  end if;
  dataToPrint := dataToPrint || currentChar;
end loop;

if p_return_type = 0 then
  return c128Start || dataToPrint || c128_CheckDigit || c128Stop;
elsif p_return_type = 1 then
  return HumanReadableText;
elsif p_return_type = 2 then
  return c128_CheckDigit;
end if;
end Code128;

function Code128A (data_to_encode    varchar2) return varchar2
/********************************************************************************************
** This function will provide a string formatted for alpha-numeric values for Code 128A    **
** Parameters                                                                              **
** data_to_encode  : String that will be encoded without start and stop, checkdigit        **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/
is

  v_data_to_encode       varchar2(4000) := upper(data_to_encode);  -- Convert any lowercase letters to upper case
  check_digit_char       varchar2(1)    := null;
  check_digit            number         := null;
  start_character        varchar2(1)    := chr(0203);
  stop_character         varchar2(1)    := chr(0206);

  current_value          number         := null;
  encoded_string         varchar2(1000) := null;

  -- Calcuation variables
  weight_total           number         := ascii(start_character) - 100;

begin

  -- Determine the check digit
  for i in 1..length(v_data_to_encode)
  loop
    current_value := to_number(ascii(substr(v_data_to_encode, i, 1)));
    if current_value < 135 then
    current_value := current_value - 32;
  elsif  current_value >= 135  then
    current_value := current_value - 100;
    end if;

    -- Calculate the check digit
  current_value := current_value * i;
  weight_total := weight_total + current_value;

  end loop;
  -- Get the check digit value
  check_digit := mod(weight_total,103);
  -- Get the corresponding character from the check_digit
  if check_digit < 95 and check_digit > 0 then
    check_digit_char := chr(check_digit + 32);
  elsif  check_digit >= 95 then
    check_digit_char := chr(check_digit + 100);
  elsif check_digit = 0 then
  check_digit_char := chr(194);
  end if;
  -- check digit determined

  -- Replace any occurence of ' ' (space) with chr(194)
  encoded_string := replace(v_data_to_encode,' ',chr(194));

  return start_character || encoded_string || check_digit_char || stop_character;

end;

function Code128B (data_to_encode    varchar2) return varchar2
/********************************************************************************************
** This function will provide a string formatted for alpha-numeric values for Code 128B    **
** Parameters                                                                              **
** data_to_encode  : String that will be encoded without start and stop, checkdigit        **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/
is

  check_digit_char       varchar2(1)    := null;
  check_digit            number         := null;
  start_character        varchar2(1)    := chr(0204);
  stop_character         varchar2(1)    := chr(0206);

  current_value          number         := null;
  encoded_string         varchar2(1000) := null;

  -- Calcuation variables
  weight_total           number         := ascii(start_character) - 100;

begin

  -- Determine the check digit
  for i in 1..length(data_to_encode)
  loop
    current_value := to_number(ascii(substr(data_to_encode, i, 1)));
    if current_value < 135 then
    current_value := current_value - 32;
  elsif  current_value >= 135  then
    current_value := current_value - 100;
    end if;

    -- Calculate the check digit
  current_value := current_value * i;
  weight_total := weight_total + current_value;

  end loop;
  -- Get the check digit value
  check_digit := mod(weight_total,103);
  -- Get the corresponding character from the check_digit
  if check_digit < 95 and check_digit > 0 then
    check_digit_char := chr(check_digit + 32);
  elsif  check_digit >= 95 then
    check_digit_char := chr(check_digit + 100);
  elsif check_digit = 0 then
  check_digit_char := chr(194);
  end if;
  -- check digit determined

  -- Replace any occurence of ' ' (space) with chr(194)
  encoded_string := replace(data_to_encode,' ',chr(194));

  return start_character || encoded_string || check_digit_char || stop_character;

end;

function Code128C (data_to_encode    NUMBER) RETURN VARCHAR2
/********************************************************************************************
** This function will provide a string formatted for numeric only values for Code 128C     **
** Parameters                                                                              **
** data_to_encode  : Value that will be encoded without start and stop, checkdigit         **
**                   characters                                                            **
** Return Value                                                                            **
** start_character + data_to_encode + check_digit + stop_character                         **
*********************************************************************************************/
is

  data_to_encode_char    varchar2(1000) := null;
  check_digit_char       varchar2(1)    := null;
  check_digit            number         := null;
  start_character        varchar2(1)    := chr(0205);
  stop_character         varchar2(1)    := chr(0206);

  current_value          number         := null;
  encoded_string         varchar2(1000) := null;

  -- Calcuation variables
  weight_value           number         := 1;
  weight_total           number         := 105;

begin

  -- Only keep numbers and remove dashes
  for i in 1..length(data_to_encode)
  loop
    if is_number(substr(data_to_encode,i,1)) then data_to_encode_char := data_to_encode_char || substr(data_to_encode,i,1); end if;
  end loop;

  -- The string must be an even length, if not append a zero to the beginning of it.
  if mod(length(data_to_encode_char),2) = 1 then
    data_to_encode_char := lpad(data_to_encode_char,length(data_to_encode_char)+1,'0');
  end if;

  for i in 1..length(data_to_encode_char)
  loop
    if mod(i,2) = 1 then  -- skep every second value
      current_value := to_number(substr(data_to_encode_char, i, 2));
    if current_value < 95 and current_value > 0 then
      encoded_string := encoded_string || chr(current_value + 32);
    elsif  current_value >= 95  then
      encoded_string := encoded_string || chr(current_value + 100);
    elsif current_value = 0 then
      encoded_string := encoded_string || chr(194);
      end if;

    -- Calculate the check digit
    current_value := current_value * weight_value;
    weight_total := weight_total + current_value;
    weight_value := weight_value + 1;
  end if;
  end loop;

  -- Get the check digit value
  check_digit := mod(weight_total,103);

  -- Get the corresponding character from the check_digit
  if check_digit < 95 and check_digit > 0 then
    check_digit_char := chr(check_digit + 32);
  elsif  check_digit >= 95 then
    check_digit_char := chr(check_digit + 100);
  elsif check_digit = 0 then
  check_digit_char := chr(194);
  end if;

  return start_character || encoded_string || check_digit_char || stop_character;

end;

function Code39Mod43(p_data_to_encode    varchar2,
                     p_return_type       number    default 0) return varchar2
/****************************************************************************
** Code39Mod43 will return the properly formatted string for a Code39Mod43 **
** barcode using the A, B, or C Specification                              **
** Parameters : p_data_to_encode : Data to be encoded                      **
**           p_return_type    : 1 - String to used with barcode font    **
**                   2 - Human readable string with start    **
**                       and end characters                  **
**                   3 - Check digit only                    **
****************************************************************************/
is

v_data_to_encode    varchar2(4000) := rtrim(upper(p_data_to_encode));
onlyCorrectData     varchar2(4000);
dataToPrint         varchar2(4000);

currentCharNum      number;
weightedTotal       number := 0;

currentValue        number;
checkDigitValue     number;
checkDigit          number;

begin

for i in 1..length(v_data_to_encode)
loop
  -- Get each character one at a time
  currentCharNum := ascii(substr(v_data_to_encode,i,1));
  -- Get the value of CurrentChar according to MOD43
  -- 0-9
  if currentCharNum between 48 and 57      -- 0-9
       or currentCharNum between 65 and 90 -- A-Z
     or currentCharNum in (32,45,46,36,47,43,37) then -- Space,-,.,$,/,+,%
    onlyCorrectData := onlyCorrectData || substr(v_data_to_encode,i,1);
  end if;
end loop;

v_data_to_encode := onlyCorrectData;

for i in 1..length(v_data_to_encode)
loop
  -- Get each character one at a time
  currentCharNum := ascii(substr(v_data_to_encode,i,1));
  -- Get the value of CurrentChar according to MOD43
  -- 0-9
  if currentCharNum between 48 and 57 then currentValue := currentCharNum - 48; end if;
  -- A-Z
  if currentCharNum between 65 and 90 then currentValue := currentCharNum - 55; end if;
  -- Space
  if currentCharNum = 32 then currentValue := 38; end if;
  -- -
  if currentCharNum = 45 then currentValue := 36; end if;
  -- .
  if currentCharNum = 46 then currentValue := 37; end if;
  -- $
  if currentCharNum = 36 then currentValue := 39; end if;
  -- /
  if currentCharNum = 47 then currentValue := 40; end if;
  -- +
  if currentCharNum = 43 then currentValue := 41; end if;
  -- %
  if currentCharNum = 37 then currentValue := 42; end if;

  -- To print the barcode symbol representing a space you will
  -- type or print "=" instead of a space character
  if currentCharNum = 32 then currentCharNum := 61; end if;

  -- Gather data to print
  dataToPrint := dataToPrint || chr(currentCharNum);

  -- Add the values together
  weightedTotal := weightedTotal + currentValue;

end loop;

-- Divide the weightedTotal by 43 and get the remainder for check digit
checkDigitValue := mod(weightedTotal,43);

-- Assign check digit a character value
-- 0-9
if checkDigitValue < 10 then checkDigit := checkDigitValue + 48; end if;
-- A-Z
if checkDigitValue between 10 and 35 then checkDigit := checkDigitValue + 55; end if;
-- Space
if checkDigitValue = 38 then checkDigit := 61; end if;
-- -
if checkDigitValue = 36 then checkDigit := 45; end if;
-- .
if checkDigitValue = 37 then checkDigit := 46; end if;
-- $
if checkDigitValue = 39 then checkDigit := 36; end if;
-- /
if checkDigitValue = 40 then checkDigit := 47; end if;
-- +
if checkDigitValue = 41 then checkDigit := 43; end if;
-- %
if checkDigitValue = 42 then checkDigit := 37; end if;

-- Return appropriate string
if p_return_type = 0 then
  return '!' || dataToPrint || chr(checkDigit) || '!' || ' ';
elsif p_return_type = 1 then
  return dataToPrint || chr(checkDigit);
elsif p_return_type = 2 then
  return chr(checkDigit);
else return null;
end if;

end Code39Mod43;

function UPCa  (p_data_to_encode    varchar2) return varchar2
/***************************************************************************
** UPCa will return the properly formatted string for a UPCa              **
** barcode.                                                               **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/
is
v_data_to_encode    varchar2(4000) := rtrim(ltrim(p_data_to_encode));
onlyCorrectData     varchar2(4000);
dataToEncode        varchar2(4000);
currentCharNum      number;
currentChar         varchar2(1);
checkDigit          number;
dataToPrint         varchar2(4000);

ean5addon           varchar2(5);
ean2addon           varchar2(2);
eanaddonToPrint     varchar2(100);
encoding            varchar2(10);
currentEncoding     varchar2(1);

-- Check digit variables
factor              number := 3;
weightedTotal       number := 0;

begin
  -- Only keep numbers and remove dashes
  for i in 1..length(v_data_to_encode)
  loop
    if is_number(substr(v_data_to_encode,i,1)) then onlyCorrectData := onlyCorrectData || substr(v_data_to_encode,i,1); end if;
  end loop;

  -- Remove check digits if one was added
  if length(onlyCorrectData) = 12 then onlyCorrectData := substr(onlyCorrectData, 1, 11); end if;
  if length(onlyCorrectData) = 14 then onlyCorrectData := substr(onlyCorrectData, 1, 11) || substr(onlyCorrectData, 13,2); end if;
  if length(onlyCorrectData) = 17 then onlyCorrectData := substr(onlyCorrectData, 1, 11) || substr(onlyCorrectData, 13,5); end if;

  -- Split the 12 digit number from add-on
  if length(onlyCorrectData) = 16 then ean5addon := substr(onlyCorrectData, 12, 5); end if;
  if length(onlyCorrectData) = 13 then ean2addon := substr(onlyCorrectData, 12, 2); end if;
  dataToEncode := substr(onlyCorrectData, 1, 11);

  -- Calculate the Check Digit
  for i in reverse 1..length(dataToEncode)
  loop
    currentCharNum := substr(dataToEncode,i,1);
  -- multiply by the weighting factor which is 3,1,3,1,3,.....
  -- and add the sum together
  weightedTotal := weightedTotal + (currentCharNum * factor);
  -- change the factor for the next calculation
  factor := 4 - factor;
  end loop;

  -- Find the check digit by finding the number + weightedTotal that = a multiple of 10
  -- Divide by 10, get the remainder and subtract from 10
  if mod(weightedTotal, 10) <> 0 then
    checkDigit := 10 - mod(weightedTotal,10);
  else
    checkDigit := 0;
  end if;

  dataToEncode := dataToEncode || checkDigit;

  -- Determine character to print for proper barcoding
  for i in 1..length(dataToEncode)
  loop
    -- Get ASCII value from each character
  currentCharNum := ascii(substr(dataToEncode, i, 1));
  -- Print different barcodes according to the location of the CurrentChar
  if i = 1 then -- Print the human readable character, the normal guard pattern and then the barcode
    if chr(currentCharNum) > 4  then dataToPrint := chr(currentCharNum + 64) || '(' || chr(currentCharNum + 49); end if;
    if chr(currentCharNum) <= 4 then dataToPrint := chr(currentCharNum + 37) || '(' || chr(currentCharNum + 49); end if;
  elsif i between 2 and 5 then
    dataToPrint := dataToPrint ||chr(currentCharNum);
  elsif i = 6 then -- print the center guard after the 6th character
      dataToPrint := dataToPrint ||chr(currentCharNum) || '*';
  elsif i between 7 and 11 then    -- Add 27 to the ASCII value of characters 6-12 to print from character set+ C
                                  -- this is required when printing to the right of the center guard pattern
      dataToPrint := dataToPrint || chr(currentCharNum + 27);
  elsif i = 12 then                -- print the barcode without the human readable character, the normal guard pattern
                                   -- and then the human readable character
    if chr(currentCharNum) > 4  then dataToPrint := dataToPrint || chr(currentCharNum + 59) || '(' || chr(currentCharNum + 64); end if;
    if chr(currentCharNum) <= 4 then dataToPrint := dataToPrint || chr(currentCharNum + 59) || '(' || chr(currentCharNum + 37); end if;
    end if;
  end loop;

  -- Process 5 digit add on if it exits
  if length(ean5addon) = 5 then
    -- Get check digit for add on
    factor := 3;
  weightedTotal := 0;
  for i in reverse 1..length(ean5addon)
  loop
    -- Get the value of each number starting at the end
    currentCharNum := substr(ean5addon, i, 1);
    -- Multiply by the weighting factor which is 3,9,3,9, ....
    -- and add the sum together
    if factor = 3 then weightedTotal := weightedTotal + (currentCharNum * 3); end if;
    if factor = 1 then weightedTotal := weightedTotal + (currentCharNum * 9); end if;
    -- Change the factor for the next calculation
    factor := 4 - factor;
  end loop;

    -- Find the check digit by extracting to the right-most number from weightedTotal
    checkDigit := to_number(substr(weightedTotal,length(weightedTotal), 1));

    -- Encode the add-on CheckDigit into the number sets
    -- by using variable parity between character sets A and B
    if    checkDigit = 0 then encoding := 'BBAAA';
    elsif checkDigit = 1 then encoding := 'BABAA';
    elsif checkDigit = 2 then encoding := 'BAABA';
    elsif checkDigit = 3 then encoding := 'BAAAB';
    elsif checkDigit = 4 then encoding := 'ABBAA';
    elsif checkDigit = 5 then encoding := 'AABBA';
    elsif checkDigit = 6 then encoding := 'AAABB';
    elsif checkDigit = 7 then encoding := 'ABABA';
    elsif checkDigit = 8 then encoding := 'ABAAB';
    elsif checkDigit = 9 then encoding := 'AABAB';
    end if;

  -- Determine character to print for proper barcoding
  for i in 1..length(ean5addon)
    loop
      -- Get the value of each number
    -- it is encoded with variable parity
    currentChar := substr(ean5addon, i, 1);
    currentEncoding := substr(encoding, i, 1);
    -- Print different barcodes according to the location of the currentChar and currentEncoding
    if currentEncoding = 'A' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(34); end if;
      if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(35); end if;
      if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(36); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(37); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(38); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(44); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(46); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(47); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(58); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(59); end if;
    elsif currentEncoding = 'B' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(122); end if;
      if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(61); end if;
      if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(63); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(64); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(91); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(92); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(93); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(95); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(123); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(125); end if;
    end if;

      -- Add in the space and add on guard pattern
    -- eanAddOnToPrint
    if i = 1 then -- eanAddOnToPrint = chr(32) || chr(43) || eanAddOnToPrint || chr(33)
      eanAddOnToPrint := chr(43) || eanAddOnToPrint || chr(33);
      elsif i between 2 and 4 then
      eanAddOnToPrint := eanAddOnToPrint || chr(33);
    elsif i = 5 then
      eanAddOnToPrint := eanAddOnToPrint;
    end if;
    end loop;
  end if; -- ean5addon

  -- Process 2 digit add-on if it exists
  if length(ean2AddOn) = 2 then
    -- Get encoding for add on
  for i in 0..99
  loop
    if mod(i,4) = 0 then  -- Only process every fourth item
      if to_number(ean2AddOn) = i     then encoding := 'AA'; end if;
    if to_number(ean2AddOn) = i + 1 then encoding := 'AB'; end if;
    if to_number(ean2AddOn) = i + 2 then encoding := 'BA'; end if;
    if to_number(ean2AddOn) = i + 3 then encoding := 'BB'; end if;
    end if;
  end loop;

  -- Determine what to print
  for i in 1..length(ean2AddOn)
  loop
    -- Get the value of each number
    -- it is encoded with variable parity
    currentChar := substr(ean2AddOn, i, 1);
    currentEncoding := substr(encoding, i, 1);
    -- Print the different barcodes according to the location of the currentChar and currentEncoding
    if currentEncoding = 'A' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(34); end if;
      if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(35); end if;
      if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(36); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(37); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(38); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(44); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(46); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(47); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(58); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(59); end if;
    elsif currentEncoding = 'B' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(122); end if;
      if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(61); end if;
      if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(63); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(64); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(91); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(92); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(93); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(95); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(123); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(125); end if;
    end if;

      -- Add in the space and add-on guard pattern
    if i = 1 then
      eanAddOnToPrint := chr(43) || eanAddOnToPrint || chr(33);
      elsif i = 2 then
      eanAddOnToPrint := eanAddOnToPrint;
    end if;
  end loop;
  end if; -- ean2AddOn

  return dataToPrint || eanAddOnToPrint || ' ';
end UPCa;

function EAN8 (p_data_to_encode    varchar2) return varchar2
/***************************************************************************
** EAN8 will return the properly formatted string for an EAN8 barcode     **
** This function also "interleaves" numbers into pairs for high density   **
** without check digits.                                                  **
** specification string.                                                  **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/
is

dataToEncode         varchar2(4000) := rtrim(ltrim(p_data_to_encode));
onlyCorrectData      varchar2(4000);
dataToPrint          varchar2(4000);

factor               number := 3;
weightedTotal        number := 0;

currentCharNum       number;
checkDigit           number;

wrong_length         exception;
begin
  -- Clean up the data by removing keeping numbers and removing dashes
  for i in 1..length(dataToEncode)
  loop
    if is_number(substr(dataToEncode, i, 1)) then
    onlyCorrectData := onlyCorrectData || substr(dataToEncode, i, 1);
  end if;
  end loop;

  dataToEncode := onlyCorrectData;

  if length(dataToEncode) <> 7 then
    raise wrong_length;
  end if;

  -- Calculate the check digit
  for i in reverse 1..length(dataToEncode)
  loop
    -- Get the value of each number starting at the end
  currentCharNum := substr(dataToEncode, i, 1);
    -- Multiply by the weighting factor which is 3,1,3,1,...
  -- and add sum together
  weightedTotal := weightedTotal + (currentCharNum * factor);
  -- Change the factor for the next calculation
  factor := 4 - factor;
  end loop;

  -- Find the checkdigit by finding the number + weightedTotal that = multiple of 10
  -- Divide by 10, get the remainder and subtract from 10
  if mod(weightedTotal,10) <> 0 then
    checkDigit := 10 - mod(weightedTotal,10);
  else
    checkDigit := 0;
  end if;

  dataToEncode := dataToEncode || checkDigit;

  -- Determine the correct character to print for proper barcoding
  for i in 1..length(dataToEncode)
  loop
    currentCharNum := ascii(substr(dataToEncode, i, 1));

  if i = 1        then dataToPrint := '(' || chr(currentCharNum); end if;
  if i in (2,3)   then dataToPrint := dataToPrint || chr(currentCharNum); end if;
  if i = 4        then dataToPrint := dataToPrint || chr(currentCharNum) || '*'; end if; -- Print the center guard
  if i in (5,6,7) then dataToPrint := dataToPrint || chr(currentCharNum + 27); end if;
  -- Print the check digit as 8th character and normal guard pattern
  if i = 8        then dataToPrint := dataToPrint || chr(currentCharNum + 27) || '('; end if;
  end loop;

  return dataToPrint || ' ';

exception
  when wrong_length then
    raise_application_error(-20001,'Cannot process this barcode.  Please enter a 7 digit number for an EAN8 barcode. Do not use any spaces or dashes');
end EAN8;

function EAN13 (p_data_to_encode    varchar2) return varchar2
/***************************************************************************
** EAN13 will return the properly formatted string for an EAN8 barcode    **
** This function only accepts 12 digits                                   **
** Parameters : p_data_to_encode : Data to be encoded                     **
****************************************************************************/
is

dataToEncode    varchar2(4000)  := rtrim(ltrim(p_data_to_encode));
onlyCorrectData varchar2(4000);
dataToPrint     varchar2(4000);

currentCharNum  number;
currentChar     varchar2(1);

factor          number := 3;
weightedTotal   number := 0;

ean5AddOn       varchar2(10);
ean2AddOn       varchar2(10);
eanAddOnToPrint varchar2(20);

checkDigit      number;

leadingDigit    number;
encoding        varchar2(15);
currentEncoding varchar2(1);

begin
  -- Only keep numbers and remove dashes
  for i in 1..length(dataToEncode)
  loop
    if is_number(substr(dataToEncode, i, 1)) then onlyCorrectData := onlyCorrectData || substr(dataToEncode, i, 1); end if;
  end loop;

  -- Remove check digit if one was added
  if length(onlyCorrectData) = 13 then onlyCorrectData := substr(onlyCorrectData, 1, 12); end if;
  if length(onlyCorrectData) = 15 then onlyCorrectData := substr(onlyCorrectData, 1, 12) || substr(onlyCorrectData, 14, 2); end if;
  if length(onlyCorrectData) = 18 then onlyCorrectData := substr(onlyCorrectData, 1, 12) || substr(onlyCorrectData, 14, 5); end if;

  -- setup the add on variables
  if length(onlyCorrectData) = 17 then ean5AddOn := substr(onlyCorrectData, 13, 5); end if;
  if length(onlyCorrectData) = 14 then ean2AddOn := substr(onlyCorrectData, 13, 2); end if;
  -- split the 12 digit number from add-on
  dataToEncode := substr(onlyCorrectData, 1, 12);

  -- Calculate the check digit
  for i in reverse 1..length(dataToEncode)
  loop
    -- Get the value of each number starting at the end
  currentCharNum := substr(dataToEncode, i, 1);

  -- Multiply by the weighting factor which is 3,1,3,1...
  -- and add the sum together
  weightedTotal := weightedTotal + (currentCharNum * factor);

  -- change the factor for next calculation
  factor := 4 - factor;
  end loop;

  -- Find the check digit by finding the number + weightedTotal that = a multiple of 10
  -- divide by 10, get the remainder and subtract from 10
  if mod(weightedTotal,10) <> 0 then
    checkDigit := 10 - mod(weightedTotal,10);
  else
    checkDigit := 0;
  end if;

  -- Encode the leading digit into the left half of the EAN-13 symbol
  -- by using variable parity between character sets A and B
  leadingDigit := substr(dataToEncode,1,1);
  if    leadingDigit = 0 then encoding := 'AAAAAACCCCCC';
  elsif leadingDigit = 1 then encoding := 'AABABBCCCCCC';
  elsif leadingDigit = 2 then encoding := 'AABBABCCCCCC';
  elsif leadingDigit = 3 then encoding := 'AABBBACCCCCC';
  elsif leadingDigit = 4 then encoding := 'ABAABBCCCCCC';
  elsif leadingDigit = 5 then encoding := 'ABBAABCCCCCC';
  elsif leadingDigit = 6 then encoding := 'ABBBAACCCCCC';
  elsif leadingDigit = 7 then encoding := 'ABABABCCCCCC';
  elsif leadingDigit = 8 then encoding := 'ABABBACCCCCC';
  elsif leadingDigit = 9 then encoding := 'ABBABACCCCCC';
  end if;

  -- Add the check digit to the end of the barcode and remove the leading digit
  dataToEncode := substr(dataToEncode, 2, 11) || checkDigit;

  -- Determine the character to print for proper barcoding
  for i in 1..length(dataToEncode)
  loop
    -- get the ASCII value of each number excluding the first number because it is
  -- encoded with variable parity
  currentCharNum  := ascii(substr(dataToEncode, i, 1));
  currentEncoding := substr(encoding, i, 1);

    -- Print different barcodes according to the location of the currentCharNum and currentEncoding
  if    currentEncoding = 'A' then dataToPrint := dataToPrint || chr(currentCharNum);
    elsif currentEncoding = 'B' then dataToPrint := dataToPrint || chr(currentCharNum + 17);
  elsif currentEncoding = 'C' then dataToPrint := dataToPrint || chr(currentCharNum + 27);
  end if;

  -- Add in the first character along with guard patterns
  if i = 1 then   -- For the leading digit print the human readable character
    if leadingDigit > 4  then dataToPrint := chr((leadingDigit + 48) + 64) || '(' || dataToPrint; end if;
      if leadingDigit <= 4 then dataToPrint := chr((leadingDigit + 48) + 37) || '(' || dataToPrint; end if;
  elsif i = 6 then  -- Print the center guard pattern after the 6th character
    dataToPrint := dataToPrint || '*';
    elsif i = 12 then -- Print the normal guard pattern at the end of the barcode
    datatoPrint := dataToPrint || '(';
  end if;
  end loop;

  -- Process the 5 digit add-on if it exists
  if length(ean5AddOn) = 5 then
    factor := 3;
  weightedTotal := 0;

  for i in reverse 1..length(ean5AddOn)
    loop
      -- Get the value of each number starting at the end
    currentCharNum := substr(ean5AddOn, i, 1);

    -- Multiply by the weighting factor which is 3,9,3,9, ...
    -- and add the sum together
    if factor = 3 then weightedTotal := weightedTotal + (currentCharNum * 3); end if;
    if factor = 1 then weightedTotal := weightedTotal + (currentCharNum * 9); end if;

    -- change the factor for the next calculation
    factor := 4 - factor;
  end loop;

    -- Find the check digit by extracting the right-most number from weightedTotal
  checkDigit := to_number(substr(weightedTotal,length(weightedTotal), 1));

  -- Encode the add-on checkDigit into the number sets
  -- by using variable parity between character sets A and B
  if    checkDigit = 0 then encoding := 'BBAAA';
    elsif checkDigit = 1 then encoding := 'BABAA';
  elsif checkDigit = 2 then encoding := 'BAABA';
  elsif checkDigit = 3 then encoding := 'BAAAB';
  elsif checkDigit = 4 then encoding := 'ABBAA';
  elsif checkDigit = 5 then encoding := 'AABBA';
  elsif checkDigit = 6 then encoding := 'AAABB';
  elsif checkDigit = 7 then encoding := 'ABABA';
  elsif checkDigit = 8 then encoding := 'ABAAB';
  elsif checkDigit = 9 then encoding := 'AABAB';
  end if;

    -- Determine the character to print for proper barcoding
  for i in 1..length(ean5AddOn)
    loop
    -- get the value of each number
    -- it is encoded with variable parity
    currentChar     := substr(ean5AddOn, i, 1);
    currentEncoding := substr(encoding, i, 1);
    -- Print different barcodes according to the location of the currentChar and currentEncoding
    if currentEncoding = 'A' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(34); end if;
    if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(35); end if;
    if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(36); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(37); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(38); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(44); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(46); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(47); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(58); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(59); end if;
    elsif currentEncoding = 'B' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(122); end if;
    if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(61);  end if;
    if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(63);  end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(64);  end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(91);  end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(92);  end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(93);  end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(95);  end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(123); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(125); end if;
    end if;

      if    i = 1             then eanAddOnToPrint := chr(32) || chr(43) || eanAddOnToPrint || chr(33);
    elsif i between 2 and 4 then eanAddOnToPrint := eanAddOnToPrint || chr(33);
    elsif i = 5             then eanAddOnToPrint := eanAddOnToPrint;
    end if;
    end loop;
  end if; -- ean5AddOn
  -- Process 2 digit add on if it exists
  if length(ean2AddOn) = 2 then
    -- Get encoding for add on
    for i in 0..99
  loop
    if mod(i,4) = 0 then  -- only every fourth digit
        if to_number(ean2AddOn) = i   then encoding := 'AA'; end if;
    if to_number(ean2AddOn) = i+1 then encoding := 'AB'; end if;
    if to_number(ean2AddOn) = i+2 then encoding := 'BA'; end if;
    if to_number(ean2AddOn) = i+3 then encoding := 'BB'; end if;
    end if;
  end loop;

  -- Determine what to print
  for i in 1..length(ean2AddOn)
    loop
    -- get the value of each number
    currentChar     := substr(ean2AddOn, i, 1);
    currentEncoding := substr(encoding, i, 1);
    -- Print different barcodes according to the location of the currentChar and currentEncoding
    if currentEncoding = 'A' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(34); end if;
    if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(35); end if;
    if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(36); end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(37); end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(38); end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(44); end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(46); end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(47); end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(58); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(59); end if;
    elsif currentEncoding = 'B' then
      if currentChar = '0' then eanAddOnToPrint := eanAddOnToPrint || chr(122); end if;
    if currentChar = '1' then eanAddOnToPrint := eanAddOnToPrint || chr(61);  end if;
    if currentChar = '2' then eanAddOnToPrint := eanAddOnToPrint || chr(63);  end if;
    if currentChar = '3' then eanAddOnToPrint := eanAddOnToPrint || chr(64);  end if;
    if currentChar = '4' then eanAddOnToPrint := eanAddOnToPrint || chr(91);  end if;
    if currentChar = '5' then eanAddOnToPrint := eanAddOnToPrint || chr(92);  end if;
    if currentChar = '6' then eanAddOnToPrint := eanAddOnToPrint || chr(93);  end if;
    if currentChar = '7' then eanAddOnToPrint := eanAddOnToPrint || chr(95);  end if;
    if currentChar = '8' then eanAddOnToPrint := eanAddOnToPrint || chr(123); end if;
    if currentChar = '9' then eanAddOnToPrint := eanAddOnToPrint || chr(125); end if;
    end if;

      if    i = 1 then      -- add in the space and add-on pattern
      eanAddOnToPrint := chr(32) || chr(43) || eanAddOnToPrint || chr(33);
    elsif i = 2 then  -- print add-on delineators between each add-on character
      eanAddOnToPrint := eanAddOnToPrint;
    end if;
  end loop;
  end if; --ean2AddOn

  -- return printable string
  return dataToPrint || eanAddOnToPrint || ' ';

end EAN13;

end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('IDAUTOMATION', 'ADM_PERSON'); 
END;
/
