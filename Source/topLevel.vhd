library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity topLevel is
generic(
	 TAM_IMG    : integer := 102; -- Tamanho da imagem
	 TAM_KERNEL : integer := 3    -- Tamanho do kernel (3 => 3x3; 5 => 5x5; 7 => 7x7)
);
port(
		i_RESET       :  in  std_logic;
		i_clk         :  in  std_logic;
		i_pixel       :  in  std_logic_vector(7 downto 0);
		i_Kernel      :  in  std_logic_vector((8*TAM_KERNEL*TAM_KERNEL - 1) downto 0);
		i_Divider     :  in  std_logic_vector(7 downto 0);
		o_pixel       :  out std_logic_vector(7 downto 0);
		o_FlagProcess :  out std_logic
);
end topLevel;

architecture arch0 of topLevel is
	
	signal w_OUT_RowBuffer : std_logic_vector(((TAM_KERNEL - 1)*8*TAM_KERNEL - 1) downto 0);
		
	signal w_Buffer        : std_logic_vector((TAM_KERNEL*8 - 1) downto 0);
	 
	signal w_Flag_Process  : std_logic := '0';
	
	signal w_Pixels        : std_logic_vector((8*TAM_KERNEL*TAM_KERNEL - 1) downto 0);
	
begin
	 
	o_FlagProcess <= w_Flag_Process;
	
	WINDOW_PIXELS: for i in 0 to ((TAM_KERNEL - 1)*TAM_KERNEL - 1) generate
		w_Pixels(((i + 1)*8 - 1) downto i*8) <= w_OUT_RowBuffer(((i + 1)*8 - 1) downto i*8);
	end generate WINDOW_PIXELS;
	 
	WINDOW_PIXELS_2: for i in 0 to (TAM_KERNEL - 1) generate
		w_Pixels((((i + 1)*8 - 1) + (TAM_KERNEL - 1)*TAM_KERNEL*8) downto (i*8 + (TAM_KERNEL - 1)*TAM_KERNEL*8)) <= w_Buffer(((i + 1)*8 - 1) downto i*8);
	end generate WINDOW_PIXELS_2;
		 
	window : entity work.window
	generic map (TAM_KERNEL => TAM_KERNEL)
	port map(
		i_clk     => i_clk,
		i_Pixels  => w_Pixels,
		i_Kernel  => i_Kernel,
		i_Divider => i_Divider,
		o_Result  => o_pixel
	);
    
	rowBuffer1 : entity work.RowBuffer
	generic map (TAM_IMG => TAM_IMG, TAM_KERNEL => TAM_KERNEL)
	port map (
		i_RESET   => i_RESET,
		i_CLOCK   => i_clk,
		i_D       => w_Buffer(7 downto 0),
		o_OUT     => w_OUT_RowBuffer((8*TAM_KERNEL - 1) downto 0)
	);
		
	ROWS: for i in 1 to (TAM_KERNEL - 2) generate
		ROW: 	entity work.RowBuffer
		generic map (TAM_IMG => TAM_IMG, TAM_KERNEL => TAM_KERNEL)
		port map (
			i_RESET   => i_RESET,
			i_CLOCK   => i_clk,
			i_D       => w_OUT_RowBuffer(( 7 + (i - 1)*TAM_KERNEL*8) downto ( (i - 1)*TAM_KERNEL*8 )),
			o_OUT     => w_OUT_RowBuffer(((i + 1)*8*TAM_KERNEL - 1) downto ((i)*8*TAM_KERNEL))
		);
	end generate ROWS;
	    
	process(i_clk)
    
		variable v_Pixel_Counter : integer range -1 to TAM_IMG + 1                   := 0;
		variable v_Line_Counter  : integer range 0  to TAM_IMG                       := 0;
		variable v_DelayLimit    : integer range 0  to (2*TAM_IMG + TAM_KERNEL)      := (2*TAM_IMG + TAM_KERNEL);
		
		variable v_Flag_Delay    : std_logic := '1';
		variable v_Flag_Borda    : std_logic := '0';
		variable v_Flag_Fim_Img  : std_logic := '0';
		
	begin
	    	
		if(rising_edge(i_clk)) then
											
			if(v_Flag_Fim_Img = '0') then
			
				if(v_Flag_Delay = '0') then
					v_Pixel_Counter := v_Pixel_Counter + 1;
				end if;
								
				-- Delay
					-- Delay do processamento (enche os row buffers e uma linha da janela)
					if(v_DelayLimit > 0) then 
						v_DelayLimit := v_DelayLimit - 1;
					else
						v_Flag_Delay := '0';				
					end if;			
				-- /Delay
				
				-- Bordas
				
					if(v_Pixel_Counter <= TAM_IMG - (TAM_KERNEL)) then
						v_Flag_Borda := '0';
					else
						v_Flag_Borda := '1';
					end if;
				
				-- /Bordas
				
				-- Fim Imagem
				
					if(v_Line_Counter = (TAM_IMG - TAM_KERNEL) and v_Flag_Borda = '1') then
						v_Flag_Fim_Img := '1';
					else
						v_Flag_Fim_Img := '0';
					end if;
				
				-- /Fim Imagem
				
				-- Processamento
					
					if(v_Flag_Delay = '0') then
					
						if(v_Flag_Borda = '0') then
							w_Flag_Process <= '1';
						elsif(v_Flag_Borda = '1' and v_Pixel_Counter <= TAM_IMG - 2) then
							w_Flag_Process <= '0';
						else
							v_Line_Counter  := v_Line_Counter + 1;
							v_Pixel_Counter := -1;
						end if;
						
					end if;
				
				-- /Processamento
				
				for i in 0 to (TAM_KERNEL - 2) loop
					w_Buffer(((i + 1)*8 - 1) downto (i*8)) <= w_Buffer(((i + 2)*8 - 1) downto (i + 1)*8);
				end loop;
				
				w_Buffer((TAM_KERNEL*8 - 1) downto ((TAM_KERNEL - 1)*8)) <= i_pixel;
				
			else
				w_Flag_Process <= '0';
			end if;
		end if;
    
  end process;

end arch0;
