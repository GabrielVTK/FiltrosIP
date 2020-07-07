library verilog;
use verilog.vl_types.all;
entity rowbuffer_vlg_check_tst is
    port(
        o_saida         : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end rowbuffer_vlg_check_tst;
