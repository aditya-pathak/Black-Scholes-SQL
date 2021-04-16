CREATE FUNCTION BS.D2(@_D1 decimal(8,2), @_s decimal(8,2), @_t decimal(8,2))
RETURNS decimal(8,2)
BEGIN
    RETURN @_D1 - @_s * Sqrt(@_t);
END
