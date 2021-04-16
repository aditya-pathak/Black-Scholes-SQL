
 GO
DROP FUNCTION If EXISTS BS.Delta

 GO 
CREATE FUNCTION BS.Delta(@_CallPut int, @_s0 Decimal(15,5), @_q Decimal(15,5), @_t decimal(8,5), @_X Decimal(15,5), @_r Decimal(15,5), @_s Decimal(15,5)) 
RETURNS Decimal(15,5)
BEGIN
	Declare @_d1 as Decimal(15,5)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	if @_CallPut = 0
		RETURN Exp(-1*@_q*@_t) * BS.CND(@_d1);
	else
		RETURN Exp(-1*@_q*@_t) * (BS.CND(@_d1)-1);

	--Not reachable return but it's required.
	Return 0.0
END