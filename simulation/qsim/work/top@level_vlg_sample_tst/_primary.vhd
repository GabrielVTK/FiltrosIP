library verilog;
use verilog.vl_types.all;
entity topLevel_vlg_sample_tst is
    port(
        i_clk           : in     vl_logic;
        i_pixel         : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end topLevel_vlg_sample_tst;
