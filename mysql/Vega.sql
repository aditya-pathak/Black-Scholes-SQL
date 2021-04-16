
 GO
DROP FUNCTION If EXISTS BS.Vega

 GO 
CREATE FUNCTION BS.Vega(@_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare
	@_d1 Decimal(15,5)
	, @_dd1 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_dd1 = (1/sqrt(2*PI())) * Exp(-1 * @_d1 * @_d1 / 2);
	RETURN (1/100.0) * @_S0 * Exp(-1*@_q*@_t) * Sqrt(@_t) * @_dd1;
END