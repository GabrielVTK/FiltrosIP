library ieee;
use ieee.std_logic_1164.all;

entity RowBuffer is
  generic(
	 TAM_IMG    : integer := 102; -- Tamanho da imagem
	 TAM_KERNEL : integer := 3    -- Tamanho do kernel (3 => 3x3; 5 => 5x5; 7 => 7x7)
  );
  port(
	 i_RESET  : in std_logic;
    i_CLOCK  : in std_logic;
    i_D      : in std_logic_vector(7 downto 0);
	 o_OUT    : out std_logic_vector((8*TAM_KERNEL - 1) downto 0)
  );
end entity RowBuffer;

architecture Arch of RowBuffer is
	signal w_Q : std_logic_vector((TAM_IMG*8 - 1	) downto 0);
begin

	FF_00: entity work.FlipFlop PORT MAP (
		i_RESET => i_RESET,
		i_CLOCK => i_CLOCK,
		i_D     => i_D,
		o_QF    => w_Q(7 downto 0)
	);

	REG: for i in 1 to (TAM_IMG - 1) generate
		FF: entity work.FlipFlop PORT MAP (
			i_RESET => i_RESET,
			i_CLOCK => i_CLOCK,
			i_D     => w_Q((8*i - 1) downto 8*(i - 1)),
			o_QF    => w_Q(8*(i+1) - 1 downto 8*i)
		);
	end generate REG;
	
	ROW_OUT: for i in 0 to (TAM_KERNEL - 1) generate
		o_OUT((8*(i + 1) - 1) downto 8*i) <= w_Q(((TAM_IMG - i)*8 - 1) downto (TAM_IMG - (i + 1))*8);
	end generate ROW_OUT;
	
end Arch;