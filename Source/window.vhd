library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity window is
generic(
	 TAM_KERNEL : integer := 3 -- Tamanho do kernel (3 => 3x3; 5 => 5x5; 7 => 7x7)
);
port(
	i_clk     :  in  std_logic;
	i_Pixels  :  in  std_logic_vector((8*TAM_KERNEL*TAM_KERNEL - 1) downto 0);
	i_Kernel  :  in  std_logic_vector((8*TAM_KERNEL*TAM_KERNEL - 1) downto 0);
	i_Divider :  in  std_logic_vector(7 downto 0);
   o_Result  :  out std_logic_vector(7 downto 0)
 );
end window;

architecture arch0 of window is	 
begin

	process(i_Pixels)
		variable result : integer;
	begin
		
		result := 0;
		
		for i in 0 to (TAM_KERNEL*TAM_KERNEL - 1) loop
			
			result := result +
						 to_integer(unsigned(i_Kernel((8*(i + 1) - 1) downto 8*i)) * unsigned(i_Pixels((8*(i + 1) - 1) downto 8*i)));
			
		end loop;
	  
		result := result / to_integer(unsigned(i_Divider));
		o_Result <= std_logic_vector(resize(to_unsigned(result, 16), 8));

	end process;
  
end arch0;