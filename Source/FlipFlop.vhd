--FLipFlop type D

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlop is
  generic(size : integer := 8);

  port(
    i_CLOCK : in std_logic;
	  i_RESET : in std_logic;
    i_D     : in std_logic_vector(size-1 downto 0);
    o_QF    : out std_logic_vector(size-1 downto 0)
  );
end entity FlipFlop;

architecture Arch of FlipFlop is
begin
  process(i_CLOCK)
  begin
    if(rising_edge(i_CLOCK)) then
	 
		  if(i_RESET = '1') then
			 o_QF <= x"00";
		  else
			 o_QF <= i_D;
		  end if;
		
    end if;
  end process;
end Arch;
