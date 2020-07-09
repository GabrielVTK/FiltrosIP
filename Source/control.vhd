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
	i_Pixel_Counter : in  integer range -1 to TAM_IMG + 1;
	i_Line_Counter  : in  integer range 0  to TAM_IMG;
	i_DelayLimit    : in  integer range 0  to (2*TAM_IMG + TAM_KERNEL);
	o_Flag_Process  : out std_logic
);
end entity control;

architecture arch1 of control is

  type STATE is (Reset, PreencheRB, Processa, Borda, Fim);
  signal Atual    : STATE;
  signal Proximo  : STATE;
    
begin

	p_ATUAL : process (i_CLOCK, i_RESET)
	begin
		if (i_RESET = '1') then
			Atual <= Reset;
		elsif (rising_edge(i_CLOCK)) then
			Atual <= Proximo;
		end if;
	end process p_ATUAL;

	p_PROXIMO : process (i_Pixel_Counter, i_Line_Counter, i_DelayLimit, Atual)
		
	begin	
			
		case Atual is	
		
			when Reset =>
				Proximo <= PreencheRB;
			when PreencheRB =>
			  
			  if(i_DelayLimit > 0) then
					Proximo <= PreencheRB;
				else
					Proximo <= Processa;					
				end if;	
								
			when Processa =>
				
				if(i_Pixel_Counter > TAM_IMG - TAM_KERNEL - 1) then
				
					if(i_Line_Counter = (TAM_IMG - TAM_KERNEL)) then
						Proximo <= Fim;
					else
						Proximo <= Borda;
					end if;
					
				end if;
				
				if(i_Line_Counter = (TAM_IMG - TAM_KERNEL) and Proximo = Borda) then
					Proximo <= FIM;
				end if;
				
			when Borda =>
			
				if(i_Pixel_Counter <= TAM_IMG - 2) then
					Proximo <= Borda;
				else
					Proximo <= Processa;
				end if;
				
			when Fim =>
			
			when others =>			  
		end case;
						
	end process p_PROXIMO;
			
	o_Flag_Process <= '1' when Atual = Processa else '0';
	
end arch1;
