CREATE FUNCTION BS.Delta(@_CallPut int, @_s0 decimal(8,2), @_q decimal(8,2), @_t decimal(8,2), @_X decimal(8,2), @_r decimal(8,2), @_s decimal(8,2)) 
RETURNS decimal(8,2)
BEGIN
	Declare @_d1 as decimal(8,2)

	set @_d1 = BS.D1(@_s0, @_X, @_t, @_r, @_q, @_s);
	if @_CallPut = 0
		RETURN Exp(-1*@_q*@_t) * BS.CND(@_d1);
	else
		RETURN Exp(-1*@_q*@_t) * (BS.CND(@_d1)-1);

	--Not reachable return but it's required.
	Return 0.0
END