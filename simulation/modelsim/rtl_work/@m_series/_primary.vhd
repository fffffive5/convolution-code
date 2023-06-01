library verilog;
use verilog.vl_types.all;
entity M_series is
    generic(
        len             : integer := 15
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        Q               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of len : constant is 1;
end M_series;
