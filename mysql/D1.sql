
 GO
DROP FUNCTION If EXISTS BS.D1

 GO 
CREATE FUNCTION BS.D1(@_s0 Decimal(15,5), @_X Decimal(15,5), @_t decimal(8,5), @_r Decimal(15,5), @_q Decimal(15,5), @_s Decimal(15,5))
RETURNS Decimal(15,5)
BEGIN
    RETURN (Log(@_s0/@_X)+@_t*(@_r-@_q+Power(@_s,2)/2))/(@_s*Sqrt(@_t));
END