
 GO
DROP FUNCTION If EXISTS BS.OptionPrice

 GO 
CREATE FUNCTION BS.OptionPrice (@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_p Decimal(15,5)

	if @_CallPut = 0
		set @_p = BS.CallPrice(@_S0, @_q, @_t, @_X, @_r, @_s);
	else
		set @_p = BS.PutPrice(@_S0, @_q, @_t, @_X, @_r, @_s);

	RETURN @_p;
END