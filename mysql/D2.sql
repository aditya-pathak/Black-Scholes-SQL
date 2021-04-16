
 GO
DROP FUNCTION If EXISTS BS.D2

 GO 
CREATE FUNCTION BS.D2(@_D1 Decimal(15,5), @_s Decimal(15,5), @_t decimal(8,5))
RETURNS Decimal(15,5)
BEGIN
    RETURN @_D1 - @_s * Sqrt(@_t);
END
