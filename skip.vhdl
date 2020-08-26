-- Skip Function
-- Michael Guerrero & Michael Figura

library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
	port(I1, I2, I3, I4, sel : in std_logic_vector(1 downto 0);
	O : out std_logic_vector(1 downto 0));
end entity mux_4to1;

architecture behave of mux_4to1 is
begin
	process(i1, i2, i3, i4, sel) is
	begin
		if (sel = "00") then
                	O <= i1;
        	elsif (sel = "01") then
                	O <= i2;
        	elsif (sel = "10") then
                	O <= i3;
       		else
                	O <= i4;
	        end if;

end process;
end architecture behave;


library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
	port(clk, R, D : in std_logic;
	Q : out std_logic);
end entity flipflop;

architecture behave of flipflop is
	signal O : std_logic := '1';
begin
	process (clk, R) is
	begin	
	if (R = '1') then
		O <= '0';
	elsif clk'event and clk = '1' then
		O <= D;
	end if;
	end process;
Q <= O;
end architecture behave;



