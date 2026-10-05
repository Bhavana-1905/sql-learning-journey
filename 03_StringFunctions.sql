--upper(): converts all the characters into uppercase
select upper('Hello')
select EnglishProductName, 
    upper(EnglishProductName) UpperName 
from DimProduct

--lower(): converts all the characters into lowercase
select EnglishProductName, 
    lower(EnglishProductName) LowerName 
from DimProduct

--left(): used to extract specified no.of characters from the left side
select EnglishProductName, 
    left(EnglishProductName,5) FirstFiveCharacters 
from DimProduct

--right(): Used to extract specified no.of characters from the right side
select EnglishProductName,
    right(EnglishProductName,7) LastSevenCharacters
from DimProduct

--substring(): Extract a pattern from a specified position
select EnglishProductName, 
    substring(EnglishProductName,1,5) FirstFiveCharacters 
from DimProduct

--Trim(): Remove all the leading and tailing whitespaces in the string
select EnglishProductName, 
    trim(EnglishProductName) TrimmedName 
from DimProduct

--LTrim(): Remove the whitespaces on the left hand side
select EnglishProductName, 
    ltrim(EnglishProductName) LeftTrimName 
from DimProduct

--RTrim(): Remove the whitespaces on the right hand side
select EnglishProductName, 
    rtrim(EnglishProductName) RightTrimmedName 
from DimProduct

--Replace(): Replaces a specified part of the string
SELECT EnglishProductName,
       REPLACE(EnglishProductName, 'Mountain', 'MTN') AS ModifiedName
FROM DimProduct

--Stuff(): Delets sepecified characters and inserts another string
SELECT EnglishProductName,
       STUFF(EnglishProductName, 1, 5, 'XXXXX') AS ModifiedName
FROM DimProduct

-- REVERSE(): Reverses the characters in a string
SELECT EnglishProductName,
       REVERSE(EnglishProductName) AS ReversedName
FROM DimProduct


