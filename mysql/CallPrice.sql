CREATE FUNCTION BS.CallPrice (@_s0 Decimal(8,2), @_q Decimal(8,2), @_t Decimal(8,2), @_X Decimal(8,2), @_r Decimal(8,2), @_s Decimal(8,2)) 
RETURNS Decimal(8,2)
BEGIN
	Declare @@_t as Decimal(8,2)
	, @_d1 Decimal(8,2)
	, @_d2 Decimal(8,2)

	set @@_t = @_t;
	if @_t < 0
	Begin
		set @@_t = 0;
	END
	set @_d1 = BS.D1(@_s0, @_X, @@_t, @_r, @_q, @_s);
	set @_d2 = BS.D2(@_d1, @_s, @@_t);
    RETURN @_s0 * Exp(-1*@_q*@@_t) * BS.CND(@_d1)- @_X * Exp(-1*@_r*@@_t) * BS.CND(@_d2);
END