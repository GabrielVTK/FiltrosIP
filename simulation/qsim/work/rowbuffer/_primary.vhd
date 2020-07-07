library verilog;
use verilog.vl_types.all;
entity rowbuffer is
    port(
        i_clock         : in     vl_logic;
        i_D             : in     vl_logic_vector(7 downto 0);
        o_saida         : out    vl_logic_vector(7 downto 0)
    );
end rowbuffer;
