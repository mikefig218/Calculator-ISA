-- Calculator ISA testbench
-- Michael Guerrero & Michael Figura

library ieee;
use ieee.std_logic_1164.all;

entity isa_calc_tb is
end entity isa_calc_tb;

architecture behav of isa_calc_tb is

component isa_calc is
	port(instr : in std_logic_vector(7 downto 0);
	CLK : in std_logic
);
end component isa_calc;

signal instr : std_logic_vector(7 downto 0);
signal CLK : std_logic;

begin
	isa_calc_0 : isa_calc port map(instr, CLK);

	process

	type pattern_array is array (natural range <>) of std_logic_vector(7 downto 0);
	constant patterns : pattern_array :=
	(("00000010"),	--Load 2 into register 0
	("11100000"),	--print contents of register 0
	("00010100"),	--load 4 into register 1
	("11101000"),	--display contents of register 1
	("10000110"),	--subtract the contents of register 0 from register 1 and put into register 2
	("11110000"),	--display the contents of register 2
	("00011000"),   --load -8 into register 1
	("01010011"),   --Adds the value of registers 0 and 1 and puts in register 3
      	("11111000"),	--prints the value of register 3
	("11000001"),   --skips one line
	("11100000")    --prints the value of register 0, should skip
);

begin
        for n in patterns'range loop
        	instr <= patterns(n); 
		CLK <= '0';
        	wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
        end loop;

        
        wait;

end process;
end behav;

