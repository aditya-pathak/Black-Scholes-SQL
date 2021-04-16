CREATE FUNCTION BS.Gamma(@_s0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare @_d1 as decimal(8,2)
	, @_dd1 as decimal(8,2)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN (Exp(-1*@_q*@_t) / (@_s0 * @_s * Sqrt(@_t))) * @_dd1;
END