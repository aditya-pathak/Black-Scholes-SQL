CREATE FUNCTION BS.OptionPrice (@_CallPut int, @_S0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare @_p decimal(8,2)

	if @_CallPut = 0
		set @_p = BS.CallPrice(@_S0, @_q, @_t, @_X, @_r, @_s);
	else
		set @_p = BS.PutPrice(@_S0, @_q, @_t, @_X, @_r, @_s);

	RETURN @_p;
END