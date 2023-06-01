library verilog;
use verilog.vl_types.all;
entity encode is
    port(
        clk             : in     vl_logic;
        clk_code        : in     vl_logic;
        Q               : in     vl_logic;
        code            : out    vl_logic
    );
end encode;
