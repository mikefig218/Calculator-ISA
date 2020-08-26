-- Register Function
-- Michael Guerrero & Michael Figura

library ieee;
use ieee.std_logic_1164.all;

entity isa_reg is
	port(R1, R2 : in std_logic_vector(1 downto 0);
	WR : in std_logic_vector(1 downto 0);
	WD : in std_logic_vector(7 downto 0);
	CLK : in std_logic;
	WE : in std_logic;
	RD1 : out std_logic_vector(7 downto 0);
	RD2 : out std_logic_vector(7 downto 0)
);
end entity isa_reg;


architecture behav of isa_reg is
	signal reg_0, reg_1, reg_2, reg_3 : std_logic_vector(7 downto 0) := "00000000";

begin
	with R1 select RD1 <= reg_0 when "00", reg_1 when "01", reg_2 when "10", reg_3 when others;
	with R2 select RD2 <= reg_0 when "00", reg_1 when "01", reg_2 when "10", reg_3 when others;

	process (CLK) is
	begin
		if(CLK'event and CLK = '1'and WE = '1') then
				if(WR = "00") then reg_0 <= WD;
				elsif(WR = "01") then reg_1 <= WD;
				elsif(WR = "10") then reg_2 <= WD;
				elsif(WR = "11") then reg_3 <= WD;
			end if;
		end if;
	end process;
end architecture;
