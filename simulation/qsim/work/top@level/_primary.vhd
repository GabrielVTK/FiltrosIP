library verilog;
use verilog.vl_types.all;
entity topLevel is
    port(
        i_clk           : in     vl_logic;
        i_pixel         : in     vl_logic_vector(7 downto 0);
        o_pixel         : out    vl_logic_vector(7 downto 0)
    );
end topLevel;
