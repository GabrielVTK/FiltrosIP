library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity window7x7 is
port(
    ---------------------------
	 ---  | 0x0  0x1  0x2  0x3  0x4  0x5  0x6 |  ---
    ---  | 1x0  1x1  1x2  1x3  1x4  1x5  1x6 |  ---
    ---  | 2x0  2x1  2x2  2x3  2x4  2x5  2x6 |  ---
	 ---  | 3x0  3x1  3x2  3x3  3x4  3x5  3x6 |  ---
	 ---  | 4x0  4x1  4x2  4x3  4x4  4x5  4x6 |  ---
	 ---  | 5x0  5x1  5x2  5x3  5x4  5x5  5x6 |  ---
	 ---  | 6x0  6x1  6x2  6x3  6x4  6x5  6x6 |  ---
    ---------------------------
  
    i_clk          :  in  std_logic;
  
	 i_Pixel0x0     :  in  std_logic_vector(7 downto 0); -- [-1, -1]
    i_Pixel0x1     :  in  std_logic_vector(7 downto 0); -- [-1,  0]
    i_Pixel0x2     :  in  std_logic_vector(7 downto 0); -- [-1,  1]
    
	 
    i_Pixel1x0     :  in  std_logic_vector(7 downto 0); -- [ 0, -1]
    i_Pixel1x1     :  in  std_logic_vector(7 downto 0); -- [ 0,  0]
    i_Pixel1x2     :  in  std_logic_vector(7 downto 0); -- [ 0,  1]
    
    i_Pixel2x0     :  in  std_logic_vector(7 downto 0); -- [ 1, -1]
    i_Pixel2x1     :  in  std_logic_vector(7 downto 0); -- [ 1,  0]
    i_Pixel2x2     :  in  std_logic_vector(7 downto 0); -- [ 1,  1]
        
    o_Result       :  out std_logic_vector(7 downto 0)
    );
end window7x7;

architecture arch0 of window7x7 is

	 signal w_Kernel0x0 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel0x1 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel0x2 : std_logic_vector(7 downto 0) := "00000001";
    
    signal w_Kernel1x0 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel1x1 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel1x2 : std_logic_vector(7 downto 0) := "00000001";
    
    signal w_Kernel2x0 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel2x1 : std_logic_vector(7 downto 0) := "00000001";
    signal w_Kernel2x2 : std_logic_vector(7 downto 0) := "00000001";
    
begin
  
  o_Result <= std_logic_vector(
                  resize(
                  (
                    unsigned(w_Kernel0x0) * unsigned(i_Pixel0x0) +
                    unsigned(w_Kernel0x1) * unsigned(i_Pixel0x1) +
                    unsigned(w_Kernel0x2) * unsigned(i_Pixel0x2) +
                  
                    unsigned(w_Kernel1x0) * unsigned(i_Pixel1x0) +
                    unsigned(w_Kernel1x1) * unsigned(i_Pixel1x1) +
                    unsigned(w_Kernel1x2) * unsigned(i_Pixel1x2) +
                  
                    unsigned(w_Kernel2x0) * unsigned(i_Pixel2x0) +
                    unsigned(w_Kernel2x1) * unsigned(i_Pixel2x1) +
                    unsigned(w_Kernel2x2) * unsigned(i_Pixel2x2)
                  ) / 9
                  ,8)
              );
  
end arch0;