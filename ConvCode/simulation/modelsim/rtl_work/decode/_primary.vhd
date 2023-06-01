library verilog;
use verilog.vl_types.all;
entity decode is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        data_in         : in     vl_logic_vector(1 downto 0);
        data_out        : out    vl_logic
    );
end decode;
