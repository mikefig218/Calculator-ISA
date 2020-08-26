-- Calculator ISA
-- Michael Guerrero & Michael Figura

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity isa_calc is
       port(instr : in std_logic_vector(7 downto 0);
       output : out std_logic_vector(7 downto 0);
	CLK : in std_logic
);       
end entity isa_calc;

architecture structural of isa_calc is
component isa_reg is
	port(R1, R2 : in std_logic_vector(1 downto 0);
        WR : in std_logic_vector(1 downto 0);
        WD : in std_logic_vector(7 downto 0);
        CLK : in std_logic;
        WE : in std_logic;
        RD1 : out std_logic_vector(7 downto 0);
        RD2 : out std_logic_vector(7 downto 0)
);
end component isa_reg;

component addsub_8 is
	port(I1, I2 : in std_logic_vector(7 downto 0);
	sel : in std_logic;
	O : out std_logic_vector(7 downto 0)
);
end component addsub_8;


signal r1, r2, wr : std_logic_vector(1 downto 0);
signal wd :  std_logic_vector(7 downto 0);
signal we : std_logic := '1';
signal rd1, rd2 : std_logic_vector(7 downto 0);
signal aluO : std_logic_vector(7 downto 0);
signal skpamt : std_logic_vector(7 downto 0);
signal skpamtO : std_logic_vector(7 downto 0);

begin
	isa_reg0 : isa_reg port map(r1, r2, wr, wd, CLK, we, rd1, rd2);
	ALU : addsub_8 port map(rd1, rd2, instr(7), aluO);
	ALUskip : addsub_8 port map(skpamt, "00000001", '1', skpamtO); 
	
process(CLK) is
variable dsp_int : integer;
begin

		if (instr(7 downto 6) = "00") then
			wd(3 downto 0) <= instr(3 downto 0);
			if(instr(3) = '1') then
				wd(7 downto 4) <= "1111";
			else
				wd(7 downto 4) <= "0000";
			end if;
			r1 <= "00";
			r2 <= "00";
			we <= '1';
		        wr <= instr(5 downto 4);
 		elsif (instr(7 downto 6) = "01" or instr(7 downto 6) = "10") then
			wd <= aluO;
			wr <= instr(1 downto 0);
			r1 <= instr(5 downto 4);
			r2 <= instr(3 downto 2);
		elsif (instr(7 downto 5) = "111") then
			r1 <= instr(4 downto 3);
			output(7 downto 0) <= rd1(7 downto 0);
--			dsp_int := to_integer(signed(rd1));
--			if(dsp_int >= 0) then
--				if(dsp_int < 10) then
--					report "   " & integer'image(dsp_int) severity note;
--				elsif (dsp_int < 100) then
--					report "  " & integer'image(dsp_int) severity note;		
--				elsif (dsp_int < 1000) then
--					report " " & integer'image(dsp_int) severity note;
--				else
--					report integer'image(dsp_int) severity note;
--				end if;
--			else
--				if(dsp_int > -10) then
--					report "  " & integer'image(dsp_int) severity note;
--				elsif (dsp_int > -100) then
--					report " " & integer'image(dsp_int) severity note;		
--				else
--					report integer'image(dsp_int) severity note;
--				end if;
--			end if;
		elsif (instr(7 downto 5) = "110") then
			if (skpamt /= "00000000") then
				we <= '0';
				if (CLK'event and CLK = '1') then
					report "Skip" severity note; --Catches the skip
				end if;
			else
				we <= '1';
			end if;
		end if;
end process;
end architecture structural;	
