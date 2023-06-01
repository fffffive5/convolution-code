library verilog;
use verilog.vl_types.all;
entity Conv_code is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        Q               : out    vl_logic;
        data_out        : out    vl_logic
    );
end Conv_code;
