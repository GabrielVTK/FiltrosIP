library verilog;
use verilog.vl_types.all;
entity rowbuffer_vlg_sample_tst is
    port(
        i_clock         : in     vl_logic;
        i_D             : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end rowbuffer_vlg_sample_tst;
