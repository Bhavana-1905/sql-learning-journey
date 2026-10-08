-- Date and Time Functions

-- GETDATE() returns the current date and time.
SELECT GETDATE();

-- SYSDATETIME() returns the current date and time with higher precision.
SELECT SYSDATETIME();

-- SYSDATETIMEOFFSET() returns the current date and time along with the time zone offset.
SELECT SYSDATETIMEOFFSET();

-- SYSUTCDATETIME() returns the current date and time in UTC.
SELECT SYSUTCDATETIME();

-- DATEFROMPARTS() creates a date using year, month, and day.
SELECT DATEFROMPARTS(2023, 11, 3);

-- DATETIMEFROMPARTS() creates a date and time using year, month, day, hour, minute, second, and milliseconds.
SELECT DATETIMEFROMPARTS(2023, 11, 3, 12, 00, 00, 0);

-- TIMEFROMPARTS() creates a time using hour, minute, second, fractional seconds, and precision.
SELECT TIMEFROMPARTS(7, 15, 32, 5, 7);

-- YEAR() returns the year from a date.
SELECT YEAR(GETDATE());

-- YEAR(), MONTH(), and DAY() extract the year, month, and day from the BirthDate column.
SELECT BirthDate, YEAR(BirthDate) AS YEAR, MONTH(BirthDate) AS MONTH, DAY(BirthDate) AS DAY
FROM DimEmployee;

-- DATEPART() returns the numeric value of a specified date part.
SELECT DATEPART(MONTH, GETDATE());
SELECT DATEPART(WEEKDAY, GETDATE());

-- DATENAME() returns the name of a specified date part.
SELECT DATENAME(WEEKDAY, GETDATE());
SELECT DATENAME(MONTH, GETDATE());

-- FORMAT() formats a date or time value as text.
SELECT FORMAT(GETDATE(), 'yy');
SELECT FORMAT(GETDATE(), 'dd');
SELECT FORMAT(GETDATE(), 'MMMM');

-- DATEADD() adds or subtracts a specified interval from a date.
SELECT DATEADD(YEAR, 1, GETDATE());
SELECT DATEADD(MONTH, 1, GETDATE());
SELECT DATEADD(YEAR, -5, GETDATE());

-- DATEDIFF() returns the number of specified date-part boundaries crossed between two dates.
SELECT DATEDIFF(DAY, DATEFROMPARTS(2003, 5, 19), DATEFROMPARTS(2003, 11, 3));

-- EOMONTH() returns the last day of a month. The second argument moves forward or backward by months.
SELECT EOMONTH(GETDATE(), 5);
