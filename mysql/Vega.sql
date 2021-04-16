CREATE FUNCTION BS.Vega(@_S0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare
	@_d1 decimal(8,2)
	, @_dd1 decimal(8,2)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN (1/100.0) * @_S0 * Exp(-1*@_q*@_t) * Sqrt(@_t) * @_dd1;
END