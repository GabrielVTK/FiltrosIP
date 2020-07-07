library verilog;
use verilog.vl_types.all;
entity topLevel_vlg_check_tst is
    port(
        o_pixel         : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end topLevel_vlg_check_tst;
