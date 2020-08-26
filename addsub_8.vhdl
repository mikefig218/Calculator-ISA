-- 8 Bit Adder/Subtractor
-- Michael Guerrero & Michael Figura

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	port(I1, I2 : in std_logic;
			sum, carry_out : out std_logic);
end entity half_adder;

architecture behavioral of half_adder is
begin
	sum <= I1 xor I2;
	carry_out <= I1 and I2;
end architecture behavioral;




library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
		port(I1, I2, carry_in : in std_logic;
		sum, carry_out : out std_logic);
end entity full_adder;

architecture structural of full_adder is
component half_adder is
	port(I1, I2 : in std_logic;
	sum, carry_out : out std_logic);
end component half_adder;

signal connect, out_1, out_2 : std_logic;

begin
	HA1 : half_adder port map(I1, I2, connect, out_1);
	HA2 : half_adder port map(connect, carry_in, sum, out_2);
	carry_out <= out_1 or out_2;
end architecture structural;



library ieee;
use ieee.std_logic_1164.all;

entity add_8 is
	port(I1, I2 : in std_logic_vector(7 downto 0);
	O : out std_logic_vector(7 downto 0));
end entity add_8;

architecture structural of add_8 is
component full_adder is
	port(I1, I2, carry_in : in std_logic;
	sum, carry_out : out std_logic);
end component full_adder;

signal out_0, out_1, out_2, out_3, out_4, out_5, out_6 : std_logic;
begin
	FA0 : full_adder port map(I1(0), I2(0), '0', O(0), out_0);
	FA1 : full_adder port map(I1(1), I2(1), out_0, O(1), out_1);
	FA2 : full_adder port map(I1(2), I2(2), out_1, O(2), out_2);
	FA3 : full_adder port map(I1(3), I2(3), out_2, O(3), out_3);
	FA4 : full_adder port map(I1(4), I2(4), out_3, O(4), out_4);
	FA5 : full_adder port map(I1(5), I2(5), out_4, O(5), out_5);
	FA6 : full_adder port map(I1(6), I2(6), out_5, O(6), out_6);
	FA7 : full_adder port map(I1(7), I2(7), out_6, O(7), open);

end architecture structural;



library ieee;
use ieee.std_logic_1164.all;

entity addsub_8 is
	port( I1, I2 : in std_logic_vector(7 downto 0);
  sel : in std_logic;
	O : out std_logic_vector(7 downto 0));
end entity addsub_8;

architecture structural of addsub_8 is
component add_8 is
	port(I1, I2 : in std_logic_vector(7 downto 0);
	O : out std_logic_vector(7 downto 0));
end component add_8;

signal I2_val, not_I2, twos_I2 : std_logic_vector(7 downto 0);

begin

	with sel select I2_val <= I2 when '0', twos_I2 when others;

	A1 : add_8 port map(I1, I2_val, O);

	not_I2 <= not(I2);

	A2 : add_8 port map(not_I2, "00000001", twos_I2);

end architecture structural;
