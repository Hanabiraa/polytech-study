library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity algMin is
	type arr is array(integer range <>) of integer; -- arr type
	signal y : arr(0 to 3) := (25, 20, 15, 10); -- init arr
end entity;
 
architecture simulator of algMin is

	function findmin(a : arr) return integer is
		variable minval : integer := 32000;
	begin
	    for i in 0 to a'high loop
	        if (a(i) < minval) then
				minval := a(i);
		    end if;
	    end loop;
	 	return minval;
	end function;
	
begin
 
    process is
    begin
 		report "Min value is: ";
        report integer'Image(findmin(y));
 		wait;
    end process;
 
end architecture;
