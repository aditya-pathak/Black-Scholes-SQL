
 GO
DROP FUNCTION If EXISTS BS.Colour

 GO
CREATE FUNCTION BS.Colour(@_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	RETURN (1/365.0)* (Exp(-1*@_q*@_t) * @_dd1 / ( @_s * @_s0 * Sqrt(@_t)) * (@_q + (1-@_d1*@_d2)/(2*@_t) - @_d1*(@_r-@_q)/(@_s* Sqrt(@_t))));
END