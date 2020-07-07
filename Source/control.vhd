library ieee;
use ieee.std_logic_1164.all;

entity control is
  generic(
	 TAM_IMG    : integer := 102; -- Tamanho da imagem
	 TAM_KERNEL : integer := 3    -- Tamanho do kernel (3 => 3x3; 5 => 5x5; 7 => 7x7)
  );
	port(
	 i_CLOCK         : in  std_logic;
	 i_RESET         : in  std_logic;
	 i_FlagDelay     : in  std_logic;
	 o_FlagProcess   : out std_logic
	);
end entity control;

architecture arch1 of control is

  type STATE is (Reset, PreencheRB, Processa);
  signal Atual    : STATE;
  signal Proximo  : STATE;
    
begin

	p_ATUAL : process (i_RESET, i_CLOCK)
	begin
		if (i_RESET = '1') then
			Atual <= Reset;
		elsif (rising_edge(i_CLOCK)) then
			Atual <= Proximo;
		end if;
	end process p_ATUAL;

	p_PROXIMO : process (Atual)
	
	begin	
			
		case Atual is	
		
			when Reset =>
				Proximo <= PreencheRB;
				
			when PreencheRB =>
			  
			  if(i_FlagDelay = '1') then
					Proximo <= PreencheRB;
			  else
					Proximo <= Processa;
			  end if;
				
			when Processa =>
			  Proximo <= Processa;
			  
		end case;
	end process p_PROXIMO;
			
	o_FlagProcess <= '1' when Atual = Processa else '0';
	
	
end arch1;
