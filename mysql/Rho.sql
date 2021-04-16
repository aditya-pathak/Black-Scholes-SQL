
 GO
DROP FUNCTION If EXISTS BS.Rho

 GO 
CREATE FUNCTION BS.Rho(@_CallPut int, @_S0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 Decimal(15,5)
	, @_d2 Decimal(15,5)

	set @_d1 = BS.D1(@_S0, @_X, @_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @_t);
	
	if @_CallPut = 0
		RETURN (1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(@_d2);
	else
		RETURN (-1/100.0)*@_X*@_t*Exp(-1*@_r*@_t)*BS.CND(-1*@_d2);

	--Not reachable return but it's required.
	Return 0.0
END 